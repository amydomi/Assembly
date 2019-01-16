.386
.model flat,stdcall
option casemap:none

; 系统函数声明
ExitProcess proto :dword
printf proto C :vararg

; 导入库
includelib kernel32.lib
includelib msvcrt.lib

.const
_str db '%d + %d = %d',0dh,0ah,0

.code

; =======================================
; 简单的加法运算
; C语言写法：
;
; void _add(int a, int b) {
;   return a + b;
; }
; =======================================
_add proc a:dword, b:dword
    mov eax, a
    add eax, b
    ret
_add endp

; =======================================
; C语言参照
; int main() {
;   int a, b;
;   a = 10;
;   b = 20;
;   printf("%d + %d = %d'\n", add(a, b));
; }
; =======================================
main proc
    local @num1, @num2
    mov @num1, 10
    mov @num2, 20
    invoke _add,@num1,@num2
    invoke printf, addr _str, @num1, @num2, eax
    invoke ExitProcess,0
main endp

end main