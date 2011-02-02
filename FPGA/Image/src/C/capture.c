#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

#include "capture.h"
#include "convert.h"

#define DEBUG  1 
//#define DEPTH8 0

AT91PS_PIO pio;
int fd_pio, fd_file;
static void *base_pio;
unsigned char rst_val;

void bayerfilter(unsigned short* p,unsigned char* rgb, int w, int h)
{
  unsigned int i,j, index, index_g0, index_g1, index_r, index_b;
  static unsigned char g,r, b;
  static unsigned short  g0,g1;
  for( i=0; i<h; i++ )
    for( j=0; j<w; j++ )
      {
/*   j->
i=0            |G|R|G|R|G|R|G|R|G|R|G|R|
i=1            |B|G|B|G|B|G|B|G|B|G|B|G|
*/
        index_g0 = 2*i*2*w + j*2 ;
        index_b  = (2*i+1)*2*w + j*2;
        index_g1 = index_b  +1;
        index_r  = index_g0 +1;


        g0 = p[index_g0 +1];
        g1 = p[index_b  +1];
        r  = p[index_g1 +1];
        b  = p[index_r  +1];
        g  = (g0 + g1) >> 1;

        index = i*w + j;

        rgb[3*index]      = r;
        rgb[(3*index +1)] = g;
        rgb[(3*index +2)] = b;
    }
}


int io_map(off_t address){
	int fd;
	void *base;
	volatile unsigned long *virt_addr;

	if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
	{
		printf ("Cannot open /dev/mem.\n");
		return -1;
	}

	if(DEBUG)
	 printf ("/dev/mem opened.\n");
	
	base = mmap (0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, address & ~MAP_MASK);
	if (base == (void *) -1)
	{
		printf ("Cannot mmap.\n");
		return -1;
	}
	if(DEBUG)
	  printf ("Memory mapped at address %p.\n", base);

	virt_addr = base + (address & MAP_MASK);


/*	SMC:
	-    RWHLD2 RWHLD1 RWHLD0 -     RWSTP2 RWSTP1 RWSTP0 
	-    -      -      -      -     -      ACSS1  ACSS0
	DRP  DBW1   DBW0   BAT    TDF3  TDF2   TDF1   TDF0
	WSEN NWS6   NWS5   NWS4   NWS3  NWS2   NWS1   NWS0

        DBW:  Data Bus Width:		01: 16 bits, 		10: 8  bits
        BAT:  Byte Access type:		0: 8 bit device, 	 1: 16 bits
	TDF:  Data Float Time
	WSEN: Wait State Enable		1: enable
	NWS:  Number of Wait States                                            */

   if(*virt_addr != 0x00003080){    // 0 WS, 16 bits
      *virt_addr  = 0x00003080;
      if(DEBUG)
        printf("Configuring CS3 16 bits and 1 WS\n");
   }
   else
     if(DEBUG)
       printf("CS3, already configured\n");

	if (munmap (base, MAP_SIZE) == -1)
	{
		printf ("Cannot munmap.\n");
		return -1;
	}
	else{
          if(DEBUG)
	    printf ("Memory unmapped at address %p.\n", base);
	}
    return 1;
}

//0xFFFFFF70=CS0, 0xFFFFFF74=CS1, 0xFFFFFF78=CS2, 0xFFFFFF7C=CS3

int file_map(void){
	if (( fd_file = open( "test.bin", O_CREAT|O_RDWR )) < 0 )
	{
	        if(DEBUG)
		  printf( "Error  creating '%s'\n", "test.bin");
		return -1;
	}
	return 0;
}

void pio_setup(void)
{
	pio->PIO_PER	= C_DONE | RESET | CAPTURE;    /* Enable PIO */
	pio->PIO_ODR    = C_DONE;
	pio->PIO_OER	= RESET | CAPTURE;    /* Set RESET and CAPTURE as outputs */
	pio->PIO_CODR	= CAPTURE;
        pio->PIO_SODR   = RESET;
	pio->PIO_IFER	= C_DONE;
	pio->PIO_IDR	= C_DONE | RESET |CAPTURE;    /* Disable pin interrupts */
	pio->PIO_MDDR	= RESET |CAPTURE;    /* Disable Multiple Diver*/
	pio->PIO_PPUDR	= C_DONE | RESET | CAPTURE;    /* Disable Pull-Ups*/
	pio->PIO_OWDR	= C_DONE | RESET | CAPTURE;    /* Synchronous Data Output Write in PIO_*/
}



