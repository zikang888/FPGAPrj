#ifndef MC_OLED_H
#define MC_OLED_H

#include <stdint.h>

/* SSD1306 128x64, 7-pin 4-wire SPI: PB12=CS, PB13=SCLK, PB15=DIN,
   PC4=D/C, PC5=RES. Connect VCC to the module's rated supply and share GND. */
void mc_oled_init(void);
void mc_oled_clear(void);
void mc_oled_text(uint8_t col, uint8_t row, const char *text);
void mc_oled_flush(void);

#endif
