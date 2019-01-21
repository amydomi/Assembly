;-------------------------------------
; 功能: 简单的菜单示例
; 作者: dusksoft
; 编写日期: 2019.01.21
;
; compile:
; ml /c /coff main.asm
;
; rc:
; rc main.rc
;
; link
; link /subsystem:windows main.obj main.res
;-------------------------------------
.386
.model flat,stdcall
option casemap:none

include windows.inc
include user32.inc
include kernel32.inc

includelib kernel32.lib
includelib user32.lib

; 导入资源ID
include resource.inc

.const
szClassName     db  'MyApp', 0
szWindowName    db  'My first window', 0
szMessageText   db  'Do you want to close the window?', 0
szmessageTitle  db  'Message', 0
szOpenText      db  'Click the Open Menu', 0
szExitText      db  'Click the Exit Menu', 0

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
    .elseif eax == WM_COMMAND
    
        ; 响应菜单点击
        mov  eax, wParam
        movzx  eax, ax      ; 取低16位做判断
        .if  eax == ID_MENU_OPEN
            invoke  MessageBox, hWnd, offset szOpenText, offset szmessageTitle, MB_OK or MB_ICONINFORMATION
        .elseif eax == ID_MENU_EXIT
            invoke  MessageBox, hWnd, offset szExitText, offset szmessageTitle, MB_OK or MB_ICONINFORMATION
        .endif
        
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
    local @hMenu
    
    ; 获取当前模块(进程)句柄
    invoke      GetModuleHandle, NULL
    mov         hInstance,eax
    
    ; 加载菜单资源
    ; MENU_MAIN : 菜单资源ID
    invoke      LoadMenu, hInstance, MENU_MAIN
    mov         @hMenu, eax
    
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

; 在这指定菜单只要指定资源ID即可
;   mov        @wndClass.lpszMenuName, MENU_MAIN

;    mov         @wndClass.lpszMenuName, NULL              
    mov         @wndClass.lpszClassName, offset szClassName
    
    invoke      RegisterClassEx,addr @wndClass
    
    ; @hMenu 传入菜单句柄, 需要用LoadMenu载入菜单资源
    invoke      CreateWindowEx, NULL, offset szClassName, offset szWindowName, WS_OVERLAPPEDWINDOW, \
                CW_USEDEFAULT, CW_USEDEFAULT, 1024, 768, NULL, @hMenu, hInstance, 0
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