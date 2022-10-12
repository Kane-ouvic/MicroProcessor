#INCLUDE <p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x10

setup1:
    LFSR 0, 0x100
    LFSR 1, 0x101
    LFSR 2, 0x0F0
    MOVLW 0x07
    MOVWF INDF2
    MOVLW 0x01
    MOVWF INDF0
    MOVWF INDF1
    
start:
    MOVF POSTINC1, 0, 0
    MOVWF INDF1
    MOVF POSTINC0, 0, 0
    ADDWF INDF1
    DECF INDF2
    MOVLW 0x00
    CPFSEQ INDF2
    GOTO start
end



