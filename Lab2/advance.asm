#INCLUDE <p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x10

setup1: ;???
    LFSR 0, 0x010
    MOVLW 0x0B
    MOVWF POSTINC0 ;0x010
    MOVLW 0x05
    MOVWF POSTINC0 ;0x011
    MOVLW 0x40
    MOVWF POSTINC0 ;0x012
    MOVLW 0x07
    MOVWF POSTINC0 ;0x013
    MOVLW 0x0D
    MOVWF POSTINC0 ;0x014
    MOVLW 0x7F
    MOVWF POSTINC0 ;0x015
    MOVLW 0x0A
    MOVWF POSTINC0 ;0x016
    MOVLW 0x01
    MOVWF POSTINC0 ;0x017
    MOVLW 0xFE
    MOVWF POSTINC0 ;0x018
    

LFSR 1, 0x010 ;i ????
LFSR 2, 0x010 ;j ????

;??????
MOVLW 0x000 ;i
MOVWF 0x000
MOVLW 0x001 ;j
MOVWF 0x001
MOVLW 0x009
MOVWF 0x002
    
outer:
    
    inner:
	
	MOVLW 0x000 ;move pointer
	IORWF POSTINC2 ;move pointer
	INCF 0x001
	
	;compare
	MOVF INDF1, 0, 0
	CPFSLT INDF2 ;
	GOTO next
	GOTO swap
	;compare
	
	;swap
	
	swap:
	    MOVF INDF1, 0, 0
	    MOVWF 0x003
	    MOVF INDF2, 0, 0
	    MOVWF INDF1
	    MOVF 0x003, 0, 0
	    MOVWF INDF2
	    CLRF 0x003
	
	next:
	    MOVF 0x001, 0, 0 ;compare
	    CPFSEQ 0x002
	    GOTO inner
    
    s1:
	MOVLW 0x000 ;move pointer
	IORWF POSTINC1 ;move pointer
	INCF 0x000 ; +1

    fix:
	MOVF 0x001, 0, 0 ;compare i, j
	CPFSEQ 0x000
	GOTO case1
	GOTO case2
	case1:
	    MOVLW 0x000 ;move pointer
	    IORWF POSTDEC2 ;move pointer
	    DECF 0x001 ;-1
	    GOTO fix
	;CPFSEQ 0x000
	case2:
    
    MOVF 0x002, 0, 0 ;compare
    CPFSEQ 0x000
    GOTO outer
    NOP
end






