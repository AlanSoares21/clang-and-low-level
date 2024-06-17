%include './colon.inc'
global _start

section	.data:
	colon "first str", first_str
	db "ola amigo", 0
	colon "second str", second_str
	db "estou sossegado", 0
	colon "third str", third_str
	db "serei o primeiro a chegar hoje", 0
	
	find_this: 
	db"second str", 0
	not_found_message:
	db "string nao encontrada", 0

extern print_string, exit, string_length

section .text
%include "dict.asm"

	_start:
		mov rdi, find_this
		mov rsi, third_str
		call find_word
		test rax, rax
		jz .not_found
		push rax
		mov rdi, find_this
		call string_length
		pop rdi
		lea rdi, [rax+9+rdi]
	.end:
		call print_string
		mov rdi, 0
		call exit
	.not_found:
		mov rdi, not_found_message
		jmp .end


