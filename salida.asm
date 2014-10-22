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
	input1 resd 1
	aux resd 1 

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
	
		mov dword[input1], eax
		call bin_ascii
		call reordenar

		mov eax, 4
		mov ebx, 1
		mov ecx, input1
		mov edx, 10
		int 80h
	
		; Imprimir por pantalla la petición del capital
		mov eax, 4
		mov ebx, 1
		mov ecx, outputRed
		mov edx, l_outRed
		int 80h

		mov eax, dword[rbp+32]
		mov dword[input1], eax
		call bin_ascii
		call reordenar

		mov eax, 4
		mov ebx, 1
		mov ecx, input1
		mov edx, 10
		int 80h

		; Imprimir por pantalla la petición del capital
		mov eax, 4
		mov ebx, 1
		mov ecx, outputTie
		mov edx, l_outTie
		int 80h

		mov eax, dword[rbp+24]
		mov dword[input1], eax
		call bin_ascii
		call reordenar

		mov eax, 4
		mov ebx, 1
		mov ecx, input1
		mov edx, 10
		int 80h

		; Imprimir por pantalla la petición del capital
		mov eax, 4
		mov ebx, 1
		mov ecx, outputInt
		mov edx, l_outInt
		int 80h

		mov eax, dword[rbp+16]
		mov dword[input1], eax
		call bin_ascii
		call reordenar

		mov eax, 4
		mov ebx, 1
		mov ecx, input1
		mov edx, 10
		int 80h

		pop rbp
		ret

		bin_ascii:	
			mov eax, dword[input1]
			mov ebx, 10
			mov ecx, 0
			Loop_start:
				cdq
				idiv ebx
				add dl, 0x30
				mov byte[input1+ecx], dl
				inc ecx
				cmp eax, 0
				jne Loop_start
			ret

		reordenar:
			mov eax, 0
			dec ecx
			Loop_start2:
				mov bl, byte[input1+eax]
				mov dl, byte[input1+ecx]
				mov byte[input1+eax], dl
				mov byte[input1+ecx], bl
				inc eax
				dec ecx
				cmp ecx, eax
				jg Loop_start2
		ret


		

				





