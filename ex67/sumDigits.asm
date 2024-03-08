section .text
;%include "../ex-2.7/lib.inc"
;%include "../mem-virt/mem_utils.asm"
%include "./utils.asm"
global _start

sumDig:
    push rdi
    call string_length
    pop rdi
    mov rbx, rax ; length of the string
    dec rbx
    xor rax, rax ; sum of the digits
    xor rcx, rcx
    .loop:
    	cmp rcx, rbx
	jae .end
        mov dl, [rdi + rcx] ; get the digit
	and rdx, 0xFF
        sub rdx, 0x30 ; get the number
	add rax, rdx ; sum digits
        inc rcx
        jmp .loop
    .end:
        ret


_start:
    call read_input_file
    push rsi
    push rax
    mov rdi, rax
    call sumDig 
    mov rdi, rax
    call print_uint
    pop rdi; removing input file page address
    pop rdi ; removing file descriptor
    call close_file
    mov rdi, 0
	call exit
