// project.cpp
// Tue 11 Apr 01:30:35 UTC 2023
// https://wokwi.com/projects/361672464877262849

// theory: a setup() loop() project.cpp will
// bring in the framework (usart support wanted)
// without disturbing the simplicity exhibited
// in cloop.c for exploration of
// Assembly Language programming.

// first step: compile without cloop.c at all
// (renamed cloop_c.md here) and see what's what.

// Result: ran about the same. Did not look at
// sketch.list to see what changed. ;)

// Second: look at sketch.list to find:

// 100032f4:	f7ff ffea 	bl	100032cc <experiment_a_asm>

// This got called with about the same code as before - great!

// Additionally, experiment_a_asm looks about the same.

// Suspect: 'Serial1.begin(9600)' will change the code a lot
// more towards what was seen (earlier) as 'too complex' but
// will try 'now' (10 Apr 15:39 UTC).

// Note: forgot - Serial1 not Serial here ;)


// setup C Preprocessor flags to choose compile environment
#ifndef NOT_WOKWI // default - no '#define NOT_WOKWI found'
#define HAVE_FOUND_WOKWI_ENVIRONMENT
#endif


#ifdef NOT_WOKWI // exception: when not in wokwi this #define must be in place
#define HAVE_FOUND_NON_WOKWI_ENVIRONMENT
#endif


// everywhere:
#include "hardware/gpio.h"


#ifdef HAVE_FOUND_WOKWI_ENVIRONMENT
#include <Arduino.h>  // wokwi gets this - not sure other envs do or not (pio, pico-sdk)
#endif


#ifdef __cplusplus
extern "C" {
#endif

void experiment_a_asm(unsigned int *rptr);

#ifdef __cplusplus
}
#endif


// everywhere:

int maths = -18; // make sure it's wrong to begin

void printMaths() {
    Serial1.print("maths: ");
    Serial1.println(maths);
}

#define PBLINKS 3   // zero 1 2 3 all good

#define EVEN_BLINKS PBLINKS * 2

#define COMPUTED_BLINKS_FACTOR EVEN_BLINKS + 2

#define MULTIPLE_OF_TWO 2 * 0
#define PARITY_TOGGLES MULTIPLE_OF_TWO

void asmword_go(void) {
    static volatile int c;
    c = (COMPUTED_BLINKS_FACTOR) + PARITY_TOGGLES;
    unsigned int *rptr = (unsigned int *) &c;
    return experiment_a_asm(rptr);
}

#ifdef HAVE_FOUND_WOKWI_ENVIRONMENT
void lJust() {
//  To get very first line left-justified:
    Serial1.write('\r');
    Serial1.flush();
}

void signOnMsgs(){
    lJust();
    Serial1.print("asm w cpp: ");
}

void setup(void) {
    Serial1.begin(9600);
    signOnMsgs();
    asmword_go();
}
#endif // #ifdef HAVE_FOUND_WOKWI_ENVIRONMENT


#ifdef HAVE_FOUND_NON_WOKWI_ENVIRONMENT
#warning this is  not wokwi

void asmword(void) {
    asmword_go();
}
#endif


#ifdef HAVE_FOUND_WOKWI_ENVIRONMENT
// #warning this is very much wokwi
void loop() {
    while(-1);
}
#endif

// END.