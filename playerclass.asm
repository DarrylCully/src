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
    call nc, shoot ; Would read input 1 = S
    pop af
    rra
    push af
    call nc, moveright ; Reads input 3 = D
    pop af
    ; rra
    ; push af
    ; call nc, F pressed
    ; pop af
    ; rra
    ; push af
    ; call nc, G pressed
    ; pop af
    ret

; General rules on CP
; if A == N, then Z flag is set
; if A != N, then Z flag is reset
; if A < N, then C flag is set
; if A >= N, then C flag is reset

moveleft:
    ld a,(ix+1) ; inputting the position of the player
    cp  PLAYER_SPEED_X
    ret c
    sub PLAYER_SPEED_X
    ld (ix+1),a
    ret


moveright:
    ld a,(ix+1) ; inputting the position of the player
    cp  SCREEN_WIDTH-PLAYER_WIDTH_PX
    ret nc
    add a,PLAYER_SPEED_X
    ld (ix+1),a
    ret

shoot:
    ;Add timer
    ld iy,bulletdata
    call spawnbullet
    ret

spawnbullet:
    ld a,(iy)
    cp 255
    ret z
    ld a,(iy)
    cp 1
    jp z, spawnbullet_next
    ;spawn it
    ld a,1
    ld (iy),a
    ;ld a,(ix+1)
    ;ld (iy+1), a
    ;ld a,(ix+2)
    ;sub 9
    ;ld (iy+2),a
    ret

spawnbullet_next:
    ld bc,BULLET_DATA_LENGTH
    add iy,bc
    jp spawnbullet
