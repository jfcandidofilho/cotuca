; ASSEMBLY INTEL 8085
;
; Exercício 01
;
; Escreva um programa em linguagem Assembly, com as instruções do micro-
; processador 8085 para realizar a soma do conteúdo do endereço 2000H 
; com o conteúdo 2001H e colocar o resultado em 4000H.
;
;   MNEMÔNICOS          COMENTÁRIOS
;   -------------------------------------------------------------------

init:   MVI A, 27h      ; Armazena o valor 27h em 2000h por meio de A
        STA 2000h       ;

        MVI A, 98h      ; Armazena o valor 98h em 2001h por meio de A
        STA 2001h       ;

        ; Resolução do exercício ↓

main:   LDA A, 2000h    ; Carrega B com o conteúdo de 2000h por
        MOV B, A        ; meio do acumulador

        LDA A, 2001h    ; Carrega o acumulador com o conteúdo de
                        ; 2000h

        ADD B           ; Soma B em A e armazena o resultado no
        STA 4000h       ; acumulador em 4000h

fim:    HLT             ; Faz o microcontrolador ficar em espera