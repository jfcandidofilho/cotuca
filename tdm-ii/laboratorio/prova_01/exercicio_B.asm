; ASSEMBLY INTEL 8085
;
; PROVA 01 - EXERCÍCIO 01 - PARTE B
;
; A partir da posição de memória 1000h (inclusive), está colocada uma 
; série de 08 (OITO) números inteiros e positivos. A representação biná-
; ria de cada número não ultrapassa os 8 bits. Escreva um programa em 
; linguagem Assembly, com as instruções do microprocessador 8085, que 
; permita contar QUANTOS destes números são PARES e que coloque o resul-
; tado dessa contagem na posição de memória 1600H.
;
;   MNEMÔNICOS          COMENTÁRIOS
;   -------------------------------------------------------------------

init:   MVI A, 27h      ; Armazena o valor 27h em 1000h por meio de A
        STA 1000h       ; É o número inteiro positivo 01

        MVI A, 98h      ; Armazena o valor 98h em 1001h por meio de A
        STA 1001h       ; É o número inteiro positivo 02

        MVI A, 07h      ; Armazena o valor 07h em 1002h por meio de A
        STA 1002h       ; É o número inteiro positivo 03

        MVI A, 10h      ; Armazena o valor 10h em 1003h por meio de A
        STA 1003h       ; É o número inteiro positivo 04

        MVI A, 0Fh      ; Armazena o valor 0Fh em 1004h por meio de A
        STA 1004h       ; É o número inteiro positivo 05

        MVI A, FFh      ; Armazena o valor FFh em 1005h por meio de A
        STA 1005h       ; É o número inteiro positivo 06

        MVI A, 00h      ; Armazena o valor 55h em 1006h por meio de A
        STA 1006h       ; É o número inteiro positivo 07

        MVI A, 80h      ; Armazena o valor 80h em 1007h por meio de A
        STA 1007h       ; É o número inteiro positivo 08

        ; Resolução do exercício ↓

start:  LXI H, 1000h    ; Carrega o par HL com a seqüência de dados
                        ; ( com o endereço inicial 1000h )
        MVI B, 00h      ; Zera a contagem de números pares
        MVI C, 08h      ; Total de checagens a serem feitas

loop:   MOV A, M        ; Carrega o acumulador com o dado em HL
        CALL fnPAR      ; Chama a função de verificação de "é par?"

        INX H           ; Configura o endereço da próxima checagem
        DCR C           ; Decrementa a contagem de comparações
        JNZ loop        ; Repete o laço se ainda restar comparações

        MOV A, B        ; Armazena o resultado da contagem em B no ende-
        STA 1600h       ; reço 1600h por meio do acumulador
        JMP fim         ; Termina o laço

fnPAR:  RRC             ; Rotaciona o bit menos significativo ao carry
        JC fnPARprox    ; Salta se carry CY=1 (ímpar)...
        INR B           ; ...Ou incrementa a contagem de pares (CY=0)
        fnPARprox: RET  ; Retorna

fim:    HLT             ; Faz o microcontrolador ficar em espera