.8086
.MODEL SMALL
.STACK
.DATA
    N EQU 20
    MAXLEN BYTE N
    ACTLEN BYTE ?
    STRING BYTE N DUP('$')
    TRUE BYTE 0AH,0DH,'It is a palindrome',0AH,0DH,'$'	;开头加0AH、0DH是为了防止回车把输入冲掉
    FALSE BYTE 0AH,0DH,'It is NOT a palindrome',0AH,0DH,'$'
.CODE
START:
    MOV AX,@DATA
    MOV DS,AX
    MOV AH,0AH
    MOV DX,OFFSET MAXLEN
    INT 21H;缓冲区的第一个字节指定容纳的最大字符个数，由用户给出；第二个字节存放实际的最大字符个数，由系统最后填入；从第三个字节开始存放从键盘接受的字符，直到ENTER键结束。
    MOV AL,ACTLEN
    MOV AH,0
    MOV BL,2
    DIV BL
    CMP AH,1
    JE ITSODD;如果是奇数字数的字符串，跳到"It's odd"
    CMP AL,1
    JE ITSTWO;如果是两个字符的字符串，跳到"It's two"
    ADD AL,AH;奇数个数和偶数个数的区别就在这句话
    MOV AH,0
    MOV BL,ACTLEN
    MOV BH,0
    MOV SI,BX
    MOV BX,OFFSET STRING
    DEC SI
ITSEVEN:
    CMP SI,AX
    JNA T
    MOV DL,[BX+SI]
    MOV DH,[BX]
    CMP DL,DH
    JNZ F
    INC BX
    SUB SI,2;因为BX加了一，所以BX+SI要想减一，就需要SI减二
    JMP ITSEVEN
ITSODD:
    MOV AH,0
    MOV BL,ACTLEN
    MOV BH,0
    MOV SI,BX
    MOV BX,OFFSET STRING
    DEC SI
JUDGEODD:
    CMP SI,AX
    JNA T
    MOV DL,[BX+SI]
    MOV DH,[BX]
    CMP DL,DH
    JNZ F
    INC BX
    SUB SI,2
    JMP JUDGEODD
ITSTWO:
    MOV BX,OFFSET STRING
    MOV DL,[BX+1]
    MOV DH,[BX]
    CMP DL,DH
    JNE F;如果这两个字符不相同，就不是。否则直接向下执行T
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
