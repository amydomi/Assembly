assume cs:code

code segment

    ; 使用ds存放数据源的段地址
    mov ax, 0ffffh
    mov ds,ax
    
    ; 使用es存放目标数据的段地址
    mov ax,0020h
    mov es,ax
    
    ; 偏移地址为0
    mov bx,0
    
    ; 循环16次
    mov cx,0f
    
    ;循环从FFFF:0 ~ FFFFF:F 读取数据，放入20:0 ~ 20:F中，每此循环取一个字节
s:  mov dl,[bx]
    mov es:[bx],dl
    inc bx
    loop s
    
    mov ax,4c00h
    int 21h
    
code ends
end