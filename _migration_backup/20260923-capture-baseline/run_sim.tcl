set script_dir [file dirname [file normalize [info script]]]
set proj_dir [file dirname [file dirname $script_dir]]
set xpr [file join $proj_dir Multi_protocol.xpr]

if {![file exists $xpr]} {
    puts "ERROR: missing $xpr; run create_project.tcl first"
    exit 1
}

open_project $xpr
set_property top multi_protocol_core_tb [get_filesets sim_1]
update_compile_order -fileset sim_1
launch_simulation
close_sim
set sim_log [file join $proj_dir Multi_protocol.sim sim_1 behav xsim simulate.log]
if {![file exists $sim_log]} {
    error "Simulation log not found: $sim_log"
}
set log_handle [open $sim_log r]
set log_text [read $log_handle]
close $log_handle
if {[string first "PASS: multi_protocol_core AXI register test" $log_text] < 0} {
    error "Simulation did not report PASS"
}
close_project
puts "SIMULATION_COMPLETED"
exit
