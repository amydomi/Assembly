assume cs:code

code segment

        ; 在代码段最前面定义8个字型数据, dw = define word
        dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h

;start只是个标号， 由end指令来指定ip偏移位置
start:  mov bx,0
        mov ax,0
    
        mov cx,8
s:      add ax,cs:[bx]  ; 循环8次，将上面定义数据累加到ax寄存器中
        add bx,2
        loop s
    
        mov ax,4c00h
        int 21h
    
code ends

end start ; end指令指定第一行代码执行的位置