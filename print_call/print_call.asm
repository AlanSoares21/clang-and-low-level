section .data

newline_char: db 10
codes: db '0123456789abcdef'
input: dq 0x00

section .text
global _start

print_newline:
	mov rax, 1
	mov rdi, 1
	mov rsi, newline_char
	mov rdx, 1
	syscall
	ret

print_hex:
	mov rax, rdi
	mov rdi, 1
	mov rdx, 1
	mov rcx, 64
	iterate:
		push rax
		sub rcx, 4
		sar rax, cl
		and rax, 0xf
		lea rsi, [codes + rax]
		mov rax, 1
		push rcx
		syscall
		pop rcx
		pop rax
		test rcx, rcx
		jnz iterate
		ret
exit:
	mov rax, rdi
	xor rdi, rdi
	syscall
	ret

read_8_chars:
	mov rsi, rdi
	mov rdi, 0; descritor de stdin
	mov rdx, 8; quantos bytes ler
	mov rax, 0; chamada read
	syscall
	ret

_start:
	mov rdi, [input]
	call print_hex
	call print_newline
	mov rdi, input
	call read_8_chars
	mov rdi, [input]
	call print_hex
	call print_newline
	mov rdi, 60
	call exit
