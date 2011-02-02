#include <iostream>
#include <ostream>
#include <fstream>
#include <math.h>
#include <string>
#include <unistd.h>

extern "C"{  // Add all headers used for .c files
#include "gpio_map.h"
#include "tracking.h"
#include "i2c-api.h"
#include "comms.h"
#include "comms-lib.h"
#include <errno.h>
#include "Log.h"
}

using namespace std;
#include <time.h>
#include <stdlib.h>
#include "capture.h"
#include "pngwriter.h"
#include <png.hpp>


#define SUB_FACTOR    1


  int                i2cDev;
  const char         *i2cDevName = "/dev/i2c-0";
  static I2C_Addr_t  I2cAddr = 0x3D;


void init_objects(trackedObject_t * objects){
  for(int i = 0; i<8; i++){
    objects[i].x0 = 0xffff;
    objects[i].y0 = 0xff;
    objects[i].x1 = 0x00;
    objects[i].y1 = 0x00;
    objects[i].objectValid = 0;
  }
}

void init_i2c(void){
  if (( i2cDev = open( i2cDevName, O_RDWR )) < 0 ) {
    LogError( "Error  opening '%s': %s\n", i2cDevName, strerror( errno ));
    exit( 1 );
  }
  I2cSetSlaveAddress( i2cDev, I2cAddr, I2C_NO_CRC );
}

void config_cam(unsigned char bright, unsigned char contrast){


  I2cWriteByte(i2cDev, 0x02, 0x00);  // Enable Camera
  I2cWriteByte(i2cDev, 0x02, 0x40);  // Reset Camera
  I2cWriteByte(i2cDev, 0x02, 0x00);  // Enable Camera
  I2cWriteByte(i2cDev, 0x0b, 0x00);  // White Line OFF 
  I2cWriteByte(i2cDev, 0x58, 0x10);  // Exposure
  I2cWriteByte(i2cDev, 0x05, 0x00);  // Frame rate full (0x80 quarter)
  I2cWriteByte(i2cDev, 0x0D, 0x01);  // DON'T REMOVE THIS LINE
  I2cWriteByte(i2cDev, 0x1a, 0xff);  // HCOUNT [7:0]
  I2cWriteByte(i2cDev, 0x1b, 0xb3);  // VCOUNT[3:0] HCOUNT [9:8]
  I2cWriteByte(i2cDev, 0x11, 0x4a);
  I2cWriteByte(i2cDev, 0x14, 0x33);
  I2cWriteByte(i2cDev, 0x04, 0x0c);
  I2cWriteByte(i2cDev, 0x1f, 0x0b);  // SPCOUNT[11:8]
  I2cWriteByte(i2cDev, 0x1e, 0xf9);  // SPCOUNT[7:0]
  I2cWriteByte(i2cDev, 0x0e, 0x0f);  //
  I2cWriteByte(i2cDev, 0x6d, 0x21);  // Disable AWB
  I2cWriteByte(i2cDev, 0x6d, 0x21);  // Disable AWB
//  I2cWriteByte(i2cDev, 0xE0, 0x40);  // Digital zoom[5:0]

  //Bright RGB General
//  I2cWriteByte(i2cDev, 0xd8, 0x3f);
//  I2cWriteByte(i2cDev, 0xd9, 0x3f);
//  I2cWriteByte(i2cDev, 0xda, 0x3f);
    I2cWriteByte(i2cDev, 0xdb, 60);  // 0x63
  //Contrast RGB General
//  I2cWriteByte(i2cDev, 0xd4, 0x20);
//  I2cWriteByte(i2cDev, 0xd5, 0x20);
//  I2cWriteByte(i2cDev, 0xd6, 0x20);
//  I2cWriteByte(i2cDev, 0xd7, contrast); // 0x29


//  I2cWriteByte(i2cDev, 0x2d, 0xb0);   // CB_MODE COLOR BAR MODE for test
}

