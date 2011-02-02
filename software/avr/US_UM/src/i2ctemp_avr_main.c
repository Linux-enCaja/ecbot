#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdlib.h> 
#include "i2c_avr.h"
#include "avr_compat.h"

	char rec_buf[MAX_BUF_LEN+1];
	char out_buf[MAX_BUF_LEN+1];


int main(void)
{

        char i;
	// in house and outdoor sensor:
	int temp_sensor_in,temp_sensor_out;
	int led;
	unsigned char adc_ref_sel; // 0 -> avcc=ref
	temp_sensor_in=0;
	temp_sensor_out=0;
	// LED is output line:
	sbi(DDRD,PD5);
	// led off
	sbi(PORTD,PD5);
	// I2C also called TWI
	i2c_init(5,1);
	//
	sei();
	led=0;
	adc_ref_sel=0;


	out_buf[0]=0x01; out_buf[1]=0x01; out_buf[2]=0x02; out_buf[3]=0x03; out_buf[4]=0x04; out_buf[5]=0x05; 


	cbi(PORTD,PD5);
	while (1) {
		if (i2c_get_received_data(rec_buf)){
			if (rec_buf[0]==0x30){
                                for(i=1; i <= MAX_BUF_LEN; i++){
				  out_buf[i]=rec_buf[i];

                                }
                        }
			if (rec_buf[0]==0x31){
				i2c_send_data(out_buf);
			}
		}
	}
	return(0); // avoid gcc warning
}

