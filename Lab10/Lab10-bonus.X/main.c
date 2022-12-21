#include "setting_hardaware/setting.h"

#include <pic18f4520.h>
#include <xc.h>
#include <stdlib.h>
#include "stdio.h"
#include "string.h"
#define _XTAL_FREQ 8000000
// using namespace std;

char str[20];
void Mode1(){   // Todo : Mode1 
    ClearBuffer();
    UART_Write('\n');
    UART_Write('\r');
//    UART_Write_Text("Enter mode1");
    strcpy(str, GetString());
    LATD = 0b01010101;
    while (1)
    {
        strcpy(str, GetString());
        if (str[0] == 'e')
        {
            UART_Write('\n');
            UART_Write('\r');
            ClearBuffer();
            break;
        }
        asm("RRNCF LATD");
        __delay_ms(500);
    }
    LATD = 0;
    
    return ;
}
void Mode2(){   // Todo : Mode2 
    ClearBuffer();
    UART_Write('\n');
    UART_Write('\r');
//    UART_Write_Text("Enter mode1");
    strcpy(str, GetString());
    LATD = 0b10001000;
    while (1)
    {
        strcpy(str, GetString());
        if (str[0] == 'e')
        {
            UART_Write('\n');
            UART_Write('\r');
            ClearBuffer();
            break;
        }
        asm("RRNCF LATD");
        __delay_ms(500);
    }
    LATD = 0;
    
    return ;
}
void main(void) 
{
    
    SYSTEM_Initialize() ;
    
    while(1) {
        strcpy(str, GetString()); // TODO : GetString() in uart.c
        if(str[0]=='m' && str[1]=='1'){ // Mode1
            Mode1();
            ClearBuffer();
        }
        else if(str[0]=='m' && str[1]=='2'){ // Mode2
            Mode2();
            ClearBuffer();  
        }
    }
    return;
}

void __interrupt(high_priority) Hi_ISR(void)
{

}