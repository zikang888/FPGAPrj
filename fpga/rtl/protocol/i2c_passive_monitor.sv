`timescale 1ns / 1ps

// Passive I2C monitor for the 100 kHz STM32/AT24C256 bus.
// Both pins are inputs only.  Every address/data byte is emitted after its
// ninth (ACK/NACK) clock.  Error reason is carried in flags[15:8].
module i2c_passive_monitor #(
    parameter integer CLK_HZ = 100000000,
    parameter integer STUCK_US = 1000,
    parameter integer BUSY_WINDOW_US = 10000,
    parameter [3:0] CHANNEL = 4'd0
) (
    input  wire         clk,
    input  wire         rst_n,
    input  wire [63:0]  timestamp,
    input  wire         i2c_scl,
    input  wire         i2c_sda,
    output reg          evt_valid,
    input  wire         evt_ready,
    output reg          evt_trigger,
    output reg  [127:0] evt_data,
    output reg  [31:0]  dropped_event_count
);

localparam integer STUCK_CLKS = (CLK_HZ / 1000000) * STUCK_US;
localparam integer BUSY_CLKS  = (CLK_HZ / 1000000) * BUSY_WINDOW_US;
localparam [3:0] PROTOCOL_I2C = 4'h3;
localparam [1:0] DIRECTION_DUPLEX = 2'b11;
localparam [5:0] EVENT_START = 6'h00;
localparam [5:0] EVENT_DATA  = 6'h01;
localparam [5:0] EVENT_END   = 6'h02;
localparam [5:0] EVENT_ERROR = 6'h3F;
localparam [7:0] ERR_ADDRESS_NACK = 8'h01;
localparam [7:0] ERR_BUSY_NACK    = 8'h02;
localparam [7:0] ERR_SDA_STUCK    = 8'h03;
localparam [7:0] ERR_SCL_STUCK    = 8'h04;
localparam [7:0] ERR_MISSING_STOP = 8'h05;

(* ASYNC_REG = "TRUE" *) reg scl_meta, scl_sync;
(* ASYNC_REG = "TRUE" *) reg sda_meta, sda_sync;
reg scl_d, sda_d;
reg transaction_active;
reg [23:0] transaction_id;
reg [3:0] bit_index;
reg [7:0] shift;
reg [7:0] captured_byte;
reg [7:0] byte_index;
reg [6:0] current_address;
reg current_write;
reg current_had_payload;
reg [31:0] idle_count;
reg [31:0] scl_low_count;
reg [31:0] busy_window;
reg stuck_reported;
reg nack_error_pending;
reg [7:0] nack_error_reason;
reg [7:0] nack_error_byte;
reg [23:0] nack_error_transaction_id;

wire scl_rising = !scl_d && scl_sync;
wire sda_falling = sda_d && !sda_sync;
wire sda_rising = !sda_d && sda_sync;
wire start_condition = sda_falling && scl_sync;
wire stop_condition = sda_rising && scl_sync;

function automatic [127:0] make_event;
    input [63:0] event_timestamp;
    input [5:0] event_type;
    input [15:0] flags;
    input [7:0] payload_length;
    input [23:0] event_transaction_id;
    begin
        make_event = {event_timestamp, PROTOCOL_I2C, CHANNEL,
                      DIRECTION_DUPLEX, event_type, flags,
                      payload_length, event_transaction_id};
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
        scl_meta <= 1'b1; scl_sync <= 1'b1; scl_d <= 1'b1;
        sda_meta <= 1'b1; sda_sync <= 1'b1; sda_d <= 1'b1;
        transaction_active <= 1'b0;
        transaction_id <= 24'd0;
        bit_index <= 4'd0;
        shift <= 8'd0;
        captured_byte <= 8'd0;
        byte_index <= 8'd0;
        current_address <= 7'd0;
        current_write <= 1'b0;
        current_had_payload <= 1'b0;
        idle_count <= 32'd0;
        scl_low_count <= 32'd0;
        busy_window <= 32'd0;
        stuck_reported <= 1'b0;
        nack_error_pending <= 1'b0;
        nack_error_reason <= 8'd0;
        nack_error_byte <= 8'd0;
        nack_error_transaction_id <= 24'd0;
        evt_valid <= 1'b0;
        evt_trigger <= 1'b0;
        evt_data <= 128'd0;
        dropped_event_count <= 32'd0;
    end else begin
        scl_meta <= i2c_scl; scl_sync <= scl_meta; scl_d <= scl_sync;
        sda_meta <= i2c_sda; sda_sync <= sda_meta; sda_d <= sda_sync;
        if (evt_valid && evt_ready) begin
            evt_valid <= 1'b0;
            evt_trigger <= 1'b0;
        end
        // A NACK needs both the raw ninth-clock DATA event and a diagnostic
        // ERROR event.  Queue the latter for the following cycle so neither
        // event overwrites the other on this single ready/valid output.
        if (nack_error_pending && (!evt_valid || evt_ready)) begin
            offer_event(make_event(timestamp, EVENT_ERROR,
                {nack_error_reason, nack_error_byte}, 8'd0,
                nack_error_transaction_id), 1'b1);
            nack_error_pending <= 1'b0;
        end
        if (busy_window != 0) busy_window <= busy_window - 32'd1;

        if (!scl_sync) begin
            if (scl_low_count < STUCK_CLKS) scl_low_count <= scl_low_count + 32'd1;
            if (scl_low_count == STUCK_CLKS - 1 && !stuck_reported) begin
                offer_event(make_event(timestamp, EVENT_ERROR,
                    {ERR_SCL_STUCK, 8'd0}, 8'd0, transaction_id), 1'b1);
                stuck_reported <= 1'b1;
                transaction_active <= 1'b0;
            end
        end else begin
            scl_low_count <= 32'd0;
            if (sda_sync || start_condition || stop_condition)
                stuck_reported <= 1'b0;
        end

        if (transaction_active && !scl_rising && !start_condition && !stop_condition) begin
            if (idle_count < STUCK_CLKS) idle_count <= idle_count + 32'd1;
            if (idle_count == STUCK_CLKS - 1 && !stuck_reported) begin
                if (!sda_sync) begin
                    offer_event(make_event(timestamp, EVENT_ERROR,
                        {ERR_SDA_STUCK, byte_index}, 8'd0,
                        transaction_id), 1'b1);
                end else begin
                    offer_event(make_event(timestamp, EVENT_ERROR,
                        {ERR_MISSING_STOP, byte_index}, 8'd0,
                        transaction_id), 1'b1);
                end
                transaction_active <= 1'b0;
                stuck_reported <= 1'b1;
            end
        end else begin
            idle_count <= 32'd0;
        end

        if (start_condition) begin
            if (!transaction_active) begin
                transaction_id <= transaction_id + 24'd1;
                transaction_active <= 1'b1;
                byte_index <= 8'd0;
                current_had_payload <= 1'b0;
                offer_event(make_event(timestamp, EVENT_START, 16'd0,
                    8'd0, transaction_id + 24'd1), 1'b0);
            end else begin
                // Repeated START belongs to the same logical transaction.
                byte_index <= 8'd0;
                offer_event(make_event(timestamp, EVENT_START, 16'h0001,
                    8'd0, transaction_id), 1'b0);
            end
            bit_index <= 4'd0;
            shift <= 8'd0;
            stuck_reported <= 1'b0;
        end else if (stop_condition && transaction_active) begin
            offer_event(make_event(timestamp, EVENT_END,
                {current_address, current_write, 8'd0}, byte_index,
                transaction_id), 1'b0);
            if (current_write && current_address == 7'h50 && current_had_payload)
                busy_window <= BUSY_CLKS;
            transaction_active <= 1'b0;
            bit_index <= 4'd0;
        end else if (scl_rising && transaction_active) begin
            if (bit_index < 4'd8) begin
                shift <= {shift[6:0], sda_sync};
                if (bit_index == 4'd7)
                    captured_byte <= {shift[6:0], sda_sync};
                bit_index <= bit_index + 4'd1;
            end else begin
                // Ninth clock: low is ACK, high is NACK.
                offer_event(make_event(timestamp, EVENT_DATA,
                    {sda_sync, (byte_index == 0),
                     (byte_index == 0 ? captured_byte[0] : 1'b0),
                     5'd0, captured_byte}, 8'd1, transaction_id), 1'b0);
                if (byte_index == 0) begin
                    current_address <= captured_byte[7:1];
                    current_write <= !captured_byte[0];
                    if (sda_sync) begin
                        nack_error_reason <=
                            (captured_byte[7:1] == 7'h50 && busy_window != 0) ?
                            ERR_BUSY_NACK : ERR_ADDRESS_NACK;
                        nack_error_byte <= captured_byte;
                        nack_error_transaction_id <= transaction_id;
                        nack_error_pending <= 1'b1;
                    end
                end else if (!sda_sync) begin
                    current_had_payload <= 1'b1;
                end
                byte_index <= byte_index + 8'd1;
                bit_index <= 4'd0;
                shift <= 8'd0;
            end
        end
    end
end

endmodule
