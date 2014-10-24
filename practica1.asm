;
; Código desarrollado por Sergio Delgado y Alberto Amigo.
; Práctica 1 de AOC (IA32).
;

segment .data
	; Etiqueta el mensaje que pide el capital y guarda su número de caracteres.
	promptCap db "Introduzca el capital: ", 0
	l_proCap equ $-promptCap

	; Etiqueta el mensaje que pide el redito y guarda su número de caracteres.
	promptRed db "Introduzca el redito: ", 0
	l_proRed equ $-promptRed

	; Etiqueta el mensaje que pide el tiempo y guarda su número de caracteres.
	promptTie db "Introduzca el tiempo: ", 0
	l_proTie equ $-promptTie

segment .bss
	; Reserva espacio de 32 bits para almacenar el capital
	capital resd 1	

	; Reserva espacio de 32 bits para almacenar el redito
	redito resd 1

	; Reserva espacio de 32 bits para almacenar el tiempo
	tiempo resd 1

	; Reserva espacio de 32 bits para almacenar el intercambio
	input resb 10

	result resq 1
	
segment .text
	global _start
	extern interes
	extern salida
	
	_start:
		; Imprimir por pantalla la petición del capital
		mov eax, 4
		mov ebx, 1
		mov ecx, promptCap
		mov edx, l_proCap
		int 80h

		; Recoger de teclado el valor introducido para capital
		mov eax, 3
		mov ebx, 0
		mov ecx, input
		mov edx, 80
		int 80h

		call ascii_bin

		mov dword[capital], eax

		; Imprimir por pantalla la petición del rédito
		mov eax, 4
		mov ebx, 1
		mov ecx, promptRed
		mov edx, l_proRed
		int 80h

		; Recoger de teclado el valor introducido para redito
		mov eax, 3
		mov ebx, 0
		mov ecx, input
		mov edx, 80
		int 80h

		call ascii_bin
		mov dword[redito], eax

		; Imprimir por pantalla la petición del tiempo
		mov eax, 4
		mov ebx, 1
		mov ecx, promptTie
		mov edx, l_proTie
		int 80h

		; Recoger de teclado el valor introducido para tiempo
		mov eax, 3
		mov ebx, 0
		mov ecx, input
		mov edx, 80
		int 80h

		call ascii_bin
		mov dword[tiempo], eax
		
		;Introducir en la pila todos los parametros necesarios
		push qword[capital]
		push qword[redito]
		push qword[tiempo]
		push qword[result]
	
		call interes
	
		pop qword[result]
		push qword[result]
	
		call salida
		add esp, 8

		mov eax, 1
		mov ebx, 0
		int 80h

	;
	; Función para convertir de codificación ASCII a números.
	; Parámetros:
	; 	· eax - Cantidad de dígitos del número
	;	· [input] - Número en ASCII a convertir
	; Devuelve:
	;	· eax - Número en binario
	;
	ascii_bin:
		dec eax					; Decrementamos eax para obtener el numero de cifras exacto 
		mov ecx, eax			; y lo movemos a ecx para gobernar el bucle
		mov eax, 0 
		cmp byte[input], 0x2D	; Comparamos el primer byte del parametro "input" para comprobar si es el caracter "-"
		je Negativo				; si la comparacion es correcta saltamos a la etiqueta "Negativo"

		Positivo:
			mov edx, 0 			; Colocamos el contador para movernos por los bytes de la palabra a 0
			jmp Loop_start			

		Negativo:
			mov edx, 1			; Colocamos el contador para movernos por los bytes de la palbara a 1
			dec ecx				; Decrementamos el ecx ya que tiene una cifra decimal menos

		Loop_start:						
			mov bl, byte[input+edx]			
			sub bl, 0x30				; Restamos a cada byte 0x30 para combertirlo en un numero decimal
			movzx ebx, bl			
			imul eax, eax, 10			; Multiplicamos recursivamente  el registro que contendra el valor final por 10
			add eax, ebx				; y le sumamos el siguiente byte de la palabra
			loop Loop_start				

		cmp byte[input], 0x2D			; Comparamos de nuevo el primer byte con el caracter "-"
		jne Return
				
		Complemento_a_2:
			xor eax, 0xFFFFFFFF			; Realizamos el complemento a2 del numero y le sumamos 1
			inc eax

		Return:
			ret
