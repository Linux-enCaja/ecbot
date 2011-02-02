#ifndef MEMMAP_H
#define MEMMAP_H

#include <sys/mman.h>
#include <string.h>
#include <stdio.h>
#include <fcntl.h>

#include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/mman.h>

#include <string>
#include <iostream>

using namespace std;

class MemMap
{
public:
  MemMap(off_t phy_addr,  unsigned int sz, string device="/dev/mem")
  {
    phy_address = phy_addr;
    size = sz;
  
    if((filemem = open(device.c_str(), O_RDWR | O_SYNC)) < 0)
    {
      cerr << "ERROR: can not open " <<  device << endl;;
      return;
    }

    if((fpga_base = (unsigned short*)(mmap(0,size,PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED,  filemem, phy_address))) < 0)
    {
      cerr << "ERROR: can map physical address into virtual space!" << endl;
      return;
    }
  }
  
  ~MemMap()
  {
    //release virtual memory
    munmap((void*)fpga_base, size);
  }
  
  void set(unsigned long i, unsigned short v)
  {
    fpga_base[i<<10] = v;
  }

  unsigned short  get(unsigned long i)
  {
    return fpga_base[i<<10];
  }

  int operator[] (unsigned  int i)
  {
    return get(i);
  }
  
protected:  
  int    filemem;
  off_t  phy_address;
  unsigned int  size;
  volatile unsigned short *fpga_base;
};

#endif

