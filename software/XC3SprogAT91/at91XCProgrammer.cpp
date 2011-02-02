/* JTAG GNU/Linux parport device io

Copyright (C) 2005 Andres Calderon

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

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h> 
#include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/mman.h>

#include "at91XCProgrammer.h"

using namespace std;


AT91Programmer::AT91Programmer(const char *device_name) : IOBase()
{
  pio_map();
  pio_setup();
/*
  printf ("iniciar el parpadeo!!");
  fflush(stdout);
  for(bool i=true;;i=!i)
  {
    usleep(1000000);
    pio_out(1<<7,i);
  }
*/

  error=false;
}

 
AT91Programmer::~AT91Programmer()
{
}
