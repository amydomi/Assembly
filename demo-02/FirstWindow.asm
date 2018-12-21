;-------------------------------------
; 功能: 主窗口Demo
; 作者: 黄海
; 编写日期: 2018.12.01
;-------------------------------------

    .386
    .model flat, stdcall
    option casemap: none
    
    include windows.inc
    include gdi32.inc
    include user32.inc
    include kernel32.inc
    
    includelib gdi32.lib
    includelib user32.lib
    includelib kernel32.lib
    
    ; 数据段
    .data?
    hInstance       dd      ?
    hWndMain        dd      ?
    
    .const
    szClassName         db      'MyWindow', 0
    szCaptionName       db      'My First Window!', 0
    szText              db      'Win32 Assembly, Simple and powerful !', 0
    
    ;代码段
    .code
    
    _WindowProc proc    uses ebx edi esi, hWnd, uMsg, wParam, lParam
            local   @stPs:PAINTSTRUCT
            local   @stRect: RECT
            local   @hDc
            
            mov eax, uMsg
            
            .if     eax == WM_PAINT
                    invoke BeginPaint, hWnd, addr @stPs
                    mov @hDc, eax
                
                    invoke GetClientRect, hWnd, addr @stRect
                    invoke DrawText, @hDc, addr szText, -1, addr @stRect, DT_SINGLELINE or DT_CENTER or DT_VCENTER
                
                    invoke EndPaint, hWnd, addr @stPs
            .elseif eax == WM_CLOSE
                    invoke DestroyWindow, hWndMain
                    invoke PostQuitMessage, NULL
            .else
                    invoke DefWindowProc, hWnd, uMsg, wParam, lParam
                    ret
            .endif
            
            xor eax, eax
            ret
    _WindowProc endp
    
    _WinMain proc
            local   @stWndClass: WNDCLASSEX
            local   @stMsg: MSG
            
            invoke GetModuleHandle, NULL
            mov hInstance, eax
            
            invoke RtlZeroMemory, addr @stWndClass, sizeof @stWndClass
            
            ; 注册窗口类
            invoke  LoadCursor, 0, IDC_ARROW
            mov     @stWndClass.hCursor,eax
            push    hInstance
            pop     @stWndClass.hInstance
            mov     @stWndClass.cbSize, sizeof WNDCLASSEX
            mov     @stWndClass.style, CS_HREDRAW or CS_VREDRAW
            mov     @stWndClass.lpfnWndProc, offset _WindowProc
            mov     @stWndClass.hbrBackground, COLOR_WINDOW + 1
            mov     @stWndClass.lpszClassName, offset szClassName
            invoke  RegisterClassEx, addr @stWndClass
            
            invoke CreateWindowEx, WS_EX_CLIENTEDGE, offset szClassName, offset szCaptionName, \
                   WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, CW_USEDEFAULT, 800, 600, \
                   NULL, NULL, hInstance, NULL
            mov    hWndMain, eax
            
            invoke ShowWindow, hWndMain, SW_SHOW
            invoke UpdateWindow, hWndMain
            
            ; 消息循环
            .while TRUE
                    invoke GetMessage, addr @stMsg, NULL, 0, 0
                    .break .if eax == 0
                    invoke TranslateMessage, addr @stMsg
                    invoke DispatchMessage, addr @stMsg
            .endw
            ret
    _WinMain endp
    
    start:
        call _WinMain
        invoke ExitProcess, NULL
    end start