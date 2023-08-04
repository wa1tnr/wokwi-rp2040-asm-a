/* wa1tnr 04 Aug 2023 06:15z */

/* https://arduino.stackexchange.com/questions/23146/make-led-blink-using-avr-assembly */

/* not much taken from it, just 0x04 vs 0x24 for DDRB &c */

.equ DDRB, 0x04 /* 0x24 */
.equ PORTB, 0x05 /* 0x25 */ /* 13.4.2 */

.equ PB5, 0x20
.equ PB4, 0x10

/*
.equ PB4_PB5, 0x20 | 0x10  */  /* experimental - syntax? */

.global start
.global xpMain

output_mode_gpio:
	ldi r17, PB4 /* PB5 seems to get initialized elsewhere */
	out DDRB, r17
	ret

all_leds_OFF:
  ldi r17, 0x00
	out PORTB, r17
	ret

led_13_ON:
  ldi r17, PB5
	out PORTB, r17
	ret

led_D12_PB4_ON:
  ldi r17, PB4
	out PORTB, r17
	ret

start:
  call output_mode_gpio
  call led_13_ON
  call led_D12_PB4_ON
	call bDelay
	ret

xpMain:
  call led_13_ON
	call bDelay
  call all_leds_OFF
	call bDelay

  call led_D12_PB4_ON
	call bDelay
  call all_leds_OFF
	call bDelay
	ret

bDelay:
  call cDelay
	call cDelay
  call cDelay
	call cDelay
	ret

cDelay:
  call dDelay
  call dDelay
  call dDelay
	call dDelay

  call dDelay
  call dDelay
  call dDelay
	call dDelay
	ret

dDelay:
  call eDelay
  call eDelay
  call eDelay
  call eDelay

  call eDelay
  call eDelay
  call eDelay
  call eDelay
  ret

eDelay:
  call uDelay
	call uDelay
  call uDelay
	call uDelay

  call uDelay
	call uDelay
  call uDelay
	call uDelay
  ret

uDelay:
  call vDelay
  call vDelay
  call vDelay
  call vDelay

  call vDelay
  call vDelay
  call vDelay
  call vDelay
	ret

vDelay:
  call wDelay
  call wDelay
  call wDelay
  call wDelay

  call wDelay
  call wDelay
  call wDelay
  call wDelay
	ret

wDelay:
  call xDelay
	call xDelay
  call xDelay
	call xDelay

  call xDelay
	call xDelay
  call xDelay
	call xDelay
	ret

xDelay:

  nop
  nop
  nop
  nop

  nop
  nop
  nop
  nop

	ret

/* end */
