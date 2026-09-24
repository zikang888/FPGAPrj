`timescale 1ns / 1ps

module event_snapshot_buffer_tb;

localparam integer EVENT_WIDTH = 128;
localparam integer DEPTH = 8;
localparam integer PTR_WIDTH = 3;
localparam integer COUNT_WIDTH = 4;

reg clk = 1'b0;
reg rst_n = 1'b0;
reg arm = 1'b0;
reg ack = 1'b0;
reg in_valid = 1'b0;
reg [EVENT_WIDTH-1:0] in_event = {EVENT_WIDTH{1'b0}};
reg in_trigger = 1'b0;
wire capture_active;
wire snapshot_ready;
wire [31:0] snapshot_id;
wire [COUNT_WIDTH-1:0] snapshot_count;
wire [PTR_WIDTH-1:0] snapshot_trigger_index;
wire overwritten;
reg rd_en = 1'b0;
reg [PTR_WIDTH-1:0] rd_index = {PTR_WIDTH{1'b0}};
wire rd_valid;
wire [EVENT_WIDTH-1:0] rd_event;

integer index;
integer failures = 0;

always #5 clk = ~clk;

event_snapshot_buffer #(
    .EVENT_WIDTH(EVENT_WIDTH),
    .DEPTH(DEPTH),
    .POST_TRIGGER_EVENTS(2)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .arm(arm),
    .ack(ack),
    .in_valid(in_valid),
    .in_event(in_event),
    .in_trigger(in_trigger),
    .capture_active(capture_active),
    .snapshot_ready(snapshot_ready),
    .snapshot_id(snapshot_id),
    .snapshot_count(snapshot_count),
    .snapshot_trigger_index(snapshot_trigger_index),
    .overwritten(overwritten),
    .rd_en(rd_en),
    .rd_index(rd_index),
    .rd_valid(rd_valid),
    .rd_event(rd_event)
);

task pulse_arm;
begin
    @(negedge clk); arm = 1'b1;
    @(negedge clk); arm = 1'b0;
end
endtask

task pulse_ack;
begin
    @(negedge clk); ack = 1'b1;
    @(negedge clk); ack = 1'b0;
end
endtask

task send_event;
    input [31:0] value;
    input trigger;
begin
    @(negedge clk);
    in_event = {{(EVENT_WIDTH-32){1'b0}}, value};
    in_trigger = trigger;
    in_valid = 1'b1;
    @(negedge clk);
    in_valid = 1'b0;
    in_trigger = 1'b0;
end
endtask

task check_event;
    input [PTR_WIDTH-1:0] logical_index;
    input [31:0] expected;
begin
    @(negedge clk);
    rd_index = logical_index;
    rd_en = 1'b1;
    @(posedge clk);
    #1;
    if (!rd_valid || rd_event[31:0] !== expected) begin
        $display("FAIL read index=%0d expected=%0d got=%0d valid=%0d",
                 logical_index, expected, rd_event[31:0], rd_valid);
        failures = failures + 1;
    end
    @(negedge clk);
    rd_en = 1'b0;
end
endtask

initial begin
    repeat (3) @(negedge clk);
    rst_n = 1'b1;

    pulse_arm();
    for (index = 0; index < 10; index = index + 1) begin
        send_event(index, 1'b0);
    end
    send_event(10, 1'b1);
    send_event(11, 1'b0);
    send_event(12, 1'b0);
    @(negedge clk);

    if (!snapshot_ready || capture_active || snapshot_count != 8 ||
        snapshot_trigger_index != 5 || !overwritten || snapshot_id != 1) begin
        $display("FAIL wrapped metadata ready=%0d active=%0d count=%0d trig=%0d over=%0d id=%0d",
                 snapshot_ready, capture_active, snapshot_count,
                 snapshot_trigger_index, overwritten, snapshot_id);
        failures = failures + 1;
    end

    for (index = 0; index < 8; index = index + 1) begin
        check_event(index[PTR_WIDTH-1:0], index + 5);
    end

    pulse_ack();
    if (snapshot_ready) begin
        $display("FAIL ACK did not clear snapshot_ready");
        failures = failures + 1;
    end

    pulse_arm();
    send_event(20, 1'b1);
    send_event(21, 1'b0);
    send_event(22, 1'b0);
    @(negedge clk);

    if (!snapshot_ready || snapshot_count != 3 ||
        snapshot_trigger_index != 0 || overwritten || snapshot_id != 2) begin
        $display("FAIL short metadata ready=%0d count=%0d trig=%0d over=%0d id=%0d",
                 snapshot_ready, snapshot_count, snapshot_trigger_index,
                 overwritten, snapshot_id);
        failures = failures + 1;
    end

    check_event(0, 20);
    check_event(1, 21);
    check_event(2, 22);

    if (failures == 0) begin
        $display("PASS: event snapshot wrap, trigger, post-count, ACK and re-arm");
    end else begin
        $fatal(1, "FAIL: event snapshot failures=%0d", failures);
    end
    $finish;
end

endmodule
