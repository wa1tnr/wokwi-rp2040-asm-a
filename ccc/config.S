@ config.S

@ Sat  8 Apr 23:11:15 UTC 2023
@ https://wokwi.com/projects/361482746894193665  or later

@ not the user interface:
.if (toggle_flash_vs_buzz == 1)
.equ it_buzzes, 0
.equ it_flashes, 1
.endif

.if (toggle_flash_vs_buzz == 0)
.equ it_buzzes, 1
.equ it_flashes, 0
.endif


.if (it_buzzes == 1)
  .equ COUNT               ,  0x00020000
.endif

.if (it_flashes == 1)
  .equ COUNT               ,  0x00f00000
.endif

@ end.
