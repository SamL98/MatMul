write:
	push rbp
	mov rbp, rsp

	; rdi - starting matrix address
	; rsi - number of rows
	; rdx - number of columns

	push rbx
	push r12
	push r13
	push r14
	push r15

	; move the parameters into callee-save registers since I don't feel like pushing and popping them for every procedure call
	mov rbx, rdi ; starting matrix address
	mov r14, rsi ; number of rows
	mov r15, rdx ; number of columns
	dec byte [r15]

	mov rdi, mat_write_stat
	call sprint 

	xor r12, r12
	
rowWriteLoop:
	xor r13, r13

	mov rdi, rbx
	mov rsi, r15
	mov rdx, r12
	inc byte [r15]
	call calcRowIndex	
	dec byte [r15]

colWriteLoop:
	mov rdi, rax
	push rax
	call fprint

	mov rdi, 0x20
	push rdi
	mov rdi, rsp
	call sprint
	pop rdi
	pop rax

	add rax, 8
	inc r13
	cmp r13b, byte [r15]
	jne colWriteLoop

	mov rdi, rax
	push rax
	call fprintln
	pop rax

	inc r12
	cmp r12b, byte [r14]
	jne rowWriteLoop	

writeFinish:
	pop r14
	pop r15
	pop r13
	pop r12
	pop rbx

	leave
	ret
