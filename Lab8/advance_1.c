#include <xc.h>
#include <pic18f4520.h>

#pragma config OSC = INTIO67 // Oscillator Selection bits
#pragma config WDT = OFF     // Watchdog Timer Enable bit
#pragma config PWRT = OFF    // Power-up Enable bit
#pragma config BOREN = ON    // Brown-out Reset Enable bit
#pragma config PBADEN = OFF  // Watchdog Timer Enable bit
#pragma config LVP = OFF     // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF     // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)

#define _XTAL_FREQ 1000000
int direction = 0;
void __interrupt(high_priority) ISR(void)
{
    while(CCPR1L!=20) {
        __delay_ms(7);
        CCPR1L++;
    }
    CCPR1L = 4;
    INT0IF  = 0;
    return;
}

int main(void)
{
// RB0 as input, RC2 as , init
  TRISC = 0x00;
  LATC = 0;

  // timer2, prescaler=4
  T2CON = 0b01111101; // 125
  // OSC - Fosc=125k, Tosc=8us
  OSCCONbits.IRCF = 0b001;
  // CCP1
  CCP1CONbits.CCP1M = 0b1100;
  CCP1CONbits.DC1B = 0b00;

  // pr2, period=20ms
  // period = (PR2+1)*4*Tosc*(TMR2 prescaler)
  PR2 = 0x9b; // 155

  // CCPR1L, dutyCycle=512us
  // duty cycle = (CCPR1L:CCP1CON<5:4>)*Tosc*(TMR2 prescaler)
  CCPR1L = 4; // 4*2*2=16

  // timer0 interrupt
  T0CON = 0b11111000;
  IPEN = 0;
  GIE  = 1;
  INT0IE = 1;
  INT0IF =0;
  while (1);
  return 0;
}