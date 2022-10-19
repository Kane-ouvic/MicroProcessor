/*
 * File:   bonus.c
 * Author: Kane
 *
 * Created on 2022?10?17?, ?? 2:12
 */


#include <xc.h>

extern unsigned int mypow(unsigned int a, unsigned int b);
void main(void) {
    volatile unsigned int result = mypow(3, 10);
    while(1);
    return;
}
