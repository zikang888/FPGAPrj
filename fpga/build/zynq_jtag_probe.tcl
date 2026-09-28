# Read-only JTAG discovery before loading any image.
if {[catch {connect -url tcp:127.0.0.1:3121} connection_error]} {
    puts "JTAG_CONNECT_FAILED: $connection_error"
    exit 1
}
puts "JTAG_TARGETS_BEGIN"
puts [targets]
puts "JTAG_TARGETS_END"
puts "JTAG_CHAIN_BEGIN"
if {[catch {jtag targets} chain_error]} {
    puts "JTAG_CHAIN_QUERY_FAILED: $chain_error"
} else {
    puts [jtag targets]
}
puts "JTAG_CHAIN_END"
puts "JTAG_CABLES_BEGIN"
puts [jtag servers]
puts "JTAG_CABLES_END"
disconnect
exit
