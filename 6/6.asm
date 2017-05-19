.8086
.MODEL SMALL
.STACK
.DATA
    STRING DB 'You must input 0~9, OR `Q` OR `q`',0AH,0DH,'$'
    BUF DB 8 DUP(30H),'$'
.CODE
START:
    MOV AX,@DATA
    MOV DS,AX
    MOV AH,01H
    INT 21H
    CMP AL,'q'
    JE EXIT
    CMP AL,'Q'
    JE EXIT
    CMP AL,'0'
    JL WRONG
    CMP AL,'9'
    JG WRONG
    
    MOV BL,AL
    MOV AH,02H
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    MOV AL,BL
    SUB AL,30H
    MOV DX,0
    MOV AH,0
    MOV BX,OFFSET BUF+7
AGAIN:
    MOV DX,0
    MOV CX,2
    DIV CX
    ADD DL,30H
    MOV [BX],DL
    DEC BX
    AND AX,AX
    JNE AGAIN
    JMP RIGHT
RIGHT:
    MOV AH,09H
    LEA DX,BUF
    INT 21H
    JMP EXIT
WRONG:
    MOV AH,09H
    LEA DX,STRING
    INT 21H
    JMP EXIT
EXIT:
    MOV AH,4CH
    INT 21H
END START