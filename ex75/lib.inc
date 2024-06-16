extern _GLOBAL_OFFSET_TABLE_

global exit:function, string_length:function, print_string:function, string_equals:function, parse_int:function, parse_uint:function, read_word:function, print_char:function, print_newline:function, print_uint:function, print_int:function, read_char:function, string_copy:function

section .text

exit:
    mov rax, 60
    syscall
    ret

string_length:
    xor rax, rax
    .loop:
        mov rsi, [rdi + rax]
	and rsi, 0xFF
   	cmp sil, 0
	je .end
	inc rax
	jmp .loop
    .end:
        ret

print_string:
    call string_length
    mov rdx, rax ; numero de bytes a escrever
    mov rsi, rdi ; enderoco da string
    mov rdi, 1 ; fd de std out
    mov rax, 1 ; numero da chamada de sistema
    syscall
    ret

print_char:
    xor rax, rax
    push rdi
    lea rsi, [rsp] ; endereco onde pegar a string para escrever
    mov rdx, 1 ; numero de bytes a escrever
    mov rdi, 1 ; fd de std out
    mov rax, 1 ; numero da chamada de sistema
    syscall
    pop rdi
    ret

print_newline:
    mov rdi, 10
    jmp print_char

print_uint:
    xor rcx, rcx
    push rbx
    xor rbx, rbx
    mov ax, 0
    push ax
    mov rsi, 0xA
    mov rax, rdi
    .loop:
    	    cmp rax, rsi
	    jbe .end
	    xor rdx, rdx
	    div rsi
	    add rdx, 0x30 ; selecionando caractere
	    sal rdx, 8
	    push dx ; colocando caractere e mais um bit na stack
	    inc rsp ; removendo ultimo caractere  
	    inc rcx
	    jmp .loop
    .end:
    add rax, 0x30
    sal rax, 8
    push ax
    inc rcx
    inc rsp
    ; show number
    lea rdi, [rsp]
    push rcx
    call print_string
    pop rcx
    add rsp, rcx ; restaurando rsp antes da funcao executar
    add rsp, 2
    pop rbx
    ret


print_int:
    mov rax, rdi
    mov rcx, 0x8000000000000000
    and rax, rcx
    test rax, rax
    je .print_u_int
    push rdi
    mov rdi, '-'
    call print_char
    pop rdi
    neg rdi
    .print_u_int:
        jmp print_uint

string_copy:
    push rbx
    xor rax, rax
    push rsi
    push rdx
    call string_length
    pop rdx
    pop rsi
    cmp rax, 0
    ; sem string para ser copiada
    jle .too_long
    cmp rax, rdx
    ja .too_long
    xor rcx, rcx
    .cp:
    	; pega o caractere da string original
	mov bl, [rdi + rcx]
	and rbx, 0xFF
	lea rdx, [rsi + rcx]
	mov [rdx], bl
	inc rcx
	cmp rcx, rax
	jbe .cp
	mov rax, rsi
	jmp .end
    .too_long:
    	mov rax, 0
    	mov [rsi], al
    .end:
    	pop rbx
	ret

read_char:
    push rsi
    lea rsi, [rsp]
    mov rdi, 0
    mov rax, 0
    mov rdx, 1
    syscall
    cmp rax, 1
    je .get_char
    pop rax
    mov rax, 0
    jmp .end
    .get_char:
    	pop rax
    	and rax, 0xFF
    .end:
	ret 

read_word:
    push r10
    push r11
    mov r10, rsi
    mov r11, rdi
    xor rcx, rcx
    .reading:
    	push rcx
	push r11
        call read_char
	pop r11
	pop rcx
        test rax, rax
        jz .finish
	cmp rax, 0x10
	je .finish
	cmp rax, 0x20
	je .finish
	cmp rax, 0x9
	je .finish
	lea rdi, [r11 + rcx]
	mov [rdi], al
	inc rcx
	cmp rcx, r10
	jb .reading
    .to_long:
    	pop r11
    	pop r10
	mov rax, 0
	ret
    .finish:
    	lea rdi, [r11 + rcx]
    	mov qword[rdi], 0
	mov rdx, rcx
	mov rax, r11
	pop r11
	pop r10
    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_uint:
    push rdi
    call string_length
    pop rdi
    mov rsi, rax
    push r11
    push rbx
    xor rax, rax
    mov r11, 10
    xor rcx, rcx
    .loop:
    	; se o contador e igual ao numero de caracteres na string 
    	cmp rcx, rsi 
	je .end
	; pegando caractere que sera avaliado
	mov bx, [rdi + rcx]
	and rbx, 0xFF
	; se caractere nao e um numero, pula para o final
	cmp bl, 0x30
	jb .not_a_number 
	cmp bl, 0x39
	ja .not_a_number 
	; convertendo characters em numeros
	sub rbx, 0x30
	mul r11
	add rax, rbx
	; atualizando base 10
        inc rcx
	jmp .loop
    .not_a_number:
    	; se rcx e zero
	test rcx, rcx
	jnz .end
	; incrementa rdi
	inc  rdi
	dec rsi
	; volta pro loop
	jmp .loop
    .end:
	mov rdx, rcx
	pop rbx
	pop r11
	ret

; rdi points to a string
; returns rax: number, rdx : length
parse_int:
    push rdi
    call string_length
    pop rdi
    xor rcx, rcx
    .find_start_number:
        lea rsi, [rdi + rcx]
	mov dx, [rsi]
	and rdx, 0xFF
	cmp rdx, 0x30
	jb .not_a_number
	cmp rdx, 0x39
	ja .not_a_number
	; achou o primeiro numero
	jmp .positive
    .not_a_number:
    	cmp rdx, '-'
	je .negative
	inc rdi
    	jmp .find_start_number
    .negative:
    	inc rdi
	call parse_uint
	push rdx
	xor rdx, rdx
	mov rsi, -1
	imul rsi 
	pop rdx
	inc rdx
	jmp .end
   .positive:
   	call parse_uint
    .end:
    	ret 

string_equals:
    push r10
    push r11
    ; tamanho da primeira string
    push rdi
    push rsi
    call string_length
    mov r10, rax
    ; tamanho da segunda string
    pop rdi
    call string_length
    mov r11, rax
    pop rsi
    ; se tamanho diferente, false
    cmp r11, r10
    jne .false
    xor rcx, rcx
    .loop:
    	; verificar se o rcx nao e maior que o tamanho da string
	cmp rcx, r10
	je .true
        mov ax, [rdi + rcx]
	mov dx, [rsi + rcx]
	and rax, 0xFF
	and rdx, 0xFF
	cmp ax, dx
	jne .false
	inc rcx
	jmp .loop
    .false:
    	mov rax, 0
	jmp .end
    .true:
    	mov rax, 1
	jmp .end
    .end:
	pop r11
	pop r10
	ret


