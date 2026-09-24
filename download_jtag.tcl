set proj_dir [file dirname [file normalize [info script]]]
set bit_file [file join $proj_dir Multi_protocol.runs impl_1 multi_protocol_bd_wrapper.bit]
set hdf_file [file join $proj_dir Multi_protocol.sdk multi_protocol_bd_wrapper.hdf]
set build_ws [file join $proj_dir Multi_protocol.sdk]
set ps7_init_file [file join $build_ws platform_hw ps7_init.tcl]
set elf_file [file join $build_ws platform_app Debug platform_app.elf]

foreach required_file [list $bit_file $hdf_file $ps7_init_file $elf_file] {
    if {![file exists $required_file]} {
        puts "ERROR: missing $required_file"
        exit 1
    }
}

connect
jtag targets -set -filter {level == 0}
set supported [jtag frequency -list]
set selected 0
foreach candidate $supported {
    if {$candidate <= 5000000 && $candidate > $selected} {
        set selected $candidate
    }
}
if {$selected > 0} { jtag frequency $selected }

source $ps7_init_file
targets -set -filter {level == 0} -index 1
fpga -file $bit_file
targets -set -nocase -filter {name =~ "APU*"} -index 0
loadhw -hw $hdf_file -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
rst -processor
dow $elf_file
configparams force-mem-access 0
con
exit
