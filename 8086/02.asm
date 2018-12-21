assume cs:code

code segment

    ; 设置数据段地址为 0
    mov ax,0
    mov ds,ax
  
    ; 设置数据偏移地址为 200，组装为 0:200
    mov bx,200h
    
    ; 初始化数据累加器为0
    mov dl,0
    
    ; 循环63次， 3F
    mov cx,63
    
s:  mov [bx],dl ; 将dl中的值写入到内存单元为ds:[bx]中 (0:200 ~ 0:23F)
    inc dl ; dl中的值自增1
    inc bx ; bx自增1
    loop s
    
    mov ax,4c00h
    int 21h
    
code ends
end