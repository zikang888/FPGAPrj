# ACZ702 platform status LEDs.
# D0 = P20, D1 = P21. P15 is not a board LED on this carrier.
set_property -dict {PACKAGE_PIN P20 IOSTANDARD LVCMOS33} [get_ports led_heartbeat]
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS33} [get_ports led_ps_active]

# Status LEDs are asynchronous observability outputs, not timed interfaces.
set_false_path -to [get_ports led_heartbeat]
set_false_path -to [get_ports led_ps_active]

# Passive SPI Mode-0 monitor inputs on A's P7 wiring plan. The FPGA only
# observes the STM32-to-flash bus and does not drive any SPI line.
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33 PULLUP true} [get_ports SPI_CS_N]
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports SPI_SCLK]
set_property -dict {PACKAGE_PIN U10 IOSTANDARD LVCMOS33} [get_ports SPI_MOSI]
set_property -dict {PACKAGE_PIN U9  IOSTANDARD LVCMOS33} [get_ports SPI_MISO]

# All four pins enter two-stage synchronizers in spi_mode0_monitor.
set_false_path -from [get_ports {SPI_CS_N SPI_SCLK SPI_MOSI SPI_MISO}]

# Passive UART monitor, 115200 baud, 8N1. W5 receives STM32 TX. AA9 is the
# reserved FPGA TX pin and stays at the UART idle level; PL sends no frames.
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33 PULLUP true} [get_ports UART_RX]
set_property -dict {PACKAGE_PIN AA9 IOSTANDARD LVCMOS33} [get_ports UART_TX]
set_false_path -from [get_ports UART_RX]
set_false_path -to [get_ports UART_TX]

# Passive I2C1 monitor. Both pins are high-impedance inputs in PL; the physical
# AT24C256 bus must retain its normal 3.3 V pull-ups.
set_property -dict {PACKAGE_PIN AA6 IOSTANDARD LVCMOS33 PULLUP true} [get_ports I2C_SCL]
set_property -dict {PACKAGE_PIN V8  IOSTANDARD LVCMOS33 PULLUP true} [get_ports I2C_SDA]
set_false_path -from [get_ports {I2C_SCL I2C_SDA}]

# Active second CAN node through the second SN65HVD230. W8 drives its TXD for
# ACK, automatic echo and requested test frames; AA11 observes its RXD.
set_property -dict {PACKAGE_PIN W8   IOSTANDARD LVCMOS33} [get_ports CAN_TX]
set_property -dict {PACKAGE_PIN AA11 IOSTANDARD LVCMOS33 PULLUP true} [get_ports CAN_RX]
set_false_path -from [get_ports CAN_RX]
