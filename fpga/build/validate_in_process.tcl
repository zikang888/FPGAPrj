set script_dir [file dirname [file normalize [info script]]]
set source_dir [file dirname [file dirname $script_dir]]
set build_dir $source_dir
if {[info exists ::env(MULTI_PROTOCOL_BUILD_DIR)] &&
    $::env(MULTI_PROTOCOL_BUILD_DIR) ne ""} {
    set build_dir [file normalize $::env(MULTI_PROTOCOL_BUILD_DIR)]
}
set xpr [file join $build_dir Multi_protocol.xpr]
set bd_name multi_protocol_bd
set top_name ${bd_name}_wrapper

if {![file exists $xpr]} {
    puts "ERROR: missing $xpr; run create_project.tcl first"
    exit 1
}

source [file join $script_dir create_bd.tcl]
open_project $xpr
set_property top $top_name [current_fileset]
update_compile_order -fileset sources_1
set bd_file [get_files ${bd_name}.bd]
set_property synth_checkpoint_mode None $bd_file
generate_target all $bd_file

synth_design -top $top_name -part xc7z020clg484-2
opt_design
place_design
route_design

set report_dir [file join $build_dir reports in_process]
set artifact_dir [file join $build_dir artifacts]
file mkdir $report_dir
file mkdir $artifact_dir
report_timing_summary -file [file join $report_dir timing.rpt]
report_utilization -file [file join $report_dir utilization.rpt]
report_drc -file [file join $report_dir drc.rpt]

set bit_file [file join $artifact_dir ${top_name}.bit]
set hdf_file [file join $artifact_dir ${top_name}.hdf]
write_bitstream -force $bit_file
write_hwdef -force -file $hdf_file

puts "IN_PROCESS_BUILD_DONE"
puts "BITSTREAM: $bit_file"
puts "HDF: $hdf_file"
close_project
exit
