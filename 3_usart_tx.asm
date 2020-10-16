;.CSEG
	; RESET
	.org 0x0000
	jmp RESET

RESET:
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

	; Transmite word "hello" + "new line"
	; Register r17 used for character code storage
	ldi r17, 0x48
	call TRANSMIT_FUNC
	ldi r17, 0x65
	call TRANSMIT_FUNC
	ldi r17, 0x6c
	call TRANSMIT_FUNC
	ldi r17, 0x6c
	call TRANSMIT_FUNC
	ldi r17, 0x6f
	call TRANSMIT_FUNC
	ldi r17, 0x0a
	call TRANSMIT_FUNC
	
	; Wait for TX complete
CHECK_TX_COMPLETE:
	; Bit 6 of register UCSR0A is 1 in case that transmition complete
	lds r16, UCSR0A
	sbrs r16, 6
	rjmp CHECK_TX_COMPLETE
	ret

TRANSMIT_FUNC:
	; Not neccesary storage of r16 to stack
	push r16
TRANSMIT:
	; Check if buffer available to use (not full) (Bit 5 of register UCSR0A is 1 in case that buffer not full).
	ldi r16, 0
	lds r16, UCSR0A
	sbrs r16, 5
	rjmp TRANSMIT
	; Send character by pushing character code from r17 to UDR0 register
	sts UDR0, r17
	; Pop saved value of r16 from stack
	pop r16
	ret
