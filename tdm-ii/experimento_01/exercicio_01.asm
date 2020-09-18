; Exercício 01
; ************
; 
; Executar o pseudo-assembly abaixo e mostrar o resultado na tabela
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
; Tabela:
;
;         PC          A           R1          M1          M2
;       ---------------------------------------------------------------
;       Início      vazio       vazio       vazio       vazio
;       ---------------------------------------------------------------
;       1             20          "           "           "
;       2             20          30          "           "
;       3             50          30          "           "
;       4             50          30          50          "
;       5             50          10          50          "
;       6             40          10          50          "
;       7             40          10          50          40
;       8             40          10          50          40