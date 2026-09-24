`timescale 1ns / 1ps

module spi_snapshot_path_tb;

reg clk = 1'b0;
reg rst_n = 1'b0;
reg [63:0] timestamp = 64'd0;
reg spi_sclk = 1'b0;
reg spi_cs_n = 1'b1;
reg spi_mosi = 1'b0;
reg spi_miso = 1'b0;
reg arm = 1'b0;
reg ack = 1'b0;

wire spi_valid;
wire spi_ready;
wire spi_trigger;
wire [127:0] spi_event;
wire spi_active;
wire [23:0] spi_transaction_id;
wire [31:0] spi_dropped_count;

wire arb_valid;
wire arb_ready;
wire arb_trigger;
wire [127:0] arb_event;
wire arb_source;
wire [31:0] contention_count;

wire capture_active;
wire snapshot_ready;
wire [31:0] snapshot_id;
wire [8:0] snapshot_count;
wire [7:0] snapshot_trigger_index;
wire snapshot_overwritten;
reg snapshot_rd_en = 1'b0;
reg [7:0] snapshot_rd_index = 8'd0;
wire snapshot_rd_valid;
wire [127:0] snapshot_rd_event;

integer failures = 0;
integer bit_index;
integer post_index;

always #5 clk = ~clk;
always @(posedge clk) timestamp <= timestamp + 64'd1;

spi_mode0_monitor #(
    .CHANNEL(4'd0)
) spi_monitor (
    .clk(clk), .rst_n(rst_n), .timestamp(timestamp),
    .spi_sclk(spi_sclk), .spi_cs_n(spi_cs_n),
    .spi_mosi(spi_mosi), .spi_miso(spi_miso),
    .evt_valid(spi_valid), .evt_ready(spi_ready),
    .evt_trigger(spi_trigger), .evt_data(spi_event),
    .monitor_active(spi_active),
    .transaction_id(spi_transaction_id),
    .dropped_event_count(spi_dropped_count)
);

event_arbiter_2 arbiter (
    .clk(clk), .rst_n(rst_n),
    .s0_valid(1'b0), .s0_ready(),
    .s0_data(128'd0), .s0_trigger(1'b0),
    .s1_valid(spi_valid), .s1_ready(spi_ready),
    .s1_data(spi_event), .s1_trigger(spi_trigger),
    .out_valid(arb_valid), .out_ready(arb_ready),
    .out_data(arb_event), .out_trigger(arb_trigger),
    .out_source(arb_source), .contention_count(contention_count)
);

assign arb_ready = capture_active;

event_snapshot_buffer #(
    .EVENT_WIDTH(128),
    .DEPTH(256),
    .POST_TRIGGER_EVENTS(16)
) snapshot_buffer (
    .clk(clk), .rst_n(rst_n), .arm(arm), .ack(ack),
    .in_valid(arb_valid && arb_ready),
    .in_event(arb_event), .in_trigger(arb_trigger),
    .capture_active(capture_active),
    .snapshot_ready(snapshot_ready), .snapshot_id(snapshot_id),
    .snapshot_count(snapshot_count),
    .snapshot_trigger_index(snapshot_trigger_index),
    .overwritten(snapshot_overwritten),
    .rd_en(snapshot_rd_en), .rd_index(snapshot_rd_index),
    .rd_valid(snapshot_rd_valid), .rd_event(snapshot_rd_event)
);

task pulse_arm;
begin
    @(negedge clk); arm = 1'b1;
    @(negedge clk); arm = 1'b0;
end
endtask

task spi_begin;
begin
    spi_sclk = 1'b0;
    spi_cs_n = 1'b0;
    #100;
end
endtask

task spi_byte;
    input [7:0] mosi_byte;
    input [7:0] miso_byte;
begin
    for (bit_index = 7; bit_index >= 0; bit_index = bit_index - 1) begin
        spi_mosi = mosi_byte[bit_index];
        spi_miso = miso_byte[bit_index];
        #50; spi_sclk = 1'b1;
        #50; spi_sclk = 1'b0;
    end
end
endtask

task spi_partial_nibble;
begin
    for (bit_index = 3; bit_index >= 0; bit_index = bit_index - 1) begin
        spi_mosi = 4'hA >> bit_index;
        spi_miso = 4'h5 >> bit_index;
        #50; spi_sclk = 1'b1;
        #50; spi_sclk = 1'b0;
    end
end
endtask

task spi_end;
begin
    #50; spi_cs_n = 1'b1;
    #200;
end
endtask

task read_snapshot;
    input [7:0] index;
    output [127:0] value;
begin
    @(negedge clk);
    snapshot_rd_index = index;
    snapshot_rd_en = 1'b1;
    @(posedge clk);
    #1;
    if (!snapshot_rd_valid) begin
        $display("FAIL snapshot read valid index=%0d", index);
        failures = failures + 1;
    end
    value = snapshot_rd_event;
    @(negedge clk);
    snapshot_rd_en = 1'b0;
end
endtask

reg [127:0] value;

initial begin
    repeat (5) @(posedge clk);
    rst_n = 1'b1;
    pulse_arm();

    // Three pre-trigger events: START, DATA, END.
    spi_begin();
    spi_byte(8'h9F, 8'hEF);
    spi_end();

    // START followed by a four-bit frame error is the trigger event.
    spi_begin();
    spi_partial_nibble();
    spi_end();

    // More than sixteen events after the trigger. The snapshot must freeze
    // after exactly sixteen, while subsequent monitor loss is counted.
    for (post_index = 0; post_index < 6; post_index = post_index + 1) begin
        spi_begin();
        spi_byte(post_index[7:0], ~post_index[7:0]);
        spi_end();
    end
    #300;

    if (!snapshot_ready || capture_active || snapshot_id !== 32'd1 ||
        snapshot_count !== 9'd21 || snapshot_trigger_index !== 8'd4 ||
        snapshot_overwritten) begin
        $display("FAIL metadata ready=%0d active=%0d id=%0d count=%0d trig=%0d over=%0d",
                 snapshot_ready, capture_active, snapshot_id, snapshot_count,
                 snapshot_trigger_index, snapshot_overwritten);
        failures = failures + 1;
    end

    read_snapshot(8'd0, value);
    if (value[63:60] !== 4'h2 || value[53:48] !== 6'h00 ||
        value[23:0] !== 24'd1) begin
        $display("FAIL first SPI START event=%032h", value);
        failures = failures + 1;
    end

    read_snapshot(8'd1, value);
    if (value[53:48] !== 6'h01 || value[47:32] !== 16'hEF9F ||
        value[31:24] !== 8'd2) begin
        $display("FAIL SPI DATA event=%032h", value);
        failures = failures + 1;
    end

    read_snapshot(8'd4, value);
    if (value[53:48] !== 6'h3F || value[47:32] !== 16'h0004 ||
        value[23:0] !== 24'd2) begin
        $display("FAIL trigger frame-error event=%032h", value);
        failures = failures + 1;
    end

    read_snapshot(8'd20, value);
    if (value[63:60] !== 4'h2) begin
        $display("FAIL last post-trigger event=%032h", value);
        failures = failures + 1;
    end

    if (contention_count !== 32'd0) begin
        $display("FAIL unexpected contention=%0d", contention_count);
        failures = failures + 1;
    end

    if (failures == 0) begin
        $display("PASS: SPI waveform through ready/valid arbiter to triggered snapshot");
    end else begin
        $fatal(1, "FAIL: SPI snapshot path failures=%0d", failures);
    end
    $finish;
end

endmodule
