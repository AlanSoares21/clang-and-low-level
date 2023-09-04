%include "lib.inc"

section .data
value: db 'abcdefghij', 0

section .text
global _start
_start:
	mov rdi, [value]
	call print_char
	mov rdi, rax
	call exit
