; ASSEMBLY INTEL 8051
;
; Exercício 03
;
; Escreva um programa em linguagem Assembly (família MCS-51) que cumpra
; os seguintes requisitos: 
; 
;   1-  Compare o conteúdo na localização da memória interna 50h e 51h;
;   2-  Mova o número maior para a localização de dados internos 61h; 
;   4-  Mova o número menor para a localização de dados internos 60h;
;   3-  Seu código fonte não deve exceder 13 linhas de código;
;
; Pontuação máxima: 2,5
;
;
;   MNEMÔNICOS          COMENTÁRIOS
;   -------------------------------------------------------------------

; VALORES DE TESTE

        ORG 0000h       ; Diretiva para começar o programa em 0000h

        MOV 50h, #70h   ; Define o valor 70h para o endereço 50h
        MOV 51h, #82h   ; Define o valor 82h para o endereço 51h

        JMP init        ; Inicia o programa


; RESOLUÇÃO DO EXERCÍCIO

        ORG 0010h       ; Diretiva para começar o programa em 0010h

init:   CLR C           ; Limpa o bit flag de carry para SUBB não usar

        MOV A, 50h      ; Copia o conteúdo de 50h no acumulador
        SUBB A, 51h     ; Subtrai o conteúdo de 51h do acumulador (A) e
                        ; armazena no acumulador
        JC menor        ; Se houve empréstimo ao bit 7 de A, 50h < 51h
                        ; Se não houve empréstimo, 51h < 50h

maior:  MOV 61h, 50h    ; Armazena o conteúdo de 50h (maior) em 61h
        MOV 60h, 51h    ; Armazena o conteúdo de 51h (menor) em 60h
        JMP fim

menor:  MOV 61h, 51h    ; Armazena o conteúdo de 51h (maior) em 61h
        MOV 60h, 50h    ; Armazena o conteúdo de 50h (maior) em 60h

fim:    END             ; Termina o programa