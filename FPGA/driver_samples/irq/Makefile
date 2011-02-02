EXTRA_CFLAGS += -Wall
CC = /home/at91/arm-2007q1/bin/arm-none-eabi-gcc
obj-m +=  irq.o 
all: driver main

driver:
	make -C  /home/cain/Embedded/AT91/work/linux/linux-2.6.24.4  M=$(PWD) modules
clean:
	make -C  /home/cain/Embedded/AT91/work/linux/linux-2.6.24.4  M=$(PWD) clean
	rm -rf *.o main.o main irq.ko Modules.symvers

main: main.o

PREPROCESS.c = $(CCB) $(CFLAGS) $(TARGET_ARCH) -E -Wp,-C,-dD,-dI
%.pp : %.c FORCE
	$(PREPROCESS.c) $< > $@
	
		

