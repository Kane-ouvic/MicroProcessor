/*
 * File:   testcode1.c
 * Author: Kane
 *
 * Created on 2022?12?6?, ?? 8:35
 */


#include <xc.h>
#include <pic18f4520.h>
#include <stdio.h>

#pragma config OSC = INTIO67 // Oscillator Selection bits
#pragma config WDT = OFF     // Watchdog Timer Enable bit
#pragma config PWRT = OFF    // Power-up Enable bit
#pragma config BOREN = ON    // Brown-out Reset Enable bit
#pragma config PBADEN = OFF  // Watchdog Timer Enable bit
#pragma config LVP = OFF     // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF     // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)

int PI[10] = {3,1,4,1,5,9,2,6,5,3};

void __interrupt(high_priority) Hi_ISR(void) {
    // check bits
    int input = (ADRESH << 8) + ADRESL;
//    int bitShow = (input - (input % 64)) / 64;
    int index = input / 103;
    LATD = PI[index];
    printf("%d\n" ,input);
    
    // Clear ADIF
    PIR1bits.ADIF = 0x0;
    // Turn AD Conversion Status to Idle
    ADCON0bits.GO = 0x1;
    return;
}

void __interrupt(low_priority) Lo_ISR(void) {
    // low priority interrupt here
    return;

}
void init(){
    // Set Oscillator to 8MHz
    OSCCONbits.IRCF = 7;
    // set TRISA<0> as INPUT
    TRISA = 0x01;
    // set TRISD<0-3> as OUTPUT
    TRISD = 0x00;
    // clear LEDs
    LATD = 0x00;
    // set VREF- to -5V
    ADCON1bits.VCFG1 = 0;
    // set VREF+ to 5V
    ADCON1bits.VCFG0 = 0;
    // set AD Port Configuration
    ADCON1bits.PCFG = 0xE;
    // set Analog Channel Select bits
    ADCON0bits.CHS = 0x0;
    // set AD Conversion Clock Select bits
    ADCON2bits.ADCS = 0x1;
    // Select A/D Acquisition Time Select bit
    ADCON2bits.ACQT = 0x4;
    // Turn A/D On
    ADCON0bits.ADON = 0x1;
    // set AD Result Format Select bit
    ADCON2bits.ADFM = 0x1;
    // first clear ADIF
    PIR1bits.ADIF = 0x0;
    // enable AD Converter Interrupt
    PIE1bits.ADIE = 0x1;
    // enable Global Interrupt
    INTCONbits.GIE = 0x1;
    // set  AD Converter Interrupt Priority to High
    IPR1bits.ADIP = 0x1;
    // Turn AD Conversion Status to Running
    ADCON0bits.GO = 0x1;
    // TEST
    RCONbits.IPEN = 0x1;
}

void main(void) {
    init();
    while(1){
        // Turn AD Conversion Status to Running
        ADCON0bits.GO = 0x1;
        continue;
    };
    return;
}

