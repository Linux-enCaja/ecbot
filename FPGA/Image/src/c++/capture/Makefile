PWD       := $(shell pwd)
PNG_LIBRARY   = ../../../images/pngwriter-0.5.3/src
PNGPP_PATH    = ../../../images/pngpp/
I2C_LIB	  = ../lib
INCLUDE_PATH  = /home/at91/oe/tmp/staging/armv4t-angstrom-linux-gnueabi/usr/include/ -I$(I2C_LIB) -I$(PNGPP_PATH) 
LIBDIR = -L$(PNG_LIBRARY) -L -L$(PREFIX)/lib/
PREFIX = 

CROSS_COMPILE = /home/at91/oe/tmp/cross/armv4t/bin/arm-angstrom-linux-gnueabi-
CFLAGS	  = -mcpu=arm920t -Wall -O2 -I$(INCLUDE_PATH)
CXXFLAGS  = -mcpu=arm920t -Wall -O2 -I$(INCLUDE_PATH) -Wno-deprecated -fno-strict-aliasing


LIBS      += $(LIBDIR) -lstdc++ -lz -lpng ../../../images/pngwriter-0.5.3/src/libpngwriter.a

vpath %.c %cxx $(I2C_LIB)

TARGET_ARCH=-Os
CC  = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++
LD  = $(CROSS_COMPILE)ld

TARGET = capture

OBJS = capture.o gpio_map.o  tracking.o \
       i2c-api.o comms-lib.o Crc8.o DumpMem.o Log.o


all: capture gpio_control servo_test 

servo_test: servo_test.o rcservo.o
	${CXX} $(CXXFLAGS) $(INC) -o $@ $^ ${LIBS}

capture: $(OBJS) 
	${CXX} -O3 -Wall -Wno-deprecated -I$(INCLUDE_PATH) -mcpu=arm920t -o $@ $^ ${LIBS}

gpio_control: gpio_map.o gpio_control.o
	${CXX} -O3 -Wall -Wno-deprecated -I$(INCLUDE_PATH) -mcpu=arm920t -o $@ $^ ${LIBS}

sram: sram.o

test: 	test.o i2c-api.o comms-lib.o Crc8.o DumpMem.o Log.o

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko $(TARGET) test sram servo_test gpio_control


PREPROCESS.c = $(CC) $(CPPFLAGS) $(TARGET_ARCH) -E -Wp,-C,-dD,-dI

.SUFFIXES: .c .m .cc .cxx .cpp .C .o

.cc.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.cxx.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.cpp.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.C.o:
	$(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) -c $<

.c.o:
	$(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) -c $<

%.pp : %.c FORCE
	$(PREPROCESS.c) $< > $@
