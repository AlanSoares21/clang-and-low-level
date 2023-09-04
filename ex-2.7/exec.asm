%include "lib.inc"

section .data
value: db 'abcdef', 0

section .text
global _start
_start:
	mov rdi, value
	call print_string
	mov rdi, rax
	call exit
