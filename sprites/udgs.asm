;Sprites include file

udg1 
    db %11111111
    db %11010111
    db %11000111
    db %11000011
    db %11111111
    db %10111001
    db %11100111
    db %11000011
;
    db %11111111
    db %10000000
    db %01000100
    db %01101100
    db %00000000
    db %01000100
    db %01111100
    db %11111111
; 3
    db %00010000
    db %00111000
    db %10111010
    db %11101110
    db %01111100
    db %00111000
    db %01111100
    db %00111000

bullet: 
    db %000010000
    db %000111000
    db %0001111100
    db %0001111100
    db %0001111100
    db %0000111000
    db %0000111000
    db %001100110

bullet1: 
    db %00011000
    db %00011000
    db %00011000
    db %00011000
    db %00011000
    db %00011000
    db %00011000
    db %00011000


bitmap1:
    db %11111111, %11111111
    db %11111111, %11111111
    db %11111111, %11111111
    db %11010111, %00011111
    db %11111111, %11111111
    db %11111111, %10101010
    db %11111111, %11111111
    db %11010111, %00000000
;
    db %11111111, %11111111
    db %11000111, %01111100
    db %11111111, %11111111
    db %11111111, %01111100
    db %11111111, %11111111
    db %11111111, %00000000
    db %11111111, %11111111
    db %11000111, %00000000

ship:
    db %00000001, %10000000
    db %00000010, %01000000
    db %00000010, %01000000
    db %00000010, %01000000
    db %00000010, %01000000
    db %01000100, %00100010
    db %01001011, %11010010
    db %11110001, %10001111
    db %10000000, %00000001
    db %10000000, %00000001
    db %01010000, %00001010
    db %00100101, %10100100
    db %00011000, %00011000
    db %00000101, %10100000
    db %00000010, %01000000
    db %00000001, %10000000

enemy1:
    db %00111001, %10011100
    db %00000010, %01000000
    db %00000010, %01000000
    db %00000010, %01000000
    db %00000010, %01000000
    db %01000100, %00100010
    db %01001011, %11010010
    db %11110001, %10001111
