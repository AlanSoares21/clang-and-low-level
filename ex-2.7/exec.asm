%include "lib.inc"

section .data
value: db 'abcdefghij', 0

section .text
global _start
_start:
	mov rdi, 9876
	call print_uint
	mov rdi, rax
	call exit
