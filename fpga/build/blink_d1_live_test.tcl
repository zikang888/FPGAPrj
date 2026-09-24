connect
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
stop
configparams force-mem-access 1

puts "D1_P21_TEST_BEGIN"
for {set i 0} {$i < 8} {incr i} {
    mwr 0x40000030 0x00000001
    puts "D1_LEVEL=1"
    after 500
    mwr 0x40000030 0x00000000
    puts "D1_LEVEL=0"
    after 500
}
puts "LED_CTRL_READBACK: [mrd 0x40000030]"

configparams force-mem-access 0
con
puts "D1_P21_TEST_DONE"
exit
