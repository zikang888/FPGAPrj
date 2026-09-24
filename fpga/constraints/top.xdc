# ACZ702 platform status LEDs.
# D0 = P20, D1 = P21. P15 is not a board LED on this carrier.
set_property -dict {PACKAGE_PIN P20 IOSTANDARD LVCMOS33} [get_ports led_heartbeat]
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS33} [get_ports led_ps_active]

# Status LEDs are asynchronous observability outputs, not timed interfaces.
set_false_path -to [get_ports led_heartbeat]
set_false_path -to [get_ports led_ps_active]
