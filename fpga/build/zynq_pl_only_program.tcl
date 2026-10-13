# Program only the volatile PL image, then verify configuration status.
# Do not initialize PS, download ELF, or write boot media here.
if {![info exists ::env(ZYNQ_TEST_BIT)] || $::env(ZYNQ_TEST_BIT) eq ""} {
    error "Set ZYNQ_TEST_BIT"
}
set bit_file [file normalize $::env(ZYNQ_TEST_BIT)]
if {![file isfile $bit_file]} {error "Missing BIT: $bit_file"}
open_hw
connect_hw_server -url localhost:3121
open_hw_target
set dev [lindex [get_hw_devices *xc7z020*] 0]
if {$dev eq ""} {error "xc7z020 not found"}
puts "PROGRAM_BITSTREAM $bit_file"
set_property PROGRAM.FILE $bit_file $dev
program_hw_devices $dev
refresh_hw_device $dev
set done [get_property REGISTER.IR.BIT5_DONE $dev]
set status [get_property REGISTER.CONFIG_STATUS $dev]
puts "PL_DONE $done"
puts "PL_CONFIG_STATUS $status"
if {$done ne "1"} {error "PL DONE remains 0 after programming"}
close_hw_target
disconnect_hw_server
close_hw
puts "ZYNQ_PL_ONLY_PROGRAM_DONE"
