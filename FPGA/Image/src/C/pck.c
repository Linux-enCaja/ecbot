#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

#define MAP_SIZE 4096Ul
#define MAP_MASK (MAP_SIZE - 1)

int main ()
{	
	int fd;
	void *base;
	unsigned long *virt_addr;

	if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
	{
		printf ("Cannot open /dev/mem.\n");
		return -1;
	}
	printf ("/dev/mem opened.\n");

	base = mmap (0, MAP_SIZE, PROT_READ | PROT_WRITE,
		     MAP_SHARED, fd, 0xFFFFF600 & ~MAP_MASK);
	if (base == (void *) -1)
	{
		printf ("Cannot mmap.\n");
		return -1;
	}
	printf ("Memory mapped at address %p.\n", base);

	virt_addr = base + (0xFFFFF600 & MAP_MASK) + 0x0004;
	*virt_addr = 0x08000000;

	if (munmap (base, MAP_SIZE) == -1)
	{
		printf ("Cannot munmap.\n");
		return -1;
	}

	base = mmap (0, MAP_SIZE, PROT_READ | PROT_WRITE,
		     MAP_SHARED, fd, 0xFFFFFC00 & ~MAP_MASK);
	if (base == (void *) -1)
	{
		printf ("Cannot mmap.\n");
		return -1;
	}
	printf ("Memory mapped at address %p.\n", base);

	virt_addr = base + (0xFFFFFC00 & MAP_MASK) + 0x44;
        *virt_addr = 0x00000006;        // PCK1 @ 45 MHz


	virt_addr = base + (0xFFFFFC00 & MAP_MASK) + 0x00;
	*virt_addr = 0x00000200;	// enable PCK1
	if (munmap (base, MAP_SIZE) == -1)
	{
		printf ("Cannot munmap.\n");
		return -1;
	}
//***********************************************************
// *                      CONFIG CS3                        *
//***********************************************************
	if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
	{
		printf ("Cannot open /dev/mem.\n");
		return -1;
	}

	 printf ("/dev/mem opened.\n");
	
	base = mmap (0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0xFFFFFF7C & ~MAP_MASK);
	if (base == (void *) -1)
	{
		printf ("Cannot mmap.\n");
		return -1;
	}
	  printf ("Memory mapped at address %p.\n", base);

	virt_addr = base + (0xFFFFFF7C & MAP_MASK);


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

   if(*virt_addr != 0x00003080)    // 0 WS, 16 bits
      *virt_addr  = 0x00003080;
   else
       printf("CS3, already configured\n");

	if (munmap (base, MAP_SIZE) == -1)
	{
		printf ("Cannot munmap.\n");
		return -1;
	}
	else
	    printf ("Memory unmapped at address %p.\n", base);

	return 0;
}

