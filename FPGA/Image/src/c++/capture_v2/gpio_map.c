/*
 * ecb_at91.c - AT91RM9200 Programmer, This programmer uses AT91' GPIO lines  
 *
 * Written 2006 by Carlos Camargo 
 * Based in Werner Almesberger's TrivialSerial Programmer
 */


#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>


#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

#include "AT91Regs.h"
#include "gpio_map.h"


int reset, dummy;
AT91PS_PIO pio;
volatile unsigned short *fpga_base;
volatile unsigned long  *virt_addr;
void *base;


 void pio_out (int mask, int val)
{
  if (val==0)
    pio->PIO_CODR = mask;
  else
    pio->PIO_SODR = mask;
}


 int pio_in(unsigned int pin)
{
	return (pio->PIO_PDSR & pin);
}



int ebi_map(off_t address, unsigned int size)
{
  int fd;
  if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1){
    printf ("Cannot open /dev/mem.\n");
    return -1;
  }
  printf ("/dev/mem opened.\n");

  printf("WRITE TO: %X\n", address);
  base = mmap (0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, (address & ~(size-1)) );
  if (base == (void *) -1){
    printf ("Cannot mmap.\n");
    return -1;
  }
  printf ("EBI Memory mapped at address %p.\n", base);
  virt_addr = base + (address & (size -1));
  return 0;

}

 int ebi_setup(void)
{
  if(*virt_addr != 0x00003080){    // 0 WS, 16 bits
    *virt_addr  = 0x00003080;
  }
  else
    printf("CS3, already configured\n");
  return 0;
}


int  ebi_unmap(unsigned int size){
  if (munmap ((void*)virt_addr, size) == -1){
    printf ("Cannot munmap EBI.\n");
    return -1;
  }
  else
    printf ("EBI Memory unmapped at address %p.\n", virt_addr);
  return 0;
}

 int pio_map(off_t address, unsigned int size)
{
 int fd;

  off_t addr = address;	// PIO controller C
  if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
  {
    printf ("Cannot open /dev/mem.\n");
    return -1;
  }
  base = mmap (0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, (addr & ~(size-1)) );
  if (base == (void *) -1)
  {
    printf ("Cannot mmap PIO.\n");
    return -1;
  }
  printf ("PIO Memory mapped at address %p.\n", base);
  pio = base + (address & (size -1));
  return 0;
}


 void pio_setup(void)
{

  pio->PIO_PER	 = C_DONE | RESET | CAPTURE;    /* Enable PIO */
  pio->PIO_ODR   = C_DONE;
  pio->PIO_OER	 = RESET | CAPTURE;             /* Set RESET and CAPTURE as outputs */
//  pio->PIO_CODR	 = RESET | CAPTURE;             /* Set Initial States No reset, no capture */
  pio->PIO_IFER	 = C_DONE;
  pio->PIO_IDR	 = C_DONE | RESET |CAPTURE;    /* Disable pin interrupts */
  pio->PIO_MDDR	 = RESET |CAPTURE;             /* Disable Multiple Diver*/
  pio->PIO_PPUDR = C_DONE | RESET | CAPTURE;   /* Disable Pull-Ups*/
  pio->PIO_OWDR	 = C_DONE | RESET | CAPTURE;   /* Synchronous Data Output Write in PIO_*/

}
	
int pio_unmap(unsigned int size){
  if (munmap ((void*)pio, size) == -1){
    printf ("Cannot munmap PIO.\n");
    return -1;
  }
  else
    printf ("PIO Memory unmapped at address %p.\n", pio);
  return 0;
}


 int mem_map(off_t address, unsigned int size)
{
  int fd;
  off_t addr = address;	// PIO controller C
  if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1){
    printf ("Cannot open /dev/mem.\n");
    return -1;
  }
  base = mmap (0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, (addr & ~(size-1)));
  if (base == (void *) -1){
    printf ("Cannot mmap FPGA.\n");
    return -1;
  }
  printf ("Memory mapped at address %p.\n", base);
  fpga_base = base + (addr & MAP_MASK);
  return 0;
}

int mem_unmap(unsigned int size){
  if (munmap ((void*)fpga_base, size) == -1){
    printf ("Cannot munmap FPGA.\n");
    return -1;
  }
  else
    printf ("FPGA Memory unmapped at address %p.\n", fpga_base);

  return 0;
}


void mem_set(unsigned long i, unsigned short v)
{
  fpga_base[i<<10] = v;
}

unsigned short  mem_get(unsigned long i)
{
  return fpga_base[i<<10];
}
