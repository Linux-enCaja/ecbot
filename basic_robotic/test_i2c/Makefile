ifeq ($(DEBUG),y)
	CFLAGS += -O -g		# -O is need to expand inlines
else
	CFLAGS += -O2
endif

PWD       := $(shell pwd)

CROSS_COMPILE = /home/at91/oe/tmp/cross/armv4t/bin/arm-angstrom-linux-gnueabi-
I2C_LIB			= ../lib


vpath %.c $(I2C_LIB)

CPPFLAGS += -I . -I $(I2C_LIB)
CFLAGS	 += -Wall -mcpu=arm920t

TARGET_ARCH=-Os 
CC = $(CROSS_COMPILE)gcc

OBJS = \
	test.o 			\
	i2c-api.o		\
	comms-lib.o		\
	Crc8.o			\
	DumpMem.o		\
	Log.o

all: test

test:  $(OBJS)

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions test


PREPROCESS.c = $(CC) $(CPPFLAGS) $(TARGET_ARCH) -E -Wp,-C,-dD,-dI

%.pp : %.c FORCE
	$(PREPROCESS.c) $< > $@
