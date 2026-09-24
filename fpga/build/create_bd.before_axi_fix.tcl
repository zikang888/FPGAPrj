set script_dir [file dirname [file normalize [info script]]]
set proj_dir [file dirname [file dirname $script_dir]]
set proj_name "Multi_protocol"
set xpr [file join $proj_dir ${proj_name}.xpr]
set bd_name "multi_protocol_bd"

if {![file exists $xpr]} {
    puts "ERROR: missing $xpr; run create_project.tcl first"
    exit 1
}

open_project $xpr
package require msgcat

set_msg_config -id {Netlist 29-160} \
    -string {multi_protocol_bd_processing_system7_0_0.xdc} \
    -suppress

catch {set_property top "" [current_fileset]}
set old_bd_files [get_files -quiet ${bd_name}.bd]
if {$old_bd_files ne ""} {
    catch {remove_files $old_bd_files}
}
set old_wrapper [get_files -quiet ${bd_name}_wrapper.v]
if {$old_wrapper ne ""} {
    catch {remove_files $old_wrapper}
}

set bd_src_dir [file join $proj_dir ${proj_name}.srcs sources_1 bd $bd_name]
set bd_gen_dir [file join $proj_dir ${proj_name}.gen sources_1 bd $bd_name]
if {[file exists $bd_src_dir]} { file delete -force $bd_src_dir }
if {[file exists $bd_gen_dir]} { file delete -force $bd_gen_dir }

create_bd_design $bd_name

set ps7 [create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0]
set_property -dict [list \
    CONFIG.PCW_USE_M_AXI_GP0 {1} \
    CONFIG.PCW_USE_S_AXI_HP0 {1} \
    CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
    CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
    CONFIG.PCW_EN_CLK1_PORT {1} \
    CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {33.333336} \
    CONFIG.PCW_CLK1_FREQ {33333336} \
    CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {33} \
    CONFIG.PCW_FPGA_FCLK1_ENABLE {1} \
    CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {55} \
    CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1 {1} \
    CONFIG.PCW_FCLK_CLK1_BUF {TRUE} \
    CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
    CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {100} \
    CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
    CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
    CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
    CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
    CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
    CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
    CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
    CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
    CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
    CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
    CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
    CONFIG.PCW_EN_GPIO {1} \
    CONFIG.PCW_EN_EMIO_GPIO {1} \
    CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
    CONFIG.PCW_GPIO_EMIO_GPIO_IO {1} \
    CONFIG.PCW_GPIO_EMIO_GPIO_WIDTH {1} \
    CONFIG.PCW_EN_I2C0 {1} \
    CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_I2C0_I2C0_IO {MIO 50 .. 51} \
    CONFIG.PCW_I2C_RESET_ENABLE {0} \
    CONFIG.PCW_DDR_RAM_HIGHADDR {0x3FFFFFFF} \
    CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {533.333374} \
    CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
    CONFIG.PCW_UIPARAM_DDR_CL {7} \
    CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
    CONFIG.PCW_UIPARAM_DDR_CWL {6} \
    CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
    CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {4096 MBits} \
    CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} \
    CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} \
    CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
    CONFIG.PCW_UIPARAM_DDR_T_FAW {40.0} \
    CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {35.0} \
    CONFIG.PCW_UIPARAM_DDR_T_RC {48.75} \
    CONFIG.PCW_UIPARAM_DDR_T_RCD {7} \
    CONFIG.PCW_UIPARAM_DDR_T_RP {7} \
] $ps7

set axi_ic [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0]
set_property -dict [list CONFIG.NUM_MI {3} CONFIG.NUM_SI {1}] $axi_ic
set ps_reset [create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0]
set core [create_bd_cell -type module -reference multi_protocol_core multi_protocol_core_0]

set vdma [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_0]
set_property -dict [list \
    CONFIG.c_include_s2mm {0} \
    CONFIG.c_m_axis_mm2s_tdata_width {24} \
    CONFIG.c_mm2s_linebuffer_depth {512} \
    CONFIG.c_mm2s_max_burst_length {64} \
    CONFIG.c_num_fstores {2} \
] $vdma
set vtc [create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_0]
set_property -dict [list \
    CONFIG.GEN_HACTIVE_SIZE {800} \
    CONFIG.GEN_HFRAME_SIZE {1056} \
    CONFIG.GEN_HSYNC_START {840} \
    CONFIG.GEN_HSYNC_END {968} \
    CONFIG.GEN_VACTIVE_SIZE {480} \
    CONFIG.GEN_F0_VBLANK_HSTART {640} \
    CONFIG.GEN_F0_VBLANK_HEND {640} \
    CONFIG.GEN_F0_VSYNC_HSTART {640} \
    CONFIG.GEN_F0_VSYNC_HEND {640} \
    CONFIG.GEN_F0_VFRAME_SIZE {525} \
    CONFIG.GEN_F0_VSYNC_VSTART {489} \
    CONFIG.GEN_F0_VSYNC_VEND {491} \
    CONFIG.VIDEO_MODE {Custom} \
    CONFIG.enable_detection {false} \
] $vtc
set video_out [create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_0]
set_property -dict [list CONFIG.C_HAS_ASYNC_CLK {1}] $video_out
set hp_smc [create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc_0]
set rgb565 [create_bd_cell -type module -reference rgb888torgb565 rgb888torgb565_0]
set lcd_bl_const [create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_lcd_bl]
set_property -dict [list CONFIG.CONST_WIDTH {1} CONFIG.CONST_VAL {1}] $lcd_bl_const

