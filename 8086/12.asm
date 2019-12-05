assume cs:code, ds:data

data segment
	db	'H',07h,'e',07h,'l',07h,'l',07h,'o',07h,' ',07h,'w',07h,'o',07h,'r',07h,'l',07h,'d',07h
data ends

code segment
        
start:
	mov ax,data			; 设置ds段 - 源字符串
	mov ds,ax
	
	mov ax,0b800h		; 设置es段 - 屏幕缓冲区
	mov es,ax
	
	; 清屏
	mov cx,0fa0h
s:	mov di,cx
	mov byte ptr es:[di],0
	loop s
	
	; cld 指令设置DF=0，std指令DF=1
	; DF=0, movsw和movesb复制指令后 si, di 递增
	; DF=1, movsw和movesb复制指令后 si, di 递减
	
	cld
	mov si,0
	mov di,860h
	mov cx,11
	
	; rep 指令根据cx重复执行 movsw 指令，
	; movsw = 从 ds:[si] 复制2个字节到 es:[di] 中
	rep movsw 
	mov ax,4c00h
	int 21h
code ends

end start