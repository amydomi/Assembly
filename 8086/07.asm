assume cs:code, ds:data

; 数据段
data segment
     db '1. file         '
     db '2. edit         '
     db '3. search       '
     db '4. view         '
     db '5. options      '
     db '6. help         '
data ends

; 代码段
code segment
        
start:  mov ax,data
        mov ds,ax
        
        mov cx, 6
        mov bx, 3

        ; 在没有使用到寄存器操作内存的时候，需要显示指明长度
        
        ; mov 寄存器,寄存器   (否)
        ; mov 寄存器,立即数   (否)
        ; mov 寄存器,内存     (否)
        ; mov 内存,寄存器     (否)
        ; mov 内存,立即数     (需要指定长度)
        ; push 内存           (否)
        ; pop 内存            (否)
        ; push 寄存器         (否)
        ; pop 寄存器          (否)
        ; add 内存,立即数     (需要指定长度)
        ; add 内存, 寄存器    (否)
        ; inc 内存            (需要指定长度)
        ; and 内存            (需要指定长度)
        ; or 内存             (需要指定长度)
        
        ; mov byte ptr ds:[bx],0FFH             8位
        ; mov word ptr ds:[bx],0FFFFH           16位
        ; mov dword ptr ds:[bx],0FFFFFFFFH      32位
        
s:      and byte ptr [bx], 11011111B    ; 修改首字母大写
        add bx, 16
        loop s

        mov ax,4c00h
        int 21h
    
code ends

end start