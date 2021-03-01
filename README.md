Description:
==============
This repository include examples of short assembly programs for Atmega328p (AVR family 8-bit microcontroller which used in Arduino Uno). Examples written using Atmel Studio assembly and concentrated in this repository for knowledge share. It may be usefull for people who want to undersand how AVR microcontrollers works. Using assembly it is good way to undersand the architecture and to controll the microcontroller on low level.

List of examples:
=================
#### 1. 8  bit Timer 0
Pin (Pin 1 Port B) state flipping by timer's (counter) interrupt. Pin voltage flips at counter pattern match and handles by interrupt handler.
#### 2. 16 bit Timer 1
Pin (Pin 1 Port B) state flipping every second by timer's (counter) interrupt. Pin voltage flips at counter pattern match and handles by interrupt handler.  
Counting cycle time: Cycle time = 15625 (OCR1A) * 1024 (Prescaler 1024) / 16000000 (System Clock 16MHz) = 1 second
#### 3. USART TX (transmission)
Transmission of word "hello" by USART.  
(USART configuration: baud rate 9600, single stop bit, disabled parity check, 8 bits for character)
#### 4. USART RX (reception)
Reception of characters by USART and comparison of each received character to expected value. In case there is a match, the program changes the state of the pin.  
(USART configuration: baud rate 9600, single stop bit, disabled parity check, 8 bits for character)
#### 5. USART TX/RX interrupts
Reception of characters by USART and sending it back.  
(USART configuration: baud rate 9600, single stop bit, disabled parity check, 8 bits for character)
#### 6. ADC single sample at request by USART
Controlled sampling of analog pin 0 by USART character reception and sending sample by USART.  
(USART configuration: baud rate 9600, single stop bit, disabled parity check, 8 bits for character)
#### 7. ADC samples flow by USART
Sampling of analog pin 0 in cycle and sending samples by USART.  
(USART configuration: baud rate 1000000, single stop bit, disabled parity check, 8 bits for character)

Arduino firmware burn using avrdude in Linux:
===============================================
General command format:\
```$ sudo avrdude -p <chip_version> -P <device> -c arduino -b 115200 -U flash:w:<hex_image>```

Example (Arduino Uno / Atmaga328p):\
```$ sudo avrdude -p m328p -P /dev/ttyACM0 -c arduino -b 115200 -U flash:w:1_8_bit_timer.hex```

Device check:\
```$ dmesg | grep tty```

Usefull minicom commands for work with USART:
=============================================
Enter minicom settings menu:\
```$ sudo minicom -s```

Run minicom with specific baud rate (also supports baud rates that not available in settings menu):\
```$ sudo minicom -b <boud_rate>```\
Examples of baud rates: 9600, 115200, 500000, 1000000

Display characters in hex format:\
```$ sudo minicom -H```

Store received data to file:\
```$ sudo minicom -C <file_path>```

