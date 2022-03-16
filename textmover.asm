
;Input ports
; 32766 B, N, M, Symbol Shift, Space
; 49150 H, J, K, L, Enter
; 57342 Y, U, I, O, P
; 61438 6, 7, 8, 9, 0 = Opens Port 1
; 63486 5, 4, 3, 2, 1 = Opens Port 2
; 64510 T, R, E, W, Q
; 65022 G, F, D, S, A
; 65278 V, C, X, Z, Caps Shift
;
;
;
;
ENTRY_POINT equ 32768

    org ENTRY_POINT

    
    call 0xdaf ;ROM routine of spectrum which clears screen and opens channel 2
    ld hl,udg1 ;HL pointer to Udg1
    ld (23675), hl
    ld a, ATTR_BLUE_INK_YELLOW_PP
    ld (23693), a ;poke value into the screen colour attributes memory address
    call 0xdaf ; clear screen

loop:
    halt ;waits for the interrupt, locks fps at 50
    
    ld de,(posx) ; DE = posx, posy
    call setposition
    call deletesprite

    ld bc,65022
    in a,(c) ;reads port in c
    rra ;roll bits to the right; bit0 moves into the carry bit of F
    push af
    call nc, moveleft ; Reads input 0 = A
    pop af
    rra ;roll bits to the right; bit1 moves into the carry bit of F
    push af
    call nc, movedown ; Would read input 1 = S
    pop af
    rra
    push af
    call nc, moveright ; Reads input 3 = D
    pop af
    ;rra
    ;push af
  ; call nc,KeyPress_4
    ;pop af
    ;rra
    ;push af
   ; call nc,KeyPress_5
    ;pop af
    ;and %00000010 ; and 2; mask out all bits except bit1

    ld bc, 64510
    in a,(c)
    rra
    push af
    ;call nc, Q
    pop af
    rra
    push af
    call nc, moveup
    pop af

    ;call delay
    ld de,(posx) ; DE = posx, posy
    call setposition
    call displaysprite
   ; call moveright

    ld de,(score_xpos)
    call setposition
    ld bc,(score) ; stores score value in register
    call 0x1a1b ; built in routine to print int less than 10000

    jp loop ; game loop

displaysprite:
    ld a,(playersprite)
    rst 16
    ret 

deletesprite:
    ld a,ASCII_SPACE
    rst 16
    ret

; INPUTS

setposition:
    ld a,ASCII_AT
    rst 16
    ld a,d
    rst 16
    ld a,e
    rst 16
    ret
     

; setposition:
;     ld a,ASCII_AT
;     rst 16
;     ld a,(posy)
;     rst 16
;     ld a,(posx)
;     rst 16
;     ret
     

moveleft:
    ld a,(posx) ; inputting the position of the player
    cp  0 ; comparing the players x position to the value of 32 so that the player does not exceed 256
    ;ret nc ; if 256 reached code below stops running
    ret z
    ld a,(posx) ;is this needed?
    dec a
    ld (posx),a
    ret

moveright:
    ld a,(posx) ; inputting the position of the player
    cp  MAX_X ; comparing the players x position to the value of 32 so that the player does not exceed 256
    ret nc ; if 256 reached code below stops running
    ld a,(posx)
    inc a
    ld (posx),a
    ret

moveup:
    ld a,(posy) ; inputting the position of the player
    cp  1 ; comparing the players x position to the value of 32 so that the player does not exceed 256
    ret z ; if 256 reached code below stops running
    ld a,(posy)
    dec a
    ld (posy),a
    ret

movedown:
    ld a,(posy) ; inputting the position of the player
    cp  MAX_Y ; comparing the players x position to the value of 32 so that the player does not exceed 256
    ret z ; if 256 reached code below stops running
    ld a,(posy)
    inc a
    ld (posy),a
    ret

;delay ld b,10
;delay0 halt
;       djnz delay0
;       ret


; Variables
score dw 2555
score_xpos db 0
score_ypos db 20


posx db 15
posy db 21

playersprite db 0x92



include "constants.asm"
include "sprites\udgs.asm"


    end ENTRY_POINT