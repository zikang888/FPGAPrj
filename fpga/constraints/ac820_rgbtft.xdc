
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullnone [current_design]


set_property PACKAGE_PIN V14  [get_ports {LCD_DATA[0]}]
set_property PACKAGE_PIN V15  [get_ports {LCD_DATA[1]}]
set_property PACKAGE_PIN V13  [get_ports {LCD_DATA[2]}]
set_property PACKAGE_PIN W13  [get_ports {LCD_DATA[3]}]
set_property PACKAGE_PIN AB15 [get_ports {LCD_DATA[4]}]
set_property PACKAGE_PIN AA21 [get_ports {LCD_DATA[5]}]
set_property PACKAGE_PIN AB22 [get_ports {LCD_DATA[6]}]
set_property PACKAGE_PIN AA22 [get_ports {LCD_DATA[7]}]
set_property PACKAGE_PIN W22  [get_ports {LCD_DATA[8]}]
set_property PACKAGE_PIN AA13 [get_ports {LCD_DATA[9]}]
set_property PACKAGE_PIN Y13  [get_ports {LCD_DATA[10]}]
set_property PACKAGE_PIN AB16 [get_ports {LCD_DATA[11]}]
set_property PACKAGE_PIN AA16 [get_ports {LCD_DATA[12]}]
set_property PACKAGE_PIN AB17 [get_ports {LCD_DATA[13]}]
set_property PACKAGE_PIN AA17 [get_ports {LCD_DATA[14]}]
set_property PACKAGE_PIN AB21 [get_ports {LCD_DATA[15]}]

set_property IOSTANDARD LVCMOS33 [get_ports {LCD_DATA[*]}]


set_property PACKAGE_PIN V22  [get_ports LCD_PCLK]
set_property PACKAGE_PIN AB19 [get_ports LCD_DE]
set_property PACKAGE_PIN U19  [get_ports LCD_BL]
set_property PACKAGE_PIN AB14 [get_ports LCD_HS]
set_property PACKAGE_PIN U14  [get_ports LCD_VS]

set_property IOSTANDARD LVCMOS33 [get_ports LCD_PCLK]
set_property IOSTANDARD LVCMOS33 [get_ports LCD_DE]
set_property IOSTANDARD LVCMOS33 [get_ports LCD_BL]
set_property IOSTANDARD LVCMOS33 [get_ports LCD_HS]
set_property IOSTANDARD LVCMOS33 [get_ports LCD_VS]


set_property PACKAGE_PIN R15  [get_ports {touch_int_tri_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {touch_int_tri_io[0]}]
set_property PULLUP true [get_ports {touch_int_tri_io[0]}]
