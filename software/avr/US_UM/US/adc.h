#ifndef ADC_H
#define ADC_H

#include "US.h"

void InitADC(unsigned char ref, unsigned char prescale);
void Set_ADC_Channel(unsigned char ch);
void Start_ADC_conv(void);
unsigned char a2dIsComplete(void);
unsigned short ADC_Convert(unsigned char ch);

#endif
