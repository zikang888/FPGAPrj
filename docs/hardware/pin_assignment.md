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

## Reserved for later protocol phases

| Signal | Pin | Standard |
|---|---|---|
| uart_rx | W5 | LVCMOS33 |
| uart_tx | AA9 | LVCMOS33 |
| spi_cs_n | AA8 | LVCMOS33 |
| spi_sclk | AB10 | LVCMOS33 |
| spi_mosi | AB9 | LVCMOS33 |
| spi_miso | AA7 | LVCMOS33 |
| i2c_scl | AA6 | LVCMOS33 |
| i2c_sda | V8 | LVCMOS33 |
| can_tx | W8 | LVCMOS33 |
| can_rx | AA11 | LVCMOS33 |

Reserved pins are intentionally absent from the phase-1 XDC so incomplete logic cannot drive an external bus.
