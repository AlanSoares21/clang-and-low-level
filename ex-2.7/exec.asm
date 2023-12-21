%include "lib.inc"

section .data
value: db 'abc', 0
value2: times 10 db 66, 0
numero: db 'abc', 0

section .text
global _start
_start:
	mov ax, 0xFF
	neg ax
	neg ax
	mov rax, 0x01
	neg rax
	lea rdi, [value]
	call print_string
	call print_newline
	call exit
