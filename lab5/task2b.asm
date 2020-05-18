section .data
   bufsize dw 50
   msg: db "system call failed",10,0 ;if failed
   len: equ $ - msg
   numOfWords: dd 0

section .bss
   buf resb 50
   output resb 16
    
section .text
    global _start
    global read
    global write
    global open
    global _open
    global close
    global strlen
    global uota_s

_start:
    pop eax ;argc to eax
    pop ebx; argv[0]
    pop ebx; argv[1]
    cmp eax, 3
    je _open
    mov eax, ebx
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

    cmp eax, 0 ;error
    jl _error

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

    ;cmp eax, 0 ;error
    ;jl _error

    
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
    
;;;;;;;;;;2b;;;;;;;;;
_open:
    pop ebx ;argv[2] filename
    mov eax, ebx
    push eax ;the file
    call open

    mov ecx, eax
    
_toRead:
    push bufsize
    push buf 
    push ecx ;discipitor
    call read ;sys_call

    cmp eax, 0
    je _toPrint
    
    mov ebx, 0 ;becomes my poinetr
    
_count_words: ;;check again!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    dec eax
    mov edx, buf
    add edx, ebx
    inc ebx
    cmp byte [edx], ' '
    je _check_next
    cmp byte [edx], 9
    je _check_next
    cmp byte [edx], 10
    je _check_next
    inc byte [numOfWords]
    jmp _not_increase
    
_check_next:
    cmp eax, 1
    jl _toRead
    cmp byte [edx+1], ' '
    je _not_increase
    cmp byte [edx+1],9
    je _not_increase
    cmp byte [edx+1],10
    je _not_increase
    inc byte [numOfWords]
    jmp _count_words
    

_not_increase:
    cmp eax, 0
    je _toRead
    jmp _count_words
    
    jmp _toRead
    
_toPrint:
    mov eax, [numOfWords] 
    push eax
    call uota_s
    
    mov ebx, eax
    push ebx
    call strlen
    
    push eax
    push ebx
    push 1
    call write
    
    push ecx
    
    call close
    
    mov ebx, eax
    mov eax,1
    int 80h


;;;;;;;;;;;;2b;;;;;;;;;;;;;;
    
uota_s:
    push ebp ;giboi
    mov ebp, esp
    push ebx ;giboi
    push ecx ;giboi
    push edx ; data register ;giboi

    xor eax, eax ;reset eax
    xor ebx, ebx ;reset ebx
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
    pop eax ; char to eax (?)
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
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;??????????
_error:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len
    int 80h
    mov eax,1
    int 80h
    
    
