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
#include "Log.h"


#include "comms.h"
#include "comms-lib.h"

int main( int argc, char **argv )
{
   int                  i2cDev;
   const char           *i2cDevName = "/dev/i2c-0";
   static I2C_Addr_t  	I2cAddr = 0x3D;
//   Get_IR_Value_t       *adcVal;
   uint8_t             adcVal[4];

   time_t               prevTime;
   time_t               endTime;
   uint8_t       	      count = 0;
   
    LogInit( stdout );

    if (( i2cDev = open( i2cDevName, O_RDWR )) < 0 )
    {
        LogError( "Error  opening '%s': %s\n", i2cDevName, strerror( errno ));
        exit( 1 );
    }

    I2cSetSlaveAddress( i2cDev, I2cAddr, I2C_NO_CRC );

    for ( ; ; )
    {

    	count++;
	prevTime = time( NULL );
    	while ( time( NULL ) == prevTime )
    	{
        	;
    	}
    	endTime = prevTime + 1;

      ReadIRSensors( i2cDev, adcVal );
      
      printf("%X, %X, %X, %X \n", adcVal[0], adcVal[1], adcVal[2], adcVal[3] );


	
    }

    close( i2cDev );
    printf("cain\n");

    return 0;
}
