#!/bin/bash
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
echo "removing old bin/ content"
rm bin/*
nasm -f elf64 -o bin/libtoinclude.o lib.inc
echo "lib compiled"
nasm -f elf64 -o bin/test.o test.asm
echo "test compiled"
ld -shared -o bin/libtoinclude.so bin/libtoinclude.o --dynamic-linker=/lib64/ld-linux-x86-64.so.2
echo "shared libtoinclude linked"
ld -o bin/main bin/test.o -d "bin/libtoinclude.so" --dynamic-linker=/lib64/ld-linux-x86-64.so.2
echo "main linked"

