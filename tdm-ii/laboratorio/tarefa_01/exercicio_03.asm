; Exercício 03
; ************
; 
; Executar o pseudo-assembly abaixo e mostrar o resultado na tabela
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
; Tabela:
;
;         PC          A           R1          R2          M1
;       ---------------------------------------------------------------
;       Início      vazio       vazio       vazio       vazio
;       ---------------------------------------------------------------
;       1             "           6           "           "
;       2             "           6           5           "
;       3             0           6           5           "
;       4             6           6           5           "
;       5             1           6           5           "
;       6             1           6           5           "
;       7             1           6           0           1
;       8             1           6           0           1
;
;
;       Note que na linha 7, R2 é zero pois estou supondo seja para
;       considerar que o desvio da linha 6 seja para a linha 5. Assim,
;       executando normalmente, R2 é decrementado N vezes até chegar em
;       0, ativando a flag de zero, seguindo o fluxo do programa.