;.CSEG
	; RESET
	.org 0x0000
	jmp RESET
	; USART_RX
	.org 0x0024
	jmp USART_RX_INT
	; USART_TX
	.org 0x0028
	jmp USART_TX_INT

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

	; Enable RX Complete and TX Complete Interrupts + enable RX and TX (TX Enable (TXEN0) - Bit 3, RX Enable (RXEN0) - Bit 4 | TX Complete Interrupt Enable - Bit 6, RX Complete Interrupt Enable - Bit 7)
	ldi r16, 0b11011000
	sts UCSR0B, r16

	; Global Enable Interrupts
	sei

LOOP:
	nop
	jmp LOOP

USART_RX_INT:
	; Get received data and send it back
	ldi r16, 0
	lds r16, UDR0
	sts UDR0, r16
	reti

USART_TX_INT:
	reti
