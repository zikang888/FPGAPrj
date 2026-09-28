# AXI-only D1 control probe; restores LED_CTRL to off before resuming PS.
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
catch {stop}
configparams force-mem-access 1
puts "LED_CTRL_BEFORE [mrd 0x40000030]"
puts "TIMESTAMP_BEFORE [mrd 0x40000024]"
set test_error [catch {
    mwr 0x40000030 1
    puts "LED_CTRL_ON [mrd 0x40000030]"
} message]
mwr 0x40000030 0
puts "LED_CTRL_RESTORED [mrd 0x40000030]"
after 100
puts "TIMESTAMP_AFTER [mrd 0x40000024]"
configparams force-mem-access 0
con
disconnect
if {$test_error} {error $message}
