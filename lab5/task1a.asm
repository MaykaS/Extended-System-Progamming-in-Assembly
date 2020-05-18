section .text

global _start
global read
global write
global open
global close
global strlen

extern main
_start:

    pop dword eax ;argc to eax
    mov ebx, esp ;argv to ebx
    push ebx 
    push eax 

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
