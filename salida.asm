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
	output resb 10

segment .text
	global salida

	salida:
		push rbp
		mov rbp, rsp

		; Imprimir por pantalla el resultado del capital
		mov eax, 4
		mov ebx, 1
		mov ecx, outputCap
		mov edx, l_outCap
		int 80h
	
		mov eax, dword[rbp+40]
		mov dword[input1], eax
		call bin_ascii

		mov eax, 4
		mov ebx, 1
		mov ecx, output
		mov edx, 10
		int 80h
	
		; Imprimir por pantalla el resultado del redito
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
		mov ecx, output
		mov edx, 10
		int 80h

		; Imprimir por pantalla el resultado del tiempo
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
		mov ecx, output
		mov edx, 10
		int 80h

		; Imprimir por pantalla el resultado del interes
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
		mov ecx, output
		mov edx, 10
		int 80h

		pop rbp
		ret
		;
		; Funcion que recibe como paramteros un numero
		; y transforma sus cifras decimales a codigo ASCII para imprimirlo por pantalla.
		;
		bin_ascii:	
			mov qword[output], 0
			mov eax, dword[input1]		
			mov ebx, 10			
			mov ecx, 1 
			mov byte[output], 0xA		; Colocamos en output un salto de linea para luego imprimirlo
			cmp byte[input1+3], 0xFF	; Comprobamos si el numero es negativo 
			jne Loop_start1
			xor eax, 0xFFFFFFFF			; Realizamos el complemento a2 del numero en caso de que sea negativo
			inc eax

			Loop_start1:
				cdq							; Este bucle realiza recursivamente una division del numero por 10 
				idiv ebx					; hasta que el cociente de la operacion es 0
				add dl, 0x30				; Sumamos 0x30 al resto para pasarlo a caracter ASCII
				mov byte[output+ecx], dl 	; Guardando el resto en el espacio reservado para la salida
				inc ecx
				cmp eax, 0
				jne Loop_start1

			cmp byte[input1+3], 0xFF		; Al finalizar el bucle comprobamos si el numero era negativo
			jne Reordenar					; si es asi colocamos el caracter "-" en la ultima posicion
			mov byte[output+ecx], 0x2D	
			inc ecx

			Reordenar:
				mov eax, 0
				dec ecx
				Loop_start2:			
					mov bl, byte[output+eax]	; Esta funcion ordena los numeros ya transformados en ASCII
					mov dl, byte[output+ecx]	; ya que el metodo bin_ascii los deja en la posicion opuesta
					mov byte[output+eax], dl
					mov byte[output+ecx], bl
					inc eax
					dec ecx
					cmp ecx, eax
					jg Loop_start2
		ret