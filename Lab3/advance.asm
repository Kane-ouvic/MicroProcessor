#INCLUDE <p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x10
    
x = 0x06
y = 0x17
set_counter:
    MOVLW 0x05 ;10
    MOVWF 0x006 ;12

set_up:
;divisor
    MOVLW x ;14
    RLNCF WREG ;16
    RLNCF WREG ;18
    RLNCF WREG ;1A
    RLNCF WREG ;1C
    MOVWF 0x002 ;1E
    MOVWF 0x003 ;20
;divide
    MOVLW y ;22
    MOVWF 0x001 ;24
    MOVWF 0x005 ;26

sub:
    MOVF 0x002, 0, 0 ;28
    SUBWF 0x001, 0, 0 ;2A
    BN 0x3E ;2C

case1: ; >= 0
    MOVWF 0x001 ;2E
    BSF 0x000, 0 ;set 1  30
    RLNCF 0x000 ;shift q 32
    RRNCF 0x002 ;shift div 34
    DECF 0x006 ;36
    MOVF 0x006, 0, 0 ;38
    BNZ 0x28 ;3A
    BZ 0x48  ;3C

case2: ; < 0
    RLNCF 0x000 ;shift q 3E
    RRNCF 0x002 ;shift div 40
    DECF 0x006 ; 42
    MOVF 0x006, 0, 0 ; 44
    BNZ 0x28 ; 46

fixed:
    RRNCF 0x000
    
    
NOP
    
end





