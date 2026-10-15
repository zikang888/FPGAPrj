`timescale 1ns / 1ps

// Passive 8N1 receiver for a 100 MHz PL clock. It never drives uart_rx.
// A high idle gap closes one burst; external case boundaries still require
// the STM32 truth log or a dedicated sync signal for exact identification.
module uart_8n1_monitor #(
    parameter [3:0] CHANNEL = 4'd0,
    parameter integer CLOCK_HZ = 100000000,
    parameter integer BAUD = 115200,
    parameter integer IDLE_BITS = 20
) (
    input  wire         clk,
    input  wire         rst_n,
    input  wire [63:0]  timestamp,
    input  wire         uart_rx,
    output reg          evt_valid,
    input  wire         evt_ready,
    output reg          evt_trigger,
    output reg  [127:0] evt_data,
    output reg  [31:0]  dropped_event_count
);

localparam integer BIT_CYCLES = CLOCK_HZ / BAUD;
localparam integer HALF_CYCLES = BIT_CYCLES / 2;
localparam integer IDLE_CYCLES = BIT_CYCLES * IDLE_BITS;
localparam [2:0] WAIT_START = 3'd0, CHECK_START = 3'd1,
                 SAMPLE_DATA = 3'd2, SAMPLE_STOP = 3'd3,
                 WAIT_HIGH = 3'd4;
localparam [5:0] EVENT_START = 6'd0, EVENT_DATA = 6'd1,
                 EVENT_END = 6'd2, EVENT_ERROR = 6'h3F;

(* ASYNC_REG = "TRUE" *) reg rx_meta;
(* ASYNC_REG = "TRUE" *) reg rx_sync;
reg rx_prev;
reg [2:0] state;
reg [31:0] timer;
reg [31:0] idle_timer;
reg [2:0] bit_index;
reg [7:0] rx_byte;
reg       burst_open;
reg [23:0] transaction_id;

function automatic [127:0] make_event;
    input [63:0] event_timestamp;
    input [5:0] event_type;
    input [15:0] flags;
    input [7:0] length;
    input [23:0] txn;
    begin
        make_event = {event_timestamp, 4'd1, CHANNEL, 2'd0,
                      event_type, flags, length, txn};
    end
endfunction

initial begin
    if (BAUD <= 0 || BIT_CYCLES < 8 || IDLE_BITS < 12)
        $error("uart_8n1_monitor requires at least 8 clocks/bit and 12 idle bits");
end

always @(posedge clk) begin
    if (!rst_n) begin
        rx_meta <= 1'b1;
        rx_sync <= 1'b1;
        rx_prev <= 1'b1;
        state <= WAIT_START;
        timer <= 32'd0;
        idle_timer <= 32'd0;
        bit_index <= 3'd0;
        rx_byte <= 8'd0;
        burst_open <= 1'b0;
        transaction_id <= 24'd0;
        evt_valid <= 1'b0;
        evt_trigger <= 1'b0;
        evt_data <= 128'd0;
        dropped_event_count <= 32'd0;
    end else begin
        rx_meta <= uart_rx;
        rx_sync <= rx_meta;
        rx_prev <= rx_sync;
        if (evt_valid && evt_ready) begin
            evt_valid <= 1'b0;
            evt_trigger <= 1'b0;
        end
        case (state)
            WAIT_START: begin
                if (rx_prev && !rx_sync) begin
                    timer <= HALF_CYCLES - 1;
                    idle_timer <= 32'd0;
                    state <= CHECK_START;
                end else if (burst_open && rx_sync) begin
                    if (idle_timer >= IDLE_CYCLES - 1) begin
                        burst_open <= 1'b0;
                        idle_timer <= 32'd0;
                        if (!evt_valid || evt_ready) begin
                            evt_valid <= 1'b1;
                            evt_trigger <= 1'b0;
                            evt_data <= make_event(timestamp, EVENT_END,
                                                   16'd0, 8'd0, transaction_id);
                        end else dropped_event_count <= dropped_event_count + 32'd1;
                    end else idle_timer <= idle_timer + 32'd1;
                end
            end
            CHECK_START: begin
                if (timer != 0) timer <= timer - 32'd1;
                else if (!rx_sync) begin
                    timer <= BIT_CYCLES - 1;
                    bit_index <= 3'd0;
                    rx_byte <= 8'd0;
                    state <= SAMPLE_DATA;
                    if (!burst_open) begin
                        burst_open <= 1'b1;
                        transaction_id <= transaction_id + 24'd1;
                        if (!evt_valid || evt_ready) begin
                            evt_valid <= 1'b1;
                            evt_trigger <= 1'b0;
                            evt_data <= make_event(timestamp, EVENT_START,
                                                   16'd0, 8'd0,
                                                   transaction_id + 24'd1);
                        end else dropped_event_count <= dropped_event_count + 32'd1;
                    end
                end else state <= WAIT_START;
            end
            SAMPLE_DATA: begin
                if (timer != 0) timer <= timer - 32'd1;
                else begin
                    rx_byte[bit_index] <= rx_sync;
                    timer <= BIT_CYCLES - 1;
                    if (bit_index == 3'd7) state <= SAMPLE_STOP;
                    else bit_index <= bit_index + 3'd1;
                end
            end
            SAMPLE_STOP: begin
                if (timer != 0) timer <= timer - 32'd1;
                else begin
                    if (!evt_valid || evt_ready) begin
                        evt_valid <= 1'b1;
                        evt_trigger <= !rx_sync;
                        evt_data <= make_event(timestamp,
                                               rx_sync ? EVENT_DATA : EVENT_ERROR,
                                               rx_sync ? {8'd0, rx_byte} :
                                                         {8'h01, rx_byte},
                                               8'd1, transaction_id);
                    end else dropped_event_count <= dropped_event_count + 32'd1;
                    idle_timer <= 32'd0;
                    state <= rx_sync ? WAIT_START : WAIT_HIGH;
                end
            end
            WAIT_HIGH: begin
                if (rx_sync) begin
                    idle_timer <= 32'd0;
                    state <= WAIT_START;
                end
            end
            default: state <= WAIT_START;
        endcase
    end
end

endmodule
