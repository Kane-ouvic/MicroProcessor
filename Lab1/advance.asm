
LIST p=18f4520
    #include<p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF
	org 0x00

x = b'00010111'
initial:
    MOVLW x
    MOVWF 0x000

Loop:
    BTFSC 0x00 , 0
    INCF 0x002
    RRNCF 0x000
    CPFSEQ 0x000
    GOTO Loop

end


