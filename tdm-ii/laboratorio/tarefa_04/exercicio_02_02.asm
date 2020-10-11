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

main:   LDA 1050h       ; Carrega o acumulador com o conteúdo de 1050h
        LHLD 1051h      ; Carrega L com o conteúdo de 1051h e H com o con-
                        ; teúdo de 1052h;

        ADD H           ; Adiciona os conteúdos de H e L no acumulador que
        ADD L           ; armazena o resultado

        STA 1053h       ; Armazena o resultado da soma em 1053h

fim:    HLT             ; Faz o microcontrolador ficar em espera