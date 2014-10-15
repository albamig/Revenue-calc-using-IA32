segment .data
	prompt1 db "Introduzca el capital: "
	l_pro1 equ $-prompt1

	prompt2 db "Introduzca el redito: "
	l_pro2 equ $-prompt2

	prompt3 db "Introduzca el tiempo: "
	l_pro3 equ $-prompt3

segment .bss
	capital resb 10

	redito resb 10

	tiempo resb 10

	resultado resb 10

segment .text
	global _start

	_start:
		mov eax, 4
		mov ebx, 1
		mov ecx, prompt1
		mov edx, l_pro1
		int 80h

		mov eax, 3
		mov ebx, 0
		mov ecx, capital
		mov edx, 80
		int 80h

		mov ebx, [capital]
		call ascii_bin

		mov eax, 4
		mov ebx, 1
		mov ecx, prompt2
		mov edx, l_pro2
		int 80h

		mov eax, 3
		mov ebx, 0
		mov ecx, redito
		mov edx, 80
		int 80h

		mov eax, 4
		mov ebx, 1
		mov ecx, prompt3
		mov edx, l_pro3
		int 80h

		mov eax, 3
		mov ebx, 0
		mov ecx, tiempo
		mov edx, 80
		int 80h

	ascii_bin:
		add eax, -1
		mov ecx, eax
		mov edx, 0

		loop_start:
			mov al, byte[capital+edx]
			













