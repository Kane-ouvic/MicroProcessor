LIST p=18f4520
    #include<p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF
	org 0x00
;x = 0x12
;COMF x
;MOVLW x
;MOVWF 0x11
;MOVLW 0x31
;ADDWF 0x11, F
;CLRF 0x11

x = 0x7C
y = 0x04
initial:
    MOVLW x
    MOVWF 0x000
    MOVLW y
    MOVWF 0x001
    COMF 0x000
    INCF 0x000
    MOVF 0x000, 0, 0

compare:
    CPFSEQ 0x001
	GOTO case1
	GOTO case2
    case1:
	MOVLW 0x01
	GOTO next
    case2:
	MOVLW 0xFF
	GOTO next
    next:
	MOVWF 0x002

end