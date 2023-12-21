section .data
inputFileName: db 'input.txt', 0
section .text
%include "../ex-2.7/lib.inc"
%include "../mem-virt/mem_utils.asm"
global _start

fatorial:
	mov rax, 1
; rdi = number
; rax = previous multi
fatorial_aux:
	mul rdi
	dec rdi
	cmp rdi, 1
	ja fatorial_aux
	ret

_start:
	mov rdi, inputFileName
	call open_file
	push rax
	mov rdi, rax
	call load_file_in_mem
	push rax
	mov rdi, rax
	; push rdi
	; call print_string
	; pop rdi
	call parse_uint
	mov rdi, rax
	call fatorial
	mov rdi, rax
	call print_uint
	pop rdi ; removing input file page address
	pop rdi ; removing file descriptor
	call close_file
	mov rdi, 0
	call exit
