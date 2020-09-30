; ASSEMBLY INTEL 8051
;
; Exercício 02
;
; Estude o conteúdo da memória de dados interna mostrado abaixo. Mostre
; as mudanças em seu conteúdo após a sequência de instruções que são 
; executadas no trecho de programa apresentado abaixo.
;
; Pontuação máxima: 1,5
;
; SFR                                           MEMÓRIA   
;
; +---------------------------------------+         +-----+
; |         CY  AC  F0  RS1 RS0 OV      P |     13h | 30h |
; -----------------------------------------     12h | 7Eh |
; | PSW     0   0   0   0   0   0   -   0 |     11h | F6h |
; +---------------------------------------+     10h | 13h |
;                                                   |     |
;                                               09h | 05h |
;                                               08h | 43h |
;                                                   |     |
;                                               02h | 12h |
;                                               01h | 62h |
;                                               00h | 45h |
;                                                   +-----+
;
;   MNEMÔNICOS      RESULTADOS                  MEMÓRIA (em `END`)
;   -------------------------------------------------------------------
;
    CLR RS0         ; RS0 = 0b                      +-----+
    CLR RS1         ; RS1 = 0b                  13h | 30h |
    MOV R0, #30h    ; R0  = 30h (banco 0)       12h | 7Eh |
    SETB RS0        ; RS0 = 1b                  11h | 30h |
    MOV R0, #13h    ; R0  = 13h (banco 1)       10h | 13h |
    SETB RS1        ; RS1 = 1b                  ... | ... |
    CLR RS0         ; RS0 = 0b                  09h | 05h |
    MOV R1, 00h     ; R1  = 30h (banco 2)       08h | 13h |
                    ;                           ... | ... |
    END             ; Termina o programa        02h | 12h |
;                                               01h | 62h |
;                                               00h | 30h |
; SFX (em `END`)                                    +-----+
;                                                   
; +---------------------------------------+     
; |         CY  AC  F0  RS1 RS0 OV      P |
; -----------------------------------------
; | PSW     0   0   0   1   0   0   -   0 |
; +---------------------------------------+