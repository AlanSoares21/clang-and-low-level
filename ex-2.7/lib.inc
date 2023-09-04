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
    ret

print_newline:
    xor rax, rax
    ret


print_uint:
    xor rax, rax
    ret


print_int:
    xor rax, rax
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


