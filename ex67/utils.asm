section .data
    inputFileName: db 'input.txt', 0

section .text
%include "../ex-2.7/lib.inc"
%include "../mem-virt/mem_utils.asm"
; ret -> rax = endereco da pagina na memoria
;   -> rsi = file descriptor
;   -> rdx = uint
read_input_file:
    mov rdi, inputFileName
	call open_file
	push rax
	mov rdi, rax
	call load_file_in_mem
    push rax
    mov rdi, rax
    call parse_uint
	mov rdx, rax
    pop rax
	pop rsi
    ret