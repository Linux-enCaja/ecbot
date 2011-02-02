PWD       := $(shell pwd)
CROSS_COMPILE = /home/at91/oe/tmp/cross/armv4t/bin/arm-angstrom-linux-gnueabi-
CFLAGS	 += -mcpu=arm920t -Wall

TARGET_ARCH=-Os
CC = $(CROSS_COMPILE)gcc

all: ncs0 pck blink sram pc19 irda

ncs0:ncs0.o

pck:pck.o

blink:blink.o

sram: sram.o

irda: irda.o

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions svn-version.h ncs0 pck sram blink irda 


PREPROCESS.c = $(CC) $(CPPFLAGS) $(TARGET_ARCH) -E -Wp,-C,-dD,-dI

%.pp : %.c FORCE
	$(PREPROCESS.c) $< > $@
