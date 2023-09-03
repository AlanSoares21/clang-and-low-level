%include "lib.inc"

section .data
value: db 'abcdef', 0

section .text
global _start
_start:
	mov rdi, value
	call string_length
	mov rdi, rax
	call exit
