global _start
section .data
%ifdef flag
hellostring: db "Hello",0
%endif

section .text
_start:
	
