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
;
; instance: dll的模块句柄，非宿主句柄
;
; reason: 原因 (DLL生命周期状态)
;       DLL_PROCESS_ATTACH      dll映射到宿主进程空间
;       DLL_PROCESS_DETACH      dll从宿主进程空间解除映射
;       DLL_THREAD_ATTACH       dll宿主创建线程
;       DLL_THREAD_DETACH       dll宿主线程终结
;
; reserved 系统保留参数，用不到
;
; 返回值放入eax中，当eax非0时(TRUE) dll才能正常被装载
;
_DllMain proc instance, reason, reserved
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