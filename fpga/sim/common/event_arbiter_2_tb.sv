`timescale 1ns / 1ps

module event_arbiter_2_tb;

reg clk = 1'b0;
reg rst_n = 1'b0;
reg s0_valid = 1'b0;
wire s0_ready;
reg [127:0] s0_data = 128'd0;
reg s0_trigger = 1'b0;
reg s1_valid = 1'b0;
wire s1_ready;
reg [127:0] s1_data = 128'd0;
reg s1_trigger = 1'b0;
wire out_valid;
reg out_ready = 1'b0;
wire [127:0] out_data;
wire out_trigger;
wire out_source;
wire [31:0] contention_count;
integer failures = 0;

always #5 clk = ~clk;

event_arbiter_2 dut (
    .clk(clk), .rst_n(rst_n),
    .s0_valid(s0_valid), .s0_ready(s0_ready),
    .s0_data(s0_data), .s0_trigger(s0_trigger),
    .s1_valid(s1_valid), .s1_ready(s1_ready),
    .s1_data(s1_data), .s1_trigger(s1_trigger),
    .out_valid(out_valid), .out_ready(out_ready),
    .out_data(out_data), .out_trigger(out_trigger),
    .out_source(out_source), .contention_count(contention_count)
);

initial begin
    repeat (4) @(posedge clk);
    rst_n = 1'b1;

    @(negedge clk);
    s0_data = 128'h10;
    s0_trigger = 1'b1;
    s0_valid = 1'b1;
    repeat (3) begin
        @(posedge clk);
        #1;
        if (!out_valid || s0_ready || out_data !== 128'h10 || !out_trigger) begin
            $display("FAIL stalled source-0 transfer");
            failures = failures + 1;
        end
    end
    out_ready = 1'b1;
    @(posedge clk);
    #1;
    if (!s0_ready || out_source !== 1'b0) begin
        $display("FAIL source-0 handshake");
        failures = failures + 1;
    end
    @(negedge clk);
    s0_valid = 1'b0;
    s0_trigger = 1'b0;

    s0_data = 128'h20;
    s1_data = 128'h21;
    s0_valid = 1'b1;
    s1_valid = 1'b1;
    #1;
    if (!s1_ready || s0_ready || out_source !== 1'b1 || out_data !== 128'h21) begin
        $display("FAIL first round-robin grant");
        failures = failures + 1;
    end
    @(posedge clk);
    @(negedge clk);
    s1_valid = 1'b0;

    @(posedge clk);
    #1;
    if (!s0_ready || out_source !== 1'b0 || out_data !== 128'h20) begin
        $display("FAIL second round-robin grant");
        failures = failures + 1;
    end
    @(negedge clk);
    s0_valid = 1'b0;

    s0_data = 128'h30;
    s1_data = 128'h31;
    s0_valid = 1'b1;
    s1_valid = 1'b1;
    #1;
    if (!s1_ready || out_source !== 1'b1 || out_data !== 128'h31) begin
        $display("FAIL fairness grant");
        failures = failures + 1;
    end
    @(posedge clk);
    @(negedge clk);
    s0_valid = 1'b0;
    s1_valid = 1'b0;

    if (contention_count !== 32'd2) begin
        $display("FAIL contention_count=%0d", contention_count);
        failures = failures + 1;
    end

    if (failures == 0) begin
        $display("PASS: two-source ready/valid arbitration, backpressure and fairness");
    end else begin
        $fatal(1, "FAIL: event arbiter failures=%0d", failures);
    end
    $finish;
end

endmodule
