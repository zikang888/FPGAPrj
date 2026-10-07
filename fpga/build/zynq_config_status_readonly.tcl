# Read FPGA configuration status through Vivado Hardware Manager.
open_hw
connect_hw_server -url localhost:3121
open_hw_target
set devices [get_hw_devices]
puts "HW_DEVICES $devices"
foreach dev $devices {
    if {[string match "*xc7z020*" $dev]} {
        refresh_hw_device $dev
        foreach prop [list_property $dev] {
            if {[string match "REGISTER.CONFIG_STATUS*" $prop] ||
                [string match "REGISTER.IR.BIT5_DONE" $prop]} {
                if {![catch {get_property $prop $dev} value]} {
                    puts "$prop $value"
                }
            }
        }
    }
}
close_hw_target
disconnect_hw_server
close_hw
puts "ZYNQ_CONFIG_STATUS_READONLY_DONE"
