recent_sketch_list.md

Tue 11 Apr 01:30:35 UTC 2023
https://wokwi.com/projects/361672464877262849


scroll down to L297































































































































































































































































































@ L297-361: =========================================================

1000320c:	1000f9d8 	.word	0x1000f9d8

10003210 <gpio_dir>:
.equ  HALF_BLINKS_WANTED,  1

@ https://wokwi.com/projects/361582600132446209

gpio_dir:
   push   {lr}
10003210:	b500      	push	{lr}
   push   {r0}
10003212:	b401      	push	{r0}
   movs   r3, #1
10003214:	2301      	movs	r3, #1
   movs   r2, #208      @ 0xd0
10003216:	22d0      	movs	r2, #208	; 0xd0
   lsls   r3, r0
10003218:	4083      	lsls	r3, r0
   lsls   r2, r2, #24
1000321a:	0612      	lsls	r2, r2, #24
@  movs   r1, #0        @ kludge to satisfy the compare
   cmp    r1, #0
1000321c:	2900      	cmp	r1, #0
   beq    1f
1000321e:	d007      	beq.n	10003230 <gpio_dir+0x20>
   str    r3, [r2, #36] @ 0x24
10003220:	6253      	str	r3, [r2, #36]	; 0x24
   ldr    r3, [pc, #28]
10003222:	4b07      	ldr	r3, [pc, #28]	; (10003240 <gpio_dir+0x30>)
   lsls   r0, r0, #2
10003224:	0080      	lsls	r0, r0, #2
   mov    ip, r3
10003226:	469c      	mov	ip, r3
   movs   r3, #0
10003228:	2300      	movs	r3, #0
   add    r0, ip
1000322a:	4460      	add	r0, ip
   str    r3, [r0, #4]
1000322c:	6043      	str	r3, [r0, #4]
2: bx     lr
1000322e:	4770      	bx	lr
1: str    r3, [r2, #40] @ 0x28
10003230:	6293      	str	r3, [r2, #40]	; 0x28
   ldr    r3, [pc, #12]
10003232:	4b03      	ldr	r3, [pc, #12]	; (10003240 <gpio_dir+0x30>)
   lsls   r0, r0, #2
10003234:	0080      	lsls	r0, r0, #2
   mov    ip, r3
10003236:	469c      	mov	ip, r3
   movs   r3, #192      @ 0xc0
10003238:	23c0      	movs	r3, #192	; 0xc0
   add    r0, ip
1000323a:	4460      	add	r0, ip
   str    r3, [r0, #4]
1000323c:	6043      	str	r3, [r0, #4]
   b 2b
1000323e:	e7f6      	b.n	1000322e <gpio_dir+0x1e>
   nop
10003240:	46c0      	nop			; (mov r8, r8)
@  andmi  ip, r1, r0
   pop    {r0}
10003242:	bc01      	pop	{r0}
   pop    {pc}
10003244:	bd00      	pop	{pc}
@ L362-507: =========================================================
10003246 <half_blink>:

@ -------------- unformatted code fixme -----
half_blink:
   push   {lr}
10003246:	b500      	push	{lr}
   movs   r1, #1
10003248:	2101      	movs	r1, #1
   add    r0, r1
1000324a:	4408      	add	r0, r1
   pop    {pc}
1000324c:	bd00      	pop	{pc}

1000324e <half_blinks>:

half_blinks:
   push   {lr}
1000324e:	b500      	push	{lr}
   movs   r2, #0
10003250:	2200      	movs	r2, #0
   cmp    r2, #HALF_BLINKS_WANTED
10003252:	2a01      	cmp	r2, #1
   beq    1f
10003254:	d007      	beq.n	10003266 <half_blinks+0x18>
   movs   r3, #1 
10003256:	2301      	movs	r3, #1
   movs   r2, #0
10003258:	2200      	movs	r2, #0
2: nop
1000325a:	46c0      	nop			; (mov r8, r8)
   bl     half_blink
1000325c:	f7ff fff3 	bl	10003246 <half_blink>
   add    r2, r3  @ increment by one
10003260:	441a      	add	r2, r3
   cmp    r2, #HALF_BLINKS_WANTED
10003262:	2a01      	cmp	r2, #1
   bne    2b
10003264:	d1f9      	bne.n	1000325a <half_blinks+0xc>
1: nop
10003266:	46c0      	nop			; (mov r8, r8)
   pop    {pc}
10003268:	bd00      	pop	{pc}

1000326a <full_blinks>:

full_blinks:
   push   {lr}
1000326a:	b500      	push	{lr}
   movs   r2, #0
1000326c:	2200      	movs	r2, #0
   cmp    r2, #ITERATIONS  @ very late change untested untested unt..
1000326e:	2a04      	cmp	r2, #4
   beq    7f
10003270:	d009      	beq.n	10003286 <full_blinks+0x1c>
   movs   r3, #1
10003272:	2301      	movs	r3, #1
   movs   r2, #0
10003274:	2200      	movs	r2, #0
8: nop
10003276:	46c0      	nop			; (mov r8, r8)
   push   {r2, r3}
10003278:	b40c      	push	{r2, r3}
   bl     half_blinks
1000327a:	f7ff ffe8 	bl	1000324e <half_blinks>
   pop    {r2, r3}
1000327e:	bc0c      	pop	{r2, r3}
   add    r2, r3  @ increment by one
10003280:	441a      	add	r2, r3
   cmp    r2, #ITERATIONS
10003282:	2a04      	cmp	r2, #4
   bne    8b
10003284:	d1f7      	bne.n	10003276 <full_blinks+0xc>
7: nop
10003286:	46c0      	nop			; (mov r8, r8)
   pop    {pc}
10003288:	bd00      	pop	{pc}

1000328a <add_some_blinks>:

add_some_blinks:
   push   {lr}
1000328a:	b500      	push	{lr}
@  bl     half_blinks
   bl     full_blinks
1000328c:	f7ff ffed 	bl	1000326a <full_blinks>
   pop    {pc}
10003290:	bd00      	pop	{pc}

10003292 <program_setup>:

#include "config.S"
#include "noname.S"

program_setup:
   push   {r0, lr} @ new: was r0, lr
10003292:	b501      	push	{r0, lr}
   bl     xosc_init
10003294:	f002 fb24 	bl	100058e0 <xosc_init>
   movs   r0, #0
10003298:	2000      	movs	r0, #0
   bl     uart_init
1000329a:	f002 fcb7 	bl	10005c0c <uart_init>
   movs   r1, #2
1000329e:	2102      	movs	r1, #2
   movs   r0, #0
100032a0:	2000      	movs	r0, #0
   bl     gpio_init
100032a2:	f001 fb8f 	bl	100049c4 <gpio_init>
   movs   r1, #2
100032a6:	2102      	movs	r1, #2
   movs   r0, #1
100032a8:	2001      	movs	r0, #1
   bl     gpio_init
100032aa:	f001 fb8b 	bl	100049c4 <gpio_init>
   movs   r1, #1
100032ae:	2101      	movs	r1, #1
   movs   r0, #0
100032b0:	2000      	movs	r0, #0
   bl     gpio_dir
100032b2:	f7ff ffad 	bl	10003210 <gpio_dir>
   pop    {r0}
100032b6:	bc01      	pop	{r0}

   @ okay to comment this out:
   bl     add_some_blinks
100032b8:	f7ff ffe7 	bl	1000328a <add_some_blinks>

   push   {r0}
100032bc:	b401      	push	{r0}
   ldr    r0, =GPIO_CTRL
100032be:	4816      	ldr	r0, [pc, #88]	; (10003318 <experiment_a_asm+0x10>)
   movs   r1, #5
100032c0:	2105      	movs	r1, #5
   str    r1, [r0, 0]
100032c2:	6001      	str	r1, [r0, #0]
   movs   r1, #1
100032c4:	2101      	movs	r1, #1
   lsls   r1, r1, #LED_ALT_PIN
100032c6:	0249      	lsls	r1, r1, #9
   ldr    r0, =SIO_BASE
100032c8:	4814      	ldr	r0, [pc, #80]	; (1000331c <experiment_a_asm+0x14>)
   str    r1, [r0, #GPIO_OE_SET]
100032ca:	6241      	str	r1, [r0, #36]	; 0x24
   pop    {r0, pc}
100032cc:	bd01      	pop	{r0, pc}
@ L508-597: =========================================================
100032ce <blinking>:

blinking:
   push   {r0, lr}
100032ce:	b501      	push	{r0, lr}
   ldr    r1, =SIO_BASE
100032d0:	4912      	ldr	r1, [pc, #72]	; (1000331c <experiment_a_asm+0x14>)
   ldr    r0, =1<<LED_ALT_PIN
100032d2:	4813      	ldr	r0, [pc, #76]	; (10003320 <experiment_a_asm+0x18>)
   str    r0, [r1, #GPIO_OUT_XOR]
100032d4:	61c8      	str	r0, [r1, #28]
   ldr    r3, =COUNT
100032d6:	4b13      	ldr	r3, [pc, #76]	; (10003324 <experiment_a_asm+0x1c>)
1: subs   r3, #1
100032d8:	3b01      	subs	r3, #1
   bne    1b
100032da:	d1fd      	bne.n	100032d8 <blinking+0xa>
   pop    {r0, pc}
100032dc:	bd01      	pop	{r0, pc}

100032de <run_program>:

run_program:
   push   {lr}
100032de:	b500      	push	{lr}
   push   {r0}
100032e0:	b401      	push	{r0}
   ldr    r1, =SIO_BASE
100032e2:	490e      	ldr	r1, [pc, #56]	; (1000331c <experiment_a_asm+0x14>)
   ldr    r0, =1<<LED_ALT_PIN
100032e4:	480e      	ldr	r0, [pc, #56]	; (10003320 <experiment_a_asm+0x18>)
   str    r0, [r1, #GPIO_OUT_SET]
100032e6:	6148      	str	r0, [r1, #20]
   pop   {r0}
100032e8:	bc01      	pop	{r0}
   movs   r2, #1
100032ea:	2201      	movs	r2, #1
   movs   r3, #1
100032ec:	2301      	movs	r3, #1
2:
   push  {r2}
100032ee:	b404      	push	{r2}
   push  {r3}
100032f0:	b408      	push	{r3}
   bl    blinking
100032f2:	f7ff ffec 	bl	100032ce <blinking>
   pop   {r3}
100032f6:	bc08      	pop	{r3}
   pop   {r2}
100032f8:	bc04      	pop	{r2}
   add    r3, r2  // r3 accumulates the count
100032fa:	4413      	add	r3, r2
   push  {r3}
100032fc:	b408      	push	{r3}
   mov    r1, r0
100032fe:	4601      	mov	r1, r0
   pop   {r3}
10003300:	bc08      	pop	{r3}
   cmp    r3, r1
10003302:	428b      	cmp	r3, r1
   bne    2b
10003304:	d1f3      	bne.n	100032ee <run_program+0x10>
   pop    {pc}
10003306:	bd00      	pop	{pc}

10003308 <experiment_a_asm>:

@  --------------------   main   ------------------
experiment_a_asm:
   push  {lr}
10003308:	b500      	push	{lr}
   ldr   r0, [r0, #0]
1000330a:	6800      	ldr	r0, [r0, #0]
   bl    program_setup
1000330c:	f7ff ffc1 	bl	10003292 <program_setup>
   bl    run_program
10003310:	f7ff ffe5 	bl	100032de <run_program>
   pop   {pc}
10003314:	bd00      	pop	{pc}
10003316:	0000      	.short	0x0000
   ldr    r0, =GPIO_CTRL
10003318:	4001404c 	.word	0x4001404c
   ldr    r0, =SIO_BASE
1000331c:	d0000000 	.word	0xd0000000
   ldr    r0, =1<<LED_ALT_PIN
10003320:	00000200 	.word	0x00000200
   ldr    r3, =COUNT
10003324:	00f00000 	.word	0x00f00000

10003328 <_Z10asmword_gov>:

=======================================================================

END.