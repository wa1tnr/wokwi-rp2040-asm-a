// Sat  8 Apr 23:11:15 UTC 2023
// https://wokwi.com/projects/361482746894193665

#ifndef NOT_WOKWI
#define HAVE_FOUND_WOKWI_ENVIRONMENT
#warning this is very much wokwi
#endif

#ifdef NOT_WOKWI
#define HAVE_FOUND_NON_WOKWI_ENVIRONMENT
#warning this is not wokwi
#endif

#define PBLINKS 4 // how many blinks?
#include "hardware/gpio.h"

#ifdef HAVE_FOUND_WOKWI_ENVIRONMENT
#warning this is very much wokwi
#include <Arduino.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

void experiment_a_asm(unsigned int *rptr);

#ifdef __cplusplus
}
#endif

#ifdef HAVE_FOUND_WOKWI_ENVIRONMENT
#warning this is setup function header
void setup(void) {
#endif

#ifdef HAVE_FOUND_NON_WOKWI_ENVIRONMENT
#warning this is  not wokwi
void asmword(void) {
#endif
    static volatile int c;
    c = (PBLINKS * 2) + 2;
    unsigned int *rptr = (unsigned int *) &c;
    return experiment_a_asm(rptr);
}

#ifdef HAVE_FOUND_WOKWI_ENVIRONMENT
#warning this is very much wokwi
void loop() {
    while(-1);
}
#endif

// END.