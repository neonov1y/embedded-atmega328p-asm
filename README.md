Description:
==============
This repository include examples of assembly programs for Atmega328p (AVR family 8-bit microcontroller which used in Arduino Uno). Examples written using Atmel Studio assembly.

List of examples:
=================
* 1. 8  bit Timer 0:
Flipping pin (Pin 1 Port B) by timer at pattern matching and handling by interrupt handler.
* 2. 16 bit Timer 1:
Flipping pin (Pin 1 Port B) every second by timer at pattern matching and handling by interrupt handler. 
(Counting cycle time = 15625 (OCR1A) * 1024 (Prescaler 1024) / 16000000 (System Clock 16MHz) = 1 second)
* 3. USART TX (transmission):
Transmission of word "hello" by USART. 
(USART configuration: boud rate 9600, single stop bit, disabled parity check, 8 bits for character)
* 4. USART RX (reception):
Reception of characters by USART and comparation of received character to expected value. In case of match change pins status.
(USART configuration: boud rate 9600, single stop bit, disabled parity check, 8 bits for character)
* 5. USART interrupts:		Reception of characters by USART and sending it back.
(USART configuration: boud rate 9600, single stop bit, disabled parity check, 8 bits for character)
* 6. ADC single sample:		Sampling of analog pin 0 at USART character reception and sample value sanding bu USART.
(USART configuration: boud rate 9600, single stop bit, disabled parity check, 8 bits for character)
* 7. ADC samples flow:		Sampling of analog pin 0 in cycle and sending sample values by USART.
(USART configuration: boud rate 1000000, single stop bit, disabled parity check, 8 bits for character)

Arduino firmware burn using avrdude in Linux:
===============================================
* General command format:
sudo avrdude -p <chip_version> -P <device> -c arduino -b 115200 -U flash:w:<hex_image>

* Example (Arduino Uno / Atmaga328p):
sudo avrdude -p m328p -P /dev/ttyACM0 -c arduino -b 115200 -U flash:w:1_8_bit_timer.hex

* Device check:
dmesg | grep tty

Usefull minicom commands for work with USART:
=============================================
* Enter minicom setting menu:
```$ sudo minicom -s```

* Run minicom with specific boud rate (also supports boud rates that not available in settings menu):
```$ sudo minicom -b <boud_rate>```
Examples of boud rates: 9600, 115200, 500000

* Display characters in hex format:
```$ sudo minicom -H```

* Store received data to file:
```$ sudo minicom -C <file_path>```

