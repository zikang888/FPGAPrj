source [file join [file dirname [file normalize [info script]]] migration_config.tcl]
set ::MULTI_PROTOCOL_KEEP_VIVADO_OPEN 1
source [file join $script_dir create_project.tcl]
source [file join $script_dir create_bd.tcl]
open_project [file join $build_dir Multi_protocol.xpr]
set report_dir [file join $build_dir reports]
file mkdir $report_dir
open_bd_design [get_files multi_protocol_bd.bd]
write_bd_tcl -force [file join $report_dir migrated_bd.tcl]
generate_target all [get_files multi_protocol_bd.bd]
report_ip_status -file [file join $report_dir ip_status.rpt]
export_ip_user_files -of_objects [get_files multi_protocol_bd.bd] -no_script -sync -force -quiet
launch_runs synth_1 -jobs $num_jobs
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] ne "100%"} {
    error "Synthesis failed: [get_property STATUS [get_runs synth_1]]"
}
launch_runs impl_1 -to_step write_bitstream -jobs $num_jobs
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] ne "100%" ||
    [get_property STATUS [get_runs impl_1]] ne "write_bitstream Complete!"} {
    error "Implementation failed: [get_property STATUS [get_runs impl_1]]"
}
open_run impl_1
report_timing_summary -report_unconstrained -file [file join $report_dir timing.rpt]
report_utilization -file [file join $report_dir utilization.rpt]
report_drc -file [file join $report_dir drc.rpt]
report_methodology -file [file join $report_dir methodology.rpt]
report_cdc -file [file join $report_dir cdc.rpt]
report_clock_interaction -file [file join $report_dir clock_interaction.rpt]
report_bus_skew -file [file join $report_dir bus_skew.rpt]
report_io -file [file join $report_dir io.rpt]
set export_dir [file join $build_dir export]
file mkdir $export_dir
write_hw_platform -fixed -include_bit -force -file [file join $export_dir multi_protocol.xsa]
file copy -force [file join $build_dir Multi_protocol.runs impl_1 multi_protocol_bd_wrapper.bit] [file join $export_dir multi_protocol.bit]
puts "MIGRATION_PL_BUILD_DONE: $export_dir"
close_project
exit
