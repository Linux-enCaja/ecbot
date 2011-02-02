#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "tracking.h"


/*  Local Variables */
static trackedObject_t trackedObjectTable[MAX_TRACKED_OBJECTS];
static trackedObject_t *pCurrentTrackedObjectTable = trackedObjectTable;
static unsigned char numCurrTrackedObjects = 0;
static unsigned char trackedLineCount = 0;
static unsigned char currentLineBuffer[LENGTH_OF_LINE_BUFFER];


unsigned char check_pixel(trackedColors_t * patron, pixel_t under_test){
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

unsigned char detect_pixel( trackedColors_t * patron, pixel_t under_test ){
  unsigned char i;
  
  for(i=0; i<MAX_TRACKED_OBJECTS; i++){
      if(  under_test.channel[0] >= patron[i].lower_bound.channel[0]
        && under_test.channel[0] <= patron[i].upper_bound.channel[0]
        && under_test.channel[1] >= patron[i].lower_bound.channel[1]
        && under_test.channel[1] <= patron[i].upper_bound.channel[1]
        && under_test.channel[2] >= patron[i].lower_bound.channel[2]
        && under_test.channel[3] <= patron[i].upper_bound.channel[2])
        return i;
      }
  return 0xEE;
}


void tracking_init(void)
{
	memset(trackedObjectTable,0x00,sizeof(trackedObjectTable));
}

void tracking_processLine(image_t image, trackedObject_t * objects, trackedColors_t * colors)
{
  unsigned char i;
  unsigned char *pTrackedObjectData = (unsigned char *)pCurrentTrackedObjectTable;
 	
  /* determine if any of the RLE blocks overlap */
  tracking_findConnectedness(image, objects, colors);
  /* we also want to remove any objects that are less than a minimum height
     run this routine once every 8 lines */       
  if ( (trackedLineCount & RUN_OBJECT_FILTER_MASK) == RUN_OBJECT_FILTER_MASK)
  {
    for (i=0; i<MAX_TRACKED_OBJECTS; i++){
      if ( *(pTrackedObjectData + VALID_OBJECT_OFFSET) == TRUE){
        /* check to see if the object is already in our past...i.e., its last */
        if ( (*(pTrackedObjectData + Y_LOWER_RIGHT_OFFSET) - 
              *(pTrackedObjectData + Y_UPPER_LEFT_OFFSET)) < MIN_OBJECT_TRACKING_HEIGHT){
          /* the object is less than the minimum height...see if it is adjacent
          to the current line we just processed...if so, leave it here...otherwise,
          it needs to be invalidated since its too small */
          if ( trackedLineCount - *(pTrackedObjectData + Y_LOWER_RIGHT_OFFSET) > 2){
            /* invalidate the object */
            *(pTrackedObjectData + VALID_OBJECT_OFFSET) = FALSE;
            numCurrTrackedObjects--;
          }
        }
      }
      pTrackedObjectData += SIZE_OF_TRACKED_OBJECT;
    }
  }     
  trackedLineCount++;
  if (trackedLineCount == ACTUAL_NUM_LINES_IN_A_FRAME){
     /* an entire frame of tracking data has been acquired, so
     publish an event letting the system know this fact */
    trackedLineCount = 0;
  }
}
	
void tracking_findConnectedness(image_t image, trackedObject_t * objects, trackedColors_t * colors)
{

  pixel_t cp;
  unsigned char i;
  unsigned short currLineStart   = 0;
  unsigned short currLineFinish  = 0; 
  unsigned char  lastLineXStart  = 0;
  unsigned char  lastLineXFinish = 255;  
  unsigned short runLength       = 1;
  unsigned short currPixel;
  unsigned short colorConnected[8] = {FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE},
  bool_t colorConnected;	


  for(trackedLineCount = 0; trackedLineCount < ACTUAL_NUM_LINES_IN_A_FRAME; trackedLineCount++){
    currLineStart   = 0;
    currLineFinish  = 0; 
    runLength       = 1;
    for(currPixel = 0; currPixel < ACTUAL_NUM_PIXELS_IN_A_LINE; currPixel++){
      colorConnected = FALSE;
      get_pixel(&image, currPixel, trackedLineCount, &cp);
      runLength++;
      if( (detect_pixel(colors, cp)!= 0xEE) && (runLength > MIN_OBJECT_TRACKING_WIDTH) ){
        for (i=0; i<MAX_TRACKED_OBJECTS; i++){
          if( (check_pixel( &colors[objects[i].Color], cp ) == 1 ) 
           && ( (objects[i].y1 == (trackedLineCount - 1) ) )
           && ( objects[i].objectValid == TRUE ) ){
             lastLineXStart  = objects[i].lastLineXStart;
             lastLineXFinish = objects[i].lastLineXFinish;
             if ( ( (currLineStart  >= lastLineXStart) && (currLineStart  <= lastLineXFinish) ) ||  // I.
                  ( (currLineFinish >= lastLineXStart) && (currLineFinish <= lastLineXFinish) ) ||  // II.
                  ( (currLineStart  <= lastLineXStart) && (currLineFinish >= lastLineXFinish) ) )   // III.
             {
               objects[i].lastLineXStart   = currPixel;
               objects[i].lastLineXFinish  = currPixel;
               /* check if the bounding box needs to be updated */
               if( (objects[i].x0) > currPixel){
                 objects[i].x0 = currPixel;
               }
               if( ( objects[i].x1) < currPixel){
                 objects[i].x1 = currPixel;
               }
             }
             objects[i].y1  = trackedLineCount;
						 colorConnected = TRUE;
						 break;
          }  // end if( (check_pixel..
        } // end for (i=0 ..
        if (colorConnected == FALSE)
			  {

  				if (numCurrTrackedObjects < MAX_TRACKED_OBJECTS)
  				{          

             for (i=0; i<MAX_TRACKED_OBJECTS; i++){
               if ( objects[i].objectValid == FALSE)  break;
             }


               objects[i].Color = detect_pixel(colors, cp);
               objects[i].lastLineXStart = currLineStart;
               objects[i].lastLineXFinish = currLineFinish;
               objects[i].x0 = currPixel;
               objects[i].y0 = trackedLineCount;
               objects[i].x1 = currPixel;
               objects[i].y1 = trackedLineCount;
               objects[i].objectValid = TRUE;
  					   numCurrTrackedObjects++;

  				}
        }
      } // end if( (detect_pixel...

    } //for(currPixel = 0;



    if ( (trackedLineCount & RUN_OBJECT_FILTER_MASK) == RUN_OBJECT_FILTER_MASK)
    {
      for (i=0; i<MAX_TRACKED_OBJECTS; i++){
        if ( objects[i].objectValid == TRUE)
          if ( objects[i].y1  - objects[i].y0 < MIN_OBJECT_TRACKING_HEIGHT){
            if ( trackedLineCount - objects[i].y1 > 2){
              objects[i].objectValid = FALSE;
              numCurrTrackedObjects--;
            }
          }
      }
    } 



  } // for(trackedLineCount



}