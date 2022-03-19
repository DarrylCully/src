; Pseudo-random number generator

;memstep
;steps a pointer through the ROM (held in seed), returning the contents of the byte at that location
;Outputs
; A = random number (1 byte)

random_memstep:
    ld hl,(memstep_seed)
    ld a,h
    and %00011111
    ld h,a
    ld a,(hl)
    inc hl
    ld (memstep_seed),hl
    ret 

memstep_seed dw 0

;true or false random
;output
; A=0 or 1(false/true)
random_memstep_bool:
    ld hl,(memstepbool_seed)
    ld a,h
    and %00011111
    ld h,a
    ld a,(hl)
    and %00000001
    inc hl
    ld (memstepbool_seed),hl
    ret
memstepbool_seed dw 0
