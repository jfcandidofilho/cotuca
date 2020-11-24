; ASSEMBLY INTEL 8051
;
;
; José Francisco Candido Filho - RA 20387
;
;
; Faça um cronômetro BCD de 00 à 99.
;
; Há três botões:
;   - B1 - START - Começa a contagem do ponto em que se encontra
;   - B2 - STOP - Para a contagem
;   - B3 - RESET - Para a contagem e limpa os estados
;
; Atente-se:
;   - Um nibble representa um digito de 0 a 9
;   - Deve haver a possibilidade de ligar displays de 7 segmentos, caso
;   assim for desejado, por meio de decodificadores
;   - A frequência de contagem é de 1 Hz
;   - Obrigatório o uso de temporizador de interrupção
;   - Deve conter arquivos do Proteus, o *.ASM e o *.HEX
;  
;
; Data de publicação:   19/11/2020
; Data de entrega:      25/11/2020 às 20h30min
;
;
;   MNEMÔNICOS              COMENTÁRIOS
;   -------------------------------------------------------------------

; EQUIVALÊNCIAS
; -------------

    ; PORTAS & ENDEREÇOS
    ; ..................

    B1          BIT P3.2    ; Botão de início (START) - INT0 Borda
    B2          BIT P3.3    ; Botão de parada (STOP) - INT1 Borda
    B3          BIT P2.0    ; Botão de reinício (RESTART) - Hardware RST

    LEDS        EQU P1      ; LEDs que recebem a saída que servem aos 
                            ; drivers de dois displays de 7 segmentos

    MARCADOR    BIT 20h     ; Marcador de Temporizador
                            ; SE MARCADOR = 1, ligar temporizador 1
                            ; SENÃO, ligar temporizador 0


    ; DADOS
    ; .....

    REP_T       EQU 0Eh     ; Comparador de repetição dos ciclos
    COMP_LSN    EQU 06h     ; Comparador do nibble menos significativo
    COMP_MSN    EQU 60h     ; Comparador do nibble menos significativo
    TEMP_SWT    EQU 50h     ; Comparador de troca do temporizador ativo

    CONTAR_H    EQU 0F0h    ; Período: 1 Hz -> T = 1s
    CONTAR_L    EQU 00H     ; O C.M. é de ((1/12)×f) S, logo 1×10^6 C.M.
                            ; são necessários para 1s. Assim, em 16bit,
                            ; precisaria repetir o timer 14 vezes
                            ; para f = 11.0592 MHz partindo de 0000h.
                            ; E ainda 2^16 - 4096 = 61440 = F000h
                            ; para o restante completar 1 s

    DISPARO     EQU 05h     ; Define o disparo por borda na INT0 e INT1
    INTERRUP    EQU 8Fh     ; Define as interrupções habilitadas
    PILHA       EQU 2Fh     ; Define o endereço atual da pilha
    TIMER       EQU 01h     ; Define os tipos de timer 
    ZERAR       EQU 00h     ; Define valor de reinício


; PROGRAMA
; --------

    ORG 0000h
init:   JMP start           ; Inicia o programa


; INTERRUPÇÕES
; ------------

    ; Interrupção Externa 0
    ; .....................

    ORG 0003h
inz:    CALL fniz           ; Chama a função da INT0

        RETI                ; Retorna ao ponto de chamada da interrupção


    ; Temporizador 0
    ; ..............

    ORG 000Bh
timez:  CALL fntz           ; Chama a função do Timer 0
        
        RETI                ; Retorna ao ponto de chamada da interrupção


    ; Interrupção Externa 1
    ; .....................
    
    ORG 0013h
inu:    CLR TR0             ; Desliga o Timer 0
        CLR TR1             ; Desliga o Timer 1

        RETI                ; Retorna ao ponto de chamada da interrupção


    ; Temporizador 1
    ; ..............

    ORG 001Bh
timeu:  CALL fntu           ; Chama a função do Timer 1

        RETI                ; Retorna ao ponto de chamada da interrupção


; PROGRAMA PRINCIPAL
; ------------------

    ORG 0033h
