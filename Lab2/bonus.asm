#INCLUDE <p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x10
    
setup:
    LFSR 0, 0x100
    MOVLW 0xA1
    MOVWF POSTINC0 ;0x100
    MOVLW 0xB2
    MOVWF POSTINC0 ;0x101
    MOVLW 0xC3
    MOVWF POSTINC0 ;0x102
    MOVLW 0xD4
    MOVWF POSTINC0 ;0x103
    MOVLW 0xE5
    MOVWF POSTINC0 ;0x104
  
    ;---------------------
    LFSR 0, 0x110
    MOVLW 0xA7
    MOVWF POSTINC0 ;0x110
    MOVLW 0xB3
    MOVWF POSTINC0 ;0x111
    MOVLW 0xC9
    MOVWF POSTINC0 ;0x112
    MOVLW 0xF6
    MOVWF POSTINC0 ;0x113

   
start:
    LFSR 0, 0x120
    LFSR 1, 0x100
    LFSR 2, 0x110
    
loop:
    ;compare
    MOVF INDF1, 0, 0
    CPFSLT INDF2
	GOTO case1
	GOTO case2
	case1:
	    MOVF POSTINC1, 0, 0
	    MOVWF POSTINC0
	    GOTO next1
	case2:
	    MOVF POSTINC2, 0, 0
	    MOVWF POSTINC0
	    GOTO next2
	    
    next1:
	MOVLW 0x00
	CPFSEQ INDF1
	    GOTO loop
	    GOTO loop2
	
    next2:
	MOVLW 0x00
	CPFSEQ INDF2
	    GOTO loop
	    GOTO loop1

loop1:
    MOVF POSTINC1, 0, 0
    MOVWF POSTINC0
    MOVLW 0x00
    CPFSEQ INDF1
	 GOTO loop1

loop2:
    MOVF POSTINC2, 0, 0
    MOVWF POSTINC0
    MOVLW 0x00
    CPFSEQ INDF2
	 GOTO loop2
    
end