; Estado inicial
MOV 13h, #30h
MOV 12h, #7Eh
MOV 11h, #0F6h
MOV 10h, #13h
MOV 09h, #05h
MOV 08h, #43h
MOV 02h, #12h
MOV 01h, #62h
MOV 00h, #45h

;Programa do Ex. 02
CLR RS0
CLR RS1
MOV R0, #30h

SETB RS0
MOV R0, #13h

SETB RS1
CLR RS0
MOV R1, 00h

JMP $

END