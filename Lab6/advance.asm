LIST p=18f4520
    #include<p18f4520.inc>
	CONFIG OSC = INTIO67 ; 1 MHZ
	CONFIG WDT = OFF
	CONFIG LVP = OFF
	
	L1	EQU 0x14
	L2	EQU 0x15
	org 0x00
	
; Total 2 + (2 + 7 * num1 + 2) * num2 cycles = C
; num1 = 200, num2 = 180, C = 252360
; Total delay ~= C/1M = 0.25s
DELAY macro num1, num2 
    local LOOP1 
    local LOOP2
    MOVLW num2
    MOVWF L2
    LOOP2:
	MOVLW num1
	MOVWF L1
    LOOP1:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DECFSZ L1, 1
	BRA LOOP1
	DECFSZ L2, 1
	BRA LOOP2
endm

	
start:
int:
; let pin can receive digital signal 
MOVLW 0x0f
MOVWF ADCON1
CLRF PORTB
BSF TRISB, 0
CLRF LATA
MOVLW 0xF0
MOVWF TRISA
;BCF TRISA, 0
;BCF TRISA, 1
;BCF TRISA, 2
;BCF TRISA, 3
MOVLW 0xF0
MOVWF LATA
MOVLW 0x05
MOVWF 0x000
    
; ckeck button
check_process:
   BTFSC PORTB, 0
   BRA check_process
   BRA status
   
    
status:
    RLCF LATA
    DELAY d'200', d'90' ;delay 0.5s
    DECFSZ 0x000
    GOTO status
    GOTO fixed
    
fixed:
    MOVLW 0xF0
    MOVWF LATA
    MOVLW 0x05
    MOVWF 0x000
    GOTO check_process

end