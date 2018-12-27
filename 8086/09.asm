assume cs:code, ds:data

; 除法运算

data segment
    dd 100001   ; 被除数   0h
    dw 100      ; 除数     4h
    dw 0        ; 商       6h
    dw 0        ; 余数     8h  
data ends

code segment
        
start:  
        ; 1. 除数长度为16位
        ; 2. 将被除数放入AX和BX寄存器中，AX=低16，BX=高16
        ; 3. 除法指令  div 除数      (除数可以是内存或寄存器)
        ; 4. 得到结果：AX=商      BX=余数
        
        ; 100001 / 100 = 1000, 余数为1
        mov dx,1        ; 被除数：高位为1
        mov ax,86A1H    ; 被除数：低位为86A1
        mov bx, 100     ; 除数    BX长度16位
        div bx          ; 结果 AX=03E8  (1000)  DX=00001 (1)
        
        ; 1. 除数长度为8位
        ; 2. 将被除数放入AX中      AX=被除数
        ; 3. 除法指令   div 除数      (除数可以是内存或寄存器)
        ; 4. 得到结果： AL=商     AH=余数
        
        ; 1001 / 100 = 10 余数为1
        mov ax,1001     ; 被除数
        mov bl,100      ; 除数     BL长度8位
        div bl          ; 结果 AL=A  (10)    AH=1 (1)    
        
        ; 从内存中计算
        mov ax, data
        mov ds,ax
        
        ; [idata]前面的ds不能省略
        
        mov ax, ds:[0]        ; 低16     AX=DS:0
        mov dx, ds:[2]        ; 高16     DX=DS:2
        div word ptr ds:[4]   ; 结果 AX=03E8  (1000)  DX=00001 (1)
        mov ds:[6],ax         ; AX中的商放入内存
        mov ds:[8],dx         ; DX中的余数放入内存
        
        mov ax,4c00h
        int 21h
code ends

end start