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

#include "ecb_at91.h"


 int reset, dummy;
 AT91PS_PIO pio;
 void *base;

 void pio_out (int mask, int val)
{
	if (val==0)
		pio->PIO_CODR = mask;
	else
		pio->PIO_SODR = mask;
}


 int pio_in(void)
{
	return (pio->PIO_PDSR & TDO);
}

 void pio_setup(void)
{


	pio->PIO_PER	= TDI | TDO | TMS | TCK | DONE | PROG;	/* Enable PIO */
	pio->PIO_OER	= TDI | TMS | TCK;			/* Set TDI, TMS and TCK as outputs */
	pio->PIO_ODR	= TDO | DONE;							/* Set TDO as input */
	pio->PIO_IFER	= TDO | DONE;							/* Enable Input Filter*/
	pio->PIO_CODR	= TDI | TMS | TCK;	/* TDI = TMS = TCK = 0 */
	pio->PIO_IDR	= TDI | TDO | TMS | TCK;	/* Disable pin interrupts */
	pio->PIO_MDDR	= TDI | TDO | TMS | TCK;  	/* Disable Multiple Diver*/
	pio->PIO_PPUDR	= TDI | TDO | TMS | TCK;  	/* Disable Pull-Ups*/
	pio->PIO_OWDR	= TDI | TDO | TMS | TCK;	/* Synchronous Data Output Write in PIO_*/
}
	
 int pio_map()
{
	 int fd;

	off_t addr = PIOBASE;	// PIO controller C

        if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
        {
                printf ("Cannot open /dev/mem.\n");
                return 0;
        }
        printf ("/dev/mem opened.\n");

	base = mmap (0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, addr & ~MAP_MASK);
        if (base == (void *) -1)
        {
                printf ("Cannot mmap.\n");
                return 0;
        }
        printf ("Memory mapped at address %p.\n", base);

	pio = base + (addr & MAP_MASK);
	return 1;
}

