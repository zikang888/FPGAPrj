source [file join [file dirname [file normalize [info script]]] migration_config.tcl]
open_project [file join $build_dir Multi_protocol.xpr]
open_bd_design [get_files multi_protocol_bd.bd]
set report_dir [file join $build_dir reports]
report_ip_status -file [file join $report_dir ip_status_final.rpt]
open_run impl_1
report_bus_skew -file [file join $report_dir bus_skew.rpt]
report_clocks -file [file join $report_dir clocks.rpt]
close_project
puts "MIGRATION_AUDIT_DONE"
exit
