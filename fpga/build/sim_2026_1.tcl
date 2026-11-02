set entry_dir [file dirname [file normalize [info script]]]
set ::MULTI_PROTOCOL_KEEP_VIVADO_OPEN 1
source [file join $entry_dir create_project.tcl]
source [file join $entry_dir run_sim.tcl]
