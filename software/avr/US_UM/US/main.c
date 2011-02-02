#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdlib.h> 
#include "i2c_avr.h"
#include "avr_compat.h"
#include "US.h"
#include "led.h"
#include "adc.h"
#include "ir.h"

#define F_CPU       1000000UL  // 1 MHz
#include <util/delay.h>


char rec_buf[MAX_BUF_LEN+1];
char out_buf[MAX_BUF_LEN+1];


void init_hw(void){
  //Init I2C bus
  i2c_init(I2C_ADDRESS,1);
  sei();

//  sbi( DDR_IR, E_IR );  // Set IR Enable as Output 
//  DDRB = E_IR;

  Init_PWM();
  InitADC(ADC_REFERENCE_AVCC, ADC_PRESCALE_DIV8);
//  OCR1B     = 0x01; // GREEN
  RGB[0] = 0xf9; // RED
  RGB[1] = 0xf9; // GREEN
  RGB[2] = 0xf9; // BLUE
}


int main(void)
{
unsigned char IR[12]; // 0 -> avcc=ref

  init_hw();
  while (1) {
    if (i2c_get_received_data(rec_buf)){
      if (rec_buf[0] == SET_COLOR){
            RGB[0] = rec_buf[1];
            RGB[1] = rec_buf[2];
            RGB[2] = rec_buf[3];
      }
      if(rec_buf[0] == READ_IR ){
        out_buf[0]= IR[0]; out_buf[1]= IR[1];
        out_buf[2]= IR[2]; out_buf[3]= IR[3];
        i2c_send_data(out_buf);
      }
    }
    // Update PWMs
    set_color (RED,   RGB[0]);
    set_color (GREEN, RGB[1]);
    set_color (BLUE,  RGB[2]);


    Read_IR((unsigned short*)IR, 0x80);

    _delay_ms(IR_DELAY); 


  }
 return(0); // avoid gcc warning
}