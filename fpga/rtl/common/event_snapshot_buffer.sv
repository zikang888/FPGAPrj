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
    input  wire                     freeze,
    input wire retain_errors,
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

(* ram_style="block" *) reg [EVENT_WIDTH-1:0] memory [0:DEPTH-1];
reg memory_we;
reg [PTR_WIDTH-1:0] memory_address;
reg [EVENT_WIDTH-1:0] memory_data;
always @(posedge clk) if(memory_we) memory[memory_address]<=memory_data;
reg arc_valid_q, arc_freeze_q;
reg [EVENT_WIDTH-1:0] arc_event_q;
always @(posedge clk) begin
    if(!rst_n || arm) begin arc_valid_q<=0;arc_freeze_q<=0;arc_event_q<=0;end
    else begin arc_valid_q<=in_valid&&capture_active;arc_freeze_q<=freeze;arc_event_q<=in_event;end
end
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

// Abnormal-transaction archive. Uncommitted normal data uses free space
// after committed records and is discarded on END / next transaction.
reg [COUNT_WIDTH-1:0] arc_committed, arc_staged;
reg [27:0] arc_key;
reg arc_have, arc_error, arc_cut;
reg [8:0] arc_bytes;
reg [7:0] arc_command;
reg arc_bad_id;
reg [COUNT_WIDTH-1:0] ac, ast;
reg [27:0] ak;
reg ah, ae, ax, ab;
reg [8:0] an;
reg [7:0] cmd;
reg archive_write, archive_full;
reg [PTR_WIDTH-1:0] archive_address;
wire [3:0] event_protocol = arc_event_q[63:60];
wire [5:0] event_type = arc_event_q[53:48];
wire [7:0] error_reason = arc_event_q[47:40];
wire [27:0] event_key = {event_protocol,arc_event_q[23:0]};
wire primary_error = event_type == 8'h3f &&
    ((event_protocol == 2) ||
     (event_protocol == 1 && (error_reason == 1 || error_reason == 2 || error_reason == 4)) ||
     (event_protocol == 3 && (error_reason == 1 || error_reason == 5)) ||
     (event_protocol == 4 && (error_reason == 1 || error_reason == 3 || error_reason == 4)));
always @* begin
    ac=arc_committed; ast=arc_staged; ak=arc_key; ah=arc_have;
    ae=arc_error; ax=arc_cut; an=arc_bytes; cmd=arc_command; ab=arc_bad_id;
    archive_write=0; archive_address=0; archive_full=0;
    if(arc_valid_q) begin
        if(!ah || ak != event_key) begin
            // Protocol STARTs can occur twice for an I2C repeated START;
            // only a new transaction ID terminates its staging area.
            if(ah && ak == event_key) begin end
            else begin
                if(ae) begin ac=ast; if(ax) archive_full=1; end
                ast=ac; ae=0; ax=0; an=0; cmd=0; ab=0;
                ak=event_key; ah=1;
            end
        end
        if(ast < DEPTH_COUNT) begin
            archive_write=1; archive_address=ast; ast=ast+1'b1;
        end else ax=1;
        if(primary_error) ae=1;
        if(event_protocol == 2 && event_type == 1) begin
            if(an == 0) cmd=arc_event_q[39:32];
            if((an==1 && arc_event_q[47:40]!=8'hef) ||
               (an==2 && arc_event_q[47:40]!=8'h40) ||
               (an==3 && arc_event_q[47:40]!=8'h18)) ab=1;
            if(an!=511) an=an+1'b1;
        end
        if(event_type == 2) begin
            if(event_protocol == 2 && cmd == 8'h9f && (an != 4 || ab)) ae=1;
            if(ae) begin ac=ast; if(ax) archive_full=1; end
            ast=ac; ae=0; ax=0; ah=0; an=0; cmd=0; ab=0;
        end
    end
    if(arc_freeze_q) begin
        if(ae) begin ac=ast; if(ax) archive_full=1; end
        ast=ac; ae=0; ah=0;
    end
end

initial begin
    if (DEPTH < 2 || (DEPTH & (DEPTH - 1)) != 0) begin
        $error("event_snapshot_buffer DEPTH must be a power of two >= 2");
    end
end

always @(posedge clk) begin
    if (!rst_n) begin
        memory_we<=0;memory_address<=0;memory_data<=0;
        arc_committed<=0;arc_staged<=0;arc_key<=0;arc_have<=0;arc_error<=0;arc_cut<=0;arc_bytes<=0;arc_command<=0;arc_bad_id<=0;
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
        memory_we<=0;
        rd_valid <= 1'b0;
        if (rd_en && snapshot_ready && rd_index < snapshot_count) begin
            rd_event <= memory[read_physical_index];
            rd_valid <= 1'b1;
        end

        if (arm) begin
            arc_committed<=0;arc_staged<=0;arc_key<=0;arc_have<=0;arc_error<=0;arc_cut<=0;arc_bytes<=0;arc_command<=0;arc_bad_id<=0;
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

            if(retain_errors && capture_active) begin
                arc_committed<=ac;arc_staged<=ast;arc_key<=ak;arc_have<=ah;
                arc_error<=ae;arc_cut<=ax;arc_bytes<=an;arc_command<=cmd;arc_bad_id<=ab;
                if(archive_write) begin memory_we<=1;memory_address<=archive_address;memory_data<=arc_event_q;end
                if(archive_full) overwritten<=1;
                if(arc_freeze_q) begin
                    capture_active<=0;snapshot_ready<=1;snapshot_id<=snapshot_id+1;
                    snapshot_count<=ac;snapshot_start<=0;snapshot_trigger_index<=0;
                end
            end else if (capture_active && (in_valid || freeze)) begin
                if (in_valid) begin
                    memory_we<=1;memory_address<=write_pointer;memory_data<=in_event;
                    write_pointer <= next_write_pointer;
                    capture_count <= next_capture_count;
                end

                if (in_valid && capture_count == DEPTH_COUNT) begin
                    overwritten <= 1'b1;
                end

                // Include a simultaneous accepted event; allow empty sessions.
                if (freeze) begin
                    capture_active <= 1'b0;
                    snapshot_ready <= 1'b1;
                    snapshot_id <= snapshot_id + 32'd1;
                    snapshot_count <= in_valid ? next_capture_count : capture_count;
                    snapshot_start <= in_valid ? next_snapshot_start :
                        ((capture_count == DEPTH_COUNT) ? write_pointer : {PTR_WIDTH{1'b0}});
                    snapshot_trigger_index <= {PTR_WIDTH{1'b0}};
                end else if (!trigger_seen && in_trigger) begin
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

