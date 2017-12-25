slen:
	push rbp
	mov rbp, rsp

	push rbx
	mov rax, rdi
	mov rbx, rdi

nextchar:
	cmp byte [rax], 0
	jz finished
	inc rax
	jmp nextchar

finished:
	sub rax, rbx
	
	pop rbx
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

fprint:
	push rbp
	mov rbp, rsp
	; rdi - the address of the float to print
	movsd xmm0, qword [rdi]
	mov rdi, dbl_print_fmt
    mov rax, 1
    call _printf	

	leave
	ret

fprintln:
	push rbp
	mov rbp, rsp
	; rdi - the address of the float to print
	call fprint
	
	mov rdi, 10
	push rdi
	mov rdi, rsp
	call sprint
	pop rdi

	leave
	ret

calcRowIndex:
	push rbp
	mov rbp, rsp

	; rdi - starting address of the matrix
	; rsi - number of columns in the matrix
	; rdx - current row index

	xor r10, r10
    mov r10b, byte [rsi] ; move the number of columns into rax
    shl r10, 3 ; scale the number by sizeof(double)
    mov rax, rdx ; current row index to rax for mul
    mul r10 ; multiply by the row size
    add rax, rdi ; add offset to start
  
	leave
	ret

quit:
	mov rdi, 0
	mov rax, 0x2000001
	syscall
	ret
