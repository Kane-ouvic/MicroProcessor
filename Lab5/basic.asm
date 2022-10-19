#include "xc.inc"
GLOBAL _isprime

PSECT mytext, local, class=CODE, reloc=2
 
_isprime:
    MOVFF 0x001, LATD
    MOVFF 0x001, 0x011
    MOVFF 0x001, 0x012
    DECF 0x001
    
    MOVLW 0x01 ; isPrime
    MOVWF 0x008 ; init
    
    
    MOVLW 0x01
    MOVWF 0x000
    
loop_num:    
    MOVFF 0x001, WREG
    CPFSEQ 0x000
    GOTO loop_case1
    GOTO loop_case2
    loop_case1: ; i < target
	INCF 0x000
	MOVFF 0x000, WREG
	MOVFF 0x011, 0x012
	rcall test_num
	GOTO loop_num
    loop_case2: ; i >= target
	MOVFF 0x008, WREG
	RETURN
test_num:
    loop:
    SUBWF 0x012, 1, 0
    MOVFF 0x012, WREG ;
    CPFSLT 0x011
    GOTO case1
    GOTO case2
    case1: ; >= 0
	MOVLW 0x00
	CPFSEQ 0x012
	GOTO next
	MOVLW 0xFF
	MOVWF 0x008
	RETURN
	next:
	MOVFF 0x000, WREG
	GOTO loop
    case2: ; < 0
	NOP
	RETURN
    
;finish:
;    MOVFF 0x008, 0x000
;    RETURN





