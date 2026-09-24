set script_dir [file dirname [file normalize [info script]]]
set source_dir [file dirname [file dirname $script_dir]]
set build_dir $source_dir
if {[info exists ::env(MULTI_PROTOCOL_BUILD_DIR)] &&
    $::env(MULTI_PROTOCOL_BUILD_DIR) ne ""} {
    set build_dir [file normalize $::env(MULTI_PROTOCOL_BUILD_DIR)]
}
set xpr [file join $build_dir Multi_protocol.xpr]

if {![file exists $xpr]} {
    puts "ERROR: missing $xpr; run create_project.tcl first"
    exit 1
}

proc run_test {build_dir top_name pass_text} {
    set_property top $top_name [get_filesets sim_1]
    set_property -name {xsim.simulate.runtime} -value {all} \
        -objects [get_filesets sim_1]
    update_compile_order -fileset sim_1
    launch_simulation
    close_sim
    set sim_log [file join $build_dir Multi_protocol.sim sim_1 behav xsim simulate.log]
    if {![file exists $sim_log]} {
        error "Simulation log not found: $sim_log"
    }
    set log_handle [open $sim_log r]
    set log_text [read $log_handle]
    close $log_handle
    if {[string first $pass_text $log_text] < 0} {
        error "$top_name did not report PASS"
    }
    puts "PASS: $top_name"
}

open_project $xpr
run_test $build_dir event_snapshot_buffer_tb \
    "PASS: event snapshot wrap, trigger, post-count, ACK and re-arm"
run_test $build_dir event_arbiter_2_tb \
    "PASS: two-source ready/valid arbitration, backpressure and fairness"
run_test $build_dir multi_protocol_core_tb \
    "PASS: multi_protocol_core AXI, virtual and external snapshot end-to-end test"
run_test $build_dir spi_mode0_monitor_tb \
    "PASS: SPI Mode-0 ready/valid, golden corpus, pause, phase, error and stress test"
run_test $build_dir spi_snapshot_path_tb \
    "PASS: SPI waveform through ready/valid arbiter to triggered snapshot"
close_project
puts "SIMULATION_COMPLETED"
exit
