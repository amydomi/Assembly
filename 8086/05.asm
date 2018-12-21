assume cs:code, ds:data, ss:stack

; 数据段
data segment
     dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
data ends

; 栈段
stack segment
     dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
stack ends

; 代码段
code segment
        
start:  mov ax,data
        mov ds,ax       ; 设置数据段的段地址
        
        mov ax,stack
        mov ss,ax
        mov sp,32      ; 设置栈段的段地址，栈顶位于32处
        
        mov bx,0
        mov cx,8
s:      push cs:[bx]
        add bx,2
        loop s      ; 循环将数据段的数据放到栈中(入栈 sp = sp - 2)
        
        mov bx,0
        mov cx,8
s0:     pop cs:[bx]
        add bx,2
        loop s0     ; 循环将栈中的数据放入数据段中(出栈 sp = sp + 2)
    
        mov ax,4c00h
        int 21h
    
code ends

end start