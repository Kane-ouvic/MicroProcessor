LIST p=18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
a = 0x04
init:
    MOVLW a ;input
    MOVWF 0x003
    INCF 0x003
    MOVLW 0x01 ;i
    MOVWF 0x004
    
    ; cmp
    MOVLW 0x01
    MOVWF 0x001
    LFSR 0, 0x011
    
loop:
    MOVFF 0x004, 0x000
    rcall hanoi
    INCF 0x004
    MOVF 0x002, 0, 0
    MOVWF POSTINC0
    CLRF 0x002
    MOVF 0x004, 0, 0
    CPFSEQ 0x003
    GOTO loop
    rcall finish
    
hanoi:
    MOVF 0x000, 0, 0
    CPFSEQ 0x001
    GOTO L1
    GOTO L2

L1: ;recusive
    DECF 0x000
    rcall hanoi
    rcall printf
    rcall hanoi
    INCF 0x000
    RETURN

L2: ;base case
    rcall printf
    RETURN

printf:
    INCF 0x002
    RETURN
    
finish:
    MOVLW 0x00
    MOVWF POSTDEC0
    MOVF INDF0, 0, 0
    MOVWF 0x000
    NOP
    end