;.CSEG
	; RESET
	.org 0x0000
	jmp RESET
	; TIMER0_COMPA
	.org 0x001c
	jmp TIMER0_COMPA
	; TIMER0_COMPB
	.org 0x001e
	jmp TIMER0_COMPB
	; TIMER0_OVF
	.org 0x0020
	jmp TIMER0_OVF

RESET:
	; Set i/o pins
	ldi r16, 0xff
	out DDRB, r16
	ldi r16, 0x2
	out PORTB, r16

	; Timer Configuration
	; Set WGM01 (bit 1) to 1, WGM00 (bit 0) to 0 - Timer 0 Mode 2 (CTC - Count to value stored in OCR0A)
	ldi r16, 0b00000010
    	out TCCR0A, r16

	; Set CS01 (bit 2) to 1, CS01 (bit 1) to 0, and CS00 (bit 0) to 1 - Set clock with prescale 1024
	ldi r16, 0b00000101
	out TCCR0B, r16

	; Set OCR0A counter stop value (number of clocks - 1) to 255
	ldi r16, 0xff
	out OCR0A, r16

	; Set TCNT0 counter start value to 0
	ldi r16, 0
	sts TCNT0, r16

	; Set TIMSK0 trigger interrupt when TCNT0 >= OCR0A
	ldi r16, 0b00000010
	sts TIMSK0, r16

	; Clear interrupt flags in register TIFR0
	ldi r16, 0
	sts TIFR0, r16

	; Global Enable Interrupts
	sei

	; Initialization of register r16 with 1. This register used to store current value of Pin 1 of PORTB.
	ldi r16, 0x1

LOOP:
	nop
    rjmp loop

TIMER0_COMPA:
	; Clear counter
	ldi r17, 0b00000000
	sts TCNT0, r17
	; Flip Pin 1 of PORTB
	ldi r18, 0x1
	eor r16, r18
	out PORTB, r16
	reti

TIMER0_COMPB:
	reti

TIMER0_OVF:
	reti
