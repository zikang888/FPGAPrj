`timescale 1ns / 1ps

// Combines all four passive protocol monitors into the core's unique external
// ready/valid event ingress. Per-monitor overflow counters are accumulated.
module protocol_event_mux_bd (
    input wire clk, input wire rst_n,
    input wire spi_valid, output wire spi_ready,
    input wire spi_trigger, input wire [127:0] spi_data,
    input wire [31:0] spi_dropped,
    input wire uart_valid, output wire uart_ready,
    input wire uart_trigger, input wire [127:0] uart_data,
    input wire [31:0] uart_dropped,
    input wire i2c_valid, output wire i2c_ready,
    input wire i2c_trigger, input wire [127:0] i2c_data,
    input wire [31:0] i2c_dropped,
    input wire can_valid, output wire can_ready,
    input wire can_trigger, input wire [127:0] can_data,
    input wire [31:0] can_dropped,
    output wire evt_valid, input wire evt_ready,
    output wire evt_trigger, output wire [127:0] evt_data,
    output wire [31:0] dropped_event_count
);

wire pair0_valid, pair0_ready, pair0_trigger, pair0_source;
wire [127:0] pair0_data;
wire pair1_valid, pair1_ready, pair1_trigger, pair1_source;
wire [127:0] pair1_data;
wire unused_source;
wire [31:0] unused_contention0, unused_contention1, unused_contention2;
assign dropped_event_count = spi_dropped + uart_dropped +
                             i2c_dropped + can_dropped;

event_arbiter_2 mux_spi_uart (
    .clk(clk), .rst_n(rst_n),
    .s0_valid(spi_valid), .s0_ready(spi_ready),
    .s0_data(spi_data), .s0_trigger(spi_trigger),
    .s1_valid(uart_valid), .s1_ready(uart_ready),
    .s1_data(uart_data), .s1_trigger(uart_trigger),
    .out_valid(pair0_valid), .out_ready(pair0_ready),
    .out_data(pair0_data), .out_trigger(pair0_trigger),
    .out_source(pair0_source), .contention_count(unused_contention0)
);

event_arbiter_2 mux_i2c_can (
    .clk(clk), .rst_n(rst_n),
    .s0_valid(i2c_valid), .s0_ready(i2c_ready),
    .s0_data(i2c_data), .s0_trigger(i2c_trigger),
    .s1_valid(can_valid), .s1_ready(can_ready),
    .s1_data(can_data), .s1_trigger(can_trigger),
    .out_valid(pair1_valid), .out_ready(pair1_ready),
    .out_data(pair1_data), .out_trigger(pair1_trigger),
    .out_source(pair1_source), .contention_count(unused_contention1)
);

event_arbiter_2 mux_pairs (
    .clk(clk), .rst_n(rst_n),
    .s0_valid(pair0_valid), .s0_ready(pair0_ready),
    .s0_data(pair0_data), .s0_trigger(pair0_trigger),
    .s1_valid(pair1_valid), .s1_ready(pair1_ready),
    .s1_data(pair1_data), .s1_trigger(pair1_trigger),
    .out_valid(evt_valid), .out_ready(evt_ready),
    .out_data(evt_data), .out_trigger(evt_trigger),
    .out_source(unused_source), .contention_count(unused_contention2)
);

endmodule
