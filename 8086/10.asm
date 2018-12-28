assume cs:code

data segment

    ; 21年的21个字符串
    db  '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db  '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db  '1993','1994','1995'

    ; 21年公司总收入21个dword型数据
    dd  16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
    dd  345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    
    ; 21年公司雇员人数21个word型数据
    dw  3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800

data ends

table segment
    db 21 dup ('year summ ne ?? ')
table ends

code segment
        
start:  mov ax,data
        mov ds,ax
        
        mov ax,table
        mov es,ax
        
        mov cx,21
        
        mov bx,0    ; 一次取4位      (年份、公司总收入下标)
        mov si,0    ; 一次取16位     (table下标)
        mov di,0    ; 一次取2位      (雇员人数下标)
        
copys:  mov ax,ds:[bx]      ; 复制年份低16位
        mov es:[si],ax
        mov ax,ds:[bx+2]    ; 复制年份高16位
        mov es:[si+2],ax

        mov ax,ds:[bx+84]   ; 复制公司总收低16位        84 = 4 * 21
        mov es:[si+5],ax
        mov ax,[bx+86]      ; 复制公司总收高16位
        mov es:[si+7],ax
        
        mov ax,ds:[di+168]  ; 复制雇员人数              168 = (4 * 21) + (4 * 21)
        mov es:[si+10],ax
        
        mov ax,ds:[bx+84]   ; 平均收入 = 公司总收 / 雇员人数
        mov dx,ds:[bx+86]
        div word ptr ds:[di+168]
        mov es:[si+13],ax

        add di,2
        add bx,4
        add si,16
loop copys
        
        mov ax,4c00h
        int 21h
code ends

end start