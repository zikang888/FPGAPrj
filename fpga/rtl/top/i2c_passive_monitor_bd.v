`timescale 1ns / 1ps

module i2c_passive_monitor_bd (
    input wire clk, input wire rst_n, input wire [63:0] timestamp,
    input wire i2c_scl, input wire i2c_sda,
    output wire evt_valid, input wire evt_ready,
    output wire evt_trigger, output wire [127:0] evt_data,
    output wire [31:0] dropped_event_count
);

i2c_passive_monitor implementation (
    .clk(clk), .rst_n(rst_n), .timestamp(timestamp),
    .i2c_scl(i2c_scl), .i2c_sda(i2c_sda),
    .evt_valid(evt_valid), .evt_ready(evt_ready),
    .evt_trigger(evt_trigger), .evt_data(evt_data),
    .dropped_event_count(dropped_event_count)
);

endmodule
