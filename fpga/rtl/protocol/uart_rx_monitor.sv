`timescale 1ns / 1ps

// Passive 8N1 UART receiver and fixed-length transaction monitor.
// The monitored line is never driven by this module.  A transaction contains
// EXPECTED_BYTES consecutive bytes; an idle gap after a shorter prefix emits
// an ERROR event.  ERROR flags[15:8] are: 1=bad stop, 2=break, 4=short txn.
module uart_rx_monitor #(
    parameter integer CLK_HZ = 100000000,
    parameter integer BAUD = 115200,
    parameter integer EXPECTED_BYTES = 8,
    parameter integer GAP_BITS = 12,
    parameter [3:0] CHANNEL = 4'd0
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

localparam integer CLKS_PER_BIT = (CLK_HZ + (BAUD / 2)) / BAUD;
localparam integer HALF_BIT = CLKS_PER_BIT / 2;
localparam integer GAP_CLKS = CLKS_PER_BIT * GAP_BITS;
localparam integer BREAK_CLKS = CLKS_PER_BIT * 10;
localparam [3:0] PROTOCOL_UART = 4'h1;
localparam [1:0] DIRECTION_CONTROLLER_TO_PERIPHERAL = 2'b01;
localparam [5:0] EVENT_START = 6'h00;
localparam [5:0] EVENT_DATA = 6'h01;
localparam [5:0] EVENT_END = 6'h02;
localparam [5:0] EVENT_ERROR = 6'h3F;
localparam [7:0] ERR_BAD_STOP = 8'h01;
localparam [7:0] ERR_BREAK = 8'h02;
localparam [7:0] ERR_SHORT = 8'h04;

localparam [2:0] RX_IDLE = 3'd0;
localparam [2:0] RX_START = 3'd1;
localparam [2:0] RX_DATA = 3'd2;
localparam [2:0] RX_STOP = 3'd3;

(* ASYNC_REG = "TRUE" *) reg rx_meta;
(* ASYNC_REG = "TRUE" *) reg rx_sync;
reg rx_d;
reg [2:0] state;
reg [31:0] bit_timer;
reg [2:0] bit_index;
reg [7:0] shift;
reg [31:0] idle_timer;
reg [31:0] low_timer;
reg break_reported;
reg transaction_open;
reg [7:0] byte_count;
reg [23:0] transaction_id;
reg [63:0] start_timestamp;
reg pending_end;
reg bad_stop_pending;
reg [7:0] bad_stop_data;
reg [23:0] bad_stop_transaction_id;

wire start_edge = rx_d && !rx_sync;

function automatic [127:0] make_event;
    input [63:0] event_timestamp;
    input [5:0] event_type;
    input [15:0] flags;
    input [7:0] payload_length;
    input [23:0] event_transaction_id;
    begin
        make_event = {event_timestamp, PROTOCOL_UART, CHANNEL,
                      DIRECTION_CONTROLLER_TO_PERIPHERAL,
                      event_type, flags, payload_length,
                      event_transaction_id};
    end
endfunction

task automatic offer_event;
    input [127:0] value;
    input trigger;
    begin
        if (!evt_valid || evt_ready) begin
            evt_valid <= 1'b1;
            evt_trigger <= trigger;
            evt_data <= value;
        end else begin
            dropped_event_count <= dropped_event_count + 32'd1;
        end
    end
endtask

always @(posedge clk) begin
    if (!rst_n) begin
        rx_meta <= 1'b1;
        rx_sync <= 1'b1;
        rx_d <= 1'b1;
        state <= RX_IDLE;
        bit_timer <= 32'd0;
        bit_index <= 3'd0;
        shift <= 8'd0;
        idle_timer <= 32'd0;
        low_timer <= 32'd0;
        break_reported <= 1'b0;
        transaction_open <= 1'b0;
        byte_count <= 8'd0;
        transaction_id <= 24'd0;
        start_timestamp <= 64'd0;
        pending_end <= 1'b0;
        bad_stop_pending <= 1'b0;
        bad_stop_data <= 8'd0;
        bad_stop_transaction_id <= 24'd0;
        evt_valid <= 1'b0;
        evt_trigger <= 1'b0;
        evt_data <= 128'd0;
        dropped_event_count <= 32'd0;
    end else begin
        rx_meta <= uart_rx;
        rx_sync <= rx_meta;
        rx_d <= rx_sync;

        if (evt_valid && evt_ready) begin
            evt_valid <= 1'b0;
            evt_trigger <= 1'b0;
        end

        if (pending_end && (!evt_valid || evt_ready)) begin
            evt_valid <= 1'b1;
            evt_trigger <= 1'b0;
            evt_data <= make_event(timestamp, EVENT_END, 16'd0, 8'd0,
                                   transaction_id);
            pending_end <= 1'b0;
        end

        if (!rx_sync) begin
            if (low_timer < BREAK_CLKS) low_timer <= low_timer + 32'd1;
            if (!break_reported && low_timer == BREAK_CLKS - 1) begin
                break_reported <= 1'b1;
                bad_stop_pending <= 1'b0;
                offer_event(make_event(timestamp, EVENT_ERROR,
                                       {ERR_BREAK, 8'd0}, 8'd0,
                                       transaction_id), 1'b1);
                transaction_open <= 1'b0;
                byte_count <= 8'd0;
            end
        end else begin
            low_timer <= 32'd0;
            break_reported <= 1'b0;
            if (bad_stop_pending) begin
                bad_stop_pending <= 1'b0;
                if (!break_reported) begin
                    offer_event(make_event(timestamp, EVENT_ERROR,
                                           {ERR_BAD_STOP, bad_stop_data}, 8'd1,
                                           bad_stop_transaction_id), 1'b1);
                end
            end
        end

        if (transaction_open && state == RX_IDLE && rx_sync) begin
            if (idle_timer < GAP_CLKS) idle_timer <= idle_timer + 32'd1;
            if (idle_timer == GAP_CLKS - 1) begin
                offer_event(make_event(timestamp, EVENT_ERROR,
                                       {ERR_SHORT, byte_count}, 8'd0,
                                       transaction_id), 1'b1);
                transaction_open <= 1'b0;
                byte_count <= 8'd0;
                idle_timer <= 32'd0;
            end
        end else begin
            idle_timer <= 32'd0;
        end

        if (!pending_end) case (state)
            RX_IDLE: begin
                if (start_edge && !break_reported) begin
                    state <= RX_START;
                    bit_timer <= HALF_BIT - 1;
                    start_timestamp <= timestamp;
                end
            end
            RX_START: begin
                if (bit_timer != 0) begin
                    bit_timer <= bit_timer - 32'd1;
                end else if (!rx_sync) begin
                    if (!transaction_open) begin
                        transaction_id <= transaction_id + 24'd1;
                        transaction_open <= 1'b1;
                        byte_count <= 8'd0;
                        offer_event(make_event(start_timestamp, EVENT_START,
                                               16'd0, 8'd0,
                                               transaction_id + 24'd1), 1'b0);
                    end
                    state <= RX_DATA;
                    bit_timer <= CLKS_PER_BIT - 1;
                    bit_index <= 3'd0;
                    shift <= 8'd0;
                end else begin
                    state <= RX_IDLE;
                end
            end
            RX_DATA: begin
                if (bit_timer != 0) begin
                    bit_timer <= bit_timer - 32'd1;
                end else begin
                    shift[bit_index] <= rx_sync;
                    bit_timer <= CLKS_PER_BIT - 1;
                    if (bit_index == 3'd7) state <= RX_STOP;
                    else bit_index <= bit_index + 3'd1;
                end
            end
            RX_STOP: begin
                if (bit_timer != 0) begin
                    bit_timer <= bit_timer - 32'd1;
                end else begin
                    state <= RX_IDLE;
                    if (!rx_sync) begin
                        // Defer classification until RX rises or reaches the
                        // Break threshold. A continuous Break is therefore
                        // reported once as Break, not as both stop and Break.
                        bad_stop_pending <= 1'b1;
                        bad_stop_data <= shift;
                        bad_stop_transaction_id <= transaction_id;
                        transaction_open <= 1'b0;
                        byte_count <= 8'd0;
                    end else begin
                        offer_event(make_event(timestamp, EVENT_DATA,
                                               {8'd0, shift}, 8'd1,
                                               transaction_id),
                                    byte_count == 8'd4);
                        if (byte_count == EXPECTED_BYTES - 1) begin
                            transaction_open <= 1'b0;
                            byte_count <= 8'd0;
                            pending_end <= 1'b1;
                        end else begin
                            byte_count <= byte_count + 8'd1;
                        end
                    end
                end
            end
            default: state <= RX_IDLE;
        endcase
    end
end

endmodule
