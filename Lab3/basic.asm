#INCLUDE <p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x10
    
start:
    LFSR 0, 0x000 ;input 1   10
    LFSR 1, 0x010 ;input 2   12
    LFSR 2, 0x033 ;carry   14
    
    
;    MOVLW 0x01
;    MOVWF POSTDEC2
;    MOVLW 0x01
;    MOVWF POSTDEC2
    
    ;1
    MOVLW 0x10     ; 16
    MOVWF POSTINC0 ; 18
    MOVLW 0x11     ; 1A
    MOVWF POSTINC0 ; 1C
    MOVLW 0x12     ; 1E
    MOVWF POSTINC0 ; 20
    MOVLW 0xFF     ; 22
    MOVWF INDF0    ; 24
    
    ;2
    MOVLW 0x20     ; 26
    MOVWF POSTINC1 ; 28
    MOVLW 0x21     ; 2A
    MOVWF POSTINC1 ; 2C
    MOVLW 0x22     ; 2E
    MOVWF POSTINC1 ; 30
    MOVLW 0xFF     ; 32
    MOVWF INDF1    ; 34

addition:
;    MOVLW 0xFF
;    ADDWF 0x000
    
    ; check 1
    MOVF INDF0, 0, 0 ; 36
    MOVWF 0x023     ; 38
    MOVF INDF1, 0, 0 ; 3A
    ADDWF 0x023     ; 3C
    
    
    MOVF POSTDEC0, 0, 0  ; 3E
    CPFSGT 0x023         ; 40
    INCF INDF2            ; 42
    MOVF POSTDEC1, 0, 0  ; 44
    CPFSGT 0x023         ; 46
    INCF INDF2            ; 48
    
    ;MOVLW 0x000 ;move pointer
    ;IORWF POSTDEC2 ;move pointer
    
    ; check 2
    MOVF INDF0, 0, 0     ; 4A
    MOVWF 0x022         ; 4C
    MOVF INDF1, 0, 0     ; 4E
    ADDWF 0x022         ; 50
    ; add carry
    MOVF POSTDEC2, 0, 0  ;52
    BZ 0x5A;sadas             ; 54
    MOVLW 0x01         ; 56
    ADDWF 0x022        ;58
    ; add carry
    
    MOVF POSTDEC0, 0, 0 ; 5A
    CPFSGT 0x022        ; 5C
    INCF INDF2           ; 5E
    MOVF POSTDEC1, 0, 0 ; 60
    CPFSGT 0x022        ; 62
    INCF INDF2           ; 64
    
    ; check 3
    MOVF INDF0, 0, 0    ; 66
    MOVWF 0x021        ; 68
    MOVF INDF1, 0, 0    ; 6A
    ADDWF 0x021        ; 6C
    ; add carry
    MOVF POSTDEC2, 0, 0  ; 6E
    BZ 0x7C ;sdasd             ;70
    MOVLW 0x01          ;72
    ADDWF 0x021         ;74
    ; add carry
    
    MOVF POSTDEC0, 0, 0 ; 76
    CPFSGT 0x021        ; 78
    INCF INDF2           ; 7A
    MOVF POSTDEC1, 0, 0 ; 7C
    CPFSGT 0x021        ; 7E
    INCF INDF2           ; 80
    
    ; check 4
    MOVF INDF0, 0, 0    ; 82
    MOVWF 0x020        ; 84
    MOVF INDF1, 0, 0    ; 86
    ADDWF 0x020         ; 88
    ; add carry
    MOVF POSTDEC2, 0, 0   ; 8A
    BZ 0x98;;;                 ; 8C
    MOVLW 0x01           ; 8E
    ADDWF 0x020          ; 90
    ; add carry
    
    ;MOVF POSTDEC0, 0, 0
    ;CPFSGT 0x020
    ;INCF INDF2
    ;MOVF POSTDEC1, 0, 0
    

    NOP
end