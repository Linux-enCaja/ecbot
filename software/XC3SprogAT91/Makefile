# Spartan3 JTAG programmer and other utilities

# Copyright (C) 2004 Andrew Rogers

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 

CROSS=/home/at91/oe_old/at91/tmp/cross/bin/arm-angstrom-linux-gnueabi-
GXX=$(CROSS)g++
GCC=$(CROSS)gcc
LIBS=-lstdc++



all:	 xc3sprog
#debug bitparse detectchain xc3sprog

debug: debug.o iobase.o at91XCProgrammer.o iodebug.o
	${GXX}  -Wall -mcpu=arm920t ${LIBS} $^ -o $@

bitparse: bitparse.o bitfile.o
	${GXX} -Wall -mcpu=arm920t ${LIBS} $^ -o $@

detectchain: detectchain.o jtag.o iobase.o at91XCProgrammer.o iodebug.o devicedb.o
	${GXX}  -Wall -mcpu=arm920t ${LIBS} $^ -o $@

xc3sprog: xc3sprog.o jtag.o iobase.o at91XCProgrammer.o iodebug.o bitfile.o devicedb.o progalgxcf.o progalgxc3s.o ecb_at91.o
	${GXX}  -Wall -mcpu=arm920t ${LIBS} $^ -o $@

debug.o: debug.cpp iobase.h at91XCProgrammer.h iodebug.h
	${GXX}  -Wall -mcpu=arm920t -c $< -o $@

bitparse.o: bitparse.cpp bitfile.h
	${GXX}  -Wall -mcpu=arm920t -c $< -o $@

detectchain.o: detectchain.cpp iobase.h at91XCProgrammer.h jtag.h iodebug.h devicedb.h
	${GXX}  -Wall -mcpu=arm920t -c $< -o $@

xc3sprog.o: xc3sprog.cpp iobase.h at91XCProgrammer.h jtag.h iodebug.h bitfile.h devicedb.h progalgxcf.h progalgxc3s.h
	${GXX}  -Wall -mcpu=arm920t -Wno-sign-compare -c $< -o $@

iobase.o: iobase.cpp iobase.h
	${GXX} -c $< -o $@

iodebug.o: iodebug.cpp iodebug.h iobase.h
	${GXX} -c $< -o $@

at91XCProgrammer.o: at91XCProgrammer.cpp at91XCProgrammer.h iobase.h
	${GXX} -c $< -o $@ 

bitfile.o: bitfile.cpp bitfile.h
	${GXX} -c $< -o $@

jtag.o: jtag.cpp jtag.h
	${GXX} -c $< -o $@

devicedb.o: devicedb.cpp devicedb.h
	${GXX} -c $< -o $@

progalgxcf.o: progalgxcf.cpp progalgxcf.h iobase.h jtag.h bitfile.h
	${GXX} -c $< -o $@

progalgxc3s.o: progalgxc3s.cpp progalgxc3s.h iobase.h jtag.h bitfile.h
	${GXX} -c $< -o $@

ecb_at91.o: ecb_at91.c ecb_at91.h
	${GCC} -c $< -o $@

clean:
	rm -f debug.o iobase.o at91XCProgrammer.o iodebug.o bitfile.o jtag.o xc3sprog.o 
	rm -f devicedb.o bitparse.o detectchain.o progalgxcf.o progalgxc3s.o
	rm -f debug bitparse detectchain xc3sprog ecb_at91.o *~
