# Reload only the PS application when the matching PL bitstream is already
# configured and PS initialization has completed. Does not touch PL.
if {![info exists ::env(ZYNQ_TEST_ELF)] || $::env(ZYNQ_TEST_ELF) eq ""} {
    error "Missing environment variable ZYNQ_TEST_ELF"
}
set elf [file normalize $::env(ZYNQ_TEST_ELF)]
if {![file isfile $elf]} {error "Missing ELF: $elf"}

connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
puts "RESET_CPU0"
rst -processor
puts "DOWNLOAD_ELF $elf"
dow $elf
puts "RUN_CPU0"
con
after 3000
disconnect
puts "ZYNQ_PS_APP_RELOAD_DONE"
