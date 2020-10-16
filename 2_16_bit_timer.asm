;.CSEG
	; RESET
	.org 0x0000
	jmp RESET
	; TIMER0_COMPA
	.org 0x0016
	jmp TIMER1_COMPA
	; TIMER0_COMPB
	.org 0x0018
	jmp TIMER1_COMPB
	; TIMER0_OVF
	.org 0x001A
	jmp TIMER1_OVF

RESET:
	; Set i/o pins
	ldi r16, 0xff
	out DDRB, r16
	ldi r16, 0x2
	out PORTB, r16

	; Timer Configuration
	; Set WGM10 (bit 0) to 0, WGM11 (bit 1) to 0 - Timer 1 Mode 4 (CTC - Count to value stored in OCR1A)
	ldi r16, 0b00000000
    	sts TCCR1A, r16

	; Set CS12 (bit 2) to 1, CS11 (bit 1) to 0, CS10 (bit 0) to 1 - Set clock with prescale 1024
	; Set WGM12 (bit 3) to 1 - Timer 1 Mode 4 (CTC)
	ldi r16, 0b00001101	
	sts TCCR1B, r16

	; Set counter stop value (number of clocks - 1) to 15625 (0x3d09 - 3d - high, 09 - low)
	; Important to store first to register with high value and after that to register with low value.
	ldi r16, 0x3d
	sts OCR1AH, r16	; OCR1AH
	ldi r16, 0x09
	sts OCR1AL, r16	; OCR1AL

	; Set TCNT1H/L counter start value to 0
	; Important to store first to register with high value and after that to register with low value.
	ldi r16, 0x00
	sts TCNT1H, r16
	sts TCNT1L, r16

	; Set TIMSK1 trigger interrupt when TCNT1 >= OCR1A
	ldi r16, 0b00000010
	sts TIMSK1, r16

	; Clear interrupt flags
	ldi r16, 0
	sts TIFR1, r16

	; Global Enable Interrupts
	sei

	; Initialization of register r16 with 1. This register used to store current value of Pin 1 of PORTB.
	ldi r16, 0x1

LOOP:
	nop
    rjmp loop

TIMER1_COMPA:
	; Clear counter
	ldi r17, 0x00
	sts TCNT1H, r17
	sts TCNT1L, r17
	; Set PORTB output 0x1
	ldi r18, 0x1
	eor r16, r18
	out PORTB, r16
	reti

TIMER1_COMPB:
	reti

TIMER1_OVF:
	reti
