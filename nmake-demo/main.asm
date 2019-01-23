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
szText      db     '�Ƿ�رմ��ڣ�', 0
szTitle     db      '��Ϣ', 0
szBtnText1  db      '�����˵�һ����ť��', 0
szBtnText2  db      '�����˵ڶ�����ť��', 0

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
; ��Ϣ����
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