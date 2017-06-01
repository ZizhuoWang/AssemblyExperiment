.8086
.MODEL SMALL
.STACK
.DATA
    BUFF BYTE 0,1,2,3,4,5,6,7,8,9
.CODE
START:
    MOV AX,@DATA
    MOV DS,AX
    MOV CX,10;计数初始化为10
    LEA SI,BUFF;BUFF首地址给SI
    MOV AH,01H
    INT 21H;从键盘输入一个字符
    SUB AL,30H;将ASCII码变成数字
    MOV AH,0
NEXT:
    MOV BL,[SI]
    MOV BH,0
    CMP AX,BX
    JE DEL;找到了就跳至删除
    INC SI
    LOOP NEXT
    JMP STOP;找不到就停
DEL:
    MOV DI,SI;记住当前元素的位置
    INC SI
    MOV AL,[SI]
    MOV AH,0
    MOV [DI],AX;后面的内容前移
    LOOP DEL
    MOV [SI],0;找到的最后一位换成0
    LEA SI,BUFF;SI指向BUFF首地址
    MOV CX,9;设计数器为9
    MOV AH,02H
    MOV DL,0DH
    INT 21H;回车
    MOV DL,0AH
    INT 21H;换行
DO:
    MOV DL,[SI]
    MOV DH,0
    ADD DX,3030H;十六进制转ASCII
    INC SI
    INT 21H;一个个输出此时BUFF内容
    LOOP DO
STOP:
    MOV AH,4CH
    INT 21H;退回DOS
END START
