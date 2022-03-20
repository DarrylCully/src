ENTRY_POINT equ 32768

    org ENTRY_POINT

    call 0xDAF
    ld a,2
    call 0x229B

main:
    halt
    
    ld ix, playerdata
    call deletesprites

    ld ix,bulletdata
    call deletebullets

    ld ix,playerdata
    call playermoveinput
    
    ; ld ix,bulletdata
    ; call movebullets

    ld ix, playerdata
    ld hl,ship
    call drawsprite


    ld ix,bulletdata
    ld hl,bullet1
    call drawbullets


    jp main

deletebullets:
    ld a,(ix)
    cp 255
    ret z
    ld a,(ix)
    cp 0
    jp z,deletebullets_next
    call deletesprites

deletebullets_next:
    ld bc,BULLET_DATA_LENGTH
    add ix,bc
    jp deletebullets

movebullets:
    ld a,(ix)
    cp 255
    ret z
    ld a,(ix)
    cp 0
    jp z, movebullets_next
    ;movebullets

    ld a,(ix+2)
    ;cp BULLET_MIN_Y
    ;call c, killbullet
    ;jp c, movebullets_next
    sub BULLET_SPEED
    ld (ix+2),a

movebullets_next:
    ld bc,BULLET_DATA_LENGTH
    add ix,bc
    jp movebullets

killbullet:
    ld (ix), 0
    ret
    

drawbullets:
    ld a,(ix)
    cp 255
    ret z
    ld a,(ix) ;?
    cp 0
    jp z, drawbullets_next
    ;if here, bullet alive
    call drawsprite
drawbullets_next:
    ld bc, BULLET_DATA_LENGTH
    add ix,bc
    jp drawbullets

;VARIABLES

; sprite data format
; isAlive, x, y, sizex (cells), sizey (lines)

;playerdata:
;    db 1, (255/2)-8, 180 - 8, 2, 16

playerdata:
    db 1,(255/2)-7,180-8,2,16


bulletdata:
    db 0,0,0,1,8
    db 0,0,0,1,8
    db 0,0,0,1,8
    db 255
BULLET_DATA_LENGTH equ 5


PLAYER_WIDTH_PX equ 16
PLAYER_SPEED_X equ 4
SCREEN_WIDTH equ 255

BULLET_SPEED equ 8
BULLET_MIN_Y equ 8




    include 'spritetools.asm'
    include 'screentools.asm'
    include 'audio.asm'
    include 'randomgenerator.asm'
    include "sprites\udgs.asm"
    include 'constants.asm'
    include 'playerclass.asm'

    end ENTRY_POINT