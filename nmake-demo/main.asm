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
szBtnText1  db      '你点击了第一个按钮。', 0
szBtnText2  db      '你点击了第二个按钮。', 0

.data?
hInstance   dd     ?

.code
commandProc proc hWnd, uMsg, wParam, lParam
    mov      eax, wParam
    movzx    eax, ax
    .if eax == IDB_BTN1
        invoke      MessageBox, hWnd, offset szBtnText1, offset szTitle, MB_OK
    .elseif eax == IDB_BTN2
        invoke      MessageBox, hWnd, offset szBtnText2, offset szTitle, MB_OK
    .endif
    ret
commandProc endp
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
    .elseif eax == WM_COMMAND
        invoke      commandProc, hWnd, uMsg, wParam, lParam
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