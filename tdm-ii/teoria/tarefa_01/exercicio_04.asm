; ASSEMBLY INTEL 8051
;
; Exercício 04
;
; Suposição:    No pino P3.3 tem uma chave não retentiva (push button).
;
; Escreva um programa em linguagem Assembly (família MCS-51) que cumpra
; os seguintes requisitos:
;
;   1-  Decremente o regirastdor R0 do segundo banco (rotina de fundo);
;   2-  Ao interromper o microcontrolador com a chave, zere R0;
;   3-  Seu código fonte não deve exceder 13 linhas de código;
;   4-  O código deve estar comentado;
;
; Pontuação máxima: 3,0
;
;
;   MNEMÔNICOS          COMENTÁRIOS
;   -------------------------------------------------------------------

        ORG 0000h       ; Diretiva para começar o programa em 0000h
init:   JMP main        ; Inicia o programa

        ORG 0013h       ; Diretiva para começar a interrupção INT1
desv:   MOV R0, #00h    ; Zera o registrador R0 (banco 1)
        RETI            ; Retorna ao ponto antes da interrupção ocorrer

        ORG 0033h       ; Diretiva para começar o programa em 0033h
main:   MOV SP, #2Fh    ; Armazena a pilha a partir de 30h (uso geral)
        MOV IE, #84h    ; Ativa as interrupções (EA=1) e habilita o uso
                        ; da INT1 (EX1=1)
        MOV TCON, #04h  ; Seleciona ativação de INT1 por borda (IT1=1)
        MOV PSW, #08h   ; Seleciona o banco 1 (RS1=0 e RS0=1)

loop:   DEC R0          ; Decrementa R0 em uma unidade
        JMP loop        ; Executa o programa a partir da linha 'loop'

fim:    END             ; Termina o programa