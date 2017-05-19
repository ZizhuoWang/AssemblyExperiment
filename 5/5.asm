.8086
.MODEL SMALL
.STACK
.DATA
    BUFF BYTE 0,1,2,3,4,5,6,7,8,9
.CODE
START:
    MOV AX,@DATA
    MOV DS,AX
    MOV CX,10
    LEA SI,BUFF
    MOV AH,01H
    INT 21H
    SUB AL,30H
    MOV AH,0
NEXT:
    MOV BL,[SI]
    MOV BH,0
    CMP AX,BX
    JE DEL
    INC SI
    LOOP NEXT
    JMP STOP
DEL:
    MOV DI,SI
    INC SI
    MOV AL,[SI]
    MOV AH,0
    MOV [DI],AX
    LOOP DEL
    MOV [SI],0
    LEA SI,BUFF
    MOV CX,9
    MOV AH,02H
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
DO:
    MOV DL,[SI]
    MOV DH,0
    ADD DX,3030H
    INC SI
    INT 21H
    LOOP DO
STOP:
    MOV AH,4CH
    INT 21H
END START