/****************************************************************************
*
*   @file   comms-lib.c
*
*   @brief  This file immplements the i2c operations on the ECB_AT91.
*
****************************************************************************/

#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdio.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <math.h>
#include <stdlib.h>  /* for abs() */
#include <netinet/in.h>
#include <ctype.h>


#include "i2c-io-api.h"
#include "i2c-api.h"
#include "i2c-io.h"
#include "Log.h"

#define TRUE    1
#define FALSE   0

I2C_Addr_t  US1_addr=US1, US2_addr=US2, US3_addr=US3, US4_addr=US4, UM_addr=UM;

int i2cDevice;

int OpenPort()
{
  if (( i2cDevice = open( ECBOT_DEFAULT_I2C_PORT, O_RDWR )) < 0 )
  {
    printf( "Error  opening '%s': %s\n", ECBOT_DEFAULT_I2C_PORT, strerror( errno ));
    return -1;
  }
  return 0;
}

void ClosePort(void)
{
    close(i2cDevice);
}

/* this will set the desired speed for the given motor mn */
int SetSpeed(int i2cDev, char Motor_L_Speed, char Motor_R_Speed)
{
	char Values[2];
	Values[0] = Motor_L_Speed;
	Values[1] = Motor_R_Speed;
	char  rc;

	OpenPort();
        I2cSetSlaveAddress ( i2cDevice, UM_addr, I2C_NO_CRC );

	if( ( rc = I2cWriteBytes(i2cDevice, SET_VEL, &Values, 3 )) != 0){
            return FALSE;	
	}
	ClosePort();
        return TRUE;
}


void ConfigPosPID(int i2cDev, int kp, int ki, int kd)
{
	char Values[3];
	Values[0] = kp;
	Values[1] = ki;
	Values[2] = kd;
	char  rc;

	OpenPort();
        I2cSetSlaveAddress ( i2cDevice, UM_addr, I2C_NO_CRC );

	if( ( rc = I2cWriteBytes(i2cDevice, SET_POS_PID, &Values, 3 )) != 0){
            LogError( "I2cWriteBytes Failed %d\n",rc);
	}
	ClosePort();
}
void ConfigSpeedPID(int i2cDev, int kp, int ki, int kd)
{
	char Values[3];
	Values[0] = kp;
	Values[1] = ki;
	Values[2] = kd;
	char  rc;

	OpenPort();
        I2cSetSlaveAddress ( i2cDevice, UM_addr, I2C_NO_CRC );

	if( ( rc = I2cWriteBytes(i2cDevice, SET_VEL_PID, &Values, 3 )) != 0){
            LogError( "I2cWriteBytes Failed %d\n",rc);
	}
	ClosePort();
}

void ConfigSpeedProfile(int i2cDev, int speed, int acc)
{
	char Values[2];
	Values[0] = speed;
	Values[1] = acc;
	char  rc;

	OpenPort();

        I2cSetSlaveAddress ( i2cDevice, UM_addr, I2C_NO_CRC );

	if( ( rc = I2cWriteBytes(i2cDevice, SET_VEL_PRO, &Values, 2 )) != 0){
            LogError( "I2cWriteBytes Failed %d\n",rc);
	}
	ClosePort();
}


