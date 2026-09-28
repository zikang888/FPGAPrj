connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
puts "TARGET [targets]"
stop
configparams force-mem-access 1
puts "REGISTERS_BEGIN"
puts [rrd]
puts "REGISTERS_END"
puts "SCRATCH [mrd 0x4000002C]"
puts "CAPTURE_STATUS [mrd 0x40001004]"
puts "SNAPSHOT_ID [mrd 0x40001008]"
configparams force-mem-access 0
con
disconnect
