;.CSEG
	; RESET
	.org 0x0000
	jmp RESET

RESET:
	; Set i/o pins - Set pins of Port B to output + set pin 2 to high.
	ldi r16, 0xff
	out DDRB, r16
	ldi r16, 0x2
	out PORTB, r16

	; USART Configuration
	; Configure UBRR0H/L - baudrate value (UBRR0L - All 8 bits | UBRR0H - bit 0,1,2,3)
	; 1	- 500000 bps
	; 8	- 115200 bps
	; 103	- 9600 bps
	ldi r16, 0
    	sts UBRR0H, r16
	ldi r16, 103
    	sts UBRR0L, r16

	; Configure UCSR0C - frame format (Character Size - Bits 1,2 | Stop Bit - Bit 3 | Parity Mode - Bits 4,5 | USART Mode Select - Bits 6,7)
	; Character Size: 11 - 8 bits for character
	; Stop Bit: 0 - 1 stop bits
	; Parity Mode: 00 - Disabled
	ldi r16, 0b00000110
	sts UCSR0C, r16

	; Enable RX and TX (TXEN0 - Bit 3, RXEN0 - Bit 4)
	ldi r16, 0b00011000
	sts UCSR0B, r16

LOOP:
	; Wait for received data, compare it to 0x61 (character "a"), in case that received character "a" set pin 1 of Port B to high. Otherwise wait for next character.
	call RECEIVE_FUNC
	ldi r18, 0x61
	cp r17, r18
	breq SET_LED
	jmp LOOP

SET_LED:
	ldi r16, 0x1
	out PORTB, r16
	jmp LOOP

RECEIVE_FUNC:
	; Not neccesary storage of r16 to stack
	push r16
RECEIVE:
	; Check if some data received. Otherwise wait.
	ldi r16, 0
	lds r16, UCSR0A
	sbrs r16, 7
	rjmp RECEIVE
	; Load received character to r17
	lds r17, UDR0
	; Pop saved value of r16 from stack
	pop r16
	ret
