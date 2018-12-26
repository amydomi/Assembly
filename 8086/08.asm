assume cs:code, ds:data

; 示例，类似C语言结构体

data segment
 
     db 60h dup(0)      ; 假设为其它数据
     
     ; 公司数据
     db 'DEC'           ; 公司名称      0h
     db 'Ken Oslen'     ; 总裁姓名      3h
     dw 137             ; 排名          0ch
     dw 40              ; 收入          0eh
     db 'PDP'           ; 产品          10h

data ends

code segment
        
start:  mov ax,data
        mov ds,ax
        
        mov bx,60h         ; ds:[bx] = ds:60h 定位基址为60h开始
        
        mov word ptr [bx].0ch,38    ; 排名字段改为38
        add word ptr [bx].0eh,70    ; 收入增加70
        
        mov si,0                        ; 用si来定位字符串，修改产品PDP为VAX
        mov byte ptr [bx].10h[si],'V'
        inc si
        mov byte ptr [bx].10h[si],'A'
        inc si
        mov byte ptr [bx].10h[si],'X'

        mov ax,4c00h
        int 21h
    
code ends

end start