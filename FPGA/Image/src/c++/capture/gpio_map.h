#ifndef	GPIO_MAP_H
#define	GPIO_MAP_H

#define MAP_SIZE 0x2000000l
#define MAP_MASK (MAP_SIZE - 1)


 int  ebi_map(off_t address, unsigned int size);

 int  ebi_setup(void);

 int  ebi_unmap(unsigned int size);

 int  pio_map(off_t address, unsigned int size);

 void pio_setup(void);

 int  pio_unmap(unsigned int size);

 void pio_out (int mask, int val);

 int  pio_in(unsigned int pin);

 int  mem_map(off_t address, unsigned int size);

 int  mem_unmap(unsigned int size);

 void mem_set(unsigned long i, unsigned short v);

 unsigned short  mem_get(unsigned long i);



#endif
