.8086
.MODEL SMALL
.STACK
.DATA
    Table BYTE 0,1,4,9,16,25,36,49,64,81
    XX BYTE 9
    YY BYTE ?
.CODE
START:
    MOV AX,@DATA
    MOV DS,AX
    LEA BX,Table
    MOV AL,XX
    XLAT;以DS:[BX+AL]为地址，提取存储器中的一个字节再送入AL。
    MOV YY,AL
END START
