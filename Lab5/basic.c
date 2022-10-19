/*
 * File:   basic.c
 * Author: Kane
 *
 * Created on 2022?10?16?, ?? 11:43
 */


#include <xc.h>

extern unsigned char isprime(unsigned int a);
void main(void) {
    
    volatile unsigned char res = isprime(111);
    while(1);
    return;
}
