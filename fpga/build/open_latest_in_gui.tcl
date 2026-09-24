# Recreate the generated Vivado project from the authoritative source tree,
# rebuild the block design, and leave the latest project open in the GUI.
# Run from Tools -> Run Tcl Script in Vivado 2018.3.

set script_dir [file dirname [file normalize [info script]]]
set source_dir [file dirname [file dirname $script_dir]]
set build_dir $source_dir
if {[info exists ::env(MULTI_PROTOCOL_BUILD_DIR)] &&
    $::env(MULTI_PROTOCOL_BUILD_DIR) ne ""} {
    set build_dir [file normalize $::env(MULTI_PROTOCOL_BUILD_DIR)]
}
set xpr [file join $build_dir Multi_protocol.xpr]

if {[current_project -quiet] ne ""} {
    close_project
}

set ::MULTI_PROTOCOL_KEEP_VIVADO_OPEN 1
source [file join $script_dir create_project.tcl]
source [file join $script_dir create_bd.tcl]
unset ::MULTI_PROTOCOL_KEEP_VIVADO_OPEN

open_project $xpr
set_property top multi_protocol_bd_wrapper [current_fileset]
set_property top multi_protocol_core_tb [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "GUI_PROJECT_READY: $xpr"
puts "Next: Flow Navigator -> Run Simulation or Generate Bitstream"
