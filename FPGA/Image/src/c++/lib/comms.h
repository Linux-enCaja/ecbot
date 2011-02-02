/****************************************************************************
*
*   @file   comms.h
*
*   @brief  This file defines the interface to the i2c program which
*           runs on the ECBOT.
*
*****************************************************************************/

#if !defined( COMMS_H )
#define COMMS_H            /**< Include Guard                             */


#define ECBOT_STATUS	0x00
#define BUSY		0x00
#define READY		0x01


#define MOTOR_PID_CTLR		0x01

typedef struct
{
    uint8_t	PGain;
    uint8_t	IGain;
    uint8_t	DGain;

} MOTOR_CTRLR_t;


#define MOTOR_LOCOMOTION	0x04
#define FORWARD		0x00
#define REVERSE		0x01
#define TURN_L		0x02
#define TURN_R		0x03
#define HOLD		0x04

typedef struct
{
    uint8_t     Direction;
    uint8_t     Velocity;
    uint8_t     Acceleration;
    uint16_t	Distance;
} MOTOR_LOC_t;



//---------------------------------------------------------------------------
/**
*   The I2C_IO_GET_GPIO command retrieves the values of the pins indicated
*   by portNum.
*
*   The portNum is set such that 0 = A, 1 = B, etc.
*
*   A block-reply with a single 8 bit value is returned.
*/

typedef struct
{
    uint8_t     portNum;
    uint8_t     pinMask;
    uint8_t     pinVal;
    uint8_t	pinCmd;

} Set_GPIO_t;

#define SET_GPIO		0x08

#define GET_IR_VALUE		0x20

typedef struct{
   uint8_t     IR1;
   uint8_t     IR2;
   uint8_t     IR3;
   uint8_t     IR4;
}Get_IR_Value_t;

#endif /* I2C_IO_H */