int pio_map ()
{
	off_t addr_pio = 0xFFFFF800;	// PIO controller C


        if ((fd_pio = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
        {
	        if(DEBUG)
                  printf ("Cannot open /dev/mem.\n");
                return 0;
        }
        if(DEBUG)
          printf ("/dev/mem opened.\n");

	base_pio = mmap (0, MAP_SIZE_PIO, PROT_READ | PROT_WRITE, MAP_SHARED, fd_pio, addr_pio & ~MAP_MASK_PIO);
        if (base_pio == (void *) -1)
        {
	        if(DEBUG)
                  printf ("Cannot mmap.\n");
                return 0;
        }
        if(DEBUG)
          printf ("Memory mapped at address %p.\n", base_pio);

	pio = base_pio + (addr_pio & MAP_MASK_PIO);
	return 1;
}


int main (int argc, char **args)
{	
	int fd;
	unsigned long i, j, w, h, tmp=0;
	void *base;
	volatile unsigned short *virt_addr;
#ifdef DEPTH8
        unsigned char  *rgb;
#else
        unsigned short *rgb;
#endif
//	RGB rgb[2];

/*
	if(argc<=1){
	  printf("\nUsage: %s Reset value (0,1) \n\n",args[0]);	
        return 1;
	}

  	if(argc==2) rst_val = atoi(args[1]);
          printf("%d\n", rst_val);
*/
	pio_map();
        pio_setup();

        pio->PIO_SODR   = RESET;
        pio->PIO_CODR   = RESET;

        pio->PIO_CODR	= CAPTURE;
        file_map();

	io_map(0xFFFFFF7C);              // Configure CS3 as 16 bit Memory and 0 Wait States
	off_t address = 0x40000000;

	if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
	{
          if(DEBUG)
	    printf ("Cannot open /dev/mem.\n");
	  return -1;
	}
	if(DEBUG)
	  printf ("/dev/mem opened.\n");

	base = mmap (0, MAP_SIZE, PROT_READ | PROT_WRITE,
		     MAP_SHARED, fd, address & ~MAP_MASK);
	if (base == (void *) -1)
	{
	        if(DEBUG)
		  printf ("Cannot mmap.\n");
		return -1;
	}
	if(DEBUG)
	  printf ("Memory mapped at address %p.\n", base);

	virt_addr = base + (address & MAP_MASK);

	w=332;
	h=251;
#ifdef DEPTH8
	rgb   = malloc(w*h*3);
#else
	rgb   = malloc((w*h*3)*2);
#endif
        if (rgb == 0){
          printf("virtual memory exhausted\n");
          return 0;
        }

        pio->PIO_SODR   = RESET;
	usleep(0x1);
        pio->PIO_CODR   = RESET;

	pio->PIO_SODR	= CAPTURE;
	pio->PIO_CODR	= CAPTURE;

	for(j=0; j < h; j++){


	  while( ( pio->PIO_PDSR & C_DONE ) == 0) {}

	  for(i=0; i < 3*w; i++){
            tmp = w*j*3 + i;
#ifdef DEPTH8
            rgb[tmp] = (virt_addr[i<<10]) & (0x00ff);
#else
            rgb[tmp] = (virt_addr[i<<10]);
#endif
	  }

	  pio->PIO_SODR	= CAPTURE;
	  pio->PIO_CODR	= CAPTURE;
	}

        printf("Writing frame data to file .. \n");
#ifdef DEPTH8
        write(fd_file, rgb, w*h*3);
#else
        write(fd_file, rgb, w*h*3*2);
#endif
        free (rgb);
	if (munmap (base, MAP_SIZE) == -1)
	{
	        if(DEBUG)
		  printf ("Cannot munmap.\n");
		return -1;
	}
        return 1;
}

