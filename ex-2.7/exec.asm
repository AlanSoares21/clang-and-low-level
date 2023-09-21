%include "lib.inc"

section .data
value: db 'abcdefghij', 0

section .text
global _start
_start:
	lea rdi, [value]
	mov rsi, 10
	call read_word
	test rax, rax
	jz .return_error
	mov rdi, rax
	call print_string
	call exit
	.return_error:
		mov rdi, 1
		call exit
