ENTRY_POINT equ 32768

    org ENTRY_POINT

    call 0xDAF
    ld a,2
    call 8859

main:
    halt
    
    ld ix, playerdata
    call deletesprites

    ld ix,playerdata
    call playermoveinput
    

    ld ix, playerdata
    ld hl,ship
    call drawsprite

    jp main


;VARIABLES

; sprite data format
; isAlive, x, y, sizex (cells), sizey (lines)

playerdata:
    db 1, (255/2)-8, 180 - 8, 2, 16




    include 'spritetools.asm'
    include 'screentools.asm'
    include 'audio.asm'
    include 'randomgenerator.asm'
    include "sprites\udgs.asm"
    include 'constants.asm'
    include 'playerclass.asm'

    end ENTRY_POINT