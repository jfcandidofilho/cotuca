; ASSEMBLY INTEL 8085
;
; Exercício 06
;
; Utilizando as instruções do microprocessador 8085, estabeleça um pro-
; grama em linguagem Assembly que conte o número de alunos de uma sala 
; de 20 alunos que obtiveram media igual ou superior a 05. As medias 
; estão armazenadas a partir do endereço 2000h da memória e o resultado
; desta contagem deve ser armazenado o endereço 1000h.
;
;   MNEMÔNICOS          COMENTÁRIOS
;   -------------------------------------------------------------------

init:   MVI A, 0Ah      ; Armazena o valor 0Ah em 2000h por meio de A
        STA 2000h       ; É a média do aluno 01

        MVI A, 09h      ; Armazena o valor 09h em 2001h por meio de A
        STA 2001h       ; É a média do aluno 02

        MVI A, 08h      ; Armazena o valor 08h em 2002h por meio de A
        STA 2002h       ; É a média do aluno 03

        MVI A, 07h      ; Armazena o valor 07h em 2003h por meio de A
        STA 2003h       ; É a média do aluno 04

        MVI A, 06h      ; Armazena o valor 06h em 2004h por meio de A
        STA 2004h       ; É a média do aluno 05

        MVI A, 05h      ; Armazena o valor 05h em 2005h por meio de A
        STA 2005h       ; É a média do aluno 06

        MVI A, 04h      ; Armazena o valor 04h em 2006h por meio de A
        STA 2006h       ; É a média do aluno 07

        MVI A, 03h      ; Armazena o valor 03h em 2007h por meio de A
        STA 2007h       ; É a média do aluno 08

        MVI A, 02h      ; Armazena o valor 02h em 2008h por meio de A
        STA 2008h       ; É a média do aluno 09

        MVI A, 01h      ; Armazena o valor 01h em 2009h por meio de A
        STA 2009h       ; É a média do aluno 10

        MVI A, 00h      ; Armazena o valor 00h em 200Ah por meio de A
        STA 200Ah       ; É a média do aluno 11

        MVI A, 0Ah      ; Armazena o valor 0Ah em 200Bh por meio de A
        STA 200Bh       ; É a média do aluno 12

        MVI A, 09h      ; Armazena o valor 09h em 200Ch por meio de A
        STA 200Ch       ; É a média do aluno 13

        MVI A, 08h      ; Armazena o valor 08h em 200Dh por meio de A
        STA 200Dh       ; É a média do aluno 14

        MVI A, 07h      ; Armazena o valor 07h em 200Eh por meio de A
        STA 200Eh       ; É a média do aluno 15

        MVI A, 06h      ; Armazena o valor 06h em 200Fh por meio de A
        STA 200Fh       ; É a média do aluno 16

        MVI A, 05h      ; Armazena o valor 05h em 2010h por meio de A
        STA 2010h       ; É a média do aluno 17

        MVI A, 04h      ; Armazena o valor 04h em 2011h por meio de A
        STA 2011h       ; É a média do aluno 18

        MVI A, 03h      ; Armazena o valor 03h em 2012h por meio de A
        STA 2012h       ; É a média do aluno 19

        MVI A, 02h      ; Armazena o valor 02h em 2013h por meio de A
        STA 2013h       ; É a média do aluno 20

        ; Resolução do exercício ↓

start:  MVI A, 04h      ; Comparador para contagem
        MVI B, 00h      ; Zera a contagem de notas superiores a 04h
        MVI C, 14h      ; Total de contagens a serem feitas
        LXI H, 2000h    ; Carrega o par HL com o endereço 2000h

loop:   CALL fnCMP      ; Chama a função de comparação
        DCR C           ; Decrementa a contagem de comparações
        JNZ loop        ; Repete o laço se ainda restar comparações
        MOV A, B        ; Armazena o resultado da contagem em B no ende-
        STA 1000h       ; reço 1600h por meio do acumulador
        JMP fim         ; Termina o laço

fnCMP:  CMP M           ; Compara (HL) com A e faz CY = 1 se A < (HL)
        JNC fnCMPprox   ; Salta para configurar a próxima se CY = 0 ...
        INR B           ; ... ou incrementa B se CY = 1
        fnCMPprox: INX H; Configura o endereço da próxima comparação
        RET             ; Retorna

fim:    HLT             ; Faz o microcontrolador ficar em espera