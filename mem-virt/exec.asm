section .data
fileName: db 'sample.txt', 0
print_message_filename: db 'escrevendo o seguinte arquivo em stdout', 10, 0

section .text

%include '../ex-2.7/lib.inc'
%include 'mem_utils.asm'

global _start
_start:
    mov rdi, print_message_filename
    call print_string
    mov rdi, fileName
    call print_string
    call print_newline

    mov rdi, fileName
    call open_file
    push rax
    mov rdi, rax
    call load_file_in_mem
    mov rdi, rax
    call print_string
    pop rdi
    call close_file

    mov rdi, 0
    call exit
