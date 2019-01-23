.386
.model flat,stdcall
option casemap:none

include windows.inc
include kernel32.inc
include user32.inc

includelib kernel32.lib
includelib user32.lib

include resource.inc

.const
szText      db     '是否关闭窗口？', 0
szTitle     db      '消息', 0

.data?
hInstance   dd     ?

.code
; 消息过程
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
dlgProc proc hWnd, uMsg, wParam, lParam
    mov     eax, uMsg
    .if eax == WM_CLOSE
        invoke      MessageBox, hWnd, offset szText, offset szTitle, MB_YESNO or MB_ICONQUESTION
        .if eax == IDYES
            invoke  EndDialog, hWnd, 0
        .endif
        mov     eax, TRUE
    .else
        mov     eax, FALSE
        ret
    .endif
    ret
dlgProc endp
; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
main proc
    invoke      DialogBoxParam, hInstance, IDD_MAIN, NULL, offset dlgProc, 0
    ret
main endp

start:
    invoke      GetModuleHandle, 0
    mov         hInstance, eax
    call        main
    invoke      ExitProcess, 0 
end start