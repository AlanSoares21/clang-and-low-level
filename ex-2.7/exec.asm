%include "lib.inc"

section .data
value: db 'abcdefghij', 0
numero: db '1234567890', 0

section .text
global _start
_start:
	lea rdi, [numero]
	call parse_uint
	mov rdi, rax
	call print_uint
	call exit
