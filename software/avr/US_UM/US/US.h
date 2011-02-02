#ifndef US_H
#define US_H

#define I2C_ADDRESS 0x10

#define ADC_PRESCALE_MASK		0x07
#define ADC_PRESCALE_DIV2		0x00	///< 0x01,0x00 -> CPU clk/2
#define ADC_PRESCALE_DIV4		0x02	///< 0x02 -> CPU clk/4
#define ADC_PRESCALE_DIV8		0x03	///< 0x03 -> CPU clk/8
#define ADC_PRESCALE_DIV16		0x04	///< 0x04 -> CPU clk/16
#define ADC_PRESCALE_DIV32		0x05	///< 0x05 -> CPU clk/32
#define ADC_PRESCALE_DIV64		0x06	///< 0x06 -> CPU clk/64
#define ADC_PRESCALE_DIV128		0x07	///< 0x07 -> CPU clk/128

#define ADC_REFERENCE_MASK		0xC0
#define ADC_REFERENCE_AREF		0x00	///< 0x00 -> AREF pin, internal VREF turned off
#define ADC_REFERENCE_AVCC		0x01	///< 0x01 -> AVCC pin, internal VREF turned off
#define ADC_REFERENCE_RSVD		0x02	///< 0x02 -> Reserved
#define ADC_REFERENCE_256V		0x03	///< 0x03 -> Internal 2.56V VREF

#define ADC_MUX_MASK			0x1F

#define ADC_CH_ADC0			0x00
#define ADC_CH_ADC1			0x01
#define ADC_CH_ADC2			0x02
#define ADC_CH_ADC3			0x03
#define ADC_CH_ADC4			0x04
#define ADC_CH_ADC5			0x05
#define ADC_CH_ADC6			0x06
#define ADC_CH_ADC7			0x07
#define ADC_CH_122V			0x1E	///< 1.22V voltage reference
#define ADC_CH_AGND			0x1F	///< AGND

#define SET_COLOR   0x10   // Set RGB LED color: RED GREEN BLUE LED (0: LED1 1: LED2 2: BOTH)
#define READ_IR     0x20   // Read IR sensor: IR1 IR2

#define RED        0x40   //PD6
#define GREEN      0x02   //PB1
#define BLUE       0x20   //PD5


//*******************
//*  IR DEFINITIONS *
//*******************

#define IR_REACT    50
#define IR_DELAY    50

#define AD1         ADC_CH_ADC0   // IR0 PC0
#define AD2         ADC_CH_ADC1   // IR1 PC1
#define AD3         ADC_CH_ADC2   // IR3 PC2
#define AD4         ADC_CH_ADC3   // IR4 PC3
#define AD5         ADC_CH_ADC6   // IR5 
#define AD6         ADC_CH_ADC7   // IR7


#define PORT_IR    _SFR_IO8 (0x05) //PB2
#define DDR_IR     _SFR_IO8 (0x04) //PB
#define E_IR        0x04  //PB2

//#define PORTB   _SFR_IO8 (0x05)
//#define PORTC   _SFR_IO8 (0x08)
//#define PORTD   _SFR_IO8 (0x0B)

//#define DDRB    _SFR_IO8 (0x04)
//#define DDRC    _SFR_IO8 (0x07)
//#define DDRD    _SFR_IO8 (0x0A)

char RGB[3];


#endif
