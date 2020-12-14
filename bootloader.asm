[org 0x7c00]
_main:	;_main label

mov si, STR
call f_print

jmp $	;infinite loop

jmp _EOF	;skip function declarations

f_print:
  pusha
  sub_print_str_loop:
    mov al, [si]
    cmp al, 0
    jne sub_print_print_char
    popa
    ret
  sub_print_print_char:
    mov ah, 0x0e
    int 0x10
    add si, 1
    jmp sub_print_str_loop

f_rdisk:
  pusha
  mov ah, 0x02
  mov dl, 0x80
  mov ch, 0
  mov dh, 0
  mov al, 1
  mov cl, 2
  push bx
  mov bx, 0
  mov es, bx
  pop bx
  mov bx, 0x7c00 + 512
  jc sub_rdisk_error
  popa
  ret
  sub_rdisk_error:
    mov si, ERR
    call f_print
    jmp $

STR: db "Hello World!", 0
ERR: db "Error was encountered!", 0

_EOF:	;EOF for skipping functions
times 510-($-$$) db 0
dw 0xaa55
