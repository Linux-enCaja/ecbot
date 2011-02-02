CROSS_COMPILE = /home/at91/buildroot/build_arm/staging_dir/bin/arm-linux-
CFLAGS	  += -mcpu=arm920t -Wall  -g -O2 -fno-strict-aliasing -I$(PREFIX)/include -I$(PNGPP)
CXXFLAGS  += -mcpu=arm920t -Wall  -g -O2 -fno-strict-aliasing  -I$(PREFIX)/include -I$(PNGPP)
LIBS=-lstdc++


TARGET_ARCH=-Os
CC  = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++


PREFIX := /home/at91/buildroot/build_arm/staging_dir/usr/

PNGPP := ../

make_cflags := -Wall $(CFLAGS) -I$(PREFIX)/include -I$(PNGPP)
make_ldflags := $(LDFLAGS) -L$(PREFIX)/lib

ifndef NDEBUG
make_cflags := $(make_cflags) -g
make_ldflags := $(make_ldflags) -g
endif

ifndef LIBPNG_CONFIG
LIBPNG_CONFIG := libpng-config
endif

sources := pixel_generator.cpp

deps := $(sources:.cpp=.dep)
objects := $(sources:.cpp=.o)
targets := $(sources:.cpp=$(bin_suffix))

all: $(deps) $(targets)

dist-copy-files:
	mkdir $(dist_dir)/example
	cp $(sources) Makefile $(dist_dir)/example

clean: clean-deps
	rm -f $(targets) $(objects)

.PHONY: all dist-copy-files clean clean-deps

%$(bin_suffix): %.o
	$(CXX) -o $@ $< $(make_ldflags) `$(LIBPNG_CONFIG) --ldflags`

%.o: %.cpp
	$(CXX) -c -o $@ $< $(make_cflags) `$(LIBPNG_CONFIG) --cflags`


%.dep: %.cpp
	$(CXX) -M $(CPPFLAGS) $(make_cflags) $< -o- | \
	  sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@

clean-deps:
	rm -f $(deps)

include $(deps)