int
main(int argc, char* argv[]){
  unsigned long      tmp;
  unsigned long      i, j;
  unsigned long      k;
  unsigned char      bright, contrast;
  char               *finalPtr;
  unsigned short RGB;
  rgb_t rgb[128*96];

  if(argc<=2){
    fprintf(stderr,"\nUsage: %s [0x00 -0xFF]Bright [0x00 -0xFF]Contrast Output file\n",argv[0]);
    return 1;
  }

/***************************************************************************
*                            CAPTURE NEW IMAGE                             *
****************************************************************************/
  bright   =  strtol(argv[1], &finalPtr, 16);
  contrast =  strtol(argv[2], &finalPtr, 16);

  pio_map(GPIOC_BASE, MAP_SIZE);
  pio_setup();

  ebi_map(0xFFFFFF7C, MAP_SIZE);
  ebi_setup();

  init_i2c();
  for(i=0; i < 0xFFFFF; i++){asm("nop");}
// Set RESET HI
  pio_out(RESET,1);
// Config Camera using I2C interface
  config_cam(bright, contrast);
    for(i=0; i < 0xFFFFF; i++){asm("nop");}
  tmp = 0;
  mem_map(CAMERA_BASE, MAP_SIZE);
  // Set RESET LOW   : The Capture interface will be waiting for capture signal
  pio_out(RESET,0);
    for(i=0; i < 0xFFFFF; i++){asm("nop");}
  for(j=0; j < 19; j++){
    // Generate a low edge on CAPTURE signal
    pio_out(CAPTURE,1);
    pio_out(CAPTURE,0);
    while( pio_in(C_DONE) == 0 ) {}
    for(i=0; i < 128*5; i++){
      RGB            = mem_get(i);
      rgb[tmp].blue  = ( (RGB >> 11) & 0x1F) << 3;
      rgb[tmp].green = ( (RGB >> 5)  & 0x3F) << 2;
      rgb[tmp].red   = (   RGB       & 0x1F) << 3;
      tmp++;
    }
  }
   cout << "Done.." << "\n "  << endl;
   mem_unmap(MAP_SIZE);
   ebi_unmap(MAP_SIZE);
   pio_unmap(MAP_SIZE);

/***************************************************************************
*                            FINDING COLOR BLOBS                             *
****************************************************************************/

  trackedObject_t objects[8];

   init_objects(objects);

   objects[0].lower_bound.channel[0] = 0x60;
   objects[0].lower_bound.channel[1] = 0x02;
   objects[0].lower_bound.channel[2] = 0x30;
   objects[0].upper_bound.channel[0] = 0xa0;
   objects[0].upper_bound.channel[1] = 0x06;
   objects[0].upper_bound.channel[2] = 0x50;

   objects[1].lower_bound.channel[0] = 0x30;
   objects[1].lower_bound.channel[1] = 0x30;
   objects[1].lower_bound.channel[2] = 0x50;
   objects[1].upper_bound.channel[0] = 0x50;
   objects[1].upper_bound.channel[1] = 0x50;
   objects[1].upper_bound.channel[2] = 0xA0;

   objects[2].lower_bound.channel[0] = 0x40;
   objects[2].lower_bound.channel[1] = 0x02;
   objects[2].lower_bound.channel[2] = 0x50;
   objects[2].upper_bound.channel[0] = 0x50;
   objects[2].upper_bound.channel[1] = 0x06;
   objects[2].upper_bound.channel[2] = 0x80;



   image_t image_track;

   image_track.channels = 3;
   image_track.width    = 128;
   image_track.height   = 94;  // image will hold just 1 row for scanline processing
   image_track.pix      = (unsigned char*)rgb;



   tracking_findConnectedness(image_track, objects);


/*
   166 pixels * 3 byes = 498 bytes = 294 words
   RG BR GB RG BR GB  

*/
    unsigned short tmp_index;
    rgb_t* prgb =  (rgb_t*)rgb;
    tmp_index=0;
    pngwriter image(128, 96, 0, argv[3]);
    for (unsigned short  y = 0; y < 96; ++y)
    {
      for (unsigned short x = 0; x < 128; ++x)
      {
        image.plot(x, 96-y, prgb[tmp_index].red, prgb[tmp_index].green, prgb[tmp_index].blue);
        tmp_index++;
      }
    }

   for(int i=0; i<5; i++){
     printf("Valid = %x \t", objects[i].objectValid);
     printf("left=%x, right=%x, top=%x, bottom=%x \n",objects[i].x0, objects[i].x1, objects[i].y0, objects[i].y1);
     image.square(objects[i].x0,(IMAGE_HEIGHT - objects[i].y0), objects[i].x1, (IMAGE_HEIGHT - objects[i].y1),255,255,0);
   }



    image.close();





//   printf("%s \n", argv[3]);
//   ofstream ofs(argv[3]);
//   ofs.write((const char*)rgb,128*95*3);

   return 0;
}
