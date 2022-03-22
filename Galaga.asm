ENTRY_POINT equ 32768

    org ENTRY_POINT

    call 0xDAF
    ld a,2
    call 0x229B

main:
    halt
    halt
    halt

    

    ld a,(bullet_timer)
    inc a
    ld (bullet_timer),a

    ld ix, player_data
    call deletesprites

    ld ix,bullet_data
    call update_bullets

    ld ix,enemy_data
    call update_enemies

    ld ix,player_data
    call playermoveinput
    
    ; ld ix,bullet_data
    ; call move_bullets

    ld ix, player_data
    ld hl,ship
    call drawsprite

    ld ix,bullet_data
    ld hl,bullet1
    call draw_bullets

    ld ix,enemy_data
    ld hl,enemy1
    call draw_enemies

    ld ix,enemy_data
    ld a,(b_enemy_spawn_complete)
    cp 0
    call z,spawn_enemy_wave

    jp main

update_bullets:
    ld a,(ix)
    cp 255
    ret z
   ; ld a,(ix)
    cp 0
    jp z,update_bullets_next
    call deletesprites
    ;move 
    ld a,(ix+2)
    cp BULLET_MIN_Y
    call c, kill_bullet
    jp c, update_bullets_next
    sub BULLET_SPEED
    ld (ix+2),a

update_bullets_next:
    ld bc,BULLET_DATA_LENGTH
    add ix,bc
    jp update_bullets

; move_bullets:
;     ld a,(ix)
;     cp 255
;     ret z
;     ;ld a,(ix)
;     cp 0
;     jp z, move_bullets_next
;     ;move_bullets
;     ld a,(ix+2)
;     cp BULLET_MIN_Y
;     call c, kill_bullet
;     jp c, move_bullets_next
;     sub BULLET_SPEED
;     ld (ix+2),a

; move_bullets_next:
;     ld bc,BULLET_DATA_LENGTH
;     add ix,bc
;     jp move_bullets

kill_bullet:
    ld (ix), 0
    ret
    
draw_bullets:
    ld a,(ix)
    cp 255
    ret z
    ;ld a,(ix) ;?
    cp 0
    jp z, draw_bullets_next
    ;if here, bullet alive
    push hl
    call drawsprite
    pop hl

draw_bullets_next:
    ld bc, BULLET_DATA_LENGTH
    add ix,bc
    jp draw_bullets

spawn_bullet:
    ld a,(iy)
    cp 255
    ret z
   ; ld a,(iy)
    cp 1
    jp z, spawn_bullet_next
    ;spawn it
    ld a,1
    ld (iy),a
    ld a,(ix+1)
    ld (iy+1), a
    ld a,(ix+2)
    sub 8
    ld (iy+2),a
    ret

spawn_bullet_next:
    ld bc,BULLET_DATA_LENGTH
    add iy,bc
    jp spawn_bullet

; all enemies 'isAlive' should be set to 0 before calling
spawn_enemy_wave:
    ld a,(ix)
    cp 255
    jp z,end_spawn
    ld (ix),1
    ld bc,ENEMY_DATA_LENGTH
    add ix,bc
    jp spawn_enemy_wave

end_spawn:
    ld a,1
    ld (b_enemy_spawn_complete),a
    ret

update_enemies:
    ld a,(ix)
    cp 255
    ret z
    ;ld a,(ix)
    cp 0
    jp z, update_enemies_next
    call deletesprites
    ;move enemies
    
update_enemies_next:
    ld bc,ENEMY_DATA_LENGTH
    add ix,bc
    jp update_enemies

;move_enemies:


draw_enemies:
    ld a,(ix)
    cp 255
    ret z
    ;ld a,(ix)
    cp 0
    jp z, draw_enemies_next
    push hl
    call drawsprite
    pop hl

draw_enemies_next:
    ld bc,ENEMY_DATA_LENGTH
    add ix,bc
    jp draw_enemies
;VARIABLES

; sprite data format
; isAlive, x, y, sizex (cells), sizey (lines)

;player_data:
;    db 1, (255/2)-8, 180 - 8, 2, 16

player_data:
    db 1,(255/2)-7,180-8,2,16


bullet_data:
    db 0,0,0,1,8
    db 0,0,0,1,8
    db 255
BULLET_DATA_LENGTH equ 5

enemy_data:
    db 0, ((255/5)*0)+8, 48, 2, 8
    db 0, ((255/5)*1)+8, 48, 2, 8
    db 0, ((255/5)*2)+8, 48, 2, 8
    ;db 0, ((255/5)*3)+8, 48, 2, 8
    ;db 0, ((255/5)*4)+8, 48, 2, 8
    db 255

ENEMY_DATA_LENGTH equ 5

PLAYER_WIDTH_PX equ 16
PLAYER_SPEED_X equ 16
SCREEN_WIDTH equ 255

BULLET_SPEED equ 9
BULLET_MIN_Y equ 13
BULLET_INTERVAL equ 16

ENEMY_DEFAULT_Y equ 24
ENEMY_DEFAULT_SPEED equ 4

bullet_timer db 0
b_enemy_spawn_complete db 0




    include 'spritetools.asm'
    include 'screentools.asm'
    include 'audio.asm'
    include 'randomgenerator.asm'
    include "sprites\udgs.asm"
    include 'constants.asm'
    include 'playerclass.asm'

    end ENTRY_POINT