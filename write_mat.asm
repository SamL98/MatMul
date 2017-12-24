write:
	push rbp
	mov rbp, rsp

	; rdi - starting matrix address
	; rsi - number of rows
	; rdx - number of columns

	push rbx
	push rax ; for 16-byte alignment
	push r12
	push r13
	push r14
	push r15

	; move the parameters into callee-save registers since I don't feel like pushing and popping them for every procedure call
	mov rbx, rdi ; starting matrix address
	mov r14, rsi ; number of rows
	mov r15, rdx ; number of columns

	mov rdi, mat_write_stat
	call sprint 

	xor r12, r12
	
rowWriteLoop:
	xor r13, r13

colWriteLoop:
	mov rdi, rbx
	mov rsi, r15
	mov rdx, r12
	mov rcx, r13
	call calcIndex

	mov rdi, dbl_print_fmt
	movsd xmm0, qword [rax]
	mov rax, 1
	call _printf

	inc r13
	cmp r13b, byte [r15]
	jne colWriteLoop

	inc r12
	cmp r12b, byte [r14]
	jne rowWriteLoop	

writeFinish:
	pop r14
	pop r15
	pop r13
	pop r12
	pop rax
	pop rbx

	leave
	ret
