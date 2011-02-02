#include <avr/io.h>         // AVR device-specific IO definitions

#define bit_set(v,m) ((v) |= (m))
#define bit_clear(v,m) ((v) &= ~(m))


void delay_ms(unsigned int ms)
/* delay for a minimum of <ms> */
/* with a 4Mhz crystal, the resolution is 1 ms */
{
	unsigned int outer1, outer2;
     	outer1 = 1; 

    	while (outer1) {
		outer2 = 0xFFFF;
		while (outer2) {
			while ( ms ) ms--;
			outer2--;
		}
		outer1--;
	}
}




int main(void)
    {
          /* INICIALIZACION */
          /* activa PC5 como salida */
          DDRC|= _BV(PC5);


          /* Parpadeo, Parpadeo ... */

          /* PC5 esta a 5 (ver el fichero include/avr/iom8.h) y _BV(PC5) es 00100000 */
          while (1) {
                /* led on, pin=0 */
                PORTC&= ~_BV(PC5);
                delay_ms(500);
                /* Activa la salida a 5V, LED desactivado */
                PORTC|= _BV(PC5);
                delay_ms(500);
          }
    }
