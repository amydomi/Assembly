.386
.model flat,stdcall
option casemap:none

ExitProcess proto :dword
printf proto C :vararg

; example.dll 中的函数原型
addNumber proto :dword, :dword
subNumber proto :dword, :dword

includelib kernel32.lib
includelib msvcrt.lib

; example 链接成功后会生成3个文件
; 1. example.dll
; 2. example.lib
; 3. example.exp (无用)
includelib example.lib

.const
strAdd  db  '%d + %d = %d', 0dh, 0ah, 0
strSub  db  '%d - %d = %d', 0dh, 0ah, 0

.code
main proc
    local num1, num2
    mov num1,20
    mov num2,10
    
    ; dll中加法运算的函数
    invoke addNumber,num1,num2
    invoke printf,offset strAdd, num1, num2, eax
    
    ; dll中减法运算的函数
    invoke subNumber,num1, num2
    invoke printf,offset strSub, num1, num2, eax
    
    invoke ExitProcess,0
main endp
end main