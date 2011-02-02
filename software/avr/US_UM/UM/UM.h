#ifndef UM_H
#define UM_H

#define I2C_ADDRESS 0x05


#define TIMER_CLK_STOP			0x00	///< Timer Stopped
#define TIMER_CLK_DIV1			0x01	///< Timer clocked at F_CPU
#define TIMER_CLK_DIV8			0x02	///< Timer clocked at F_CPU/8
#define TIMER_CLK_DIV64			0x03	///< Timer clocked at F_CPU/64
#define TIMER_CLK_DIV256		0x04	///< Timer clocked at F_CPU/256
#define TIMER_CLK_DIV1024		0x05	///< Timer clocked at F_CPU/1024
#define TIMER_CLK_T_FALL		0x06	///< Timer clocked at T falling edge
#define TIMER_CLK_T_RISE		0x07	///< Timer clocked at T rising edge
#define TIMER_PRESCALE_MASK		0x07	///< Timer Prescaler Bit-Mask

#define PWM_PRESCALE                    TIMER_CLK_DIV1

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


// ------------------------------------------------------ PROJECT DEFINITIONS


#define INA_R           0x05 // PD5
#define INB_R           0x06 // PD6
#define INA_L           0x02 // PB2
#define INB_L           0x01 // PB1

#define OCR             0x00
#define OCL             0x01
#define CHA             0x00
#define CHB             0x01

#define ON              0xFF
#define OFF             0x00


#define FORWARD         0x01
#define REVERSE         0x02
#define STOP            0x03
#define FLOAT           0x04

#define MOTL            0x00
#define MOTR            0x01

#define MOTL_A          ADC_CH_ADC2
#define MOTL_B          ADC_CH_ADC3
#define MOTR_A          ADC_CH_ADC6
#define MOTR_B          ADC_CH_ADC7


#define P_RMOTOR    _SFR_IO8 (0x0B)
#define P_LMOTOR    _SFR_IO8 (0x05)


//------------------------------------------------------- I2C COMMANDS

#define SET_VEL         0x10    // SET_VEL LV RV 
#define GET_VEL         0x20    // SET_VEL LV RV 
#define SET_POS_PID     0x30    // KP KI KD MOT
#define SET_VEL_PID     0x40    // KP KI KD MOT
#define SET_VEL_PRO     0x50    // VEL ACC MOT


#endif
