`timescale 1ns / 1ps

module event_snapshot_buffer #(
    parameter integer EVENT_WIDTH         = 128,
    parameter integer DEPTH               = 256,
    parameter integer POST_TRIGGER_EVENTS = 16,
    parameter integer PTR_WIDTH           = $clog2(DEPTH),
    parameter integer COUNT_WIDTH         = $clog2(DEPTH + 1),
    parameter integer POST_WIDTH          =
        (POST_TRIGGER_EVENTS < 2) ? 1 : $clog2(POST_TRIGGER_EVENTS + 1)
) (
    input  wire                     clk,
    input  wire                     rst_n,
    input  wire                     arm,
    input  wire                     ack,
    input  wire                     in_valid,
    input  wire [EVENT_WIDTH-1:0]   in_event,
    input  wire                     in_trigger,
    output reg                      capture_active,
    output reg                      snapshot_ready,
    output reg  [31:0]              snapshot_id,
    output reg  [COUNT_WIDTH-1:0]   snapshot_count,
    output reg  [PTR_WIDTH-1:0]     snapshot_trigger_index,
    output reg                      overwritten,
    input  wire                     rd_en,
    input  wire [PTR_WIDTH-1:0]     rd_index,
    output reg                      rd_valid,
    output reg  [EVENT_WIDTH-1:0]   rd_event
);

localparam [COUNT_WIDTH-1:0] DEPTH_COUNT = DEPTH;
localparam [POST_WIDTH-1:0] POST_COUNT = POST_TRIGGER_EVENTS;

reg [EVENT_WIDTH-1:0] memory [0:DEPTH-1];
reg [PTR_WIDTH-1:0] write_pointer;
reg [COUNT_WIDTH-1:0] capture_count;
reg trigger_seen;
reg [PTR_WIDTH-1:0] trigger_physical_index;
reg [POST_WIDTH-1:0] post_remaining;
reg [PTR_WIDTH-1:0] snapshot_start;

wire [PTR_WIDTH-1:0] next_write_pointer = write_pointer + 1'b1;
wire [COUNT_WIDTH-1:0] next_capture_count =
    (capture_count < DEPTH_COUNT) ? capture_count + 1'b1 : capture_count;
wire [PTR_WIDTH-1:0] next_snapshot_start =
    (next_capture_count == DEPTH_COUNT) ? next_write_pointer : {PTR_WIDTH{1'b0}};
wire [PTR_WIDTH-1:0] read_physical_index = snapshot_start + rd_index;

initial begin
    if (DEPTH < 2 || (DEPTH & (DEPTH - 1)) != 0) begin
        $error("event_snapshot_buffer DEPTH must be a power of two >= 2");
    end
end

always @(posedge clk) begin
    if (!rst_n) begin
        capture_active         <= 1'b0;
        snapshot_ready         <= 1'b0;
        snapshot_id            <= 32'd0;
        snapshot_count         <= {COUNT_WIDTH{1'b0}};
        snapshot_trigger_index <= {PTR_WIDTH{1'b0}};
        overwritten            <= 1'b0;
        write_pointer          <= {PTR_WIDTH{1'b0}};
        capture_count          <= {COUNT_WIDTH{1'b0}};
        trigger_seen           <= 1'b0;
        trigger_physical_index <= {PTR_WIDTH{1'b0}};
        post_remaining         <= {POST_WIDTH{1'b0}};
        snapshot_start         <= {PTR_WIDTH{1'b0}};
        rd_valid               <= 1'b0;
        rd_event               <= {EVENT_WIDTH{1'b0}};
    end else begin
        rd_valid <= 1'b0;
        if (rd_en && snapshot_ready && rd_index < snapshot_count) begin
            rd_event <= memory[read_physical_index];
            rd_valid <= 1'b1;
        end

        if (arm) begin
            capture_active         <= 1'b1;
            snapshot_ready         <= 1'b0;
            snapshot_count         <= {COUNT_WIDTH{1'b0}};
            snapshot_trigger_index <= {PTR_WIDTH{1'b0}};
            overwritten            <= 1'b0;
            write_pointer          <= {PTR_WIDTH{1'b0}};
            capture_count          <= {COUNT_WIDTH{1'b0}};
            trigger_seen           <= 1'b0;
            trigger_physical_index <= {PTR_WIDTH{1'b0}};
            post_remaining         <= {POST_WIDTH{1'b0}};
            snapshot_start         <= {PTR_WIDTH{1'b0}};
        end else begin
            if (ack) begin
                snapshot_ready <= 1'b0;
            end

            if (capture_active && in_valid) begin
                memory[write_pointer] <= in_event;
                write_pointer <= next_write_pointer;
                capture_count <= next_capture_count;

                if (capture_count == DEPTH_COUNT) begin
                    overwritten <= 1'b1;
                end

                if (!trigger_seen && in_trigger) begin
                    trigger_seen <= 1'b1;
                    trigger_physical_index <= write_pointer;
                    if (POST_TRIGGER_EVENTS == 0) begin
                        capture_active <= 1'b0;
                        snapshot_ready <= 1'b1;
                        snapshot_id <= snapshot_id + 32'd1;
                        snapshot_count <= next_capture_count;
                        snapshot_start <= next_snapshot_start;
                        snapshot_trigger_index <= write_pointer - next_snapshot_start;
                    end else begin
                        post_remaining <= POST_COUNT;
                    end
                end else if (trigger_seen) begin
                    if (post_remaining == 1) begin
                        capture_active <= 1'b0;
                        snapshot_ready <= 1'b1;
                        snapshot_id <= snapshot_id + 32'd1;
                        snapshot_count <= next_capture_count;
                        snapshot_start <= next_snapshot_start;
                        snapshot_trigger_index <= trigger_physical_index - next_snapshot_start;
                        post_remaining <= {POST_WIDTH{1'b0}};
                    end else begin
                        post_remaining <= post_remaining - 1'b1;
                    end
                end
            end
        end
    end
end

endmodule
