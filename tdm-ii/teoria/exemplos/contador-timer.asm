	; INÍCIO
init:	ORG 00h
	JMP main

	; INTERUPÇÃO
int:	ORG 0Bh
	CPL A
	MOV P2, A
	RETI

main:	MOV A, #0AAh
	MOV P2, A
	CLR TR0		; Liga o contador
	CLR TF0		; 
	MOV IE, #82h	; Habilita o Timer 0
	MOV TMOD, #06h	; Habilita o EA e o EN do Timer 0 MODO 2
	MOV TL0, #250d	; 
	MOV TH0, #250	;
	SETB TR0	;
	JMP $		; Salta para mesma linha ad infinitum
	END
	