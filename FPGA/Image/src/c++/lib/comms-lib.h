/***************************************************************************
*
*   @file   i2c-io-api.h
*
*   @brief  This file contains definitions for performing i2c-io operations 
*           on the ECB_AT91.
*
****************************************************************************/

#if !defined( COMMS_LIB_H )
#define COMMS_LIB_H

#include <inttypes.h>
#include "comms.h"



//----------------------------------------------------------------------------//                               MISC
//****************************************************************************/
int Motion_Status( void );
int Set_PID_CTRLR( int i2cDev, uint8_t PGain, uint8_t IGain, uint8_t DGain );


//---------------------------------------------------------------------------//                               LOCOMOTION
/**
*  ECBOT V1.0 has two wheels so we have the following motion posibilities:
*  
*  Forward, Reverse, TurnRight, TurnLeft
*
****************************************************************************/
int ECBOT_Motion( int i2cDev, uint8_t Direction, uint8_t Velocity, uint8_t Acceleration, uint16_t Distance );


//---------------------------------------------------------------------------//                         ENVIRONMENT MEASUREMENT
/**
*  ECBOT V1.0 has four IR distance sensor  TODO: ADD a optic mouse sensor
*  
****************************************************************************/
//
int ReadIRSensors( int i2cDev, uint8_t adcval[4] );


//---------------------------------------------------------------------------//                         GPIO OPERATIONS
/**
*  ECBOT V1.0 has 10 GPIO
*  
****************************************************************************/

    

int SetGPIODir( int i2cDev, uint8_t portNum, uint8_t pinMask, uint8_t pinVal );
int SetGPIO( int i2cDev, uint8_t portNum, uint8_t pinMask, uint8_t pinVal );
int GetGPIO( int i2cDev, uint8_t portNum, uint8_t pinMask, uint8_t pinVal );

#endif  // I2C_IO_API_H

