section .text
;%include "../ex-2.7/lib.inc"
;%include "../mem-virt/mem_utils.asm"
%include "./utils.asm"
global _start

fib:
    mov rax, 1
    mov rdx, 1
    .loop:
        add rax, rdx
	mov rsi, rdx
	mov rdx, rax
	sub rdx, rsi
	cmp rax, rdi
	jb .loop
	je .true
    .false:
        mov rax, 1
        ret
    .true:
        xor rax, rax
        ret

_start:
    call read_input_file
    push rsi
    push rax
    mov rdi, rdx
    call fib 
    mov rdi, rax
    call print_uint
    pop rdi; removing input file page address
    pop rdi ; removing file descriptor
    call close_file
    mov rdi, 0
	call exit
