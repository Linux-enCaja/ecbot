/**
*
*   @file   test.c
*
*   @brief  This file test ECB_AT91 ECBOT I2C communications.
*
****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <time.h>
#include <unistd.h>

#include "i2c-api.h"
#include "i2c-io-api.h"
#include "Log.h"

#define MIN_DIST 0x90

enum IRName { R40=0, R16, R90, R150, L16, L40, L90, L150 };

  unsigned char MAX(unsigned short num1, unsigned short num2)
  {
    if(num1 > num2)
      return (num1);
    else
      return (num2);
  }

int main( int argc, char **argv )
{
  int preferredTurn = 1;

  char turnrate = 0;
  char speed = 0x3f;
  unsigned short IR[8]={0x50,0x50,0x50,0x50,0x50,0x50,0x50,0x50}, IR_old[8];
  char left;
  char right;

  unsigned short Values[8];
  unsigned char i;


    for ( ; ; )
    {

      ReadAllIR(1, Values);

      for(i=0; i<8; i++){
        IR_old[i] = IR[i];
        IR[i] = Values[i];
        if( (IR[i] < 0x30) | (IR[i] > 0x3FF) )
          IR[i] = IR_old[i];
      }

//      printf("%X, %X, %X, %X, %X, %X, %X, %X \n", IR[0], IR[1], IR[2], IR[3], IR[4], IR[5],IR[6],IR[7] );

    if(IR[L16] >= MIN_DIST | IR[R16] >= MIN_DIST | IR[L40] >= MIN_DIST | IR[R40] >= MIN_DIST | IR[L150] >= MIN_DIST | IR[R150] >= MIN_DIST)
      SetLedColor(0, 0xff,0x01,0x01);
    else
      SetLedColor(0, 0x01,0xff,0x01);

    // Only react to objects closer than 0.4m off to the sides
    left   = MAX( MIN_DIST, IR[L16] );
    left  += MAX( MIN_DIST, IR[L40] );
    right  = MAX( MIN_DIST, IR[R16] );
    right += MAX( MIN_DIST, IR[R40] );	
    // Turn into the more open area
    if( left < right )
    {
      turnrate = 0x10; // turn 20 degrees per second
      preferredTurn = -1;
    }
    else if ( left > right )
    {
      turnrate = 0x10;
      preferredTurn = 1;
    }
    else
      turnrate = 0;

    SetSpeed( 1, (speed - turnrate), (speed + turnrate) );

    }



    return 0;
}
