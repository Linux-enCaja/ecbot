/* vim: set sw=8 ts=8 si : */
/* header for i2c slave on ATMEGA8. Written
 * by guido socher. License = GPL */
#ifndef I2C_AVR_H
#define I2C_AVR_H

#define TWSR_STATUS_MASK	0xF8
#define TWCR_CMD_MASK		0x0F

/* TWI states, slave transmitter */
#define TW_ST_SLA_ACK           0xA8
#define TW_ST_ARB_LOST_SLA_ACK  0xB0
#define TW_ST_DATA_ACK          0xB8
#define TW_ST_DATA_NACK         0xC0
#define TW_ST_LAST_DATA         0xC8
/* TWI states, slave receiver */
#define TW_SR_SLA_ACK           0x60
#define TW_SR_ARB_LOST_SLA_ACK  0x68
#define TW_SR_GCALL_ACK         0x70
#define TW_SR_ARB_LOST_GCALL_ACK 0x78
#define TW_SR_DATA_ACK          0x80
#define TW_SR_DATA_NACK         0x88
#define TW_SR_GCALL_DATA_ACK    0x90
#define TW_SR_GCALL_DATA_NACK   0x98
#define TW_SR_STOP              0xA0
/* Misc */
#define TW_NO_INFO              0xF8
#define TW_BUS_ERROR            0x00

#define MAX_BUF_LEN 16

volatile static uint8_t slave_state=0; // 1 = receive, 2 = transmit, 0 = ready (all data recieved or sent
// slave receiver buffer (we expect \0 terminated strings in there):
volatile static uint8_t slave_rec_buf[MAX_BUF_LEN+1];
volatile static uint8_t slave_rec_buf_pos=0; 
// slave_tx_buf is a \0 terminated buffer
volatile static uint8_t slave_tx_buf[MAX_BUF_LEN+1];
volatile static uint8_t slave_tx_buf_pos=0; 



// the functions which you will normally use are:
void i2c_init(uint8_t devadr, uint8_t gencall);
uint8_t i2c_get_received_data(char *i2c_outbuf);
uint8_t i2c_send_data(char *i2c_data);

#endif 
