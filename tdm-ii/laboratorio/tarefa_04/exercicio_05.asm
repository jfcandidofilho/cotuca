; ASSEMBLY INTEL 8085
;
; Exercício 05
;
; A partir da posição de memória 1400H (inclusive), está colocada uma 
; série de doze números, inteiros e positivos, em que a representação 
; binária de cada número não ultrapassa os 8 bits. Escreva um programa 
; em linguagem Assembly, com as instruções do microprocessador 8085, que
; permita contar todos os números superiores a 0FH e que coloque o 
; resultado dessa contagem na posição de memória 1600H.
;
;   MNEMÔNICOS          COMENTÁRIOS
;   -------------------------------------------------------------------

init:   MVI A, 27h      ; Armazena o valor 27h em 1400h por meio de A
        STA 1400h       ; É o número inteiro positivo 01

        MVI A, 98h      ; Armazena o valor 98h em 1401h por meio de A
        STA 1401h       ; É o número inteiro positivo 02

        MVI A, 07h      ; Armazena o valor 07h em 1402h por meio de A
        STA 1402h       ; É o número inteiro positivo 03

        MVI A, 10h      ; Armazena o valor 10h em 1403h por meio de A
        STA 1403h       ; É o número inteiro positivo 04

        MVI A, 0Fh      ; Armazena o valor 0Fh em 1404h por meio de A
        STA 1404h       ; É o número inteiro positivo 05

        MVI A, FFh      ; Armazena o valor FFh em 1405h por meio de A
        STA 1405h       ; É o número inteiro positivo 06

        MVI A, 55h      ; Armazena o valor 55h em 1406h por meio de A
        STA 1406h       ; É o número inteiro positivo 07

        MVI A, 80h      ; Armazena o valor 80h em 1407h por meio de A
        STA 1407h       ; É o número inteiro positivo 08

        MVI A, 01h      ; Armazena o valor 01h em 1408h por meio de A
        STA 1408h       ; É o número inteiro positivo 09

        MVI A, 00h      ; Armazena o valor 00h em 1409h por meio de A
        STA 1409h       ; É o número inteiro positivo 10

        MVI A, A6h      ; Armazena o valor A6h em 140Ah por meio de A
        STA 140Ah       ; É o número inteiro positivo 11

        MVI A, 6Ah      ; Armazena o valor 6Ah em 140Bh por meio de A
        STA 140Bh       ; É o número inteiro positivo 12

        ; Resolução do exercício ↓

start:  MVI A, 0Fh      ; Comparador para contagem
        MVI B, 00h      ; Zera a contagem de números superiores a 0Fh
        MVI C, 0Ch      ; Total de contagens a serem feitas
        LXI H, 1400h    ; Carrega o par HL com o endereço 1400h

loop:   CALL fnCMP      ; Chama a função de comparação
        DCR C           ; Decrementa a contagem de comparações
        JNZ loop        ; Repete o laço se ainda restar comparações
        MOV A, B        ; Armazena o resultado da contagem em B no ende-
        STA 1600h       ; reço 1600h por meio do acumulador
        JMP fim         ; Termina o laço

fnCMP:  CMP M           ; Compara (HL) com A e faz CY = 1 se A < (HL)
        JNC fnCMPprox   ; Salta para configurar a próxima se CY = 0 ...
        INR B           ; ... ou incrementa B se CY = 1
        fnCMPprox: INX H; Configura o endereço da próxima comparação
        RET             ; Retorna

fim:    HLT             ; Faz o microcontrolador ficar em espera