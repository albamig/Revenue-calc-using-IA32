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
	L5:
		mov eax, dword[rbp+40]
	L6:
		mov dword[input1], eax
exi		call bin_ascii
	L20:
		mov eax, 4
		mov ebx, 1
		mov ecx, input1
		mov edx, 10
		int 80h
	L21:
		; Imprimir por pantalla la petición del capital
		mov eax, 4
		mov ebx, 1
		mov ecx, outputRed
		mov edx, l_outRed
		int 80h

		mov eax, dword[rbp+32]
		mov dword[input1], eax
		call bin_ascii

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

		mov eax, 4
		mov ebx, 1
		mov ecx, input1
		mov edx, 10
		int 80h

		pop rbp
		ret

		bin_ascii:
			call num_digit
		L7:	mov eax, dword[input1]
			loop_start:
				cdq
				mov ecx, 10
				idiv ecx
		L8:		add cl, 0x30
				mov byte[input1+ebx], cl
				dec ebx
				cmp eax, 10
				jge loop_start
		L9:	add al, 0x30
			mov byte[input1+ebx], al
		L10:	ret

		num_digit:
			mov ebx, 1
			loop_start1:
				cmp eax, 10
				jge loop_start2
				ret
			loop_start2:
				mov ecx, 10
				idiv ecx
				inc ebx
				jmp loop_start1





