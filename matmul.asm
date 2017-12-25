%include 'utility.asm'
%include 'read_mat.asm'
%include 'write_mat.asm'

extern _printf
extern _scanf
extern _exit

section .text
global _main

_main:
	push rbp
	mov rbp, rsp

	;movupd xmm0, oword [rel r1]
	;movupd xmm1, oword [rel r2]
	;mulpd xmm0, xmm1

	;movupd xmm1, xmm0
	;unpckhpd xmm1, xmm1

	;xor rax, rax
	;mov al, 2
	;mov rdi, print_fmt
	;call _printf

	mov rdi, rows1
	mov rsi, cols1
	mov rdx, mat1
	call read

	mov rdi, rows2
	mov rsi, cols2
	mov rdx, mat2
	call read

	mov rdi, mat1
	mov rsi, rows1
	mov rdx, cols1
	call write
	
	call _exit
	leave
	ret

section .bss
rows1: resd 1
cols1: resd 1
mat1: resq 9

rows2: resd 1
cols2: resd 1
mat2: resq 9

section .data
num_row_prompt: db "Enter the number of rows: ", 0
num_col_prompt: db "Enter the number of columns: ", 0
row_val_prompt: db "Enter the next row (separated by newline): ", 10, 0
mat_write_stat: db "Elements:", 10, 0

inv_row_err: db "Invalid number of rows (must be 1-3).", 10, 0
inv_col_err: db "Invalid number of columns (must be 1-3).", 10, 0

scan_dim_fmt: db "%d", 0
dbl_print_fmt: db "%lf", 0
dbl_scan_fmt: db" %lf", 0
