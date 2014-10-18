;
; Código desarrollado por Sergio Delgado y Alberto Amigo.
; Práctica 1 de AOC (IA32).
;

segment .data
	outputCap db "El capital introducido ha sido: ", 0
	l_outCap equ $-outputCap

	outputRed db "El redito introducido ha sido: ", 0
	l_outRed equ $-outputRed

	outputTie db "El tiempo introducido ha sido: ", 0
	l_outTie equ $-outputTie

	outputInt db "El interes obtenido ha sido: ", 0
	l_outInt equ $-outputInt

segment .bss
	input resd 1 

segment .text
	global salida

	salida:
		push rbp
		mov rbp, rsp

		; Imprimir por pantalla la petición del capital
		mov eax, 4
		mov ebx, 1
		mov ecx, outputCap
		mov edx, l_outCap
		int 80h

		mov eax, dword[rbp+40]
		mov dword[input], eax
		call transformacion

		mov eax, 4
		mov ebx, 1
		mov ecx, input
		mov edx, 10
		int 80h

		; Imprimir por pantalla la petición del capital
		mov eax, 4
		mov ebx, 1
		mov ecx, outputRed
		mov edx, l_outRed
		int 80h

		mov eax, dword[rbp+32]
		mov dword[input], eax
		call transformacion

		mov eax, 4
		mov ebx, 1
		mov ecx, input
		mov edx, 10
		int 80h

		; Imprimir por pantalla la petición del capital
		mov eax, 4
		mov ebx, 1
		mov ecx, outputTie
		mov edx, l_outTie
		int 80h

		mov eax, dword[rbp+24]
		mov dword[input], eax
		call transformacion

		mov eax, 4
		mov ebx, 1
		mov ecx, input
		mov edx, 10
		int 80h

		; Imprimir por pantalla la petición del capital
		mov eax, 4
		mov ebx, 1
		mov ecx, outputInt
		mov edx, l_outInt
		int 80h

		mov eax, dword[rbp+16]
		mov dword[input], eax
		call transformacion

		mov eax, 4
		mov ebx, 1
		mov ecx, input
		mov edx, 10
		int 80h

		pop rbp
		ret

		transformacion:
			mov edx, 0
			mov eax, dword[input]
			loop_start:
				cdq
				mov ecx, 10
				idiv ecx
				add cl, 0x30
				mov byte[input+edx], cl
				inc edx
				cmp eax, 10
				jge loop_start
			add al, 0x30
			mov byte[input+edx], al
			ret
