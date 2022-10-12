LIST p=18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
a1 = 0x01
r = 0x03
    
initial:
   rcall GP
   rcall finish
   
GP:
    ;init
    MOVLW a1
    MOVWF 0x000
    MOVLW r
    MOVWF 0x001
    ;counter
    MOVLW 0x03
    MOVWF 0x004
    ;
    MOVF 0x000, 0, 0
    ADDWF 0x002, 1, 0
    MOVF 0x001, 0, 0
    MULWF 0x000
    MOVFF PRODL, 0x000
    
    MOVLW 0x10
    DECFSZ 0x004
    MOVWF PCL
    NOP
    RETURN
    
    
    
    
finish:
    NOP
    end


