section	.rodata
LC0:
	DB	"%d", 10, 0	; Format integer
LC1:
	DB "x or k, or both are off range",10,0 ;Format not legal input
OPR_ADD:
	DB "+"
OPR_SHR:
	DB "r"
OPR_SHL:
	DB "l"
OPR_DUP:
	DB "d"
OPR_PP:
	DB "p"

section .bss
	operand_stack: resd 5
	input: resb 80
	nibble_conversion_table: resb 256
section .data
	op_esp dw 5
section .text
	align 16
	global main
	extern printf
	extern exit
	extern fprintf
	extern malloc
	extern free
	extern fgets
	extern stderr
	extern stdin
	extern stdout
main:
	push ebp
	mov ebp, esp
	pushad
	mov dword [op_esp], setup_conversion_table
	call setup_conversion_table
	.calc_loop:
		
		push dword [stdin]
		push dword 80
		push input
		call fgets
		break0:
		add esp, 12
		break1:
		popad
		break2:
		add esp, 4*3 ;clean stack
		;jmp check_opr
	.add_operand:

		

	;.check_opr:
	;	cmp byte[buffer],OPR_ADD
	;	jz try_add
	;	cmp byte[buffer],OPR_SHR
	;	jz try_shr
	;	cmp byte[buffer],OPR_SHL
	;	jz try_shl
	;	cmp byte[buffer],OPR_PP
	;	jz try_print
	;	cmp byte[buffer],OPR_DUP
	;	jz try_duplicate
	;	jmp add_operand

	;mov al, byte [nibble_conversion_table + eax] ; value of high nibble
	;mov bl, byte [nibble_conversion_table + ebx] ; value low nibble

setup_conversion_table:
	mov byte [nibble_conversion_table + '0'], 0
	mov byte [nibble_conversion_table + '1'], 1
	mov byte [nibble_conversion_table + '2'], 2
	mov byte [nibble_conversion_table + '3'], 3
	mov byte [nibble_conversion_table + '4'], 4
	mov byte [nibble_conversion_table + '5'], 5
	mov byte [nibble_conversion_table + '6'], 6
	mov byte [nibble_conversion_table + '7'], 7
	mov byte [nibble_conversion_table + '8'], 8
	mov byte [nibble_conversion_table + '9'], 9
	ret

	





