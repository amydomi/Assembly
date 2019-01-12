.386  
.model flat,stdcall  
option casemap:none

; 声明printf和ExitProcess的函数原型
printf proto c:vararg
ExitProcess proto stdcall:dword

; 创建一个字符常量
.const
szHello db 'Hello, ASM!',0dh, 0ah, 0

.code  
main proc
    ; 打印Hello World并退出
    invoke printf, addr szHello              
    invoke ExitProcess,0  
main endp  
end main