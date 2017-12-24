read:
	push rbp
	mov rbp, rsp

	push rbx
	push rax ; push rax just so the stack is 16-byte aligned

	mov rbx, rdx ; mat address is in rbx
	mov r14, rdi ; row address is in r14
	mov r15, rsi ; col address is in r15

	mov rdi, num_row_prompt
	call sprint

	mov rdi, scan_dim_fmt  		
	mov rsi, r14
	call _scanf

	cmp byte [r14], 0
	je read_row_err

	cmp byte [r14], 3
	jg read_row_err 	

	mov rdi, num_col_prompt
	call sprint

	mov rdi, scan_dim_fmt
	mov rsi, r15
	call _scanf

	cmp byte [r15], 0
	je read_col_err

	cmp byte [r15], 3
	jg read_col_err

	push r12
	push r13
	
	xor r12, r12

rowReadLoop:
	mov rdi, row_val_prompt
	call sprint	

	xor r13, r13

colReadLoop:
	mov rdi, rbx
	mov rsi, r15
	mov rdx, r12
	mov rcx, r13
	call calcIndex

	mov rdi, dbl_scan_fmt
	mov rsi, rax	
	call _scanf

	inc r13
	cmp byte [r15], r13b
	je contRowLoop
	
	jmp colReadLoop
	
contRowLoop:
	inc r12
	cmp byte [r14], r12b
	jne rowReadLoop

	pop r13
	pop r12	

	jmp finish_read

read_row_err:
	mov rdi, inv_row_err
	call sprint
	jmp finish_read

read_col_err:
	mov rdi, inv_col_err
	call sprint

finish_read:
	pop rax
	pop rbx

	leave
	ret
