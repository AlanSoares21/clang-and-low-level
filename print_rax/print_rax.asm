section .data
codes: db '0123456789ABCDEF'

section .text
global _start
_start:
	mov rax, 0101 
	
	mov rdi, 1 ; chamada write deve escrever no arquivo
	
	mov rdx, 1
	mov rcx, 64

.loop:
	push rax
	sub rcx, 4
	
	; shift at rigth o numero em rax, quantidade de vezes indicada pelos ultimos 4 bits de rcx(cl)
	sar rax, cl
	
	; zera os 1 que ficaram depois dos 4 primeiros bits de rax
	and rax, 0xf

	; chamada write, rsi recebe o endereco da string que sera escrita, rax chamada de sistema write
	lea rsi, [codes + rax]
	mov rax, 1

	push rcx ; preservando rcx, por que write altera seu valor
	syscall
	pop rcx

	pop rax ; recupera o valor original de rax

	; se rcx diferente de 0, ele faz o loop denovo
	test rcx, rcx
	jnz .loop

; encerra o programa
mov rax, 60
xor rdi, rdi
syscall