int ReadAllIR(int i2cDev, unsigned short* Values) 
{
//	unsigned short Values[8];
	unsigned char  IR_Val1[4];
	unsigned char  IR_Val2[4];
	unsigned char  IR_Val3[4];
	unsigned char  IR_Val4[4];
	unsigned int   i;

	char rc;

	OpenPort();
	
	I2cSetSlaveAddress ( i2cDevice, US1_addr, I2C_NO_CRC );
	if( ( rc = I2cReadBytes(i2cDevice, READ_IR, &IR_Val1, 4 )) != 0){
            return FALSE;	
	}
	if( ( rc = I2cReadBytes(i2cDevice, READ_IR, &IR_Val1, 4 )) != 0){
            return FALSE;	
	}

	I2cSetSlaveAddress ( i2cDevice, US2_addr, I2C_NO_CRC );
	if( ( rc = I2cReadBytes(i2cDevice, READ_IR, &IR_Val2, 4 )) != 0){
            return FALSE;	
	}
	if( ( rc = I2cReadBytes(i2cDevice, READ_IR, &IR_Val2, 4 )) != 0){
            return FALSE;	
	}

	I2cSetSlaveAddress ( i2cDevice, US3_addr, I2C_NO_CRC );
	if( ( rc = I2cReadBytes(i2cDevice, READ_IR, &IR_Val3, 4 )) != 0){
            return FALSE;	
	}
	if( ( rc = I2cReadBytes(i2cDevice, READ_IR, &IR_Val3, 4 )) != 0){
            return FALSE;	
	}

	I2cSetSlaveAddress ( i2cDevice, US4_addr, I2C_NO_CRC );
	if( ( rc = I2cReadBytes(i2cDevice, READ_IR, &IR_Val4, 4 )) != 0){
            return FALSE;	
	}
	if( ( rc = I2cReadBytes(i2cDevice, READ_IR, &IR_Val4, 4 )) != 0){
            return FALSE;	
	}
	Values [0] = ((IR_Val4[1] -1) << 8) | (IR_Val4[0] -1);
	Values [1] = ((IR_Val4[3] -1) << 8) | (IR_Val4[2] -1);
	Values [2] = ((IR_Val3[1] -1) << 8) | (IR_Val3[0] -1);
	Values [3] = ((IR_Val3[3] -1) << 8) | (IR_Val3[2] -1);
	Values [4] = ((IR_Val2[1] -1) << 8) | (IR_Val2[0] -1);
	Values [5] = ((IR_Val2[3] -1) << 8) | (IR_Val2[2] -1);
	Values [6] = ((IR_Val1[1] -1) << 8) | (IR_Val1[0] -1);
	Values [7] = ((IR_Val1[3] -1) << 8) | (IR_Val1[2] -1);

	ClosePort();
	return 0;
}



int
SetLedColor(int i2cDev, unsigned char red, unsigned char green, unsigned char blue)
{
	unsigned char  LED_Color[4];
	char rc;

	LED_Color[0] = red;
	LED_Color[1] = green;
	LED_Color[2] = blue;
	LED_Color[3] = 0x02;

	OpenPort();
	I2cSetSlaveAddress ( i2cDevice, US1_addr, I2C_NO_CRC );
	if( ( rc = I2cWriteBytes(i2cDevice, SET_COLOR, &LED_Color, 5 )) != 0){
            return FALSE;	
	}
	if( ( rc = I2cWriteBytes(i2cDevice, SET_COLOR, &LED_Color, 5 )) != 0){
            return FALSE;	
	}
	ClosePort();

	OpenPort();
	I2cSetSlaveAddress ( i2cDevice, US2_addr, I2C_NO_CRC );
	if( ( rc = I2cWriteBytes(i2cDevice, SET_COLOR, &LED_Color, 5 )) != 0){
            return FALSE;	
	}
	if( ( rc = I2cWriteBytes(i2cDevice, SET_COLOR, &LED_Color, 5 )) != 0){
            return FALSE;	
	}
	ClosePort();

	OpenPort();
	I2cSetSlaveAddress ( i2cDev, US3_addr, I2C_NO_CRC );
	if( ( rc = I2cWriteBytes(i2cDevice, SET_COLOR, &LED_Color, 5 )) != 0){
            return FALSE;	
	}
	if( ( rc = I2cWriteBytes(i2cDevice, SET_COLOR, &LED_Color, 5 )) != 0){
            return FALSE;	
	}
	ClosePort();

	OpenPort();
	I2cSetSlaveAddress ( i2cDevice, US4_addr, I2C_NO_CRC );
	if( ( rc = I2cWriteBytes(i2cDevice, SET_COLOR, &LED_Color, 5 )) != 0){
            return FALSE;	
	}
	if( ( rc = I2cWriteBytes(i2cDevice, SET_COLOR, &LED_Color, 5 )) != 0){
            return FALSE;	
	}
	ClosePort();

	return 0;
}
