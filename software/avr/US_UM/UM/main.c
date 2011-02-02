#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdlib.h> 
#include "i2c_avr.h"
#include "avr_compat.h"
#include "UM.h"
#include "motor.h"
#include "adc.h"

#define F_CPU       1000000UL  // 1 MHz
#include <util/delay.h>

char rec_buf[MAX_BUF_LEN+1];
unsigned char out_buf[MAX_BUF_LEN+1];

char Motor_Speed[2];

short bemf[4];

void init_hw(void){
  unsigned char ref, prescale;

  i2c_init(I2C_ADDRESS,1);
  sei();

  InitPWM();
  InitADC(ADC_REFERENCE_AVCC, ADC_PRESCALE_DIV8);
}




int main(void)
{

  char i;
  init_hw();

  while (1) {
//    SetMotorState(MOTL, FLOAT);
//    SetMotorState(MOTR, FLOAT);
//    _delay_us(500); 
    bemf[0] = ADC_Convert(MOTR_B);
    bemf[1] = ADC_Convert(MOTR_A);
    bemf[2] = ADC_Convert(MOTL_B);
    bemf[3] = ADC_Convert(MOTL_A);


    Motor_Speed[0] = 0x70; 
    Motor_Speed[1] = 0x70;
    SetSpeed( Motor_Speed[0], Motor_Speed[1] );

    if (i2c_get_received_data(rec_buf)){
      if (rec_buf[0] == SET_VEL){
        Motor_Speed[1] = rec_buf[2];
        Motor_Speed[0] = rec_buf[1];
      }
      if(rec_buf[0] == GET_VEL ){
        out_buf[0] = ( bemf[0] & 0x00FF); 
        out_buf[1] = ( bemf[1] & 0x00ff);
        out_buf[2] = ( bemf[2] & 0x00ff);
        out_buf[3] = ( bemf[3] & 0x00ff);
        i2c_send_data(out_buf);
      }
    }
    _delay_ms(10);
  }

  return(0); // avoid gcc warning
}

