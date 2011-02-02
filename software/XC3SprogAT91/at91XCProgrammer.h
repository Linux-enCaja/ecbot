/* at91 XC Programer

Copyright (C) 2006 Carlos Camargo, Andres Calderon

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA */



#ifndef AT91_XCP_H
#define AT91_XCP_H

#include "ecb_at91.h"
#include "iobase.h"


extern "C" 
{
 void pio_out (int mask, int val);

 int pio_in(void);

 void pio_setup(void);
	
 int pio_map();
}


const static unsigned int phy_address = PIOBASE;

class AT91Programmer: public IOBase
{
 public:
  AT91Programmer(const char *device_name);
  virtual ~AT91Programmer();
  virtual bool txrx(bool tms, bool tdi);
  virtual void tx(bool tms, bool tdi);
  
  bool checkError(){return error;}
  
  bool done(){return true; /*!error && (cpld_base[0]&DONE==DONE);*/}

 protected:
  void set(int mask)   {::pio_out(mask,1);}
  void clear(int mask) {::pio_out(mask,0);}


  bool error;
    
  unsigned char data;
};

inline
bool 
AT91Programmer::txrx(bool tms, bool tdi)
{

  tx(tms,tdi);
  
  return (pio_in());
}

inline
void 
AT91Programmer::tx(bool tms, bool tdi)
{
  clear(TCK);

  pio_out(TDI,tdi);
  pio_out(TMS,tms);

  set(TCK);  
}


#endif // JTAGBUS_H