start:  MOV SP, #PILHA      ; Define a pilha para a RAM de Uso Geral

    ; Marcador de timer
        CLR MARCADOR        ; Inicializa o marcador
        MOV P1, #ZERAR      ; Inicializa a porta P1

    ; Contagem de segundos e de ciclos
        MOV R0, #ZERAR      ; Inicializa o contador de ciclos
        MOV R1, #ZERAR      ; Inicializa o contador de segundos;

    ; Configuração de interrupções
        MOV TMOD, #TIMER    ; M0 = 1 e M1 = 0 para timer de 16-bit
                            ; (MODO 1) no Timer 0
                            ; M0 = 0 e M1 = 0 para timer de 13-bit
                            ; (MODO 0) no Timer 1
        MOV TCON, #DISPARO  ; IT0 = 1, IT1 = 1 - Disparos por borda

    ; Contagem do timer
        MOV TH0, #ZERAR     ; Parte alta da contagem do timer 0
        MOV TL0, #ZERAR     ; Parte baixa da contagem do timer 0
        MOV TH1, #CONTAR_H  ; Parte alta da contagem do timer 1
        MOV TL1, #CONTAR_L  ; Parte baixa da contagem do timer 1

    ; Habilitação de interrupções
        MOV IE, #INTERRUP   ; EA  = 1 habilita interrupções
                            ; EX0 = 1, EX1 = 1 habilita INT0 e INT1
                            ; ET0 = 1, ET1 = 1 habilita os timers 0 e 1

halt:   JMP halt            ; Trava o sistema, aguardando botões


; SUBROTINAS & FUNÇÕES
; --------------------

    ; Função de reset de estados
    ; fnres significa "FuNção RESet"
    ;
fnres:  MOV IE, #ZERAR      ; Desativa interrupções
        MOV TCON, #ZERAR    ; Limpa estado dos temporizadores

        RET                 ; Retorna ao ponto de chamada da função


    ; Função do temporizador 0
    ; fntz significa "FuNção do Timer Zero"
    ;
fntz:   INC R0              ; Incrementa o contador de ciclos

        CJNE R0, #REP_T, tzf; Verifica se repetiu REP_T vezes
        SETB MARCADOR       ; Marca o temporizador 1 como alvo de START
                            ; SE repetiu em eventual STOP
        XRL TCON, #TEMP_SWT ; TR0 = 0, TR1 = 1 - SE repetiu

tzf:    RET                 ; Retorna ao ponto de chamada da função


    ; Função de um IF/ELSE lógico para nibbles
    ; fnilsn significa "FuNção If Less Significant Nibble"
    ;
fnilsn: MOV A, R1           ; Obtém possível valor xAh
        ADD A, #COMP_LSN    ; Verifica se é xAh
        CPL AC              ; Inverte a lógica JBC aplicado a AC
        JBC AC, ilsnf       ; SE AC for 0 ...
        MOV R1, A           ; ... então temos xAh, corrige para (x+1)0h

ilsnf:  RET                 ; Retorna ao ponto de chamada da função


    ; Função de um IF/ELSE lógico para nibbles
    ; fnilsn significa "FuNção If Most Significant Nibble"
    ;
fnimsn: MOV A, R1           ; Obtém possível valor Axh
        ADD A, #COMP_MSN    ; Verifica se é Axh
        JNC imsnf           ; SE CY for 0 ...
        MOV R1, A           ; ... então temos Axh, corrige para 0xh

imsnf:  RET                 ; Retorna ao ponto de chamada da função


    ; Função do temporizador 1
    ; fntu significa "FuNção do Timer Um"
    ;
fntu:   CLR MARCADOR        ; Marca o temporizador 0 como alvo de START 
                            ; em eventual STOP

        XRL TCON, #TEMP_SWT ; TR0 = 1, TR1 = 0
        MOV R0, #ZERAR      ; Reinicia o contador de ciclos (!!! ↑)

        INC R1              ; Incrementa o cronômetro
        CALL fnilsn         ; Chama IF para verificar se é xAh em R1
        CALL fnimsn         ; Chama IF para verificar se é Axh em R1

        CALL fninvn         ; Inverte os nibbles (limitação de hardware)
        MOV LEDS, R1        ; Mostra o contador
        CALL fninvn         ; Desinverte os nibbles (para calcular)

        RET                 ; Retorna ao ponto de chamada da função


    ; Função da INT0
    ; fniz significa "FuNção da Interrupção Zero"
    ;
fniz:   JBC MARCADOR, tmrz  ; Liga o timer 1 se MARCADOR = 1

        SETB TR0            ; ... Liga Timer 0
        JMP fnizf           ; Termina a execução

tmrz:   SETB TR1            ; ... Liga Timer 1
        CPL MARCADOR        ; Desfaz o "CLR" de JBC em MARCADOR

fnizf:  RET                 ; Retorna ao ponto de chamada da função


    ; Função de inversão de nibbles de um byte
    ; fninvn significa "FuNção INVerte Nibbles"
    ;
fninvn: MOV A, R1           ; Coloca o cronômetro no acumulador
        SWAP A              ; Inverte os nibbles do acumulador
        MOV R1, A           ; Atualiza o cronômetro para 

        RET                 ; Retorna ao ponto de chamada da função


; FIM
; ---

    ; Sinaliza ao montador que o programa acabou
    ;
    END                     ; Finaliza o programa