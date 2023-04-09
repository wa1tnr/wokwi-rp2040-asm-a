Sat  8 Apr 23:11:15 UTC 2023
https://wokwi.com/projects/361482746894193665

void setup(void) {
    static volatile int c;
    c = (PBLINKS * 2) + 2;
    unsigned int *rptr = (unsigned int *) &c;
    return experiment_a_asm(rptr);
}

10003288 <setup>:
    static volatile int c;
    c = (PBLINKS * 2) + 2;
10003288:	230c      	movs	r3, #12
void setup(void) {
1000328a:	b510      	push	{r4, lr}
    c = (PBLINKS * 2) + 2;
1000328c:	4802      	ldr	r0, [pc, #8]	; (10003298 <setup+0x10>)
1000328e:	6003      	str	r3, [r0, #0]
    unsigned int *rptr = (unsigned int *) &c;
    return experiment_a_asm(rptr);
10003290:	f7ff ffe8 	bl	10003264 <experiment_a_asm>
}
10003294:	bd10      	pop	{r4, pc}
10003296:	46c0      	nop			; (mov r8, r8)
10003298:	20001aa8 	.word	0x20001aa8

1000329c <loop>:


source, asmword.S for experiment_a_asm:
   movs  r1, r0
   ldr   r0, [r1, #0]
   push  {lr}
   push  {r0}
   bl    program_setup
   pop   {r0}
   bl    run_program
   pop   {pc}

10003264 <experiment_a_asm>:
experiment_a_asm:
   movs  r1, r0
10003264:	0001      	movs	r1, r0
   ldr   r0, [r1, #0]
10003266:	6808      	ldr	r0, [r1, #0]
   push  {lr}
10003268:	b500      	push	{lr}
   push  {r0}
1000326a:	b401      	push	{r0}
   bl    program_setup
1000326c:	f7ff ffd0 	bl	10003210 <program_setup>
   pop   {r0}
10003270:	bc01      	pop	{r0}
   bl    run_program
10003272:	f7ff ffe2 	bl	1000323a <run_program>
   pop   {pc}
10003276:	bd00      	pop	{pc}
   ldr    r0, =GPIO_CTRL
10003278:	4001404c 	.word	0x4001404c
   ldr    r0, =SIO_BASE
1000327c:	d0000000 	.word	0xd0000000
   ldr    r0, =1<<LED_ALT_PIN
10003280:	00000200 	.word	0x00000200
   ldr    r3, =COUNT
10003284:	00f00000 	.word	0x00f00000

10003288 <setup>:
#ifdef HAVE_FOUND_NON_WOKWI_ENVIRONMENT
#warning this is  not wokwi






background info follows (more complete disassembly).



Lines 299 to 451, sketch.lst (wokwi):


10003210 <program_setup>:
.equ GPIO_OUT_XOR        , 0x01c @ GPIO output value XOR

#include "config.S"

program_setup:
   push   {r0, lr}
10003210:	b501      	push	{r0, lr}
   ldr    r0, =GPIO_CTRL
10003212:	4816      	ldr	r0, [pc, #88]	; (1000326c <experiment_a_asm+0x10>)
   movs   r1, #5
10003214:	2105      	movs	r1, #5
   str    r1, [r0, 0]
10003216:	6001      	str	r1, [r0, #0]
   movs   r1, #1
10003218:	2101      	movs	r1, #1
   lsls   r1, r1, #LED_ALT_PIN
1000321a:	0249      	lsls	r1, r1, #9
   ldr    r0, =SIO_BASE
1000321c:	4814      	ldr	r0, [pc, #80]	; (10003270 <experiment_a_asm+0x14>)
   str    r1, [r0, #GPIO_OE_SET]
1000321e:	6241      	str	r1, [r0, #36]	; 0x24
   pop    {r0, pc}
10003220:	bd01      	pop	{r0, pc}

10003222 <blinking>:

blinking:
   push   {r0, lr}
10003222:	b501      	push	{r0, lr}

@  push   {r0}

   ldr    r1, =SIO_BASE
10003224:	4912      	ldr	r1, [pc, #72]	; (10003270 <experiment_a_asm+0x14>)
   ldr    r0, =1<<LED_ALT_PIN
10003226:	4813      	ldr	r0, [pc, #76]	; (10003274 <experiment_a_asm+0x18>)
   str    r0, [r1, #GPIO_OUT_XOR]
10003228:	61c8      	str	r0, [r1, #28]
   ldr    r3, =COUNT
1000322a:	4b13      	ldr	r3, [pc, #76]	; (10003278 <experiment_a_asm+0x1c>)
1: subs   r3, #1
1000322c:	3b01      	subs	r3, #1
   bne    1b
1000322e:	d1fd      	bne.n	1000322c <blinking+0xa>

@  pop    {r0}

   pop    {r0, pc}
10003230:	bd01      	pop	{r0, pc}

10003232 <run_program>:

run_program:
   push   {lr}
10003232:	b500      	push	{lr}
   push   {r0}
10003234:	b401      	push	{r0}
   ldr    r1, =SIO_BASE
10003236:	490e      	ldr	r1, [pc, #56]	; (10003270 <experiment_a_asm+0x14>)
   ldr    r0, =1<<LED_ALT_PIN
10003238:	480e      	ldr	r0, [pc, #56]	; (10003274 <experiment_a_asm+0x18>)
   str    r0, [r1, #GPIO_OUT_SET]
1000323a:	6148      	str	r0, [r1, #20]
   pop   {r0}
1000323c:	bc01      	pop	{r0}
   movs   r2, #1
1000323e:	2201      	movs	r2, #1
   movs   r3, #1
10003240:	2301      	movs	r3, #1
2:
   push  {r2}
10003242:	b404      	push	{r2}
   push  {r3}
10003244:	b408      	push	{r3}
   bl    blinking
10003246:	f7ff ffec 	bl	10003222 <blinking>
   pop   {r3}
1000324a:	bc08      	pop	{r3}
   pop   {r2}
1000324c:	bc04      	pop	{r2}
   add    r3, r2  // r3 accumulates the count
1000324e:	4413      	add	r3, r2
   push  {r3}
10003250:	b408      	push	{r3}
   mov    r1, r0
10003252:	4601      	mov	r1, r0
   pop   {r3}
10003254:	bc08      	pop	{r3}
   cmp    r3, r1
10003256:	428b      	cmp	r3, r1
   bne    2b
10003258:	d1f3      	bne.n	10003242 <run_program+0x10>
   pop    {pc}
1000325a:	bd00      	pop	{pc}

1000325c <experiment_a_asm>:

@  --------------------   main   ------------------
experiment_a_asm:
   push  {lr}
1000325c:	b500      	push	{lr}
   ldr   r0, [r0, #0]
1000325e:	6800      	ldr	r0, [r0, #0]
   bl    program_setup
10003260:	f7ff ffd6 	bl	10003210 <program_setup>
   bl    run_program
10003264:	f7ff ffe5 	bl	10003232 <run_program>
   pop   {pc}
10003268:	bd00      	pop	{pc}
1000326a:	0000      	.short	0x0000
   ldr    r0, =GPIO_CTRL
1000326c:	4001404c 	.word	0x4001404c
   ldr    r0, =SIO_BASE
10003270:	d0000000 	.word	0xd0000000
   ldr    r0, =1<<LED_ALT_PIN
10003274:	00000200 	.word	0x00000200
   ldr    r3, =COUNT
10003278:	00f00000 	.word	0x00f00000

1000327c <setup>:
#ifdef HAVE_FOUND_NON_WOKWI_ENVIRONMENT
#warning this is  not wokwi
void asmword(void) {
#endif
    static volatile int c;
    c = (PBLINKS * 2) + 2;
1000327c:	230a      	movs	r3, #10
void setup(void) {
1000327e:	b510      	push	{r4, lr}
    c = (PBLINKS * 2) + 2;
10003280:	4802      	ldr	r0, [pc, #8]	; (1000328c <setup+0x10>)
10003282:	6003      	str	r3, [r0, #0]
    unsigned int *rptr = (unsigned int *) &c;
    return experiment_a_asm(rptr);
10003284:	f7ff ffea 	bl	1000325c <experiment_a_asm>
}
10003288:	bd10      	pop	{r4, pc}
1000328a:	46c0      	nop			; (mov r8, r8)
1000328c:	20001aa8 	.word	0x20001aa8

10003290 <loop>:

#ifdef HAVE_FOUND_WOKWI_ENVIRONMENT
#warning this is very much wokwi
void loop() {
    while(-1);
10003290:	e7fe      	b.n	10003290 <loop>
	...

10003294 <_ZN6RP204015_SystickHandlerEv>:
#endif
    }


END.