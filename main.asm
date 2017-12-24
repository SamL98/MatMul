%include '../nasm/functions.asm'
extern _printf
extern _scanf
extern _exit

section .text
global _main

_main:
	push rbp
	mov rbp, rsp

	mov rdi, prompt
	call sprint

	mov rdi, scan_fmt
	mov rsi, r1
	mov rdx, r1+16
	mov al, 0
	call _scanf

	mov rdi, prompt
	call sprint

	mov rdi, scan_fmt
	mov rsi, r2
	mov rdx, r2+16
	mov al, 0
	call _scanf

	movupd xmm0, oword [rel r1]
	movupd xmm1, oword [rel r2]
	mulpd xmm0, xmm1

	movupd xmm1, xmm0
	unpckhpd xmm1, xmm1

	xor rax, rax
	mov al, 2
	mov rdi, print_fmt
	call _printf
	
	call _exit
	leave
	ret

section .bss
r1: resq 1
r2: resq 1

section .data
prompt: db "Enter the next row: ", 0
print_fmt: db "%f %f", 10, 0
scan_fmt: db "%lf %lf", 0
align 16
v1: dq 1.1
	dq 2.2
align 16
v2: dq 3.3
	dq 4.4
