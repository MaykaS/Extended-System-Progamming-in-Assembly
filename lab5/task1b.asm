section .bss
    output resb 16

section .text

global _start
global read
global write
global open
global close
global strlen
global uota_s

extern main
_start:

    pop eax ;argc to eax
    mov ebx, esp ;argv to ebx
    push ebx ;giboi
    push eax ;giboi

    call main
    mov ebx,eax
    mov eax,1
    int 0x80

read:
    push ebp ;giboi
    mov ebp, esp
    push ebx ;giboi
    push ecx ;giboi
    push edx ; data register ;giboi
    
    mov eax, 3 ;sys_read
    mov ebx, [ebp+8] ;descipitor
    mov ecx, [ebp+12] ;pointer to buff
    mov edx, [ebp+16] ;buffer size
    int 80h ; sys_call

    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
    
write:
    push ebp ;giboi
    mov ebp, esp
    push ebx ;giboi
    push ecx ;giboi
    push edx ; data register ;giboi
    
    mov eax, 4 ;sys_write
    mov ebx, [ebp+8] ;descipitor
    mov ecx, [ebp+12] ;pointer to buff
    mov edx, [ebp+16] ;buffer size
    int 80h ; sys_call

    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret

open:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx ; data register
    
    mov eax, 5 ;sys_open
    mov ebx, [ebp+8] ;descipitor
    mov ecx, [ebp+12] ;pointer to buff
    mov edx, [ebp+16] ;buffer size
    int 80h ; sys_call

    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret

close:
    push ebp ;giboi
    mov ebp, esp
    push ebx ;giboi
    push ecx ;giboi
    push edx ; data register ;giboi
    
    mov eax, 6 ;sys_close
    mov ebx, [ebp+8] ;descipitor
    mov ecx, [ebp+12] ;pointer to buff
    mov edx, [ebp+16] ;buffer size
    int 80h ; sys_call

    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret

uota_s:
    push ebp ;giboi
    mov ebp, esp
    push ebx ;giboi
    push ecx ;giboi
    push edx ; data register ;giboi

    xor eax, eax ;reset eax, 0
    xor ebx, ebx ;reset ebx, 0
    mov eax, [ebp+8] ;int to eax
    mov ebx, 10 ;ebx divisor by 10
    mov ecx, 0 ;counter for the dividers
    
divide:
    xor edx, edx ;reset edx
    div ebx ;edx = reminder, eax = num
    add edx, '0' ;make edx a char
    push edx
    inc ecx
    test eax, eax 
    jne divide ;if eax still not 0 
    xor ebx, ebx ;reset ebx
    xor edx, edx ;reset edx
    
char:
    add ebx, output ;ebx points to start of output
    pop eax ; char to eax
    mov [ebx], eax ;char value to output
    inc edx ;next char
    mov ebx, edx ;next char in output
    loop char ;until ecx = 0
    
    pop edx
    pop ecx
    pop ebx
    mov eax, output ;eax=output
    mov esp, ebp
    pop ebp
    ret
    

strlen: ;lab 4 - task 1
    push ebp ;giboi
    mov ebp, esp
    push ebx ;giboi
    mov eax,-1

.L2:
    add eax, 1
    mov ebx, eax
    add ebx, [ebp+8]
    movzx ebx, BYTE [ebx]
    test bl,bl
    jne .L2
    pop ebx
    mov esp, ebp
    pop ebp
    ret
