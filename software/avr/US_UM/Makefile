MCU=atmega8
CC  = avr-gcc
LD  = avr-ld -v
AR  = avr-ar
AS  = avr-as
CP  = avr-objcopy


CFLAGS  = -g -mmcu=$(MCU) -Wall -Wstrict-prototypes -Os -mcall-prologues -I. 
LFLAGS  =  -Map main.map -Tlinkerscript.ld -L/home/at91/gnutools/arm-elf/lib/gcc-lib/arm-elf/3.2.1/
CPFLAGS = -R .eeprom -O ihex


DIRS= US UM

all:
	for n in $(DIRS); do $(MAKE) -C $$n || exit 1; done
	tar zcvf avr.tgz binary

clean:
	for n in $(DIRS); do $(MAKE) -C $$n clean || exit 1; done 
	rm -rf avr.tgz
	rm -rf binary/*.hex

upload: clean all
	scp avr.tgz root@ecbot:	
