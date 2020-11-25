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
; Data de publicação:       19/11/2020
; Data de entrega (máx.):   25/11/2020 às 20h30min
;
;
;   MNEMÔNICOS              COMENTÁRIOS
;   -------------------------------------------------------------------

; EQUIVALÊNCIAS
; -------------

    ; PORTAS & ENDEREÇOS
    ; ..................

    B1          EQU P3.2    ; Botão de início (START) - INT0 Borda
    B2          EQU P3.3    ; Botão de parada (STOP) - INT1 Borda
                            ; Botão de reinício (RESTART) - Hardware RST
                            ; Então não está presente.

    LEDS        EQU P1      ; LEDs que recebem a saída que servem aos 
                            ; drivers de dois displays de 7 segmentos

    MARCADOR    EQU 20h     ; Marcador de Temporizador
                            ; SE MARCADOR = 0, contagem completa
                            ; SE MARCADOR = 1, contagem de ajuste


    ; DADOS
    ; .....

    REP_T       EQU 0Fh     ; Comparador de repetição dos ciclos
    COMP_LSN    EQU 06h     ; Comparador do nibble menos significativo
    COMP_MSN    EQU 60h     ; Comparador do nibble menos significativo

    AJUSTE_H    EQU 0BDh    ; THx do ajuste
    AJUSTE_L    EQU 0C0h    ; TLx do ajuste
                            ;
                            ; Considerando:
                            ; -- Contagem a cada 1 Hz (T = 1s)
                            ; -- O C.M. é de (1/12)×f_cristal segundos,
                            ; -- f_cristal = 12 MHz
                            ;
                            ; Assim, temos que 1×10^6 C.M. são necessá-
                            ; rios para gerar 1 segundo.
                            ;
                            ; Em um timer de 16bits, serão necessárias
                            ; 1M / (2^16) repetições do timer para gerar
                            ; 1 segundo. Ou seja: 15 repetições de 16bit
                            ; completas (THx = 00h e TLx = 00) mais um 
                            ; ajuste.
                            ;
                            ; O ajuste é de 16960 ciclos. Assim, THx e
                            ; TLx devem receber, repectivamente, o pri-
                            ; meiro (mais significativo) e o segundo 
                            ; byte (menos significativo) do resultado:
                            ;
                            ; (2^16) - 16960 = 48576 (ou 0BDC0h)

    DISPARO     EQU 05h     ; Define o disparo por borda na INT0 e INT1
                            ; IT0 = 1 e IT1 = 1 para borda de descida

    INTERRUP    EQU 87h     ; Define as interrupções habilitadas p/ uso
                            ; EA  = 1 habilita interrupções p/ uso
                            ; EX0 = 1, EX1 = 1 habilita INT0 e INT1
                            ; ET0 = 1, ET1 = 1 habilita o timer 0

    PILHA       EQU 2Fh     ; Define o endereço atual da pilha
                            ; Quando fizer uma operação de PUSH, o valor
                            ; será jogado na RAM de Uso Geral a partir
                            ; de 30h, poupando os registradores Rn

    TIMER       EQU 11h     ; Define os tipos de timer
                            ; M0 = 1 e M1 = 0 para timer de 16-bit
                            ; (MODO 1) no Timer 0 e no Timer 1

    ZERAR       EQU 00h     ; Define valor de reinício ou de zerar


; PROGRAMA
; --------

    ORG 0000h
init:   JMP start           ; Inicia o programa


; INTERRUPÇÕES
; ------------

    ; Interrupção Externa 0
    ; .....................

    ORG 0003h
inz:    SETB TR0            ; ... Liga Timer 0

        RETI                ; Retorna ao ponto de chamada da interrupção


    ; Temporizador 0
    ; ..............

    ORG 000Bh
timez:  DJNZ R0, tcf        ; Verifica se repetiu o timer REP_T vezes

                            ; SE o timer repetiu REP_T vezes:
        ACALL fntajs        ; Chama a função de ajuste

                            ; SENÃO:
tcf:    RETI                ; Retorna ao ponto de chamada da interrupção


    ; Interrupção Externa 1
    ; .....................
    
    ORG 0013h
inu:    CLR TR0             ; Desliga o Timer 0

        RETI                ; Retorna ao ponto de chamada da interrupção


; PROGRAMA PRINCIPAL
; ------------------

    ORG 0033h
start:  MOV SP, #PILHA      ; Define a pilha para a RAM de Uso Geral

                            ; Marcador de timer
        CLR MARCADOR        ; Inicializa o marcador
        MOV P1, #ZERAR      ; Inicializa a porta P1

                            ; Contagens
        MOV R0, #REP_T      ; Inicializa o contador de ciclos
        MOV A, #ZERAR       ; Inicializa o contador de segundos;

                            ; Configuração de interrupções
        MOV TMOD, #TIMER    ; Define os tipos de timer
        MOV TCON, #DISPARO  ; Tipo de disparo (sensibilidade)

                            ; Contagem do timer
        MOV TH0, #ZERAR     ; Parte alta da contagem do timer 0
        MOV TL0, #ZERAR     ; Parte baixa da contagem do timer 0

                            ; Habilitação de interrupções
        MOV IE, #INTERRUP   ; Define as interrupções habilitadas p/ uso

halt:   JMP halt            ; Trava o sistema, aguardando botões


; SUBROTINAS & FUNÇÕES
; --------------------

    ; Função de contagem de ajuste
    ; fntajs significa "FuNção do Timer para AJuSte"
    ;
fntajs: JBC MARCADOR, ajset ; Verifica se a primeira ou segunda execução
                            ; do ajuste

                            ; EXECUTADO SE reentrar no ajuste depois de
                            ; terminar a contagem de ajuste

                            ; Configura próximas iterações
        MOV TH0, #ZERAR     ; Parte alta da contagem do timer de ajuste
        MOV TL0, #ZERAR     ; Parte baixa da contagem do timer de ajuste
        SETB MARCADOR       ; Configura para entrar no ajuste após 
                            ; contar ciclos completos de 16 bits
        MOV R0, #REP_T      ; Reinicia o contador de ciclos completos

                            ; Atualização do cronômetro
        INC A               ; Incrementa o cronômetro
        DA A                ; Ajusta para BCD
        MOV LEDS, A         ; Mostra o cronômetro

                            ; Limpando o terreno para DA
        CLR AC              ; Limpa o carry auxiliar
        CLR CY              ; Limpa o carry
        
        JMP ajsf            ; Encerra a execução

                            ; EXECUTADO SE entrar no ajuste depois de 
                            ; realizar as contagens completas

                            ; Prepara contagem de ajuste p/ 1s perfeito
ajset:  MOV TH0, #AJUSTE_H  ; Parte alta da contagem do timer de ajuste
        MOV TL0, #AJUSTE_L  ; Parte baixa da contagem do timer de ajuste

                            ; Configura próximas iterações
        INC R0              ; Garante a segunda execução do ajuste

ajsf:   RET                 ; Retorna ao ponto de chamada da função


; FIM
; ---

    ; Sinaliza ao montador que o programa acabou
    ;
    END                     ; Finaliza o programa