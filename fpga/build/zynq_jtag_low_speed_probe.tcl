# Diagnostic only: lower JTAG clock, then enumerate PS and PL targets.
connect -url tcp:127.0.0.1:3121
puts "CHAIN_BEGIN\n[jtag targets]\nCHAIN_END"
jtag targets -set -filter {level == 0}
set available [jtag frequency -list]
set selected 0
foreach candidate $available {
    if {$candidate <= 250000 && $candidate > $selected} {
        set selected $candidate
    }
}
if {$selected == 0} {
    set selected [lindex [lsort -integer $available] 0]
}
jtag frequency $selected
puts "JTAG_FREQUENCY_HZ $selected"
puts "TARGETS_BEGIN\n[targets]\nTARGETS_END"
disconnect
puts "LOW_SPEED_PROBE_DONE"
