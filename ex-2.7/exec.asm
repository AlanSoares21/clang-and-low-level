%include "lib.inc"

section .data
value: db 'abcdefghij', 0

section .text
global _start
_start:
	mov rdi, -12345234121
	call print_int
	mov rdi, rax
	call exit
