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


; RESOLUÇÃO ALTERNATIVA DO EXERCÍCIO

        ORG 0010h       ; Diretiva para começar o programa em 0010h

init:   MOV 52h, 50h    ; Copia o valor de 50h para não perdê-lo
        MOV 53h, 51h    ; Copia o valor de 51h para não perdê-lo


teste1: DJNZ 52h, teste2; Verifica se decrementando 1, 50h é zero
                        ; Se não for zero, testa 51h
        JMP menor       ; Se for zero, então 50h < 51h

teste2: DJNZ 53h, teste1; Verifica se decrementando 1, 51h é zero
                        ; Se não for zero, testa 50h
                        ; Segue adiante se for zero e então 50h > 51h

; "maior" pois referencia 50h > 51h
maior:  MOV 61h, 50h    ; Armazena o conteúdo de 50h (maior) em 61h
        MOV 60h, 51h    ; Armazena o conteúdo de 51h (menor) em 60h
        JMP fim

; "menor" pois referencia 50h < 51h
menor:  MOV 61h, 51h    ; Armazena o conteúdo de 51h (maior) em 61h
        MOV 60h, 50h    ; Armazena o conteúdo de 50h (maior) em 60h

fim:    END             ; Termina o programa


; NOTA:
;
; Se no teste 1 verificar zero, ainda faltaria a checagem do teste 2
; para averiguar se os conteúdos de 50h e 51h são iguais. Porém, como
; não existe preocupação do exercício quanto a isso, então não faz 
; diferença qual dos endereços são copiados para 60h e 61h no caso de
; serem iguais.
;
; No teste 2, essa preocupação é irrelevante pois só é feito o teste se
; o teste 1 não resultar em zero. Então só teste 2 resultaria em zero.