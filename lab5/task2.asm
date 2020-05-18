section .data
   bufsize dw 50

section .bss
   buf resb 50
    
section .text
    global _start
    global read
    global write
    global open
    global close

_start:
    pop eax ;argc to eax
    pop eax; argv[0]
    pop eax; argv[1]
    push eax ;the file
    call open ; sys_call

toRead:
    push bufsize
    push buf 
    push eax ;discipitor
    call read ;sys_call
    
    cmp eax, 0 ;if i have to print
    jg toPrint
    call close ;sys_call
    
    mov ebx, eax
    mov eax, 1 ;stdout
    int 80h
    
toPrint:
    push bufsize
    push buf
    push 1 ;write
    call write ;sys_call
    call toRead
    
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
    
    
    
    
