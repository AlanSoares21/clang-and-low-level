extern string_equals
section .text
	; rdi: string terminada em nulo, key do registro do dicionario
	; rsi: ponteiro para ultima entrada? do dicionario
	find_word:
		push rsi
		lea rsi, [rsi+8] ; dict key adress
		push rdi
		call string_equals
		pop rdi
		pop rsi
		cmp rax, 1
		je .um
		mov rsi, [rsi] ; address to the next dict entry
		test rsi, rsi
		jnz find_word
		ret
	.um:
		mov rax, rsi
		ret
	

