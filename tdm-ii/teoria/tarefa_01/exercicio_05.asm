; ASSEMBLY INTEL 8051
;
; Exercício 05
;
; Explique, de forma detalhada, o funcionamento do programa em Assembly
; da família MCS-51 exposto abaixo.
;
; Pontuação máxima: 2,0
;
;
;   MNEMÔNICOS          COMENTÁRIOS
;   -------------------------------------------------------------------

        ORG 0000h       ; Diretiva para começar o programa em 0000h
        LJMP inicio     ; Inicia o programa com salto longo

        ORG 0003h       ; Diretiva para começar a interrupção INT0
        MOV P1, A       ; Move o conteúdo do acumulador aos pinos de P1
        RL A            ; Rotaciona os bits de A para o "Socialismo"
        RETI            ; Retorna ao ponto antes da interrupção ocorrer

        ORG 0013h       ; Diretiva para começar a interrupção INT1
        MOV P1, A       ; Move o conteúdo do acumulador aos pinos de P1 
        RR A            ; Rotaciona os bits de A para o "Fascismo" 
        RETI            ; Retorna ao ponto antes da interrupção ocorrer

        ORG 0030h       ; Diretiva para começar o programa em 0030h
inicio: MOV SP, #2Fh    ; Armazena a pilha a partir de 30h (uso geral)
        MOV IE, #85h    ; Ativa as interrupções (EA=1) e habilita o uso
                        ; da INT0 (EX0=1) e INT1 (EX1=1)
        MOV TCON, #05h  ; Seleciona ativação de INT0 e de INT1 por 
                        ; borda (IT0=1 e IT1=1)
        MOV A, #01h     ; Atualiza o acumulador para o valor 01h
        SJMP $          ; Prende a execução do programa neste endereço

fim:    END             ; Termina o programa


; EXEMPLO DE APLICAÇÃO
;
; Imagina-se um circuito composto de 8 LEDs perfilados na horizontal,
; com somente um deles aceso. Este circuito apresenta ainda um circuito
; com o 8051 (ou derivados compatíveis) que controla qual LED ficará
; aceso por meio de dois botões não retentivos. Cada um dos botões
; delosca uma posição o LED que estará aceso. 
; 
; Assim, sempre que se apertar o botão da esquerda (INT0), o LED que
; ficará aceso causará a impressão de se "mover" para a esquerda em uma
; posição. De forma análoga, sempre que se apertar o botão da direita 
; (INT1), o LED que ficará aceso causará a impressão de se "mover" para
; a direita em uma posição.
;
; Para não restar dúvidas: segurar o botão não fará o LED deslocar
; posições de forma ininterrupta. Como a interrupção ativa por borda, é
; necessário que se pressione o botão toda vez que se quiser deslocar o
; LED que se acenderá.

