/****************************************************************************
*
*   @file   comms-lib.c
*
*   @brief  This file immplements the i2c operations on the ECB_AT91.
*
****************************************************************************/

#include <string.h>
#include <errno.h>

#include "i2c-api.h"
#include "comms.h"
#include "comms-lib.h"
#include "Log.h"

#define TRUE    1
#define FALSE   0


//----------------------------------------------------------------------------//                               MISC
//****************************************************************************/
int Motion_Status( void )
{
   return 0;
}

int Set_PID_CTRLR( int i2cDev, uint8_t PGain, uint8_t IGain, uint8_t DGain )
{
   MOTOR_CTRLR_t PIdCtrlr;
   PIdCtrlr.PGain = PGain;
   PIdCtrlr.IGain = IGain;
   PIdCtrlr.DGain = DGain;
   
    if ( I2cWriteBlock( i2cDev, MOTOR_PID_CTLR, &PIdCtrlr, sizeof( PIdCtrlr )) != 0 )
    {
        LogError( "ECBOT_MOTION: I2cWriteBlock failed: %s (%d)\n", strerror( errno ), errno );
        return FALSE;
    }
    return TRUE;
       
}


//---------------------------------------------------------------------------//                               LOCOMOTION
/**
*  ECBOT V1.0 has two wheels so we have the following motion posibilities:
*  
*  Forward, Reverse, TurnRight, TurnLeft
*
****************************************************************************/
int ECBOT_Motion( int i2cDev, uint8_t Direction, uint8_t Velocity, uint8_t Acceleration, uint16_t Distance ){

   MOTOR_LOC_t  motion;
   
   motion.Direction    = Direction;
   motion.Velocity     = Velocity;
   motion.Acceleration = Acceleration;
   motion.Distance     = Distance;

    if ( I2cWriteBlock( i2cDev, MOTOR_LOCOMOTION, &motion, sizeof( motion )) != 0 )
    {
        LogError( "ECBOT_MOTION: I2cWriteBlock failed: %s (%d)\n", strerror( errno ), errno );
        return FALSE;
    }
    return TRUE;
   
}



//***************************************************************************
/**
*   Sets the direction of a pin.
*/

int SetGPIODir( int i2cDev, uint8_t portNum, uint8_t pinMask, uint8_t pinVal )
{

    Set_GPIO_t pin;
    
    pin.portNum = portNum;
    pin.pinMask = pinMask;
    pin.pinVal  = pinVal;
    
    if ( I2cWriteBlock( i2cDev, SET_GPIO, &pin, sizeof( pin )) != 0 )
    {
        LogError( "I2C_IO_SetGPIODir: I2cWriteBlock failed: %s (%d)\n", strerror( errno ), errno );
        return FALSE;
    }
    return TRUE;
    
}


//***************************************************************************
/**
*   Sets the value of a pin.
*/

int SetGPIO( int i2cDev, uint8_t portNum, uint8_t pinMask, uint8_t pinVal )
{

    Set_GPIO_t pin;
    
    pin.portNum = portNum;
    pin.pinMask = pinMask;
    pin.pinVal  = pinVal;

    if ( I2cWriteBlock( i2cDev, SET_GPIO, &pin, sizeof( pin )) != 0 )
    {
        LogError( "I2C_IO_SetGPIO: I2cWriteBlock failed: %s (%d)\n", strerror( errno ), errno );
        return FALSE;
    }
    return TRUE;

}


//***************************************************************************
/**
*   Retrieves the value of a pin.
*/

int GetGPIO( int i2cDev, uint8_t portNum, uint8_t pinMask, uint8_t pinVal )
{
/*    I2C_IO_Get_GPIO_t   getReq;
    uint8_t             bytesRead = 0;

    getReq.portNum = portNum;

    if ( I2cProcessBlock( i2cDev, I2C_IO_GET_GPIO, &getReq, sizeof( getReq ), pinVal, sizeof( *pinVal ), &bytesRead ) != 0 )
    {
        LogError( "I2C_IO_GetGPIO: I2cProcessBlock failed: %s (%d)\n", strerror( errno ), errno );
        return FALSE;
    }
*/
    return TRUE;
    
}


//---------------------------------------------------------------------------//                         ENVIRONMENT MEASUREMENT
/**
*  ECBOT V1.0 has four IR distance sensor  TODO: ADD a optic mouse sensor
*  
****************************************************************************/
//int ReadIRSensors( int i2cDev, Get_IR_Value_t *adcVal ){
int ReadIRSensors( int i2cDev, uint8_t adcVal[4] ){
   
   if ( I2cReadBytes( i2cDev, GET_IR_VALUE, adcVal, 4 ) != 0 )
    {
        LogError( "I2C_IO_GetADC: I2cProcessBlock failed: %s (%d)\n", strerror( errno ), errno );
        return FALSE;
    }
    return TRUE;
}





