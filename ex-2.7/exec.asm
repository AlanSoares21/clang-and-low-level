%include "lib.inc"

section .data
value: db 'abc', 0
value2: times 10 db 66, 0
numero: db 'abc', 0

section .text
global _start
_start:
	lea rdi, [value]
	lea rsi, [value2]
	mov rdx, 3 
	call string_copy
	mov rdi, rax
	call print_uint
	lea rdi, [value2]
	call print_string
	call exit
