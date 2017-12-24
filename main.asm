%include 'utility.asm'
%include 'read_mat.asm'

extern _printf
extern _scanf
extern _exit

section .text
global _main

_main:
	push rbp
	mov rbp, rsp

	;mov rdi, prompt
	;call sprint

	;mov rdi, scan_fmt
	;mov rsi, r1
	;mov rdx, r1+16
	;mov al, 0
	;call _scanf

	;mov rdi, prompt
	;call sprint

	;mov rdi, scan_fmt
	;mov rsi, r2
	;mov rdx, r2+16
	;mov al, 0
	;call _scanf

	;movupd xmm0, oword [rel r1]
	;movupd xmm1, oword [rel r2]
	;mulpd xmm0, xmm1

	;movupd xmm1, xmm0
	;unpckhpd xmm1, xmm1

	;xor rax, rax
	;mov al, 2
	;mov rdi, print_fmt
	;call _printf

	call read
	
	call _exit
	leave
	ret

section .bss
rows: resb 1
cols: resb 1
row: resq 9

section .data
num_row_prompt: db "Enter the number of rows: ", 0
num_col_prompt: db "Enter the number of columns: ", 0
row_val_prompt: db "Enter the next row: ", 0, 10

inv_row_err: db "Invalid number of rows (must be 1-3).", 0
inv_col_err: db "Invalid number of columns (must be 1-3).", 0

scan_dim_fmt: db "%d", 0
print_val_fmt: db "%f %f", 10, 0
scan_val_fmt: db "%lf %lf", 0
dbl_scan_fmt: db" %lf", 0
