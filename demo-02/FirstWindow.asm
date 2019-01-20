;-------------------------------------
; 功能: 主窗口Demo
; 作者: dusksoft
; 编写日期: 2019.01.20
;-------------------------------------
.386
.model flat,stdcall
option casemap:none

include windows.inc
include user32.inc
include kernel32.inc

includelib user32.lib
includelib kernel32.lib

.const
szClassName     db      'MyWindow',0
szWindowName    db      'My Window',0

.data?
hInstance   dd              ?

.code
; 窗口消息过程
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_wndProc proc _hWnd, _uMsg, _wParam, _lParam
    mov     eax, _uMsg
    
    .if eax == WM_CLOSE
        invoke PostQuitMessage, 0
        invoke DestroyWindow, _hWnd
    .else
        invoke  DefWindowProc, _hWnd, _uMsg, _wParam, _lParam
        ret
    .endif

    xor eax, eax
    ret
_wndProc endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_winMain proc
    local   @wndClass: WNDCLASSEX
    local   @msg: MSG
    local   @hWnd
    
    ; 获取当前模块(进程)句柄,
    ; C/C++是通过WinMain函数由系统传入，Win32汇编需要自己获取
    invoke  GetModuleHandle,NULL
    mov     hInstance, eax
    
    ; 注册窗口类
    mov     @wndClass.cbSize, sizeof @wndClass
    mov     @wndClass.style, CS_HREDRAW or CS_VREDRAW
    mov     @wndClass.lpfnWndProc, offset _wndProc
    mov     @wndClass.cbClsExtra,0
    mov     @wndClass.cbWndExtra,0
    mov     eax, hInstance
    mov     @wndClass.hInstance, eax
    invoke  LoadIcon, hInstance, IDI_APPLICATION
    mov     @wndClass.hIcon, eax
    mov     @wndClass.hIconSm, eax
    invoke  LoadCursor, hInstance,IDC_ARROW
    mov     @wndClass.hCursor, eax
    mov     @wndClass.hbrBackground,COLOR_WINDOW
    mov     @wndClass.lpszMenuName, NULL
    mov     @wndClass.lpszClassName,offset szClassName
    
    invoke  RegisterClassEx, addr @wndClass
    
    ; 创建窗口
    invoke  CreateWindowEx, WS_EX_APPWINDOW, offset szClassName, offset szWindowName, WS_OVERLAPPEDWINDOW,\
            CW_USEDEFAULT, CW_USEDEFAULT, 800, 600, NULL, NULL, hInstance, NULL
    mov     @hWnd,eax
    
    ; 显示 - 更新窗口
    invoke  ShowWindow, @hWnd, SW_SHOW
    invoke  UpdateWindow, @hWnd
    
    ; 消息循环
    .while TRUE
         invoke     GetMessage, addr @msg, NULL, 0, 0
         .break .if eax == 0
         invoke     TranslateMessage, addr @msg
         invoke     DispatchMessage, addr @msg
    .endw
    
    invoke  ExitProcess,NULL
_winMain endp
end _winMain