#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "tracking.h"


/*  Local Variables */
static trackedObject_t trackedObjectTable[MAX_TRACKED_OBJECTS];
static unsigned char CurrLine = 0;

unsigned char check_pixel(trackedObject_t * patron, pixel_t under_test){
  if( under_test.channel[0] >= patron->lower_bound.channel[0]
   && under_test.channel[0] <= patron->upper_bound.channel[0]
   && under_test.channel[1] >= patron->lower_bound.channel[1]
   && under_test.channel[1] <= patron->upper_bound.channel[1]
   && under_test.channel[2] >= patron->lower_bound.channel[2]
   && under_test.channel[2] <= patron->upper_bound.channel[2])
    return 1;
  else
    return 0; 
}

void get_pixel(image_t * img, unsigned short x, unsigned short y, pixel_t * out_pix)
{
    unsigned int index, width;
    width = img->width;
    index = (y*width*3 + (x*3));
    out_pix->channel[0] = ((unsigned char *) img->pix)[index];
    out_pix->channel[1] = ((unsigned char *) img->pix)[index + 1];
    out_pix->channel[2] = ((unsigned char *) img->pix)[index + 2];
}

void tracking_init(void)
{
}

void tracking_processLine(image_t image, trackedObject_t * objects)
{
}
	
void tracking_findConnectedness(image_t image, trackedObject_t * objects)
{

  pixel_t cp;
  unsigned char i,j;
  unsigned short runLength[7]    = {1,1,1,1,1,1,1};
  unsigned short CurrPixel;
  unsigned char  start_detect[7] = {0,0,0,0,0,0,0};
  bool_t colorConnected, overlap;	

    memset(runLength, 0x00, 8);
    memset(start_detect, 0x00, 8);
  for(CurrLine = 4; CurrLine < IMAGE_HEIGHT-4; CurrLine++){
    for(CurrPixel = 4; CurrPixel < LINE_WIDTH-4; CurrPixel++){
      colorConnected = FALSE;
      //Get a pixel from image buffer
      get_pixel(&image, CurrPixel, CurrLine, &cp);
      for (i=0; i < MAX_TRACKED_OBJECTS; i++){
        // Check for object color
        if( (check_pixel( &objects[i], cp ) == 1 ) ) {
          // First pixel detected
          if(start_detect[i] == 1){
            // check if there is any pixel on boundary
            if (((CurrPixel  >= objects[i].x0) && (CurrPixel  <= objects[i].x1) )
              ||((CurrPixel  >= (objects[i].x0 - MIN_WIDTH)) && (CurrPixel  <= (objects[i].x1) + MIN_WIDTH) ) )
              colorConnected = TRUE;
            overlap = FALSE;
            for (j=0; j<i; j++){
              if( (CurrPixel  >= (objects[j].x0)) && (CurrPixel  <= (objects[j].x1)) ){
                overlap = TRUE;
              }
            }
            if( (colorConnected == TRUE) && (overlap == FALSE) ){
              /* check if the bounding box needs to be updated */
              if( (objects[i].x0) > CurrPixel){
                objects[i].x0 = CurrPixel;
              }
              if( ( objects[i].x1) < CurrPixel){
                objects[i].x1 = CurrPixel;
              }
              objects[i].y1 = CurrLine;
            } // if( colorConnected...
            else{
              start_detect[i] = 0;
              objects[i].objectValid = FALSE;
            }
          }
          else{ // first pixel
            overlap = FALSE;
            for (j=0; j<i; j++){
              if( (CurrPixel  >= (objects[j].x0)) && (CurrPixel  <= (objects[j].x1)) ){
                overlap = TRUE;
              }
            }
            if(overlap == FALSE){
              objects[i].x0 = CurrPixel;
              objects[i].y0 = CurrLine -1;
              objects[i].x1 = CurrPixel + MIN_WIDTH;
              objects[i].y1 = CurrLine;
              start_detect[i] = 1;
              objects[i].objectValid = TRUE;
            }
          } // if (colorConeccted..else        
        } // check pixel
      } //for (i=0; i < MAX_TRACKED
    }  //for(CurrPixel

  }  //for(CurrLine



}
