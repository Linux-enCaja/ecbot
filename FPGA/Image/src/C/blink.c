#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include "blinker.h"
#include <unistd.h>

static AT91PS_PIO pioc;

inline void led_off (int mask)
{
	pioc->PIO_CODR = mask;
}

inline void led_on (int mask)
{
	pioc->PIO_SODR = mask;
}


void pioc_setup ()
{
	pioc->PIO_PER	= LED;
	pioc->PIO_OER	= LED;
//	pioc->PIO_ODR	= LED;
	
/*
	pioc->PIO_IFER	= nSTATUS | CONF_DONE;
*/
	pioc->PIO_CODR	= LED;
	pioc->PIO_IDR	= LED;
	pioc->PIO_MDER	= LED;
//	pioc->PIO_MDDR	= LED;
	pioc->PIO_PPUER	= LED;
//	pioc->PIO_PPUDR	= LED;
	pioc->PIO_OWDR	= LED;
}

int pioc_map ()
{
        int fd;
	off_t addr = 0xFFFFF800;	// PIO controller C
	static void *base;

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

	pioc = base + (addr & MAP_MASK);
	return 1;
}

int main (void)
{
	int i,j;
printf ("2\n");	
	pioc_map();
printf ("2\n");
	pioc_setup();

	for( i=0; i<10; i++){
		led_on(LED);	
		usleep(1000);
		led_off(LED);
		usleep(1000);
	}

        return 0;
}

