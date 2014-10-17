;
; Código desarrollado por Sergio Delgado y Alberto Amigo.
; Práctica 1 de AOC (IA32).
;

segment .text
	global _start
	
	_start:
		push rbp
		mov rbp, rsp
		mov rax , qword[rbp+32]
		imul rax, rax, qword[rbp+24]
		imul rax, rax, qword[rbp+16]
		idiv rax, rax, 100
		mov qword[rbp+16], rax
		pop rbp
		ret