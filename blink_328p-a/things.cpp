/* wa1tnr 04 Aug 2023 06:15z */

#include <Arduino.h>

#ifdef __cplusplus
extern "C" {
#endif
   void start();
   void xpMain();
#ifdef __cplusplus
}
#endif

void setup_serial(void) {
  Serial.begin(9600);
}

void setup(void) {
  setup_serial();
  Serial.print(" IN setup();\n");
  Serial.print("  start();  ");
  start();
  delay(1000);
  Serial.print("  xpMain();  ");
}

void loop(void) {
  xpMain();
  Serial.write('.');
}

// end.
