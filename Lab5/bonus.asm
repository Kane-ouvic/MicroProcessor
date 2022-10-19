#include "xc.inc"
GLOBAL _mypow

PSECT mytext, local, class=CODE, reloc=2
 
_mypow:
    MOVFF 0x003, LATC
    DECF LATC
    MOVLW 0x00
    MOVFF 0x001, 0x021
    MOVFF 0x001, 0x031
    CPFSEQ 0x003
    GOTO common_case
    GOTO base_case
    

base_case:
    MOVLW 0x01
    MOVWF 0x001
    GOTO finish

common_case:
    ; Low multiply
    CLRF 0x030
    MOVFF 0x021, WREG
    MULWF 0x031
    MOVFF PRODL, 0x021
    MOVFF PRODH, 0x030
    ; High multiply
    MOVFF 0x020, WREG
    MULWF 0x031
    MOVFF PRODL, 0x020
    MOVFF 0x030, WREG
    ADDWF 0x020, 1, 0
    ;
    DCFSNZ LATC, 1, 0
    GOTO fixed
    GOTO common_case

fixed:
    MOVFF 0x020, 0x002
    MOVFF 0x021, 0x001
    NOP
finish:
    NOP
    RETURN


