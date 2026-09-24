set script_dir [file dirname [file normalize [info script]]]
set proj_dir [file dirname [file dirname $script_dir]]
set proj_name "Multi_protocol"

create_project $proj_name $proj_dir -part xc7z020clg484-2 -force
set_property target_language Verilog [current_project]
set_property simulator_language Mixed [current_project]

set rtl_dirs [list \
    [file join $proj_dir fpga rtl common] \
    [file join $proj_dir fpga rtl top] \
]
foreach rtl_dir $rtl_dirs {
    foreach vf [glob -nocomplain [file join $rtl_dir *.v]] {
        add_files -norecurse $vf
    }
    foreach svf [glob -nocomplain [file join $rtl_dir *.sv]] {
        add_files -norecurse $svf
    }
}

foreach xdc [glob -nocomplain [file join $proj_dir fpga constraints *.xdc]] {
    add_files -fileset constrs_1 -norecurse $xdc
}

foreach tb [glob -nocomplain [file join $proj_dir fpga sim * *_tb.v]] {
    add_files -fileset sim_1 -norecurse $tb
}
set_property top multi_protocol_core_tb [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
puts "PROJECT_CREATED: [file join $proj_dir ${proj_name}.xpr]"
close_project
exit
