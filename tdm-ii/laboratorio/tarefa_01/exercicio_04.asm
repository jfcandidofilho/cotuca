; Exercício 04
; ************
; 
; Transformar o pseudo-código assembly baixo em código do Intel 8085
;
;   1- MOVER R1, 6
;   2- MOVER R2, 5
;   3- MOVER A, 0
;   4- SOMAR R1
;   5- DECREMENTAR R2
;   6- PULE_SE_NÃO_ZERO
;   7- MOVER M1, A
;   8- FIM
;
; Solução:
;

init:   MVI R1, 6
        MVI R2, 5
        MVI A, 0
        ADD R1
loop:   DCR R2
        JNZ loop
        MOV M2, A
        HLT