`timescale 1ns / 1ps

// Two-source ready/valid event arbiter with round-robin fairness.
// Sources must keep data and trigger stable while valid=1 and ready=0.
module event_arbiter_2 #(
    parameter integer EVENT_WIDTH = 128
) (
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire                   s0_valid,
    output wire                   s0_ready,
    input  wire [EVENT_WIDTH-1:0] s0_data,
    input  wire                   s0_trigger,
    input  wire                   s1_valid,
    output wire                   s1_ready,
    input  wire [EVENT_WIDTH-1:0] s1_data,
    input  wire                   s1_trigger,
    output wire                   out_valid,
    input  wire                   out_ready,
    output wire [EVENT_WIDTH-1:0] out_data,
    output wire                   out_trigger,
    output wire                   out_source,
    output reg  [31:0]            contention_count
);

reg last_grant;
wire both_valid = s0_valid && s1_valid;
wire select_s1 = s1_valid && (!s0_valid || !last_grant);

assign out_valid = s0_valid || s1_valid;
assign out_data = select_s1 ? s1_data : s0_data;
assign out_trigger = select_s1 ? s1_trigger : s0_trigger;
assign out_source = select_s1;
assign s0_ready = out_ready && out_valid && !select_s1;
assign s1_ready = out_ready && out_valid && select_s1;

always @(posedge clk) begin
    if (!rst_n) begin
        last_grant <= 1'b0;
        contention_count <= 32'd0;
    end else if (out_valid && out_ready) begin
        last_grant <= select_s1;
        if (both_valid) begin
            contention_count <= contention_count + 32'd1;
        end
    end
end

endmodule
