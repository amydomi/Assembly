.386
.model flat,stdcall
option casemap:none

; ϵͳ��������
ExitProcess proto :dword
printf proto C :vararg

; �����
includelib kernel32.lib
includelib msvcrt.lib

.const
_str db '%d + %d = %d',0dh,0ah,0

.code

; =======================================
; �򵥵ļӷ�����
; C����д����
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
; C���Բ���
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