#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdlib.h> 
#include "i2c_avr.h"
#include "avr_compat.h"
#include "motor.h"
#include "UM.h"

void InitPWM( void )
{
  DDRB  = ( 1 << INA_L ) | ( 1 << INB_L );
  DDRD  = ( 1 << INA_R ) | ( 1 << INB_R );
  // Fast PWM TOP=OCRA,B
  sbi(TCCR0A,WGM00);
  sbi(TCCR0A,WGM01);
  cbi(TCCR0B,WGM02);
  // TCCR1 16 bit timer !!
  sbi(TCCR1A,WGM10);
  cbi(TCCR1A,WGM11);
  sbi(TCCR1B,WGM12);
  cbi(TCCR1B,WGM13);

  // Set Prescaler
  TCCR0B = ((TCCR0B & ~TIMER_PRESCALE_MASK) | PWM_PRESCALE);
  TCCR1B = ((TCCR1B & ~TIMER_PRESCALE_MASK) | PWM_PRESCALE);
}

void Set_PWM_State(unsigned char ch, unsigned char AorB, unsigned char State)
{
  if(ch == OCR){       // RMotor attached to OC0
    if(AorB == CHA){
      if(State == ON){
	sbi(TCCR0A,COM0A1);
	cbi(TCCR0A,COM0A0);
      }
      else{
	cbi(TCCR0A,COM0A1);
	cbi(TCCR0A,COM0A0);
      }
    }
    else if (AorB == CHB){
      if(State == ON){
	sbi(TCCR0A,COM0B1);
	cbi(TCCR0A,COM0B0);
      }
      else{
	cbi(TCCR0A,COM0B1);
	cbi(TCCR0A,COM0B0);
      }
    }
  }
  else if(ch == OCL){  // LMotor attached to OC1
    if(AorB == CHA){
      if(State == ON){
	sbi(TCCR1A,COM1A1);
	cbi(TCCR1A,COM1A0);
      }
      else{
	cbi(TCCR1A,COM1A1);
	cbi(TCCR1A,COM1A0);
      }
    }
    else if (AorB == CHB){
      if(State == ON){
	sbi(TCCR1A,COM1B1);
	cbi(TCCR1A,COM1B0);
      }
      else{
	cbi(TCCR1A,COM1B1);
	cbi(TCCR1A,COM1B0);
      }
    }
  }
}

void Set_PWM_OCR(unsigned char ch, unsigned char AorB, unsigned char PWM_OCR)
{
  if(ch == OCR){       // RMotor attached to OC0
    if(AorB == CHA)
      OCR0A = PWM_OCR;
    else if (AorB == CHB)
      OCR0B = PWM_OCR;
  }
  else if(ch == OCL){  // LMotor attached to OC1
    if(AorB == CHA)
      OCR1A = PWM_OCR;
    else if (AorB == CHB)
      OCR1B = PWM_OCR;
  }
}

void SetSpeed(char LSpeed, char RSpeed){ // L,RSpeed 0-7f  80-ff
  if(LSpeed >= 0){  // DIR1 : INA = L INB = PWM
    Set_PWM_State(OCL, CHA, ON);
    Set_PWM_State(OCL, CHB, OFF);
    cbi( P_LMOTOR, INA_L );
    Set_PWM_OCR(OCL, CHA, (LSpeed << 2));
  }
  else{             // DIR2 : INA = PWM INB = L
    Set_PWM_State(OCL, CHA, OFF);
    Set_PWM_State(OCL, CHB, ON);
    cbi( P_LMOTOR, INB_L );
    Set_PWM_OCR(OCL, CHB, (LSpeed << 2));
  }
  if(RSpeed >= 0){  // DIR1 : INA = L INB = PWM
    Set_PWM_State(OCR, CHA, ON);
    Set_PWM_State(OCR, CHB, OFF);
    cbi( P_RMOTOR, INA_R );
    Set_PWM_OCR(OCR, CHA, (RSpeed << 2) );
  }
  else{             // DIR2 : INA = PWM INB = L
    Set_PWM_State(OCR, CHA, OFF);
    Set_PWM_State(OCR, CHB, ON);
    cbi( P_RMOTOR, INB_R );
    Set_PWM_OCR(OCR, CHB, (RSpeed << 2));
  }
}

void SetMotorState(char Motor, char State){
  switch(Motor){
    case MOTL:
      Set_PWM_State(OCL, CHA, OFF);  // Disable PWMs
      Set_PWM_State(OCL, CHB, OFF);  // Disable PWMs
      switch(State){
        case FORWARD:
          sbi( P_LMOTOR, INB_L );
          cbi( P_LMOTOR, INA_L );
          break;
        case REVERSE:
          cbi( P_LMOTOR, INB_L );
          sbi( P_LMOTOR, INA_L );
          break;
        case STOP:
          cbi( P_LMOTOR, INB_L );
          cbi( P_LMOTOR, INA_L );
          break;
        case FLOAT:
          sbi( P_LMOTOR, INB_L );
          sbi( P_LMOTOR, INA_L );
          break;
        }
      break;
    case MOTR:
      Set_PWM_State(OCR, CHA, OFF);  // Disable PWMs
      Set_PWM_State(OCR, CHB, OFF);  // Disable PWMs
      switch(State){
        case FORWARD:
          sbi( P_RMOTOR, INB_R );
          cbi( P_RMOTOR, INA_R );
          break;
        case REVERSE:
          cbi( P_RMOTOR, INB_R );
          sbi( P_RMOTOR, INA_R );
          break;
        case STOP:
          cbi( P_RMOTOR, INB_R );
          cbi( P_RMOTOR, INA_R );
          break;
        case FLOAT:
          sbi( P_RMOTOR, INB_R );
          sbi( P_RMOTOR, INA_R );
          break;
        }
      break;
  }

}

