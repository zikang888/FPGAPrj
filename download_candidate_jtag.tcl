set proj_dir [file dirname [file normalize [info script]]]
set candidate_dir [file join $proj_dir artifacts candidates 2026-09-24-ui-pages]
set bit_file [file join $candidate_dir multi_protocol_bd_wrapper.bit]
set hdf_file [file join $candidate_dir multi_protocol_bd_wrapper.hdf]
set elf_file [file join $candidate_dir platform_app.elf]
set ps7_init_file [file join $candidate_dir ps7_init.tcl]

foreach required_file [list $bit_file $hdf_file $elf_file $ps7_init_file] {
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

# Give the application time to initialize LCD, touch and the virtual snapshot,
# then stop briefly and read the observable closed-loop registers.
after 5000
stop
puts "VERIFY_SYS_ID"
puts [format "SYS_ID=0x%08X" [mrd -value 0x40000000]]
puts [format "VERSION=0x%08X" [mrd -value 0x40000004]]
puts [format "CAPABILITIES=0x%08X" [mrd -value 0x4000000C]]
puts "VERIFY_SCRATCH_LED_ARB_EXTDROP"
puts [format "SCRATCH=0x%08X" [mrd -value 0x4000002C]]
puts [format "LED_CTRL=0x%08X" [mrd -value 0x40000030]]
puts [format "ARB_STATUS=0x%08X" [mrd -value 0x40000034]]
puts [format "EXT_DROPPED=0x%08X" [mrd -value 0x40000038]]
puts "VERIFY_SNAPSHOT"
puts [format "CAPTURE_STATUS=0x%08X" [mrd -value 0x40001004]]
puts [format "SNAPSHOT_ID=0x%08X" [mrd -value 0x40001008]]
puts [format "SNAPSHOT_COUNT=0x%08X" [mrd -value 0x4000100C]]
puts [format "TRIGGER_INDEX=0x%08X" [mrd -value 0x40001010]]
puts [format "DROPPED_COUNT=0x%08X" [mrd -value 0x40001014]]
con
puts "CANDIDATE_JTAG_DONE"
exit
