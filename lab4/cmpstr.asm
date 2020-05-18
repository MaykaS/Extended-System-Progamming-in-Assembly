section .text
	global cmpstr ;make my_cmp transparent to other modules
	
cmpstr:
	push ebp ;stack maintenance
	mov ebp, esp ;stack maintenance esp=stack pointer, ebp=maintenance of a frame of a diff func
	push ecx ;giboi
	push ebx ;giboi
	mov eax, -1

repeat:
    add eax, 1
    mov ebx, eax
    mov ecx, eax
    add ebx, [ebp+8]
    add ecx, [ebp+12]
	movzx ebx, BYTE [ebx] 
	movzx ecx, BYTE [ecx] 
	cmp ebx, ecx
	jg F_BIG ;jump if 1 bigger than 2
	jl S_BIG ;jump if 2 bigger than 1
	test bl,bl ;check if not null
	je NONE_BIG ;then equal
    jmp repeat ;jump back

    
F_BIG:
	mov eax, 1 ;return value need to be stored in eax register
	jmp FINISH
	
S_BIG:
	mov eax, 2 ;return value need to be stored in eax register
	jmp FINISH

NONE_BIG:
    mov eax, 0 ;return value need to be stored in eax register
    jmp FINISH

FINISH:
    pop ebx
    pop ecx
	mov esp, ebp ;stack maintenance
	pop ebp ;stack maintenance
	ret ;stack maintenance
