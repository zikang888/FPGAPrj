`timescale 1ns / 1ps

// Verilog module-reference adapter for Vivado 2018.3 block designs.
module uart_rx_monitor_bd (
    input  wire         clk,
    input  wire         rst_n,
    input  wire [63:0]  timestamp,
    input  wire         uart_rx,
    output wire         evt_valid,
    input  wire         evt_ready,
    output wire         evt_trigger,
    output wire [127:0] evt_data,
    output wire [31:0]  dropped_event_count
);

uart_rx_monitor implementation (
    .clk(clk), .rst_n(rst_n), .timestamp(timestamp), .uart_rx(uart_rx),
    .evt_valid(evt_valid), .evt_ready(evt_ready),
    .evt_trigger(evt_trigger), .evt_data(evt_data),
    .dropped_event_count(dropped_event_count)
);

endmodule
