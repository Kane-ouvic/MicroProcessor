/*
 * File:   advance.c
 * Author: Kane
 *
 * Created on 2022?10?17?, ?? 2:07
 */


#include <xc.h>

extern unsigned int divide_signed(unsigned char a, unsigned char b);
void main(void) {
    
    volatile unsigned int res = divide_signed(127, 4);
    volatile unsigned char quotient = (res<<8)>>8;
    volatile unsigned char remainder = (res>>8);
    while(1);
    return;
}
