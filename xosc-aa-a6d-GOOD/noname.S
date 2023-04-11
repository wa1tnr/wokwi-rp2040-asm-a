@ noname.S
@ Tue 11 Apr 01:30:35 UTC 2023
@ https://wokwi.com/projects/361672464877262849

.syntax unified
.cpu    cortex-m0plus
.thumb

@ .global experiment_a_asm
.align 4

.equ  FULL_BLINKS_WANTED,  2
.equ  BLINK_MULTIPLIER,    2
.equ  ITERATIONS,  FULL_BLINKS_WANTED * BLINK_MULTIPLIER
.equ  HALF_BLINKS_WANTED,  1

@ https://wokwi.com/projects/361582600132446209

gpio_dir:
   push   {lr}
   push   {r0}
   movs   r3, #1
   movs   r2, #208      @ 0xd0
   lsls   r3, r0
   lsls   r2, r2, #24
@  movs   r1, #0        @ kludge to satisfy the compare
   cmp    r1, #0
   beq    1f
   str    r3, [r2, #36] @ 0x24
   ldr    r3, [pc, #28]
   lsls   r0, r0, #2
   mov    ip, r3
   movs   r3, #0
   add    r0, ip
   str    r3, [r0, #4]
2: bx     lr
1: str    r3, [r2, #40] @ 0x28
   ldr    r3, [pc, #12]
   lsls   r0, r0, #2
   mov    ip, r3
   movs   r3, #192      @ 0xc0
   add    r0, ip
   str    r3, [r0, #4]
   b 2b
   nop
@  andmi  ip, r1, r0
   pop    {r0}
   pop    {pc}

@ -------------- unformatted code fixme -----
half_blink:
   push   {lr}
   movs   r1, #1
   add    r0, r1
   pop    {pc}

half_blinks:
   push   {lr}
   movs   r2, #0
   cmp    r2, #HALF_BLINKS_WANTED
   beq    1f
   movs   r3, #1 
   movs   r2, #0
2: nop
   bl     half_blink
   add    r2, r3  @ increment by one
   cmp    r2, #HALF_BLINKS_WANTED
   bne    2b
1: nop
   pop    {pc}

full_blinks:
   push   {lr}
   movs   r2, #0
   cmp    r2, #ITERATIONS  @ very late change untested untested unt..
   beq    7f
   movs   r3, #1
   movs   r2, #0
8: nop
   push   {r2, r3}
   bl     half_blinks
   pop    {r2, r3}
   add    r2, r3  @ increment by one
   cmp    r2, #ITERATIONS
   bne    8b
7: nop
   pop    {pc}

add_some_blinks:
   push   {lr}
@  bl     half_blinks
   bl     full_blinks
   pop    {pc}

@ end.