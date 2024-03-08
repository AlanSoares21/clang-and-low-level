section .text
;%include "../ex-2.7/lib.inc"
;%include "../mem-virt/mem_utils.asm"
%include "./utils.asm"
global _start

; rdi -> number
is_prime:
	mov rbx, rdi
	; divide o numero por dois
	sar rdi, 1
is_prime_aux:
    cmp rdi, 1
    jbe is_prime_aux.prime
    ; verifica se o numero atual pode ser dividido
    mov rax, rbx
    xor rdx, rdx
    div rdi
    test rdx, rdx
    je is_prime_aux.not_prime
    dec rdi
    jmp is_prime_aux
    .prime:
        mov rax, 0
        ret
    .not_prime:
        mov rax, 1
        ret

_start:
	call read_input_file
    push rsi
    push rax
    mov rdi, rdx
    call is_prime
    mov rdi, rax
    call print_uint
    pop rdi; removing input file page address
    pop rdi ; removing file descriptor
    call close_file
    mov rdi, 0
	call exit
