#MCU=atmega168
MCU=atmega88
CC=avr-gcc
OBJCOPY=avr-objcopy
# optimize for size:
CFLAGS=-g -mmcu=$(MCU) -Wall -Wstrict-prototypes -Os -mcall-prologues

all: avrledtest.hex
avrledtest.hex : avrledtest.out 
	$(OBJCOPY) -R .eeprom -O ihex avrledtest.out avrledtest.hex 
avrledtest.out : avrledtest.o 
	$(CC) $(CFLAGS) -o avrledtest.out -Wl,-Map,avrledtest.map avrledtest.o 
avrledtest.o : avrledtest.c 
	$(CC) $(CFLAGS) -Os -c avrledtest.c

# erase the AVR before it is programmed
load: clean avrledtest.hex
	scp avrledtest.hex  root@ecbot:
#	uisp -dlpt=/dev/robostix4 -dpart=atmega161 --erase
#	uisp -dlpt=/dev/robostix4 -dpart=atmega161 --upload if=avrledtest.hex
#	uisp -dlpt=/dev/parport0 --erase  -dprog=dapa
#	uisp -dlpt=/dev/parport0 --upload if=avrledtest.hex -dprog=dapa  -v=3 --hash=32

clean:
	rm -f *.o *.map *.out
