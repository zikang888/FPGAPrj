`timescale 1ns / 1ps

module spi_mode0_monitor_tb;

reg clk = 1'b0;
reg rst_n = 1'b0;
reg [63:0] timestamp = 64'd0;
reg spi_sclk = 1'b0;
reg spi_cs_n = 1'b1;
reg spi_mosi = 1'b0;
reg spi_miso = 1'b0;
wire evt_valid;
reg evt_ready = 1'b1;
wire evt_trigger;
wire [127:0] evt_data;
wire monitor_active;
wire [23:0] transaction_id;
wire [31:0] dropped_event_count;

reg [127:0] captured_event [0:255];
reg captured_trigger [0:255];
reg [127:0] held_event;
reg [7:0] expected_mosi;
reg [7:0] expected_miso;
integer event_count = 0;
integer failures = 0;
integer bit_index;
integer random_index;

always #5 clk = ~clk;

always @(posedge clk) begin
    timestamp <= timestamp + 64'd1;
    if (evt_valid && evt_ready) begin
        captured_event[event_count] <= evt_data;
        captured_trigger[event_count] <= evt_trigger;
        event_count <= event_count + 1;
    end
end

spi_mode0_monitor #(
    .CHANNEL(4'd2)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .timestamp(timestamp),
    .spi_sclk(spi_sclk),
    .spi_cs_n(spi_cs_n),
    .spi_mosi(spi_mosi),
    .spi_miso(spi_miso),
    .evt_valid(evt_valid),
    .evt_ready(evt_ready),
    .evt_trigger(evt_trigger),
    .evt_data(evt_data),
    .monitor_active(monitor_active),
    .transaction_id(transaction_id),
    .dropped_event_count(dropped_event_count)
);

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
        #50;
        spi_sclk = 1'b1;
        #50;
        spi_sclk = 1'b0;
    end
end
endtask

task spi_byte_with_pause;
    input [7:0] mosi_byte;
    input [7:0] miso_byte;
begin
    for (bit_index = 7; bit_index >= 0; bit_index = bit_index - 1) begin
        spi_mosi = mosi_byte[bit_index];
        spi_miso = miso_byte[bit_index];
        #50;
        spi_sclk = 1'b1;
        #50;
        spi_sclk = 1'b0;
        if (bit_index == 4) begin
            #1000;
        end
    end
end
endtask

task spi_partial_nibble;
    input [3:0] mosi_nibble;
    input [3:0] miso_nibble;
begin
    for (bit_index = 3; bit_index >= 0; bit_index = bit_index - 1) begin
        spi_mosi = mosi_nibble[bit_index];
        spi_miso = miso_nibble[bit_index];
        #50;
        spi_sclk = 1'b1;
        #50;
        spi_sclk = 1'b0;
    end
end
endtask

task spi_end;
begin
    #50;
    spi_cs_n = 1'b1;
    #200;
end
endtask

task check_event;
    input integer index;
    input [5:0] expected_type;
    input [15:0] expected_flags;
    input [7:0] expected_length;
    input [23:0] expected_transaction;
    input expected_trigger;
begin
    if (captured_event[index][63:60] !== 4'h2 ||
        captured_event[index][59:56] !== 4'h2 ||
        captured_event[index][55:54] !== 2'b11 ||
        captured_event[index][53:48] !== expected_type ||
        captured_event[index][47:32] !== expected_flags ||
        captured_event[index][31:24] !== expected_length ||
        captured_event[index][23:0] !== expected_transaction ||
        captured_trigger[index] !== expected_trigger) begin
        $display("FAIL event %0d data=%032h trigger=%0d",
                 index, captured_event[index], captured_trigger[index]);
        failures = failures + 1;
    end
end
endtask

initial begin
    repeat (5) @(posedge clk);
    rst_n = 1'b1;
    #100;

    // Golden bytes plus explicit output backpressure on START.
    evt_ready = 1'b0;
    spi_begin();
    if (!evt_valid) begin
        $display("FAIL START did not enter holding register");
        failures = failures + 1;
    end
    held_event = evt_data;
    #100;
    if (!evt_valid || evt_data !== held_event || evt_trigger !== 1'b0) begin
        $display("FAIL event changed while ready=0");
        failures = failures + 1;
    end
    evt_ready = 1'b1;
    #50;
    spi_byte(8'h00, 8'hFF);
    spi_byte(8'hFF, 8'h00);
    spi_byte(8'h55, 8'hAA);
    spi_byte(8'hAA, 8'h55);
    spi_end();

    if (event_count !== 6) begin
        $display("FAIL golden transaction event_count=%0d", event_count);
        failures = failures + 1;
    end
    check_event(0, 6'h00, 16'h0000, 8'd0, 24'd1, 1'b0);
    check_event(1, 6'h01, 16'hFF00, 8'd2, 24'd1, 1'b0);
    check_event(2, 6'h01, 16'h00FF, 8'd2, 24'd1, 1'b0);
    check_event(3, 6'h01, 16'hAA55, 8'd2, 24'd1, 1'b0);
    check_event(4, 6'h01, 16'h55AA, 8'd2, 24'd1, 1'b0);
    check_event(5, 6'h02, 16'h0000, 8'd0, 24'd1, 1'b0);

    // JEDEC ID transaction: command 9F followed by EF 40 18 response.
    spi_begin();
    spi_byte(8'h9F, 8'hFF);
    spi_byte(8'h00, 8'hEF);
    spi_byte(8'h00, 8'h40);
    spi_byte(8'h00, 8'h18);
    spi_end();
    check_event(6, 6'h00, 16'h0000, 8'd0, 24'd2, 1'b0);
    check_event(7, 6'h01, 16'hFF9F, 8'd2, 24'd2, 1'b0);
    check_event(8, 6'h01, 16'hEF00, 8'd2, 24'd2, 1'b0);
    check_event(9, 6'h01, 16'h4000, 8'd2, 24'd2, 1'b0);
    check_event(10, 6'h01, 16'h1800, 8'd2, 24'd2, 1'b0);
    check_event(11, 6'h02, 16'h0000, 8'd0, 24'd2, 1'b0);

    // Asynchronous phase offset and a long low-level SCLK pause.
    #17;
    spi_begin();
    spi_byte_with_pause(8'hA5, 8'h3C);
    spi_end();
    check_event(12, 6'h00, 16'h0000, 8'd0, 24'd3, 1'b0);
    check_event(13, 6'h01, 16'h3CA5, 8'd2, 24'd3, 1'b0);
    check_event(14, 6'h02, 16'h0000, 8'd0, 24'd3, 1'b0);

    // CS deasserted after four bits must produce a triggering frame error.
    spi_begin();
    spi_partial_nibble(4'hA, 4'h5);
    spi_end();
    check_event(15, 6'h00, 16'h0000, 8'd0, 24'd4, 1'b0);
    check_event(16, 6'h3F, 16'h0004, 8'd0, 24'd4, 1'b1);

    // Deterministic 100-byte stress transaction.
    spi_begin();
    for (random_index = 0; random_index < 100; random_index = random_index + 1) begin
        spi_byte(random_index[7:0], ~random_index[7:0]);
    end
    spi_end();
    check_event(17, 6'h00, 16'h0000, 8'd0, 24'd5, 1'b0);
    for (random_index = 0; random_index < 100; random_index = random_index + 1) begin
        expected_mosi = random_index[7:0];
        expected_miso = ~expected_mosi;
        check_event(18 + random_index, 6'h01,
                    {expected_miso, expected_mosi}, 8'd2, 24'd5, 1'b0);
    end
    check_event(118, 6'h02, 16'h0000, 8'd0, 24'd5, 1'b0);

    // If a consumer stalls across an entire transaction, loss is counted and
    // never silent. The first START remains stable and is delivered later.
    evt_ready = 1'b0;
    spi_begin();
    spi_byte(8'h12, 8'h34);
    spi_end();
    if (dropped_event_count !== 32'd2) begin
        $display("FAIL dropped_event_count=%0d", dropped_event_count);
        failures = failures + 1;
    end
    evt_ready = 1'b1;
    #100;
    check_event(119, 6'h00, 16'h0000, 8'd0, 24'd6, 1'b0);

    if (event_count !== 120) begin
        $display("FAIL final event_count=%0d", event_count);
        failures = failures + 1;
    end

    if (failures == 0) begin
        $display("PASS: SPI Mode-0 ready/valid, golden corpus, pause, phase, error and stress test");
    end else begin
        $fatal(1, "FAIL: SPI monitor failures=%0d", failures);
    end
    $finish;
end

endmodule
