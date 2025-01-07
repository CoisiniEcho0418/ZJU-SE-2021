section.text
    global _start

_start:
    mov al, '3'
    add al, '4'
    aaa

    ; 系统调用退出程序
    mov eax, 1
    xor ebx, ebx
    int 0x80