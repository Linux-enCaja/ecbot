MCU=atmega168
CC=avr-gcc
OBJCOPY=avr-objcopy
CFLAGS=-g -mmcu=$(MCU) -Wall -Wstrict-prototypes -O0 -mcall-prologues

.PHONY: all 

all: i2ctemp.hex

i2ctemp.hex : i2ctemp_avr_main.out 
	$(OBJCOPY) -R .eeprom -O ihex i2ctemp_avr_main.out i2ctemp.hex 
i2ctemp_avr_main.out : i2ctemp_avr_main.o i2c_avr.o
	$(CC) $(CFLAGS) -o i2ctemp_avr_main.out -Wl,-Map,i2ctemp_avr_main.map i2ctemp_avr_main.o i2c_avr.o -lm
	avr-size i2ctemp_avr_main.out

i2ctemp_avr_main.o : i2ctemp_avr_main.c i2c_avr.h avr_compat.h 
	$(CC) $(CFLAGS) -Os -c i2ctemp_avr_main.c
i2c_avr.o : i2c_avr.c i2c_avr.h avr_compat.h
	$(CC) $(CFLAGS) -Os -c i2c_avr.c

clean:
	rm -f *.o *.map *.out test*.hex *p.hex i2c_rs232_pintest i2ctemp_linux i2ctalk_linux i2ctempgui
