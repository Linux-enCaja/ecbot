#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

#define MAP_SIZE 0x2000000l    // ECBOT USE A11 to A25 
#define MAP_MASK (MAP_SIZE - 1)


int io_map(off_t address){
	int fd;
	void *base;
	volatile unsigned long *virt_addr;

	if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
	{
		printf ("Cannot open /dev/mem.\n");
		return -1;
	}
	printf ("/dev/mem opened.\n");
	
	printf("WRITE TO: %X\n", address);

	base = mmap (0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, address & ~MAP_MASK);
	if (base == (void *) -1)
	{
		printf ("Cannot mmap.\n");
		return -1;
	}
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
      printf("Configuring CS3 16 bits and 1 WS\n");
   }
   else
     printf("CS3, already configured\n");

	if (munmap (base, MAP_SIZE) == -1)
	{
		printf ("Cannot munmap.\n");
		return -1;
	}
	else
	  printf ("Memory unmapped at address %p.\n", base);
	return 1;
}

//0xFFFFFF70=CS0, 0xFFFFFF74=CS1, 0xFFFFFF78=CS2, 0xFFFFFF7C=CS3

int main ()
{	
	int fd;
	unsigned long i, j;
	void *base;
	volatile unsigned short *virt_addr;

	io_map(0xFFFFFF7C);              // Configure CS3 as 16 bit Memory and 0 Wait States
	off_t address = 0x40000000;

	if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
	{
		printf ("Cannot open /dev/mem.\n");
		return -1;
	}
	printf ("/dev/mem opened.\n");

	base = mmap (0, MAP_SIZE, PROT_READ | PROT_WRITE,
		     MAP_SHARED, fd, address);
	if (base == (void *) -1)
	{
		printf ("Cannot mmap.\n");
		return -1;
	}
	printf ("Memory mapped at address %p.\n", base);

	virt_addr = base;


        #if 0
	printf("Writing Memory..\n");
	for (i = 0 ; i <32; i++)
	{
          virt_addr[i<<10] = i*3;       // ECBOT use from A11 to A25
	}
        #endif

	printf("Reading Memory..\n");
	for (i = 0 ; i < 32; i++)
	{
	   j = virt_addr[i<<10];
		printf("%X = %X\n", i, j );
	}


	if (munmap (base, MAP_SIZE) == -1)
	{
		printf ("Cannot munmap.\n");
		return -1;
	}

	return 0;
}

