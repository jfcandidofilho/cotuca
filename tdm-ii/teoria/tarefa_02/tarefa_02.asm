; ASSEMBLY INTEL 8051
;
; Exercício 01
;
; Suponha que a porta P1 seja usada para acionar 8 LEDs. Faça um progra-
; ma em assembly do 8051 onde a interrupção externa 0, por transição, é 
; usada para rotacionar 10 vezes para esquerda os LEDs da porta P1 e a 
; interrupção externa um, por nível, é usada para fazer piscar, de forma
; ininterrupta (enquanto P3.3 estiver em nível lógico zero) os LEDs da 
; porta P1.
;
;   MNEMÔNICOS              COMENTÁRIOS
;   -------------------------------------------------------------------

; EQUIVALÊNCIAS
; -------------

    ; Portas
    ;
    PORTA       EQU P1      ; Define a porta de entrada/saída


    ; Dados
    ;
    BANCOZ      EQU 00h     ; Define o banco 0 de registradores
    BANCOU      EQU 01h     ; Define o banco 1 de registradores

    CONTAGEM    EQU 0Ah     ; Define o valor de contagem de rotações

    DISPARO     EQU 01h     ; Define o tipo de disparo das interrupções
    INTERRUPCAO EQU 85h     ; Define as interrupções habilitadas

    PILHA       EQU 2Fh     ; Define o endereço atual da pilha

    LEDS        EQU 69h     ; Define o estado inicial dos LEDs


; PROGRAMA
; --------

    ORG 0000h
init:   JMP start           ; Inicia o programa


; INTERRUPÇÕES
; ------------

    ; Interrupção Externa 0
    ;
    ORG 0003h
inz:    MOV A, PORTA        ; Define o conteúdo a rotacionar
        MOV PSW, #BANCOZ    ; Seleciona o banco zero de registradores
        MOV R0, #CONTAGEM   ; Define a contagem de rotações máxima

        ACALL girar         ; Chama a subrotina de rotação

        RETI                ; Retorna ao ponto de chamada da interrupção


    ; Interrupção Externa 1
    ;
    ORG 0013h
inu:    MOV A, PORTA        ; Define o conteúdo a complementar
        MOV PSW, #BANCOU    ; Seleciona o banco um de registradores

        ACALL pisca         ; Chama rotina de pisca

        XRL TCON, #08h      ; Para a interrupção (se soltou o botão)

        RETI                ; Retorna ao ponto de chamada da interrupção


; PROGRAMA PRINCIPAL
; ------------------

    ORG 0033h
start:  MOV SP, #PILHA      ; Define a pilha para a RAM de Uso Geral

        MOV IE, #INTERRUPCAO; EA  = 1 habilita interrupções
                            ; EX0 = 1 habilita a interrupção externa 0
                            ; EX1 = 1 habilita a interrupção externa 1
        MOV TCON, #DISPARO  ; IT0 = 1 disparo por borda na int. ext. 0
                            ; IT1 = 0 disparo por nível na int. ext. 0

        MOV PORTA, #LEDS    ; Estado dos LEDs (0110 1001)

halt:   JMP halt            ; Trava o sistema, aguardando interupções.


; SUBROTINAS
; ----------

    ; Rotação de bits em A para a esquerda X vezes
    ;
    ORG 0050h
girar:  RL A                ; Rotaciona o acumulador para a esquerda
        MOV PORTA, A        ; Mostra a rotação na PORTA

        ACALL t1ds25        ; Espera ~0,125ms para rotacionar novamente

        DJNZ R0, girar      ; Decrementa a contagem de rotações e repete
                            ; a rotação se não chegar em zero
        RET                 ; Retorna ao ponto de chamada


    ; Complementa o acumulador duas vezes, criando um pulso de T=2s
    ;
    ORG 0070h
pisca:  MOV R1, A           ; Armazena o valor a ser trabalhado

        CPL A               ; Complementa o acumulador
        MOV PORTA, A        ; Mostra a complementação na PORTA
        ACALL t1s           ; Espera ~1s para o efeito ser visualizado
    
        MOV PORTA, R1       ; Mostra a recomplementação na PORTA
        ACALL t1s           ; Espera ~1s para o efeito ser visualizado

        RET                 ; Retorna ao ponto de chamada

    
    ; Gera atraso de aproximadamente 0.5ms (499 ciclos)
    ;
    ORG 0090h
t0ms5:  MOV R2, #0FAh       ; Define atraso de 248 ciclos (+ 2 ciclos)

        jmp1: DJNZ R2, jmp1 ; Multiplica o atrado por 2 por execução

        RET                 ; Retorna ao ponto de chamada (+ 1 ciclo)


    ; Gera atraso de aproximadamente 1.25ds (125753 ciclos)
    ;
    ORG 0110h
t1ds25: MOV R3, #0F9h       ; Define atraso de 250 ciclos (+ 2 ciclos)

        jmp2: ACALL t0ms5   ; Chama atraso de ~0.5ms (+ 2 ciclos)

        DJNZ R3, jmp2       ; Atraso (+ 2 ciclos) (x 250 rodadas)

        RET                 ; Retorna ao ponto de chamada (+ 1 ciclo)


    ; Gera atraso de aproximadamente 1s (1006059 ciclos)
    ;
    ORG 0130h
t1s:    MOV R4, #08h        ; Define atraso de 8 ciclos (+ 2 ciclos)

        jmp3: ACALL t1ds25  ; Chama atraso de ~1.25ds (+ 2 ciclos)

        DJNZ R4, jmp3       ; Atraso (+ 2 ciclos) (x 8 rodadas)

        RET                 ; Retorna ao ponto de chamada (+ 1 ciclo)


; FIM
; ---

    ; Sinaliza ao montador que o programa acabou
    ;
fim:    END                 ; Finaliza o programa