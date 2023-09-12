section .data
keys: db '0123456789'

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
    mov ax, 10
    push ax
    lea rsi, [rsp]
    mov rdx, 1
    mov rdi, 1
    mov rax, 1
    syscall
    pop ax ; tirando o byte com o caractere de pular linha da pilha
    ret

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
	    mov bh, [rdx + keys] ; selecionando caractere
	    push bx ; colocando caractere e mais um bit na stack
	    inc rsp ; removendo ultimo caractere  
	    inc rcx
	    jmp .loop
    .end:
    mov bh, [rax + keys]
    push bx
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
    imul rdi, -1
    ; and rdi, 0x7FFFFFF
    .print_u_int:
    	call print_uint
    	ret

string_equals:
    xor rax, rax
    ret


read_char:
    xor rax, rax
    ret 

read_word:
    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_uint:
    xor rax, rax
    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_int:
    xor rax, rax
    ret 


string_copy:
    ret


