; Exercício 02
; ************
; 
; Transformar o pseudo-código assembly baixo em código do Intel 8085
;
;   1- MOVER A, 20
;   2- MOVER R1, 30
;   3- SOMAR R1
;   4- MOVER M1, A
;   5- MOVER R1, 10
;   6- SUBTRAIR R1
;   7- MOVER M2, A
;   8- FIM
;
; Solução:
;

init:   MVI A, 20
        MVI R1, 30
        ADD R1
        MOV M1, A
        MVI R1, 10
        SUB R1
        MOV M2, A
        HLT