`timescale 1ns / 1ps

// Vivado 2018.3 cannot use a SystemVerilog source as the top of a block-design
// module reference. This logic-free Verilog adapter keeps the verified monitor
// implementation in SystemVerilog while exposing the same ports to the BD.
module spi_mode0_monitor_bd #(
    parameter [3:0] CHANNEL = 4'd0
) (
    input  wire         clk,
    input  wire         rst_n,
    input  wire [63:0]  timestamp,
    input  wire         spi_sclk,
    input  wire         spi_cs_n,
    input  wire         spi_mosi,
    input  wire         spi_miso,
    output wire         evt_valid,
    input  wire         evt_ready,
    output wire         evt_trigger,
    output wire [127:0] evt_data,
    output wire         monitor_active,
    output wire [23:0]  transaction_id,
    output wire [31:0]  dropped_event_count
);

spi_mode0_monitor #(
    .CHANNEL(CHANNEL)
) implementation (
    .clk(clk),
    .rst_n(rst_n),
    .timestamp(timestamp),
    .spi_sclk(spi_sclk),
    .spi_cs_n(spi_cs_n),
    .spi_mosi(spi_mosi),
    .spi_miso(spi_miso),
    .evt_valid(evt_valid),
    .evt_ready(evt_ready),
    .evt_trigger(evt_trigger),
    .evt_data(evt_data),
    .monitor_active(monitor_active),
    .transaction_id(transaction_id),
    .dropped_event_count(dropped_event_count)
);

endmodule
