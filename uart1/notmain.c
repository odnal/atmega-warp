#include <avr/io.h>
#include <stdio.h>

#define F_CPU   16000000
#define baud_rate    19200

#define bps (((F_CPU / (16UL * baud_rate)) - 1))

void uart_send(unsigned char data);


int notmain() {
  unsigned int ra, baud;

  // uart init
  baud = bps;
  UBRR1H = (unsigned char)baud>>8;
  UBRR1L = (unsigned char)baud;

  // enable transmitter
  //UCSR1B = (1<<3);
  UCSR1B = (1<<TXEN1);

  ra = 0x55;
  // transmit
  while (1) {
    uart_send(ra);
    uart_send(0x0A);
    uart_send(0x0D);
  }

}

void uart_send (unsigned char data) {
  while ( (UCSR1A & (1<<UDRE1)) == 0) continue;
  UDR1 = data;
}
