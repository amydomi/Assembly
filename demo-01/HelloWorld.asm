;-------------------------------------
; 功能: 我的第一个Win32的汇编程序
; 作者: 黄海
; 编写日期: 2018.11.27
;-------------------------------------

    .386
    .model flat,stdcall
    option casemap:none

include         windows.inc
include         kernel32.inc
include         user32.inc

includelib      user32.lib
includelib      kernel32.lib

;数据段
    .data
szText      db      'Hello assembly', 0
szTitle     db      'Message', 0

;代码段
    .code
_main proc 
    invoke MessageBox, NULL, offset szText, offset szTitle, MB_OK or MB_ICONINFORMATION
    invoke ExitProcess, NULL
_main endp
start:
    invoke _main
end start
ends