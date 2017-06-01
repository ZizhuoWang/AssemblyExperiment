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
    JE EXIT;输入'q'或'Q'时退出
    CMP AL,'0'
    JL WRONG
    CMP AL,'9'
    JG WRONG;输入小于零或者大于九时错误
    
    MOV BL,AL
    MOV AH,02H
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H;回车换行
    
    MOV AL,BL
    SUB AL,30H;ASCII码转数字
    MOV DX,0
    MOV AH,0
    MOV BX,OFFSET BUF+7
AGAIN:
    MOV DX,0;余数清零
    MOV CX,2
    DIV CX
    ADD DL,30H;转ASCII码
    MOV [BX],DL;将零或一附给BX所指内存中的元素
    DEC BX;向左移一位
    AND AX,AX
    JNE AGAIN;AX不为零就继续循环
    JMP RIGHT;其实这句可有可无，当时随便就写上了
RIGHT:
    MOV AH,09H
    LEA DX,BUF
    INT 21H;输出BUF内容
    JMP EXIT
WRONG:
    MOV AH,09H
    LEA DX,STRING
    INT 21H;输出STRING内容
    JMP EXIT
EXIT:
    MOV AH,4CH
    INT 21H;退出到DOS
END START
