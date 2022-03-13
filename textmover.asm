ENTRY_POINT equ 32768

    org ENTRY_POINT

    call 0xdaf ;ROM routine of spectrum which clears screen and opens channel 2

loop:
    
    call setposition
    call displaysprite
    halt ;waits for the interrupt, locks fps at 50
    call delay
    call setposition
    call deletesprite
    call moveright


    jp loop ; game loop

displaysprite:
    ld a,(playersprite)
    rst 16
    ret 

deletesprite:
    ld a,ASCII_SPACE
    rst 16
    ret

setposition:
    ld a,ASCII_AT
    rst 16
    ld a,(posy)
    rst 16
    ld a,(posx)
    rst 16
    ret
     

moveright:
    ld a,(posx) ; inputting the position of the player
    cp  MAX_X ; comparing the players x position to the value of 32 so that the player does not exceed 256
    ret nc ; if 256 reached code below stops running
    ld a,(posx)
    inc a
    ld (posx),a
    ret

delay ld b,1000
delay0 halt
       djnz delay0
       ret


; Variables

posx db 0
posy db 0

playersprite db 0x2a

ASCII_SPACE equ 0x20
ASCII_AT equ 0x16
MAX_X equ 31
    end ENTRY_POINT