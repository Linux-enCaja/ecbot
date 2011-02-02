include make.include

all	:    libpngwriter tracking 

libpngwriter: 
	cd src;	make 

tracking: libpngwriter
	cd tracking; make

clean	:    
	cd src; make clean
	cd tracking; rm -rf *png make clean
#	rm -f make.include.linux.oldcpp~ make.include.osx_test~ doc/.DS_Store

