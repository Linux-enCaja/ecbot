#ifndef MOTOR_H
#define MOTOR_H

#include "UM.h"

  /*
    INA  INB  OUTA  OUTB
     L    L    L     L
     H    L    H     L
     L    H    L     H
     H    H    Z     Z
     
    ------------------------
    DIR1 : INA = L INB = PWM 
    ------------------------
    INA  INB  OUTA  OUTB
     L    L    L     L
     L    H    L     H

    ------------------------
    DIR2 : INA = PWM INB = L 
    ------------------------
    INA  INB  OUTA  OUTB
     L    L    L     L
     H    L    H     L

    ------------------------
    FLOAT : INA = H INB = H	 
    ------------------------


  */

void InitPWM( void );

void Set_PWM_OCR(unsigned char ch, unsigned char AorB, unsigned char PWM_OCR);
void Set_PWM_State(unsigned char ch, unsigned char AorB, unsigned char State);
void SetMotorState(char Motor, char State);
void SetSpeed( char LSpeed, char RSpeed);



#endif
