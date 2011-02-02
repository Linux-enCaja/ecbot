#ifndef CAPTURE_H
#define CAPTURE_H

#include "memmap.h"
#include "AT91Regs.h"
#include "gpio_map.h"

#define GPIOC_BASE    0xFFFFF800l
#define CAMERA_BASE   0x40000000l


#define MAP_SIZE_PIO 8192Ul
#define MAP_MASK_PIO (MAP_SIZE_PIO - 1)

#define MAP_SIZE 0x2000000l    // ECBOT USE A11 to A25 
#define MAP_MASK (MAP_SIZE - 1)

typedef struct {
    unsigned char red;
    unsigned char green;
    unsigned char blue;  // This can be used for binary images etc in the future
} rgb_t;


union rgb565
{
  struct {
    char R:5;
    char G:6;
    char B:5;
  } rgb;
  unsigned short data;
};


#endif


