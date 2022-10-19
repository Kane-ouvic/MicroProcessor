#include "xc.inc"
GLOBAL _divide_signed

PSECT mytext, local, class=CODE, reloc=2


_divide_signed:
    
    MOVFF 0x001, 0x003
    MOVWF 0x001
    
    BTFSS 0x001, 7
    GOTO next1
    NEGF 0x001
    CLRF 0x002
    INCF 0x010 ; r
    next1:
    BTFSS 0x003, 7
    GOTO next2
    NEGF 0x003
    CLRF 0x004
    INCF 0x011 ; Q
    next2:
    MOVFF 0x010, WREG
    XORWF 0x011, 1, 0 ; Q = a xor b
    
    MOVLW 0x09
    MOVFF WREG, LATC
    MOVFF 0x003, LATD
    
    shift:
	DCFSNZ LATC, 1, 0
	GOTO finish
	RLCF 0x001, 1, 0
	RLCF 0x002, 1, 0
    sub:
	MOVFF LATD, WREG
	SUBWF 0x002, 0, 0
	BN shift
	MOVFF LATD, WREG
	SUBWF 0x002, 1, 0
	INCF 0x001, 1, 0
	GOTO shift
    finish:
	; 0x002 r
	; 0x001 Q
	BTFSC 0x010, 0
	NEGF 0x002
	BTFSC 0x011, 0
	NEGF 0x001
	RETURN