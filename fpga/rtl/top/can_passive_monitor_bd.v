`timescale 1ns / 1ps

module can_passive_monitor_bd (
    input wire clk, input wire rst_n, input wire [63:0] timestamp,
    input wire can_rx_bus, input wire ack_enable, input wire echo_enable,
    input wire tx_request,
    output wire can_tx, output wire can_rx_level,
    output wire evt_valid, input wire evt_ready,
    output wire evt_trigger, output wire [127:0] evt_data,
    output wire [31:0] dropped_event_count
);

can_passive_monitor #(.CHECK_TX_INTENT(1)) implementation (
    .clk(clk), .rst_n(rst_n), .timestamp(timestamp),
    .can_tx_intent(can_tx), .can_rx_bus(can_rx_bus),
    .ack_enable(ack_enable), .echo_enable(echo_enable),
    .tx_request(tx_request),
    .can_tx(can_tx), .can_rx_level(can_rx_level),
    .evt_valid(evt_valid), .evt_ready(evt_ready),
    .evt_trigger(evt_trigger), .evt_data(evt_data),
    .dropped_event_count(dropped_event_count)
);

endmodule
