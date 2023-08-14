global _start

section .data
message: db 'hello, world!', 10

section .text
_start:
	mov rax, 1 ; numero da chamda de sistema
	mov rdi, 1 ; descritor do arquivo onde sera escrito os bytes
	mov rsi, message ; endereço onde começa a string
	mov rdx, 14 ; quantos bytes escrever
	syscall ; chamada de sistema

