# ACZ702 platform status LEDs.
# D0 = P20, D1 = P21. P15 is not a board LED on this carrier.
set_property -dict {PACKAGE_PIN P20 IOSTANDARD LVCMOS33} [get_ports led_heartbeat]
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS33} [get_ports led_ps_active]

# Status LEDs are asynchronous observability outputs, not timed interfaces.
set_false_path -to [get_ports led_heartbeat]
set_false_path -to [get_ports led_ps_active]

# Passive SPI Mode-0 monitor on the P7 PL expansion header.  All four ports are
# inputs: the FPGA observes the STM32F407 <-> W25Q128 bus and never drives it.
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports spi_sclk]
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports spi_cs_n]
set_property -dict {PACKAGE_PIN U10 IOSTANDARD LVCMOS33} [get_ports spi_mosi]
set_property -dict {PACKAGE_PIN U9  IOSTANDARD LVCMOS33} [get_ports spi_miso]
set_property PULLUP true [get_ports spi_cs_n]

# The external SPI bus is asynchronous to PS FCLK_CLK0. Timing starts again at
# the first synchronizer outputs; the input-to-first-stage paths are excluded.
set_false_path -from [get_ports {spi_sclk spi_cs_n spi_mosi spi_miso}]
