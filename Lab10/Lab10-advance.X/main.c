#include "setting_hardaware/setting.h"
#include <stdlib.h>
#include "stdio.h"
#include "string.h"
// using namespace std;

char str[20];
void printLine(){   // Todo : Mode1 
    ClearBuffer();
//    UART_Write_Text("\r\n");
//    LATD = 0x01;
    return;
}
void Mode2(){   // Todo : Mode2 
    return ;
}
void main(void) 
{
    int index = 0;
    SYSTEM_Initialize() ;
    
    while(1) {
        strcpy(str, GetString());
        index = getstrLen();
        if (str[index] == '\r')
        {
            LATD = atoi(str);
            ClearBuffer();
        }
    }
    return;
}

void __interrupt(high_priority) Hi_ISR(void)
{

}