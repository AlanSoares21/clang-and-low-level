global _start

extern exit, print_int, print_newline

section .text
_start:
	mov rdi, -32 
	call print_int
	call print_newline
	mov rdi, 1
	call exit

