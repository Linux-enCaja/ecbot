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

void init_objects(trackedObject_t * objects){
  for(int i = 0; i<8; i++){
    objects[i].x0 = 0xffff;
    objects[i].y0 = 0xff;
    objects[i].x1 = 0x00;
    objects[i].y1 = 0x00;
    objects[i].objectValid = 0;
  }
}


int main()
{
   char buff[332*251*3];
   ifstream ifs("test.bin");
   ifs.read((char*)buff,332*251*3);

   pixel_t ip;
   
   trackedObject_t objects[8];

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

   init_objects(objects);

   objects[0].lower_bound.channel[0] = 0x88;
   objects[0].lower_bound.channel[1] = 0x60;
   objects[0].lower_bound.channel[2] = 0x60;
   objects[0].upper_bound.channel[0] = 0x8f;
   objects[0].upper_bound.channel[1] = 0x70;
   objects[0].upper_bound.channel[2] = 0x70;

   objects[1].lower_bound.channel[0] = 0xC0;
   objects[1].lower_bound.channel[1] = 0x20;
   objects[1].lower_bound.channel[2] = 0x20;
   objects[1].upper_bound.channel[0] = 0xf0;
   objects[1].upper_bound.channel[1] = 0x40;
   objects[1].upper_bound.channel[2] = 0x40;

   objects[2].lower_bound.channel[0] = 0x30;
   objects[2].lower_bound.channel[1] = 0x30;
   objects[2].lower_bound.channel[2] = 0x50;
   objects[2].upper_bound.channel[0] = 0x50;
   objects[2].upper_bound.channel[1] = 0x50;
   objects[2].upper_bound.channel[2] = 0xA0;

   objects[3].lower_bound.channel[0] = 0x88;
   objects[3].lower_bound.channel[1] = 0x60;
   objects[3].lower_bound.channel[2] = 0x60;
   objects[3].upper_bound.channel[0] = 0x8f;
   objects[3].upper_bound.channel[1] = 0x70;
   objects[3].upper_bound.channel[2] = 0x70;


   objects[4].lower_bound.channel[0] = 0x30;
   objects[4].lower_bound.channel[1] = 0x30;
   objects[4].lower_bound.channel[2] = 0x50;
   objects[4].upper_bound.channel[0] = 0x50;
   objects[4].upper_bound.channel[1] = 0x50;
   objects[4].upper_bound.channel[2] = 0xA0;


   tracking_findConnectedness(image, objects);
   for(int i=0; i<8; i++){
     printf("Valid = %x \t", objects[i].objectValid);
     printf("left=%x, right=%x, top=%x, bottom=%x \n",objects[i].x0, objects[i].x1, objects[i].y0, objects[i].y1);
     image_png.square(objects[i].x1,objects[i].y1,objects[i].x0,objects[i].y0,255,255,255);
   }
   image_png.close();

  return 0;
}
