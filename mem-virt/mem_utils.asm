section .text

%define O_RDONLY 0x0
%define O_WRONLY 0x1
%define O_RDWR 0x2

; chamada open
; pega o fd
; pede para carregar na memoria o conteudo do arquivo

; rdi caminho para o arquivo
; return file descriptor
open_file:
    mov rsi, O_RDONLY
    xor rdx, rdx
    mov rax, 2
    syscall
    ret

;rdi file descriptor
close_file:
    mov rax, 3
    syscall
    ret

%define PROT_READ 0x1
%define PROT_WRITE 0x2
%define MAP_PRIVATE 0x2

;rdi file descriptor
load_file_in_mem:
    mov rax, 9
    mov r8, rdi
    xor rdi, rdi
    mov rsi, 4096
    mov rdx, PROT_READ | PROT_WRITE
    mov r10, MAP_PRIVATE
    xor r9, r9
    syscall
    ret


