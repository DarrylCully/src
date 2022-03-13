ENTRY_POINT equ 32768 ; start of empty memory

	org ENTRY_POINT

	ld a, 2
	call 5633 ;0x1601 ; opens channel specified in A

loop:
	ld de, hellostring ; DE = a reference to hellostring memory location/address (ie. NOT the data itself)
	ld bc, endof_hellostring-hellostring ; BC = difference in bytes between and endof string
	call 8252 ; 0xdaf ; built in rom routine which prints string: takes input de = string data (pointer) / bc =  length of string in bytes

	jp loop ; jump back to loop label


hellostring 
	db 'Hello Cunts!', 0xd, 'Hello world! I hate this kind of programming'
	db 'I hate programming', 0xd, 'why do i have to suffer'
endof_hellostring 	equ $

    end ENTRY_POINT

