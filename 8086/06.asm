assume cs:code, ds:data

; 数据段
data segment
     db 'hellworld'
data ends

; 代码段
code segment
        
start:  mov ax,data
        mov ds,ax       ; 将ds寄存器设为数据段的地址

        mov bx,0
        mov cx,9
s:      mov al,[bx]
        and al,0DFH      ; 11011111B  小写转大写，ascii码中一位变为0即可
        mov [bx],al
        inc bx
        loop s
        
        mov bx,0
        mov cx,9
s0:     mov al,[bx]
        or al,020H       ; 00100000B   大写转小写，ascii码中一位变为1即可
        mov [bx],al
        inc bx
        loop s0
        
        mov ax,4c00h
        int 21h
    
code ends

end start