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

#ifdef  __cplusplus
extern "C" {
#endif



#include <inttypes.h>
#include "i2c.h"
    

#define   ECBOT_DEFAULT_I2C_PORT "/dev/i2c-0"
#define   US4       0x40
#define   US3       0x30
#define   US2       0x20
#define   US1       0x10

#define   UM        0x05


#define SET_VEL     0x10    // SET_VEL LV RV 
#define GET_VEL     0x20    // SET_VEL LV RV 
#define SET_POS_PID 0x30    // KP KI KD MOT
#define SET_VEL_PID 0x40    // KP KI KD MOT
#define SET_VEL_PRO 0x50    // VEL ACC MOT

#define SET_COLOR   0x10   // Set RGB LED color: RED GREEN BLUE LED (0: LED1 1: LED2 2: BOTH)
#define READ_IR     0x20   // Read IR sensor: IR1 IR2


//int IR_Read(unsigned char IR_sensor);
//int Led_SetColor(unsigned char Led, unsigned char Ambar, unsigned char Green, unsigned char Blue);
//int Set_PID_Vel(unsigned char Motor, unsigned char kP, unsigned char kI, unsigned char kD);
//int Set_PID_Pos(unsigned char Motor, unsigned char kP, unsigned char kI, unsigned char kD);
//int Set_Pos(unsigned char Motor, signed int Pos);
int SetSpeed(int i2cDev, char Motor_L_Speed, char Motor_R_Speed);
int SetLedColor(int i2cDev, unsigned char red, unsigned char green, unsigned char blue);

//int Enable_Motor(Unsigned char Motor_L_State, Unsigned char Motor_R_State);
void ConfigPosPID(int, int, int, int);
void ConfigSpeedPID(int, int, int, int);
void ConfigSpeedProfile(int, int, int);
int  ReadAllIR(int i2cDev, unsigned short *);


/*
We have 8 IR proximity sensors, Two motors and (8 x 3) Leds, managed by 5 AVR microcontrollers.

AVR CPU   I2C Addr.  DEVICE
  US4       0x40    IR0, IR1   D[A,G,B]7, D[A,G,B]6
  US3       0x30    IR2, IR3   D[A,G,B]5, D[A,G,B]4
  US2       0x20    IR4, IR5   D[A,G,B]8, D[A,G,B]3
  US1       0x10    IR6, IR7   D[A,G,B]2, D[A,G,B]1

  UM       0x05    MOTL, MOTR

IR and Led Functions:

IR_Read(unsigned char IR_sensor);
Led_SetColor(unsigned char Led, unsigned char Ambar, unsigned char Green, unsigned char Blue);

Motor functions:
Set_PID_Vel(unsigned char Motor, unsigned char kP, unsigned char kI, unsigned char kD);
Set_PID_Pos(unsigned char Motor, unsigned char kP, unsigned char kI, unsigned char kD);
Set_Pos(unsigned char Motor, signed int Pos);
Set_Speed(unsigned char Motor_L_Speed, unsigned char Motor_R_Speed);
Enable_Motor(Unsigned char Motor_L_State, Unsigned char Motor_R_State);

  - PLAYER_POSITION_GET_GEOM_REQ
  - PLAYER_POSITION_SET_ODOM_REQ :
  - PLAYER_POSITION_RESET_ODOM_REQ :
  - PLAYER_POSITION_SPEED_PROF_REQ :
*/


#ifdef  __cplusplus
}
#endif

#endif  // I2C_IO_API_H

