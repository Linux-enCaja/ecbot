#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdlib.h> 
#include "i2c_avr.h"
#include "avr_compat.h"
#include "led.h"
#include "US.h"


void Init_PWM(void)
{
  // Configure LEDs pins as outputs
  DDRB  = GREEN | E_IR;
  DDRD  = RED   | BLUE;

  // Fast PWM TOP=OCRA,B
  sbi(TCCR0A,WGM00);
  sbi(TCCR0A,WGM01);
  cbi(TCCR0B,WGM02);
  // TCCR1 16 bit timer !!
  sbi(TCCR1A,WGM10);
  cbi(TCCR1A,WGM11);
  sbi(TCCR1B,WGM12);
  cbi(TCCR1B,WGM13);

  // Fast PWM TOP=OCRA,B
  sbi(TCCR2A,WGM20);
  sbi(TCCR2A,WGM21);
  cbi(TCCR2B,WGM22);

  // Set Prescaler
  TCCR0B = ((TCCR0B & ~TIMER_PRESCALE_MASK) | PWM_PRESCALE);
  TCCR1B = ((TCCR1B & ~TIMER_PRESCALE_MASK) | PWM_PRESCALE);
  TCCR2B = ((TCCR2B & ~TIMER_PRESCALE_MASK) | PWM_PRESCALE);


  TCCR0A |= _BV (COM0A1) | _BV (COM0A0) | _BV(COM0B1) | _BV(COM0B0); 

  TCCR1A |= _BV (COM1A1) | _BV (COM1A0) | _BV(COM1B1) | _BV(COM1B0); 

  TCCR2A |= _BV (COM2A1) | _BV (COM2A0) | _BV(COM2B1) | _BV(COM2B0); 

  OCR1B     = 0xff; // IR
}

void set_color (unsigned char led, unsigned char value){
  switch (led){
    case RED:   OCR0A     = value; break;
    case GREEN: OCR1A     = value; break;
    case BLUE:  OCR0B     = value; break;
    default:
     OCR0A     = 0xf9; // RED
     OCR1A     = 0xf9; // GREEN
     OCR0B     = 0xf9; // BLUE
     break;

  }
}
