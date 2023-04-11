@ asmword.S
@ Tue 11 Apr 01:30:35 UTC 2023
@ https://wokwi.com/projects/361672464877262849

@ - - - - -   architecture flags   - - - - -

.syntax unified
.cpu    cortex-m0plus
.thumb

.global experiment_a_asm
.align 4


@ - - - - -   program constants   - - - - -

#ifndef NOT_WOKWI
#define HAVE_FOUND_WOKWI_ASM_ENVIRONMENT
#endif

#ifdef NOT_WOKWI
#define HAVE_FOUND_NON_WOKWI_ASM_ENVIRONMENT
#endif

#ifdef HAVE_FOUND_WOKWI_ASM_ENVIRONMENT
.equ LED_ALT_PIN         , 9 @ 25 @ 9
#endif

#ifdef HAVE_FOUND_NON_WOKWI_ASM_ENVIRONMENT
.equ LED_ALT_PIN         , 25 @ 9
#endif

.equ BLINKS              , 3 + 1
.equ BLINK_TOGGLES       , BLINKS * 2

@  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
@  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
@  -  -  -  -  -  -     configure me   -  -  -  -  -  -  -  -

        .equ toggle_flash_vs_buzz, 1 @ or 0 to buzz

@  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
@  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
@  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -


@ - - - - -   pico-sdk constants   - - - - -
.equ SIO_BASE            , 0xd0000000
.equ IO_BANK0_BASE       , 0x40014000
.equ GPIO_CTRL           , IO_BANK0_BASE + 8 *  LED_ALT_PIN + 4

.equ GPIO_OE_SET         , 0x024 @ GPIO output enable set
.equ GPIO_OUT_SET        , 0x014 @ GPIO output value set
.equ GPIO_OUT_XOR        , 0x01c @ GPIO output value XOR

#include "config.S"
#include "noname.S"

program_setup:
   push   {r0, lr} @ new: was r0, lr
   bl     xosc_init
   movs   r0, #0
   bl     uart_init
   movs   r1, #2
   movs   r0, #0
   bl     gpio_init
   movs   r1, #2
   movs   r0, #1
   bl     gpio_init
   movs   r1, #1
   movs   r0, #0
   bl     gpio_dir
   pop    {r0}

   @ okay to comment this out:
   bl     add_some_blinks

   push   {r0}
   ldr    r0, =GPIO_CTRL
   movs   r1, #5
   str    r1, [r0, 0]
   movs   r1, #1
   lsls   r1, r1, #LED_ALT_PIN
   ldr    r0, =SIO_BASE
   str    r1, [r0, #GPIO_OE_SET]
   pop    {r0, pc}

blinking:
   push   {r0, lr}
   ldr    r1, =SIO_BASE
   ldr    r0, =1<<LED_ALT_PIN
   str    r0, [r1, #GPIO_OUT_XOR]
   ldr    r3, =COUNT
1: subs   r3, #1
   bne    1b
   pop    {r0, pc}

run_program:
   push   {lr}
   push   {r0}
   ldr    r1, =SIO_BASE
   ldr    r0, =1<<LED_ALT_PIN
   str    r0, [r1, #GPIO_OUT_SET]
   pop   {r0}
   movs   r2, #1
   movs   r3, #1
2:
   push  {r2}
   push  {r3}
   bl    blinking
   pop   {r3}
   pop   {r2}
   add    r3, r2  // r3 accumulates the count
   push  {r3}
   mov    r1, r0
   pop   {r3}
   cmp    r3, r1
   bne    2b
   pop    {pc}

@  --------------------   main   ------------------
experiment_a_asm:
   push  {lr}
   ldr   r0, [r0, #0]
   bl    program_setup
   bl    run_program
   pop   {pc}

@ Set data alignment
.data
    .align 4

@ end.