#include <iostream>
#include <ostream>
#include <fstream>
#include <math.h>
#include <string>


extern "C"{
#include "gpio_map.h"
#include "tracking.h"
}


using namespace std;
#include <time.h>
#include <stdlib.h>
#include "capture.h"
//#include "pngwriter.h"
//#include <png.hpp>


#define SUB_FACTOR    1

#define IMAGE_WIDTH   498
#define IMAGE_HEIGHT  251

void init_objects(trackedObject_t * objects){
  for(int i = 0; i<8; i++){
    objects[i].x0 = 0xffff;
    objects[i].y0 = 0xff;
    objects[i].x1 = 0x00;
    objects[i].y1 = 0x00;
    objects[i].objectValid = 0;
  }
}




int
main(int argc, char **argv){


  unsigned long tmp;
  unsigned long i, j, k;

// 332 * 3 bytes = 996 = 498 words
// 166 * 3 bytes = 498 bytes = 249 bytes
  unsigned short rgb[249*126];

//  ofstream ofs("test.bin");
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// WARNING!! Please set the EBI port  first
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//for(;;){
  pio_map(GPIOC_BASE,MAP_SIZE_PIO);
  pio_setup();

  MemMap fpga(CAMERA_BASE, MAP_SIZE);

  if(argc<=1){
    fprintf(stderr,"\nUsage: %s [R]eset/[C]apture Value[0/1]\n\n",argv[0]);
    return 1;
  }
  if(argv[1][0]=='R' || argv[1][0]=='r'){
    pio_out(RESET,atoi(argv[2]));
  }
  if(argv[1][0]=='C'|| argv[1][0]=='c'){
    pio_out(CAPTURE,atoi(argv[2]));
  }

   mem_unmap(MAP_SIZE_PIO);

//   ofstream ofs("test.bin");
//   ofs.write((const char*)rgb,498*125);

   return 0;
}
