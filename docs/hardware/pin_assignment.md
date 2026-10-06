# Pin Assignment — Platform Phase

## Active in phase 1

LCD and touch pins are inherited from `ac820_rgbtft.xdc` and the validated PS7 configuration.

| Signal | Pin | Standard | Notes |
|---|---|---|---|
| led_heartbeat | P20 | LVCMOS33 | hardware heartbeat |
| led_ps_active | P21 (D1) | LVCMOS33 | AXI LED_CTRL bit0 |
| TP_RST | R15 | LVCMOS33 | PS EMIO GPIO[0] |
| TP_INT | MIO0 | PS MIO | GT911 interrupt/address select |
| GT911 I2C | MIO50/51 | PS MIO | PS I2C0 |
| UART1 | MIO48/49 | PS MIO | debug console |
| SPI_CS_N / P7-2 | U11 | LVCMOS33 | frozen passive input, pull-up |
| SPI_SCLK / P7-1 | U12 | LVCMOS33 | frozen passive input |
| SPI_MOSI / P7-3 | U10 | LVCMOS33 | frozen passive input |
| SPI_MISO / P7-4 | U9 | LVCMOS33 | frozen passive input |

The SPI assignment above is the frozen NumberA second-week map. The older
AA8/AB10/AB9/AA7 map belongs only to the retired C-only candidate and must not
be used with the current BIT.

## Reserved for later protocol phases

| Signal | Pin | Standard |
|---|---|---|
| uart_rx | W5 | LVCMOS33 |
| uart_tx | AA9 | LVCMOS33 |
| i2c_scl | AA6 | LVCMOS33 |
| i2c_sda | V8 | LVCMOS33 |
| can_tx | W8 | LVCMOS33 |
| can_rx | AA11 | LVCMOS33 |

Reserved pins are intentionally absent from the phase-1 XDC so incomplete logic cannot drive an external bus.
