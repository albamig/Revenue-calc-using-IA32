;
; Código desarrollado por Sergio Delgado y Alberto Amigo.
; Práctica 1 de AOC (IA32).
;

segment .text
	global interes
	
	interes:
		push rbp
		mov rbp, rsp
		mov rbx , qword[rbp+40]
		mov rdx, qword[rbp+32]
		imul ebx, edx
		mov rdx, qword[rbp+24] 
		imul ebx, edx
		mov eax, ebx
		cdq
		mov ecx, 100
		idiv ecx
		mov qword[rbp+16], rax
		pop rbp
		ret