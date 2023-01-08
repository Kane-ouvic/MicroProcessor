/*
 * File:   testcode1.c
 * Author: Kane
 *
 * Created on 2022?12?6?, ?? 8:35
 */

#include <xc.h>
#include <pic18f4520.h>

#pragma config OSC = INTIO67 // Oscillator Selection bits
#pragma config WDT = OFF     // Watchdog Timer Enable bit
#pragma config PWRT = OFF    // Power-up Enable bit
#pragma config BOREN = ON    // Brown-out Reset Enable bit
#pragma config PBADEN = OFF  // Watchdog Timer Enable bit
#pragma config LVP = OFF     // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF     // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)

void alcho_interrupt();
void alcho_setting();
void Set(unsigned int cycle);

void Set(unsigned int cycle)
{
    CCPR1L = cycle >> 2;
    CCP1CON = CCP1CON & 0xCF;
    CCP1CON = CCP1CON | (0x30 & (cycle << 4));
}

void alcho_interrupt()
{

    int input = (ADRESH << 8) + ADRESL;
    int bitShow = input / 64;
    LATD = bitShow;
    Set(bitShow);
    if (input > 512)
    {
        LATB = 0x01;
    }
    else
    {
        LATB = 0x00;
    }

    PIR1bits.ADIF = 0x0;
    ADCON0bits.GO = 0x1;
}

void alcho_setting()
{

    TRISA = 0x01;
    ADCON1bits.VCFG1 = 0;
    ADCON1bits.VCFG0 = 0;
    ADCON1bits.PCFG = 0xE;
    ADCON0bits.CHS = 0x0;
    ADCON2bits.ADCS = 0x1;
    ADCON2bits.ACQT = 0x4;
    ADCON0bits.ADON = 0x1;
    ADCON2bits.ADFM = 0x1;
    PIR1bits.ADIF = 0x0;
    PIE1bits.ADIE = 0x1;
    IPR1bits.ADIP = 0x1;
    ADCON0bits.GO = 0x1;
}

void light_setting()
{
    TRISB = 0x00;
    TRISC = 0x00;
    TRISD = 0x00;
    LATD = 0x00;
    LATB = 0x00;
    CCP1CON = 0x0C;
    PR2 = 0xFF;
    T2CON = 0x04;
}

void init()
{
    OSCCONbits.IRCF = 0x101;
    INTCONbits.GIE = 0x1;
    RCONbits.IPEN = 0x1;
}

void __interrupt(high_priority) ISR(void)
{
    alcho_interrupt();
    return;
}

void main(void)
{
    init();
    light_setting();
    alcho_setting();
    while (1)
    {
        continue;
    };
    return;
}
