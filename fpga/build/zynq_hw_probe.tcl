# Read-only Vivado hardware target discovery for Vivado 2018.3.
open_hw
if {[catch {connect_hw_server -url 127.0.0.1:3121} server_error]} {
    puts "HW_SERVER_CONNECT_FAILED: $server_error"
    exit 1
}
puts "HW_TARGETS_BEGIN"
puts [get_hw_targets]
puts "HW_TARGETS_END"
foreach hw_target [get_hw_targets] {
    puts "HW_TARGET: $hw_target"
    if {[catch {open_hw_target $hw_target} target_error]} {
        puts "HW_TARGET_OPEN_FAILED: $target_error"
    } else {
        puts "HW_DEVICES: [get_hw_devices]"
        close_hw_target $hw_target
    }
}
disconnect_hw_server
close_hw
exit
