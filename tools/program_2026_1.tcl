# JTAG candidate loader. Board execution has not been tested during migration.
# Invoke with xsdb.bat program_2026_1.tcl <candidate-directory> [--preflight]
if {$argc < 1} { error "Supply the verified candidate directory" }
set bundle [file normalize [lindex $argv 0]]
set bit_file [file join $bundle multi_protocol.bit]
set xsa_file [file join $bundle multi_protocol.xsa]
set elf_file [file join $bundle multi_protocol_app.elf]
set ps7_init_file [file join $bundle ps7_init.tcl]
foreach path [list $bit_file $xsa_file $elf_file $ps7_init_file] {
    if {![file isfile $path]} { error "Missing candidate input: $path" }
}
if {[lsearch -exact $argv --preflight] >= 0} {
    puts "JTAG_FILES_PREFLIGHT_PASS: $bundle"
    exit
}
connect
# Selection must resolve to one Zynq APU/CPU; XSDB rejects ambiguous targets.
targets -set -nocase -filter {name =~ "APU*"}
fpga -file $bit_file
loadhw -hw $xsa_file -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~ "*Cortex-A9*#0*"}
stop
source $ps7_init_file
ps7_init
ps7_post_config
rst -processor
dow $elf_file
configparams force-mem-access 0
con
puts "JTAG_CANDIDATE_STARTED: observe UART, LCD, touch and protocol tests"
disconnect
exit
