LIST p=18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00

DIST macro x1, y1, x2, y2, F1, F2
    MOVLW x1
    MOVWF 0x000
    MOVLW x2
    MOVWF 0x001
    MOVLW y1
    MOVWF 0x002
    MOVLW y2
    MOVWF 0x003
    
    ;x1 - x2
    MOVF 0x000, 0, 0
    MOVWF 0x005
    MOVF 0x001, 0, 0
    SUBWF 0x005, 0, 0
    MOVWF 0x005
    MOVWF 0x006
    
    ;y1 - y2
    MOVF 0x002, 0, 0
    MOVWF 0x007
    MOVF 0x003, 0, 0
    SUBWF 0x007, 0, 0
    MOVWF 0x007
    MOVWF 0x008
    
    ;(x1-x2)^2
    MOVF 0x005, 0, 0
    MULWF 0x006
    MOVFF PRODH, 0x009
    MOVFF PRODL, 0x00A
    
    ;(y1-y2)^2
    MOVF 0x007, 0, 0
    MULWF 0x008
    MOVFF PRODH, 0x00B
    MOVFF PRODL, 0x00C
    
    ; (x1-x2)^2 + (y1-y2)^2
    MOVF 0x00A, 0, 0
    MOVWF 0x00E
    MOVF 0x00C, 0, 0
    ADDWF 0x00E
    
    MOVF 0x009, 0, 0
    MOVWF 0x00D
    MOVF 0x00B, 0, 0
    ADDWFC 0x00D
    
    ;Ans
    MOVFF 0x00D, F1
    MOVFF 0x00E, F2
    endm
    
init:
    DIST 0x10, 0x10, 0x00, 0x00, 0x00B, 0x00D
    NOP

end

    
    


