set script_dir [file dirname [file normalize [info script]]]
set source_dir [file dirname [file dirname $script_dir]]
set build_dir $source_dir
if {[info exists ::env(MULTI_PROTOCOL_BUILD_DIR)] &&
    $::env(MULTI_PROTOCOL_BUILD_DIR) ne ""} {
    set build_dir [file normalize $::env(MULTI_PROTOCOL_BUILD_DIR)]
}
set proj_name "Multi_protocol"
set xpr [file join $build_dir ${proj_name}.xpr]
set bd_name "multi_protocol_bd"
set top_name "${bd_name}_wrapper"
set num_jobs 20

if {![file exists $xpr]} {
    puts "ERROR: missing $xpr; run create_project.tcl first"
    exit 1
}

# Recreate the block design from source on every build.
source [file join $script_dir create_bd.tcl]

open_project $xpr
set_param general.maxThreads $num_jobs
set_property top $top_name [current_fileset]
update_compile_order -fileset sources_1

reset_run synth_1
launch_runs synth_1 -jobs $num_jobs
wait_on_run synth_1
if {[get_property STATUS [get_runs synth_1]] ne "synth_design Complete!"} {
    puts "ERROR: synthesis failed: [get_property STATUS [get_runs synth_1]]"
    exit 1
}

reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs $num_jobs
wait_on_run impl_1
if {[get_property STATUS [get_runs impl_1]] ne "write_bitstream Complete!"} {
    puts "ERROR: implementation failed: [get_property STATUS [get_runs impl_1]]"
    exit 1
}

open_run impl_1
set report_dir [file join $build_dir reports]
file mkdir $report_dir
report_timing_summary -file [file join $report_dir timing.rpt]
report_utilization -file [file join $report_dir utilization.rpt]
report_power -file [file join $report_dir power.rpt]
report_drc -file [file join $report_dir drc.rpt]

set sdk_dir [file join $build_dir ${proj_name}.sdk]
file mkdir $sdk_dir
set hdf_file [file join $sdk_dir ${top_name}.hdf]
write_hwdef -force -file $hdf_file

set bit_file [file join $build_dir ${proj_name}.runs impl_1 ${top_name}.bit]
puts "BUILD_DONE"
puts "BITSTREAM: $bit_file"
puts "HDF: $hdf_file"
close_project
exit
