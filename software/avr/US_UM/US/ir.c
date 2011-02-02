#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdlib.h> 
#include "avr_compat.h"
#include "ir.h"

#define F_CPU       1000000UL  // 1 MHz
#include <util/delay.h>


void Set_IR_Intensity(unsigned char intensity){
  OCR1B = intensity;  
}

void Read_IR(unsigned short * IR_value, unsigned char intensity){
  static unsigned short ambient_IR[6];
  static unsigned short ambient_and_reflected_IR[6];
  unsigned char i;

  Set_IR_Intensity(0xff);            // Turn on LEDs
  for(i=0; i<6; i++)  
    ambient_IR[i] = ADC_Convert(i);  // Read ambient light

  Set_IR_Intensity(intensity);       // Turn on LEDs

  _delay_us(IR_REACT);               // wait to phototransistor react

  for(i=0; i<6; i++)  
    ambient_and_reflected_IR[i] = 0x00;//ADC_Convert(i);   // Read ambient light
  
  for(i=0; i<6; i++)  
    IR_value[i] = (ambient_IR[i] - ambient_and_reflected_IR[i]);   // Read ambient light

  Set_IR_Intensity(0xff);       // Turn on LEDs
}

