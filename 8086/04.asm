assume cs:code

code segment

        dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
        dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
           ; 将cs:10h ~ cs:30h 位置当做栈来使用 

start:  mov ax,cs
        mov ss,ax
        mov sp,30h  ; 将栈顶ss:sp指向cs:30h位置
        
        mov bx,0
        mov cx,8     
s:      push cs:[bx]
        add bx,2
        loop s      ; 将cs:0h ~ cs:fh 之间的数据依次入栈
        
        mov bx,0
        mov cx,8
s0:     pop cs:[bx]
        add bx,2
        loop s0     ; 依次从栈内取出数据放回cs:0h ~ cs:fh中
    
        mov ax,4c00h
        int 21h
    
code ends

end start