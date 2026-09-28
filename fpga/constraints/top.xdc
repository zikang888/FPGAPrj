# ACZ702 platform status LEDs.
# D0 = P20, D1 = P21. P15 is not a board LED on this carrier.
set_property -dict {PACKAGE_PIN P20 IOSTANDARD LVCMOS33} [get_ports led_heartbeat]
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS33} [get_ports led_ps_active]

# Status LEDs are asynchronous observability outputs, not timed interfaces.
set_false_path -to [get_ports led_heartbeat]
set_false_path -to [get_ports led_ps_active]

# Passive SPI Mode-0 monitor inputs from the STM32F407 test source.
set_property -dict {PACKAGE_PIN AA8  IOSTANDARD LVCMOS33 PULLUP true} [get_ports SPI_CS_N]
set_property -dict {PACKAGE_PIN AB10 IOSTANDARD LVCMOS33 PULLDOWN true} [get_ports SPI_SCLK]
set_property -dict {PACKAGE_PIN AB9  IOSTANDARD LVCMOS33 PULLDOWN true} [get_ports SPI_MOSI]
set_property -dict {PACKAGE_PIN AA7  IOSTANDARD LVCMOS33 PULLDOWN true} [get_ports SPI_MISO]

# All four pins enter two-stage synchronizers in spi_mode0_monitor.
set_false_path -from [get_ports {SPI_CS_N SPI_SCLK SPI_MOSI SPI_MISO}]
