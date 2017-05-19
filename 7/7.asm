.8086
.MODEL SMALL
.STACK
.DATA
    STRING BYTE 6 DUP(20H),'$'
    ENDL BYTE 0AH,0DH,'$'
    ERRMSG BYTE 'You must input a number from 1~6',0AH,0DH,'$'
.CODE
START:
    MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV AH,01H
    INT 21H
    CMP AL,'1'
    JL ERR
    CMP AL,'6'
    JG ERR
    SUB AL,30H
    MOV CL,AL
    LEA DX,ENDL
    MOV AH,09H
    INT 21H
    MOV DX,0
    LEA BX,STRING+5
    MOV AL,01H
    MOV AH,0
    MOV CH,0
    CALL DAC
    CALL PRINT
    MAIN ENDP
    
    DAC PROC
AGAIN:
    MOV DX,CX
    MUL DX
    LOOP AGAIN
    DAC ENDP
    
    PRINT PROC
    MOV CX,10
DO:
    MOV DX,0
    DIV CX
    ADD DL,30H
    DEC BX
    MOV [BX],DL
    AND AX,AX
    JNE DO
    MOV DX,BX
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
    PRINT ENDP
    
ERR:
    LEA DX,ENDL
    MOV AH,09H
    INT 21H
    LEA DX,ERRMSG
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
END START