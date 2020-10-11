; ASSEMBLY INTEL 8085
;
; Exercício 03
;
; Continuando o exercício 01, colocar o resultado no endereço 3000H se o
; resultado for PAR e caso contrario colocar o resultado no endereço 
; 3002H.
;
;   MNEMÔNICOS          COMENTÁRIOS
;   -------------------------------------------------------------------

init:   MVI A, 27h      ; Armazena o valor 27h em 2000h por meio de A
        STA 2000h       ;

        MVI A, 98h      ; Armazena o valor 98h em 2001h por meio de A
        STA 2001h       ;

        ; Resolução do exercício ↓

start:  LDA 2000h       ; Carrega B com o conteúdo de 2000h por
        MOV B, A        ; meio do acumulador

        LDA 2001h       ; Carrega o acumulador com o conteúdo de 2000h

        ADD B           ; Soma B no acumulador

        RRC             ; Rotaciona o bit menos significativo ao carry
        JC impar        ; para verificar se é impar - salta se for

par:    RLC             ; Desrotaciona os bis do acumulador para armaze-
        STA 3000h       ; nar o resultado da soma em 3000h se a soma for
        JMP fim         ; um número par

impar:  RLC             ; Desrotaciona os bis do acumulador para armaze-
        STA 3002h       ; nar o resultado da soma em 3002h se a soma for
                        ; um número ímpar

fim:    HLT             ; Faz o microcontrolador ficar em espera