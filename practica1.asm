segment .data
	prompt1 db "Introduzca el capital: ", 0
	l_pro1 equ $-prompt1

	prompt2 db "Introduzca el redito: ", 0
	l_pro2 equ $-prompt2

	prompt3 db "Introduzca el tiempo: ", 0
	l_pro3 equ $-prompt3

segment .bss
	capital resd 1	
	redito resd 1
	tiempo resd 1
	resultado resd 1
	
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

		call ascii_bin
		mov dword[capital], eax

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

		call ascii_bin
		mov dword[redito], eax

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

		call ascii_bin
		mov dword[tiempo], eax

		mov eax, 1
		mov ebx, 0
		int 80h

	ascii_bin:
		dec eax
		mov ecx, eax
		mov edx, 0
		mov eax, 0

		loop_start:
			mov bl, byte[capital+edx]
			sub bl, 0x30
			imul eax, eax, 10
			movzx ebx, bl
			add eax, ebx
			inc edx
			loop loop_start
		ret
		
		
			
			










