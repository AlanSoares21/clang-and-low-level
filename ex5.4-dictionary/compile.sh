#!/bin/bash
echo "limpando bin"
rm -rf ./bin/*
echo "compilando lib"
nasm -f elf64 -o bin/lib.o ../ex75/lib.inc
echo "lib compiled"

echo "compilando dict"
nasm -f elf64 -o bin/dict.o dict.asm
echo "dict compiled"

echo "compilando test"
nasm -f elf64 -o bin/test.o test.asm
echo "test compilado"

echo "linkando lib"
ld -shared -o bin/lib.so --dynamic-linker=/lib64/ld-linux-x86-64.so.2 bin/lib.o
echo "fim ligacao lib"

#echo "linkando dict"
#ld -o bin/dict.o --dynamic-linker=/lib64/ld-linux-x86-64.so.2 bin/dict.o -d bin/lib.so
#echo "fim ligacao dict"

echo "linkando test"
ld -o bin/main --dynamic-linker=/lib64/ld-linux-x86-64.so.2 bin/test.o -d bin/lib.so 
echo "fim ligacao test"

