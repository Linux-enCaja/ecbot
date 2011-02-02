MCU    = atmega168
CC     = avr-gcc
OBJCOPY= avr-objcopy
CFLAGS = -g -mmcu=$(MCU) -Wall -Wstrict-prototypes -O0 -mcall-prologues
BINDIR = ../binary
TARGET = UM

OBJECTS = main.o     \
          i2c_avr.o  \
          motor.o    \
          adc.o

.PHONY: all 

all: $(TARGET).hex

UM.hex : main.out 
	$(OBJCOPY) -R .eeprom -O ihex main.out $(BINDIR)/$(TARGET).hex 
main.out : $(OBJECTS) 
	$(CC) $(CFLAGS) -o main.out -Wl,-Map,main.map $(OBJECTS) -lm
	avr-size main.out

main.o : main.c i2c_avr.h avr_compat.h 
	$(CC) $(CFLAGS) -Os -c main.c
i2c_avr.o : i2c_avr.c i2c_avr.h avr_compat.h
	$(CC) $(CFLAGS) -Os -c i2c_avr.c

clean:
	rm -f *.o *.map *.out *.hex i2c_rs232_pintest i2ctemp_linux i2ctalk_linux i2ctempgui $(BINDIR)/$(TARGET).hex
