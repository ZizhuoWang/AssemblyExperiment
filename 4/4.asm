.8086
.MODEL SMALL
.STACK
.DATA
    N EQU 20
    MAXLEN BYTE N
    ACTLEN BYTE ?
    STRING BYTE N DUP('$')
    TRUE BYTE 'It is a palindrome',0AH,0DH,'$'
    FALSE BYTE 'It is NOT a palindrome',0AH,0DH,'$'
    CR BYTE 0AH,0DH
.CODE
START:
    MOV AX,@DATA
    MOV DS,AX
    MOV AH,0AH
    MOV DX,OFFSET MAXLEN
    INT 21H
    MOV AL,ACTLEN
    MOV AH,0
    MOV BL,2
    DIV BL
    ADD AL,AH
    MOV AH,0
    MOV BL,ACTLEN
    MOV BH,0
    MOV SI,BX
    MOV BX,OFFSET STRING
    DEC SI
LP: CMP SI,AX
    JNA T
    MOV DL,[BX+SI]
    MOV DH,[BX]
    CMP DL,DH
    JNZ F
    INC BX
    SUB SI,2
    JMP LP
T:  MOV DX,OFFSET TRUE
    JMP QUIT
F:  MOV DX,OFFSET FALSE
    JMP QUIT
QUIT:
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
END START