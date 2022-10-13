LIST p=18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
a = 0x06 ; N
init:
    MOVLW a ;input
    MOVWF 0x000
    MOVLW 0x01 ;i
    MOVWF 0x004
    
    ; cmp
    MOVLW 0x01
    MOVWF 0x001
    
    rcall hanoi
    rcall finish
    
hanoi:
    MOVF 0x000, 0, 0
    CPFSEQ 0x001
    GOTO L1
    GOTO L2

L1: ;recusive
    DECF 0x000 ; -1
    rcall hanoi ; A C B
    rcall printf
    rcall hanoi ; B A C
    INCF 0x000 ; +1
    RETURN

L2: ;base case
    rcall printf ; n, A, C
    RETURN

printf:
    INCF 0x002
    RETURN
    
finish:
    MOVFF 0x002, 0x000
    NOP
    end


