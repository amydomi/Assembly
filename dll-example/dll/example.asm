;-----------------------------------
;   example.asm - dll
;-----------------------------------
;   compile:
;   ml /c /coff example.asm
;
;   link:
;   link /subsystem:windows /dll /def:example.def example.obj
;-----------------------------------

.386
.model flat,stdcall
option casemap:none

.code
; dll入口函数，由操作系统调用
_DllMain proc dwInstance, dwReason, dwModel
    mov eax,1
    ret
_DllMain endp

; 其它函数，通过*.def描述导出函数，EXPORTS必须是大写
addNumber proc num1, num2
    mov eax, num1
    add eax, num2
    ret
addNumber endp

subNumber proc num1, num2
    mov eax, num1
    sub eax, num2
    ret
subNumber endp

end _DllMain