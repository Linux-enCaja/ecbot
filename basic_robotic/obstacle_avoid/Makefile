ifeq ($(DEBUG),y)
	CFLAGS += -O -g		# -O is need to expand inlines
else
	CFLAGS += -O2
endif

PWD       := $(shell pwd)

CROSS_COMPILE		= arm-linux-
I2C_LIB			= ./


vpath %.c $(I2C_LIB)

CPPFLAGS += -I . -I $(I2C_LIB)
CFLAGS	 += -Wall -mcpu=arm920t

TARGET_ARCH=-Os 
CC = $(CROSS_COMPILE)gcc

OBJS = \
	ir_avoid.o 	\
	i2c-api.o	\
	i2c-io-api.o	\
	Crc8.o		\
	DumpMem.o	\
	Log.o

all: ir_avoid

ir_avoid:  $(OBJS)

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions ir_avoid


PREPROCESS.c = $(CC) $(CPPFLAGS) $(TARGET_ARCH) -E -Wp,-C,-dD,-dI

%.pp : %.c FORCE
	$(PREPROCESS.c) $< > $@