connect_bd_intf_net [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins multi_protocol_core_0/S_AXI]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins axi_vdma_0/S_AXI_LITE]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M02_AXI] [get_bd_intf_pins v_tc_0/ctrl]
connect_bd_intf_net [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S] [get_bd_intf_pins axi_smc_0/S00_AXI]
connect_bd_intf_net [get_bd_intf_pins axi_smc_0/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
connect_bd_intf_net [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins v_axi4s_vid_out_0/video_in]
connect_bd_intf_net [get_bd_intf_pins v_tc_0/vtiming_out] [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in]
connect_bd_net [get_bd_pins v_tc_0/gen_clken] [get_bd_pins v_axi4s_vid_out_0/vtg_ce]

foreach pin [list \
    multi_protocol_core_0/s_axi_aclk \
    axi_vdma_0/s_axi_lite_aclk \
    axi_vdma_0/m_axi_mm2s_aclk \
    axi_vdma_0/m_axis_mm2s_aclk \
    axi_smc_0/aclk \
    v_tc_0/s_axi_aclk \
    v_axi4s_vid_out_0/aclk \
    axi_interconnect_0/ACLK \
    axi_interconnect_0/S00_ACLK \
    axi_interconnect_0/M00_ACLK \
    axi_interconnect_0/M01_ACLK \
    axi_interconnect_0/M02_ACLK \
    processing_system7_0/M_AXI_GP0_ACLK \
    processing_system7_0/S_AXI_HP0_ACLK \
    proc_sys_reset_0/slowest_sync_clk \
] {
    connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins $pin]
}

connect_bd_net [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins proc_sys_reset_0/ext_reset_in]
foreach pin [list \
    multi_protocol_core_0/s_axi_aresetn \
    axi_vdma_0/axi_resetn \
    axi_smc_0/aresetn \
    v_tc_0/s_axi_aresetn \
    axi_interconnect_0/ARESETN \
    axi_interconnect_0/S00_ARESETN \
    axi_interconnect_0/M00_ARESETN \
    axi_interconnect_0/M01_ARESETN \
    axi_interconnect_0/M02_ARESETN \
] {
    connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins $pin]
}

connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins v_tc_0/clk]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk]

set lcd_data [create_bd_port -dir O -from 15 -to 0 LCD_DATA]
set lcd_hs [create_bd_port -dir O LCD_HS]
set lcd_vs [create_bd_port -dir O LCD_VS]
set lcd_de [create_bd_port -dir O LCD_DE]
set lcd_bl [create_bd_port -dir O LCD_BL]
set lcd_pclk [create_bd_port -dir O -type clk LCD_PCLK]
connect_bd_net $lcd_data [get_bd_pins rgb888torgb565_0/rgb565_data]
connect_bd_net $lcd_hs [get_bd_pins v_axi4s_vid_out_0/vid_hsync]
connect_bd_net $lcd_vs [get_bd_pins v_axi4s_vid_out_0/vid_vsync]
connect_bd_net $lcd_de [get_bd_pins v_axi4s_vid_out_0/vid_active_video]
connect_bd_net $lcd_bl [get_bd_pins xlconstant_lcd_bl/dout]
connect_bd_net $lcd_pclk [get_bd_pins processing_system7_0/FCLK_CLK1]
connect_bd_net [get_bd_pins v_axi4s_vid_out_0/vid_data] [get_bd_pins rgb888torgb565_0/rgb888_data]

make_bd_pins_external [get_bd_pins multi_protocol_core_0/led_heartbeat]
make_bd_pins_external [get_bd_pins multi_protocol_core_0/led_ps_active]
make_bd_intf_pins_external [get_bd_intf_pins processing_system7_0/GPIO_0]

foreach port [get_bd_ports] {
    set old_name [get_property NAME $port]
    if {$old_name eq "led_heartbeat_0"} {
        set_property NAME led_heartbeat $port
    } elseif {$old_name eq "led_ps_active_0"} {
        set_property NAME led_ps_active $port
    }
}
set touch_gpio_if [get_bd_intf_ports -quiet *GPIO*]
if {[llength $touch_gpio_if] != 1} {
    error "Expected one exported PS GPIO interface, found: $touch_gpio_if"
}
set_property NAME touch_int $touch_gpio_if

assign_bd_address -target_address_space /processing_system7_0/Data \
    [get_bd_addr_segs multi_protocol_core_0/S_AXI/reg0]
set core_seg [get_bd_addr_segs processing_system7_0/Data/SEG_multi_protocol_core_0_reg0]
set_property offset 0x40000000 $core_seg
set_property range 64K $core_seg

assign_bd_address -target_address_space /processing_system7_0/Data \
    [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg]
set_property offset 0x43000000 \
    [get_bd_addr_segs processing_system7_0/Data/SEG_axi_vdma_0_Reg]
set_property range 64K \
    [get_bd_addr_segs processing_system7_0/Data/SEG_axi_vdma_0_Reg]

assign_bd_address -target_address_space /processing_system7_0/Data \
    [get_bd_addr_segs v_tc_0/ctrl/Reg]
set_property offset 0x43C00000 \
    [get_bd_addr_segs processing_system7_0/Data/SEG_v_tc_0_Reg]
set_property range 64K \
    [get_bd_addr_segs processing_system7_0/Data/SEG_v_tc_0_Reg]

create_bd_addr_seg -range 0x40000000 -offset 0x00000000 \
    [get_bd_addr_spaces axi_vdma_0/Data_MM2S] \
    [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_hp0_ddr

validate_bd_design
save_bd_design

set wrapper_file [make_wrapper -files [get_files ${bd_name}.bd] -top]
add_files -norecurse $wrapper_file
set_property top ${bd_name}_wrapper [current_fileset]
update_compile_order -fileset sources_1

puts "BD_CREATED: $bd_name"
close_project
