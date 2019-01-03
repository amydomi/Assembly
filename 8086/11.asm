assume cs:code

data segment
    db 'Welcome to masm!'       ; 16个字符
data ends

code segment
        
start:  mov bx,data
        mov ds,bx
        
        mov bx,0b800h       ; B800:0 ~ B8F9:F 显存
        mov es,bx
        
        ; 共25行，每行160个字节，
        ; 每个显示字符由两个字节组成。 奇数：ASCII码字符， 偶数：颜色属性
        
        ; 8位颜色属性中的每个位用途：
        ; 7     6  5  4    3     2  1  0
        ; BL    R  G  B    I     R  G  B
        ; --    -------   ---    -------
        ; 闪烁    背景    高亮    前景
        
        mov bx,860h      ; (160 * 13 = 2080 行数居中) +  ((160 - 16 * 2) / 2) = 水平居中
        mov si,0
        mov di,0
        
        mov cx,16
show:   mov al,ds:[si]
        mov es:[bx].0h[di],al
        mov byte ptr es:[bx].1h[di],01000011b     ; 红底青色 (青色:RGB=011)
        inc si
        add di,2
        loop show
        
        mov ax,4c00h
        int 21h
code ends

end start