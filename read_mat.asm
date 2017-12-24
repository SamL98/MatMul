read:
	push rbp
	mov rbp, rsp

	mov rdi, num_row_prompt
	call sprint

	mov rdi, scan_dim_fmt  		
	mov rsi, rows
	call _scanf

	mov rax, rows
	cmp byte [rax], 0
	je read_row_err

	cmp byte [rax], 3
	jg read_row_err 	

	mov rdi, num_col_prompt
	call sprint

	mov rdi, scan_dim_fmt
	mov rsi, cols
	call _scanf

	mov rax, cols
	cmp byte [rax], 0
	je read_col_err

	cmp byte [rax], 3
	jg read_col_err

	push r12
	push r13
	
	xor r12, r12

rowReadLoop:
	mov rdi, row_val_prompt
	call sprint	

	xor r13, r13

colReadLoop:
	mov rdi, dbl_scan_fmt

	xor rcx, rcx
	mov rax, cols
	mov cl, byte [rax] ; move the number of columns into rax
	shl rcx, 4 ; scale the number by sizeof(double)
	mov rax, r12 ; current row index to rax for mul
	mul ecx ; multiply by the row size
	mov rcx, row ; starting address of matrix into rcx
	add rax, rcx ; add offset to start

	mov rsi, r13 ; current col index into rsi
	shl rsi, 4 ; multiply index by 16 to scale by double size
	add rsi, rax ; add the address of the current row to the scaled index
	
	call _scanf

	inc r13
	mov rax, cols
	cmp byte [rax], r13b
	je contRowLoop
	
	jmp colReadLoop
	
contRowLoop:
	inc r12
	mov rax, rows
	cmp byte [rax], r12b
	jne rowReadLoop

	pop r13
	pop r12	

	jmp finish_read

read_row_err:
	mov rdi, inv_row_err
	call _printf
	jmp finish_read

read_col_err:
	mov rdi, inv_col_err
	call _printf

finish_read:
	leave
	ret
