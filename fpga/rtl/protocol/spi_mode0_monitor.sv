`timescale 1ns / 1ps

// Passive SPI Mode-0 monitor.
//
// All external SPI pins are synchronized into clk.  This keeps the monitor in
// one clock domain and is appropriate when clk is at least four times faster
// than spi_sclk.  The current platform clock is 100 MHz, so the initial
// supported SPI clock is limited to 25 MHz.
//
// One unified event is emitted for transaction start, every full-duplex byte,
// transaction end, or an incomplete byte detected when CS rises.
module spi_mode0_monitor #(
    parameter [3:0] CHANNEL = 4'd0
) (
    input  wire         clk,
    input  wire         rst_n,
    input  wire [63:0]  timestamp,
    input  wire         spi_sclk,
    input  wire         spi_cs_n,
    input  wire         spi_mosi,
    input  wire         spi_miso,
    output reg          evt_valid,
    input  wire         evt_ready,
    output reg          evt_trigger,
    output reg  [127:0] evt_data,
    output reg          monitor_active,
    output reg  [23:0]  transaction_id,
    output reg  [31:0]  dropped_event_count
);

localparam [3:0] PROTOCOL_SPI      = 4'h2;
localparam [1:0] DIRECTION_DUPLEX  = 2'b11;
localparam [5:0] EVENT_START       = 6'h00;
localparam [5:0] EVENT_DATA        = 6'h01;
localparam [5:0] EVENT_END         = 6'h02;
localparam [5:0] EVENT_FRAME_ERROR = 6'h3F;

reg spi_sclk_meta;
reg spi_sclk_sync;
reg spi_sclk_d;
reg spi_cs_meta;
reg spi_cs_sync;
reg spi_cs_d;
reg spi_mosi_meta;
reg spi_mosi_sync;
reg spi_miso_meta;
reg spi_miso_sync;

reg [2:0] bit_count;
reg [7:0] mosi_shift;
reg [7:0] miso_shift;

wire cs_falling = spi_cs_d && !spi_cs_sync;
wire cs_rising  = !spi_cs_d && spi_cs_sync;
wire sclk_rising = !spi_sclk_d && spi_sclk_sync;

function automatic [127:0] make_event;
    input [63:0] event_timestamp;
    input [5:0]  event_type;
    input [15:0] flags;
    input [7:0]  payload_length;
    input [23:0] event_transaction_id;
    begin
        make_event = {
            event_timestamp,
            PROTOCOL_SPI,
            CHANNEL,
            DIRECTION_DUPLEX,
            event_type,
            flags,
            payload_length,
            event_transaction_id
        };
    end
endfunction

always @(posedge clk) begin
    if (!rst_n) begin
        spi_sclk_meta <= 1'b0;
        spi_sclk_sync <= 1'b0;
        spi_sclk_d <= 1'b0;
        spi_cs_meta <= 1'b1;
        spi_cs_sync <= 1'b1;
        spi_cs_d <= 1'b1;
        spi_mosi_meta <= 1'b0;
        spi_mosi_sync <= 1'b0;
        spi_miso_meta <= 1'b0;
        spi_miso_sync <= 1'b0;
        bit_count <= 3'd0;
        mosi_shift <= 8'd0;
        miso_shift <= 8'd0;
        evt_valid <= 1'b0;
        evt_trigger <= 1'b0;
        evt_data <= 128'd0;
        monitor_active <= 1'b0;
        transaction_id <= 24'd0;
        dropped_event_count <= 32'd0;
    end else begin
        spi_sclk_meta <= spi_sclk;
        spi_sclk_sync <= spi_sclk_meta;
        spi_sclk_d <= spi_sclk_sync;
        spi_cs_meta <= spi_cs_n;
        spi_cs_sync <= spi_cs_meta;
        spi_cs_d <= spi_cs_sync;
        spi_mosi_meta <= spi_mosi;
        spi_mosi_sync <= spi_mosi_meta;
        spi_miso_meta <= spi_miso;
        spi_miso_sync <= spi_miso_meta;

        // Release a transferred event. A new event generated in this cycle may
        // immediately replace it below without inserting a bubble.
        if (evt_valid && evt_ready) begin
            evt_valid <= 1'b0;
            evt_trigger <= 1'b0;
        end

        if (cs_falling) begin
            monitor_active <= 1'b1;
            bit_count <= 3'd0;
            mosi_shift <= 8'd0;
            miso_shift <= 8'd0;
            transaction_id <= transaction_id + 24'd1;
            if (!evt_valid || evt_ready) begin
                evt_valid <= 1'b1;
                evt_trigger <= 1'b0;
                evt_data <= make_event(timestamp, EVENT_START, 16'd0, 8'd0,
                                       transaction_id + 24'd1);
            end else begin
                dropped_event_count <= dropped_event_count + 32'd1;
            end
        end else if (cs_rising && monitor_active) begin
            monitor_active <= 1'b0;
            if (!evt_valid || evt_ready) begin
                evt_valid <= 1'b1;
                if (bit_count != 3'd0) begin
                    evt_trigger <= 1'b1;
                    evt_data <= make_event(timestamp, EVENT_FRAME_ERROR,
                                          {13'd0, bit_count}, 8'd0,
                                          transaction_id);
                end else begin
                    evt_trigger <= 1'b0;
                    evt_data <= make_event(timestamp, EVENT_END, 16'd0, 8'd0,
                                          transaction_id);
                end
            end else begin
                dropped_event_count <= dropped_event_count + 32'd1;
            end
            bit_count <= 3'd0;
        end else if (sclk_rising && monitor_active && !spi_cs_sync) begin
            mosi_shift <= {mosi_shift[6:0], spi_mosi_sync};
            miso_shift <= {miso_shift[6:0], spi_miso_sync};
            if (bit_count == 3'd7) begin
                if (!evt_valid || evt_ready) begin
                    evt_valid <= 1'b1;
                    evt_trigger <= 1'b0;
                    evt_data <= make_event(
                        timestamp,
                        EVENT_DATA,
                        {{miso_shift[6:0], spi_miso_sync},
                         {mosi_shift[6:0], spi_mosi_sync}},
                        8'd2,
                        transaction_id
                    );
                end else begin
                    dropped_event_count <= dropped_event_count + 32'd1;
                end
                bit_count <= 3'd0;
            end else begin
                bit_count <= bit_count + 3'd1;
            end
        end
    end
end

endmodule
