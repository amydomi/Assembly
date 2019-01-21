;-------------------------------------
; 功能: 主窗口Demo
; 作者: dusksoft
; 编写日期: 2019.01.21
;-------------------------------------
.386
.model flat,stdcall
option casemap:none

include windows.inc
include user32.inc
include kernel32.inc

includelib kernel32.lib
includelib user32.lib

.const
szClassName     db  'MyApp', 0
szWindowName    db  'My first window', 0
szMessageText   db  'Do you want to close the window?', 0
szmessageTitle  db  'Message', 0

.data?
hInstance   dd      ?

.code
; 窗口消息过程 (Windows主动调用)
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
WindowProc proc hWnd, msg, wParam, lParam
    mov     eax, msg
    .if eax == WM_CLOSE
        invoke  MessageBox, hWnd, offset szMessageText, offset szmessageTitle, MB_YESNO or MB_ICONQUESTION
        .if eax == IDYES
            invoke DestroyWindow, hWnd
        .endif
    .elseif  eax == WM_DESTROY
        invoke     PostQuitMessage, 0  
    .else
        invoke     DefWindowProc, hWnd, msg, wParam, lParam
        ret
    .endif
    xor eax, eax
    ret
WindowProc endp
; 入口
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
WinMain proc
    local @wndClass: WNDCLASSEX
    local @hWnd, @msg
    
    ; 获取当前模块(进程)句柄,
    ; C/C++是通过WinMain函数由系统传入，Win32汇编需要自己获取
    invoke      GetModuleHandle, NULL
    mov         hInstance,eax
    
    mov         @wndClass.cbSize, sizeof @wndClass
    mov         @wndClass.style, CS_HREDRAW or CS_VREDRAW
    mov         @wndClass.lpfnWndProc,offset WindowProc
    mov         @wndClass.cbClsExtra,0
    mov         @wndClass.cbWndExtra,0
    mov         eax,hInstance
    mov         @wndClass.hInstance, eax
    invoke      LoadIcon,hInstance,IDI_APPLICATION
    mov         @wndClass.hIcon, eax
    mov         @wndClass.hIconSm, eax
    invoke      LoadCursor, hInstance, IDC_ARROW
    mov         @wndClass.hCursor, eax
    mov         @wndClass.hbrBackground, COLOR_WINDOW
    mov         @wndClass.lpszMenuName, NULL
    mov         @wndClass.lpszClassName, offset szClassName
    
    invoke      RegisterClassEx,addr @wndClass
    
    invoke      CreateWindowEx, NULL, offset szClassName, offset szWindowName, WS_OVERLAPPEDWINDOW, \
                CW_USEDEFAULT, CW_USEDEFAULT, 1024, 768, NULL, NULL, hInstance, 0
    mov         @hWnd, eax 
    
    invoke      ShowWindow, @hWnd, SW_SHOW
    invoke      UpdateWindow, @hWnd
    
    .while TRUE
        invoke      GetMessage, addr @msg, NULL, 0, 0
        .break .if eax == 0
        invoke      TranslateMessage, addr @msg
        invoke      DispatchMessage, addr @msg
    .endw
    
    invoke      ExitProcess, 0
WinMain endp
end WinMain