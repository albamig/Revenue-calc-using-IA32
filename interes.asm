;
; Código desarrollado por Sergio Delgado y Alberto Amigo.
; Práctica 1 de AOC (IA32).
;

segment .text
	global interes
	;Funcion que recibe los parametros del programa principal por la pila y devuelve el resultado por la pila
	interes:
		push rbp			;Empujamos el valor de el base pinter a la pila para salvar su valor
		mov rbp, rsp			;Movemos el valor del rsp al rbp
		mov rbx , qword[rbp+40]
		mov rdx, qword[rbp+32]
		imul ebx, edx
		mov rdx, qword[rbp+24] 
		imul ebx, edx
		mov eax, ebx
		cdq
		mov ecx, 100
		idiv ecx
		mov qword[rbp+16], rax		;Colocamos el valor del resultado en la pila
		pop rbp				;Recuperamos el valor original del base pointer
		ret