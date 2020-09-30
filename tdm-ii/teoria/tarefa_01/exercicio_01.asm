; ASSEMBLY INTEL 8051
;
; Exercício 01
;
; Observe a o programa abaixo. Após a execução de cada linha, apresente
; o resultado da mesma.
;
; Pontuação máxima: 1,5
;
;   MNEMÔNICOS      RESULTADOS                                SIMPLES
;   -------------------------------------------------------------------
;
    MOV 12h, #78h   ; O endereço 12h armazena o valor 78h     12h = 78h
    CLR A           ; O acumulador armazena o valor 00h       A   = 00h
    MOV R1, #12h    ; O registrador R1 armazena o valor 12h   R1  = 12h
    ADD A, @R1      ; O acumulador armazena o valor 78h       A   = 78h
    MOV 12h, A      ; O endereço 12h armazena o valor 78h     12h = 78h
    INC R1          ; O registrador R1 armazena o valor 13h   R1  = 13h
    MOV @R1, A      ; O endereço 13h armazena o valor 78h     13h = 78h

    END             ; Termina o programa