slen:
	push rbp
	mov rbp, rsp

	mov rax, rdi
	mov rbx, rdi

nextchar:
	cmp byte [rax], 0
	jz finished
	inc rax
	jmp nextchar

finished:
	sub rax, rbx
	
	leave
	ret

sprint:
	push rbp
	mov rbp, rsp

	call slen

	mov rdx, rax
	mov rsi, rdi
	mov rdi, 1
	mov rax, 0x2000004
	syscall

	leave
	ret

sprintln:
	push rbp
	mov rbp, rsp
	call sprint

	mov rdi, 10
	push rdi
	mov rdi, rsp
	call sprint
	pop rdi
	
	leave
	ret

iprint:
	push rbp
	mov rbp, rsp
	
	cmp rdi, 10
	jge multDigPrint

singleDigPrint:
	add rdi, 48
	push rdi
	mov rdi, rsp
	call sprint
	pop rdi
	jmp finishIPrint

multDigPrint:
	mov rdx, 0
	mov rax, rdi
	mov rcx, 10
	idiv rcx

	mov rdi, rax
	push rdx
	call iprint
	pop rdx

	mov rdi, rdx
	call iprint	

finishIPrint:
	leave
	ret	

iprintln:
	push rbp
	mov rbp, rsp

	call iprint

	mov rdi, 10
	push rdi
	mov rdi, rsp
	call sprint
	pop rdi
	
	leave
	ret

quit:
	mov rdi, 0
	mov rax, 0x2000001
	syscall
	ret
