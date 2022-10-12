LIST p=18f4520
    #include<p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF
	org 0x00

x = b'00001111'
y = b'00110011'
initial:
    MOVLW x
    MOVWF 0x000;x
    MOVWF 0x002;x'
    COMF 0x002
    
    MOVLW y
    MOVWF 0x001;y
    MOVWF 0x004;y'
    COMF 0x004
    
    MOVF 0x000, 0, 0
    ANDWF 0x004
    
    MOVF 0x001, 0, 0
    ANDWF 0x002
    
    MOVF 0x004, 0, 0
    IORWF 0x002

end