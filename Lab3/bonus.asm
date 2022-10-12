#INCLUDE <p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x10

setup:
    MOVLW 0xF5  
    MOVWF 0x010
    MOVWF 0x031
    MOVLW 0x5A
    MOVWF 0x011
    MOVWF 0x041

loop:
    CLRF 0x012
    CLRF 0x013


bigger:
    MOVF 0x030, 0, 0
    CPFSEQ 0x040
    GOTO next1
    GOTO jump1
next1:
    CPFSGT 0x040
    GOTO bigger_case1
    GOTO bigger_case2
    bigger_case1:
	BSF 0x012, 1
	GOTO jump1
    bigger_case2:
	BSF 0x013, 1
jump1:
    MOVF 0x031, 0, 0
    CPFSEQ 0x041
    GOTO next2
    GOTO jump2
next2:
    CPFSGT 0x041
    GOTO bigger_case3
    GOTO bigger_case4
    bigger_case3:
	BSF 0x012, 0
	GOTO jump2
    bigger_case4:
	BSF 0x013, 0
jump2:
    MOVF 0x012, 0, 0
    CPFSLT 0x013
    GOTO add_case1
    GOTO add_case2
    add_case1:
	MOVF 0x010, 0, 0
	MOVFF 0x031, 0x032
	ADDWF 0x031
	MOVF 0x032, 0, 0
	CPFSGT 0x031
	INCF 0x030
	GOTO jump3
    add_case2:
    	MOVF 0x011, 0, 0
	MOVFF 0x041, 0x042
	ADDWF 0x041
	MOVF 0x042, 0, 0
	CPFSGT 0x041
	INCF 0x040

jump3:    
    CLRF 0x050
    CLRF 0x051

;equal
compare:
    MOVF 0x030, 0, 0
    CPFSEQ 0x040
    GOTO compare_case1
    GOTO compare_case2
    compare_case1:
	BCF 0x050, 0
	GOTO jump4
    compare_case2:
	BSF 0x050, 0
    jump4:
    MOVF 0x031, 0, 0
    CPFSEQ 0x041
    GOTO compare_case3
    GOTO compare_case4
    compare_case3:
	BCF 0x051, 0
	GOTO jump5
    compare_case4:
	BSF 0x051, 0
    jump5:
    MOVF 0x050, 0, 0
    MOVWF 0x052
    MOVF 0x051, 0, 0
    ANDWF 0x052
    
    BTFSS 0x052, 0
    GOTO loop

NOP
fixed:
    MOVFF 0x030, 0x000
    MOVFF 0x031, 0x001

NOP
end





