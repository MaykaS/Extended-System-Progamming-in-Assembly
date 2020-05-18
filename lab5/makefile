all: rw

rw: rw.o
	ld -melf_i386 -o rw rw.o -lc -I/lib/ld-linux.so.2

rw.o: rw.asm
	nasm -g -f elf -w+all -o rw.o rw.asm

.PHONY: clean
clean:
	rm -f *.o rw
