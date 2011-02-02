#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdlib.h> 
#include "avr_compat.h"
#include "US.h"

void InitADC(unsigned char ref, unsigned char prescale)
{
  sbi(ADCSRA, ADEN);				// enable ADC (turn on ADC power)
  outb(ADCSRA, ((inb(ADCSRA) & ~ADC_PRESCALE_MASK) | prescale));
  outb(ADMUX,  ((inb(ADMUX)  & ~ADC_REFERENCE_MASK) | (ref<<6)));
  cbi(ADMUX, ADLAR);
}

void Set_ADC_Channel(unsigned char ch)
{
  outb(ADMUX, (inb(ADMUX) & ~ADC_MUX_MASK) | (ch & ADC_MUX_MASK));
}


void Start_ADC_conv(void)
{
    sbi(ADCSRA, ADIF);	// clear hardware "conversion complete" flag 
    sbi(ADCSRA, ADSC);	// start conversion
}

unsigned short ADC_Convert(unsigned char ch)
{
  unsigned char adc[2];
  outb(ADMUX, (inb(ADMUX) & ~ADC_MUX_MASK) | (ch & ADC_MUX_MASK));	// set channel
  sbi(ADCSRA, ADIF);				// clear hardware "conversion complete" flag 
  sbi(ADCSRA, ADSC);				// start conversion
  while( bit_is_set(ADCSRA, ADSC) );		// wait until conversion complete

  // CAUTION: MUST READ ADCL BEFORE ADCH!!!
//  return (inb(ADCL));	// read ADC;
  adc[0] = inb(ADCL);
  adc[1] = inb(ADCH);

  return( (adc[1] << 8) | (adc[0] ));
}
