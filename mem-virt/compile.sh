#!/bin/bash
nasm -f elf64 -o bin/exec.o exec.asm 
ld -o bin/exec bin/*.o

