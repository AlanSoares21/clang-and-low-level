%include "lib.inc"

section .data
value: db 'abc', 0
numero: db 'abc', 0

section .text
global _start
_start:
	lea rdi, [numero]
	lea rsi, [value]
	call string_equals
	mov rdi, rax
	call print_uint
	call exit
