%assign limit 64

section .data
is_prime: 
%assign primos 0
%assign start 2
%rep limit-start
	%assign current start/2 
	%assign isPrime 1
	%rep start
		%if current <= 1
			%exitrep
		%elif start % current = 0
			%assign isPrime 0
			%exitrep
		%endif
		%assign current current-1
	%endrep
	%if isPrime = 1
		%assign pow2 1
		%rep start
			%assign pow2 pow2*2
		%endrep
		%assign primos primos+pow2
	%endif
	%assign start start+1
%endrep
dq primos
	
section .text
global _start

check_primes:
	mov rax, rdi
	xor rdx, rdx
	mov rdi, 8
	div rdi
	mov rdi, [is_prime + rax]
	mov rcx, rdx
	sar rdi, cl
	and rdi, 0x1
	mov rax, rdi
	ret
	; div rdi / 8
	; resultado usa para pegar byte em is_prime
	; sar sobra
	; and 1
	; retorne o resultado, 0 nao primo 1 primo
	
%include '../../ex-2.7/lib.inc'

_start:
	mov rdi, 17
	call check_primes
	mov rdi, rax
	call exit
