; ASSEMBLY INTEL 8085
;
; Exercício 04
;
; Continuando exercício 03, se a soma for PAR, escrever 55H no endereço
; 3005H e, caso contrário, escrever AAH no endereço 3005H.
;
;   MNEMÔNICOS          COMENTÁRIOS
;   -------------------------------------------------------------------

init:   MVI A, 27h      ; Armazena o valor 27h em 2000h por meio de A
        STA 2000h       ;

        MVI A, 98h      ; Armazena o valor 98h em 2001h por meio de A
        STA 2001h       ;

        ; Resolução do exercício ↓

start:  LXI H, 3005h    ; Carrega o par HL com o endereço 3005h

        LDA 2000h       ; Carrega B com o conteúdo de 2000h por
        MOV B, A        ; meio do acumulador

        LDA 2001h       ; Carrega o acumulador com o conteúdo de 2000h

        ADD B           ; Soma B no acumulador

        RRC             ; Rotaciona o bit menos significativo ao carry
        JC impar        ; para verificar se é impar - salta se for

par:    RLC             ; Desrotaciona os bis do acumulador para armaze-
        STA 3000h       ; nar o resultado da soma em 3000h se a soma for
        MVI M, 55h      ; um número par, e armazena 55h em 3005h

        JMP fim         ; Termina o programa

impar:  RLC             ; Desrotaciona os bis do acumulador para armaze-
        STA 3002h       ; nar o resultado da soma em 3002h se a soma for
        MVI M, AAh      ; um número ímpar, e armazena AAh em 3005h

fim:    HLT             ; Faz o microcontrolador ficar em espera