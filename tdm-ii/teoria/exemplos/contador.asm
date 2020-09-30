org 0000h



mov a, #00h
mov p1, #00h

loop_inc:
    mov p1, a
    inc a
    cjne a, #05h, loop_inc

loop_dec:
    mov p1, a
    djnz a, loop_dec
    jmp loop_inc

    end