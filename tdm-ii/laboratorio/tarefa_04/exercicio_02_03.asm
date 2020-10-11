; ASSEMBLY INTEL 8085
;
; Exercício 02
;
; Escreva um programa em linguagem Assembly, com as instruções do micro-
; processador 8085, que permita efetuar a adição de três números intei-
; ros e positivos, colocados na memória, respectivamente em 1050H, 1051H
; e 1052H, cuja soma não ultrapassa o valor FFH.  O resultado da adição
; deverá ficar guardado na posição de memória 1053H.
;
;   MNEMÔNICOS          COMENTÁRIOS
;   -------------------------------------------------------------------

init:   MVI A, 27h      ; Armazena o valor 27h em 1050h por meio de A
        STA 1050h       ;

        MVI A, 98h      ; Armazena o valor 98h em 1051h por meio de A
        STA 1051h       ;

        MVI A, 53h      ; Armazena o valor 53h em 1052h por meio de A
        STA 1052h       ;

        ; Resolução do exercício ↓

main:   LXI B, 0000h    ; Zera os pares de registradores BC, DE e HL
        LXI D, 0000h    ; Zera os pares de registradores BC, DE e HL
        LXI H, 0000h    ; Zera os pares de registradores BC, DE e HL

        LDA 1050h       ; Carrega C com o conteúdo de 1050h por meio do
        MOV C, A        ; acumulador

        LDA 1051h       ; Carrega C com o conteúdo de 1051h por meio do
        MOV E, A        ; acumulador

        LDA 1052h       ; Carrega C com o conteúdo de 1052h por meio do
        MOV L, A        ; acumulador

        DAD B           ; Adiciona o conteúdo do par BC e do par DE ao
        DAD D           ; par HL que armazena o resultado de 16bits

        SHLD 1053h      ; Armazena L em 1053h e H em 1054h

fim:    HLT             ; Faz o microcontrolador ficar em espera