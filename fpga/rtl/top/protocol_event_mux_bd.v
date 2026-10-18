`timescale 1ns / 1ps

// Combines the passive SPI and UART monitors into the core's unique external
// ready/valid event ingress.  Per-monitor overflow counters are accumulated.
module protocol_event_mux_bd (
    input wire clk, input wire rst_n,
    input wire spi_valid, output wire spi_ready,
    input wire spi_trigger, input wire [127:0] spi_data,
    input wire [31:0] spi_dropped,
    input wire uart_valid, output wire uart_ready,
    input wire uart_trigger, input wire [127:0] uart_data,
    input wire [31:0] uart_dropped,
    output wire evt_valid, input wire evt_ready,
    output wire evt_trigger, output wire [127:0] evt_data,
    output wire [31:0] dropped_event_count
);

wire unused_source;
wire [31:0] unused_contention;
assign dropped_event_count = spi_dropped + uart_dropped;

event_arbiter_2 mux (
    .clk(clk), .rst_n(rst_n),
    .s0_valid(spi_valid), .s0_ready(spi_ready),
    .s0_data(spi_data), .s0_trigger(spi_trigger),
    .s1_valid(uart_valid), .s1_ready(uart_ready),
    .s1_data(uart_data), .s1_trigger(uart_trigger),
    .out_valid(evt_valid), .out_ready(evt_ready),
    .out_data(evt_data), .out_trigger(evt_trigger),
    .out_source(unused_source), .contention_count(unused_contention)
);

endmodule
