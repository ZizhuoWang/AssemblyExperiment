.8086
.MODEL SMALL
.STACK
.DATA
    SCORE DB 85,73,92,66,91,98,52,87,83,68
    ENDL DB 0AH,0DH,'$'
.CODE
START:
    MOV AX,@DATA
    MOV DS,AX
    MOV DI,OFFSET SCORE
    MOV AX,0
    MOV BX,0
    MOV CX,09H
    MOV DX,0
C1:
    MOV DX,CX
    MOV DI,OFFSET SCORE
C2:
    MOV AL,[DI]
    MOV BL,[DI+1]
    CMP AL,BL
    JB CHANGE
    JMP NEXT
CHANGE:
    MOV [DI],BL
    MOV [DI+1],AL
NEXT:
    INC DI
    LOOP C2
    MOV CX,DX
    LOOP C1
    
    MOV CX,10
    MOV DI,OFFSET SCORE
PRINT:
    MOV AH,0
    MOV AL,[DI]
    MOV BL,10
    DIV BL
    MOV DX,AX
    ADD DX,3030H
    MOV AH,02H
    INT 21H
    MOV DL,DH
    INT 21H
    MOV DX,OFFSET ENDL
    MOV AH,09H
    INT 21H
    INC DI
    LOOP PRINT
    MOV AH,4CH
    INT 21H
END START