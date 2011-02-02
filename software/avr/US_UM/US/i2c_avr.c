#include <avr/io.h>
#include <avr/interrupt.h>
#include <string.h>
#include "i2c_avr.h"
#include "avr_compat.h"

void i2c_init(uint8_t devadr, uint8_t gencall)
{
	uint8_t i;
	// You will have to call sei() in the main program to use this.
        // Zero in the direction bit means write
	slave_state=0;
	slave_rec_buf_pos=0;
	slave_tx_buf_pos=0;
	for(i=0;i<=MAX_BUF_LEN;i++){
		slave_tx_buf[i]='\0';
	}
        // enable TWI interrupt and slave address ACK
	outp((BV(TWINT)|BV(TWEA)|BV(TWEN)|BV(TWIE)),TWCR);
	// set local device address for the slave, must be done after setting of TWCR
	devadr=devadr<<1;
	outp(((devadr & 0xFE) | (gencall ?1:0)),TWAR );
}

uint8_t i2c_get_received_data(char *i2c_outbuf)
{
	if (slave_state !=1 && slave_rec_buf_pos >0){// && slave_rec_buf[slave_rec_buf_pos-1]=='\0'){
		slave_rec_buf[MAX_BUF_LEN]='\0';
		strncpy(i2c_outbuf,(char *) slave_rec_buf,MAX_BUF_LEN);
		// clear buffer
		slave_rec_buf_pos=0;
		return(1);
	}else{
		// no data available
		return(0);
	}
}

uint8_t i2c_send_data(char *i2c_data)
{
	while(slave_state==2); // we are still transmitting data. wait here.
	strncpy((char *) slave_tx_buf, i2c_data, MAX_BUF_LEN);
	slave_tx_buf[MAX_BUF_LEN]='\0';
	slave_tx_buf_pos=0;
	return(0);
}


SIGNAL(TWI_vect)
{
        // read status bits
        uint8_t ack=0; // 0: send no ack, 1:send TWEA=1=ack,2 recover from bus error 
        uint8_t status = inp(TWSR) & TWSR_STATUS_MASK;
        switch(status)
        {

	// ---- Slave Receiver
	//
	// 0x60: own SLA+W has been received, ACK has been returned
	case TW_SR_SLA_ACK: 
	// 0x68: own SLA+W has been received, ACK has been returned
	case TW_SR_ARB_LOST_SLA_ACK:
	// 0x70: General call address has been received, ACK has been returned
	case TW_SR_GCALL_ACK:	
	// 0x78:     GCA+W has been received, ACK has been returned
	case TW_SR_ARB_LOST_GCALL_ACK:		
		slave_state = 1; 
		slave_rec_buf_pos = 0;
		ack=1;
		break;
	// 0x80: data byte has been received, ACK has been returned
	case TW_SR_DATA_ACK:		
	// 0x90: data byte has been received, ACK has been returned
	case TW_SR_GCALL_DATA_ACK:	
		// get received data byte
		if (slave_rec_buf_pos>= MAX_BUF_LEN){
			// too much data
			slave_rec_buf[MAX_BUF_LEN]='\0';
			slave_rec_buf_pos=MAX_BUF_LEN+1;
			//slave_state = 0; // expect no more data
			// return NACK
		}else{
			slave_rec_buf[slave_rec_buf_pos] = inp(TWDR);
			slave_rec_buf_pos++;
			// return ACK
			ack=1;
		}
		break;
	// 0x88: data byte has been received, NACK has been returned
	case TW_SR_DATA_NACK:		
	// 0x98: data byte has been received, NACK has been returned
	case TW_SR_GCALL_DATA_NACK:	
		if (slave_rec_buf_pos>= MAX_BUF_LEN){
			// too much data
			slave_rec_buf[MAX_BUF_LEN]='\0';
			slave_rec_buf_pos=MAX_BUF_LEN+1;
		}else{
			slave_rec_buf[slave_rec_buf_pos] = inp(TWDR);
			slave_rec_buf_pos++;
		}
		break;
	// 0xA0: STOP or REPEATED START has been received while addressed as slave
	case TW_SR_STOP:
		ack=1;
		slave_state = 0;
		break;

	// ---- Slave Transmitter
	//
	// 0xA8: own SLA+R has been received, ACK has been returned
	case TW_ST_SLA_ACK:
	// 0xB0: GCA+R has been received, ACK has been returned
	case TW_ST_ARB_LOST_SLA_ACK:
		slave_state = 2;
		slave_tx_buf_pos=0;
	// 0xB8: data byte has been transmitted, ACK has been received
	case TW_ST_DATA_ACK:				
		// the master has to know how many bytes it should read
		// the last byte must get a nack from the master.
		outp(slave_tx_buf[slave_tx_buf_pos],TWDR);
		slave_tx_buf_pos++;
		ack=1;
		break;
	// 0xC0: data byte has been transmitted, NACK has been received
	case TW_ST_DATA_NACK:
	// 0xC8: Last data byte in TWDR has been transmitted (TWEA =  0 ); ACK has been received
	case TW_ST_LAST_DATA:
		// all done
		// switch to open slave
		ack=1;
		slave_tx_buf_pos=0;
		// set state
		slave_state = 0;
		break;

	// ---- Misc

	// Status 0xF8 indicates that no relevant information is available
	// because the TWINT Flag is not set. This occurs between other
	// states, and when the TWI is not involved in a serial transfer.
	case TW_NO_INFO:
		// do nothing
		break;
	// Status 0x00 indicates that a bus error has occurred during a
	// Two-wire Serial Bus trans-fer. A bus error occurs when a START
	// or STOP condition occurs at an illegal position in the format
	// frame. Examples of such illegal positions are during the serial
	// transfer of an address byte, a data byte, or an acknowledge
	// bit. When a bus error occurs, TWINT is set. To recover from a
	// bus error, the TWSTO Flag must set and TWINT must be cleared
	// by writing a logic one to it. This causes the TWI to enter the
	// not addressed Slave mode and to clear the TWSTO Flag (no other
	// bits in TWCR are affected). The SDA and SCL lines are released,
	// and no STOP condition is transmitted.
	case TW_BUS_ERROR:
		// reset internal hardware by falling to the default case
	default:
		// we should actually only come here if we forgott
		// something in the above list. That should normally
		// not be the case. Still we just act 
		//
		// set state
		slave_rec_buf_pos=0;
		slave_tx_buf_pos=0;
		slave_state = 0;
		// reset internal hardware 
		ack=2;
		break;
	}
	// clear the interrupt flag and give control to start again
	if (ack==2){
		// reset
		outp((BV(TWINT)|BV(TWEA)|BV(TWSTO)|BV(TWEN)|BV(TWIE)),TWCR);
	}
	if (ack==1){
		// normal ack
		outp((BV(TWINT)|BV(TWEA)|BV(TWEN)|BV(TWIE)),TWCR);
	}
	if (ack==0){
		// normal nack
		outp((BV(TWINT)|BV(TWEN)|BV(TWIE)),TWCR);
	}
}
