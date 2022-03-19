;Contains all relevant data for player
;Input ports
; 32766 B, N, M, Symbol Shift, Space
; 49150 H, J, K, L, Enter
; 57342 Y, U, I, O, P
; 61438 6, 7, 8, 9, 0 = Opens Port 1
; 63486 5, 4, 3, 2, 1 = Opens Port 2
; 64510 T, R, E, W, Q
; 65022 G, F, D, S, A
; 65278 V, C, X, Z, Caps Shift

playermoveinput:
    ld bc,65022
    in a,(c) ;reads port in c
    rra ;roll bits to the right; bit0 moves into the carry bit of F
    push af
    call nc, moveleft ; Reads input 0 = A
    pop af
    rra ;roll bits to the right; bit1 moves into the carry bit of F
    push af
   ; call nc, movedown ; Would read input 1 = S
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
    ;push af
    ;call nc, Q
    ;pop af
    rra
    push af
    ;call nc, moveup
    pop af

moveleft:
    ld a,(ix+1) ; inputting the position of the player
    sub 1
    ld (ix+1),a
    ret


    ; cp  0 ; comparing the players x position to the value of 32 so that the player does not exceed 256
    ; ;ret nc ; if 256 reached code below stops running
    ; ret z
    ; ld a,(posx) ;is this needed?
    ; dec a
    ; ld (posx),a
    ; ret

moveright:
    ld a,(ix+1) ; inputting the position of the player
    add a,1
    ld (ix+1),a
    ret

playerspeed_x db 1

    ; ld a,(posx) ; inputting the position of the player
    ; cp  MAX_X ; comparing the players x position to the value of 32 so that the player does not exceed 256
    ; ret nc ; if 256 reached code below stops running
    ; ld a,(posx)
    ; inc a
    ; ld (posx),a
    ; ret 