;Data section
section .data
    msg: db "maya", 0 ;my name
    len: equ $ - msg ; length of my name , $=were i am right now

section .bss
    ans: resb len ; my respons

section .revers
    printFormat db 'reverse string is: %s' ,10,0 ;what i print 

section .text
    global _start
    extern printf ;to be able to print
    
_start:
    mov eax, ans ; eax points to start of output
	mov ebx, msg+len-2 ;-2 because ther are two zero's , points to end os maya
	mov ecx, len-1 ;ecx is a counter

_loop:
    mov dl, [ebx] ;mov to dl (data) the last byte of maya
    mov [eax], dl ;mov to output the dl
    inc eax ;point to next
    dec ebx ;point to prev
    dec ecx 
    jnz _loop ;if counter != 0 do loop again
    
_PRINT:
    push dword ans ; push to stack
    push printFormat ;to be able to print
    call printf ;print
    
_FINISH:
    mov ebx, 0
    mov ecx, 0
    mov eax, 1 ;the exit
    int 80h ;call kernel interrupt 80
    
    
    
