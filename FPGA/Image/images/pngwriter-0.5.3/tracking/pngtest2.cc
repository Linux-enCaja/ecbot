//**********  pngtest.cc   **********************************************
//  Author:                    Paul Blackburn
//
//  Email:                     individual61@users.sourceforge.net
//
//  Version:                   0.5.3   (24 / I / 2005)
//
//  Description:               Test and example for PNGwriter,
//                             a C++ library that enables plotting to a
//                             PNG image pixel by pixel, which can 
//                             then be opened with a graphics program.
//  
//  License:                   GNU General Public License
//                             © 2002, 2003, 2004, 2005 Paul Blackburn
//                             
//  Website: Main:             http://pngwriter.sourceforge.net/
//           Sourceforge.net:  http://sourceforge.net/projects/pngwriter/
//           Freshmeat.net:    http://freshmeat.net/projects/pngwriter/
//           
//  Documentation:             The PNGwriter header file is commented, but for a
//                             quick reference document, and support,
//                             take a look at the website.
//
//*************************************************************************

/*
 * ######################################################################
 *  This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *     
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 * 02111-1307  USA
 * ######################################################################
 * */

#include <pngwriter.h>
#include <math.h>
#include <iostream.h>
#include <string>
#include <ostream>
#include <fstream>

using namespace std;
#include <time.h>
#include <stdlib.h>

extern "C" {
  #include "tracking.h"
}

image_t image;


int main()
{
   char buff[332*251*3];
   ifstream ifs("test.bin");
   ifs.read((char*)buff,332*251*3);

   pixel_t ip;
   
   trackedObject_t objects[8];
   trackedColors_t  colors[8];

   image.channels = 3;
   image.width    = 332;
   image.height   = 251;  // image will hold just 1 row for scanline processing
   image.pix      = &buff;


   pngwriter image_png(332, 251, 0, "cain.png");
   for (unsigned char  y = 0; y < 251; y++)
   {
     for (unsigned short x = 0; x < 332; x++)
     {
       get_pixel(&image, x, y, &ip);
       image_png.plot(x, y, ip.channel[0], ip.channel[1], ip.channel[2]);
     }
   }

   colors[1].lower_bound.channel[0] = 0xC0;
   colors[1].lower_bound.channel[1] = 0x20;
   colors[1].lower_bound.channel[2] = 0x20;
   colors[1].upper_bound.channel[0] = 0xf0;
   colors[1].upper_bound.channel[1] = 0x40;
   colors[1].upper_bound.channel[2] = 0x40;

   objects[1].x0 = 0xffff;
   objects[1].y0 = 0xff;
   objects[1].objectValid = FALSE;

   colors[0].lower_bound.channel[0] = 0x30;
   colors[0].lower_bound.channel[1] = 0x30;
   colors[0].lower_bound.channel[2] = 0x50;
   colors[0].upper_bound.channel[0] = 0x50;
   colors[0].upper_bound.channel[1] = 0x50;
   colors[0].upper_bound.channel[2] = 0x90;
   objects[0].x0 = 0xffff;
   objects[0].y0 = 0xff;
   objects[0].objectValid = FALSE;

   objects[2].objectValid = FALSE;
   objects[3].objectValid = FALSE;
   objects[4].objectValid = FALSE;
   objects[5].objectValid = FALSE;
   objects[6].objectValid = FALSE;
   objects[7].objectValid = FALSE;



   tracking_findConnectedness(image, objects, colors);
   for(int i=0; i<8; i++){
     printf("left=%x, right=%x, top=%x, bottom=%x \n",objects[i].x0, objects[i].x1, objects[i].y0, objects[i].y1);
     image_png.square(objects[i].x1,objects[i].y1,objects[i].x0,objects[i].y0,255,255,255);
   }

   image_png.close();

  return 0;
}
