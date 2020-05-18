section .text
	global funcA
	
funcA:
	push	ebp
	mov	ebp, esp
	push ebx
	mov	eax,-1

.L2:
	add eax, 1
	mov ebx, eax
	add ebx, [ebp+8]
	movzx	ebx, BYTE [ebx]
	test bl,bl
	jne .L2
	pop ebx
	mov esp, ebp
	pop ebp
	ret
	
	
	
	; 1 parameter
	; return string.len
	; 0 variables 
	; string.len in c
	
