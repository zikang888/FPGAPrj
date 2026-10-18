`timescale 1ns / 1ps

module uart_rx_monitor_tb;
localparam integer BIT_NS = 100;
reg clk = 1'b0;
reg rst_n = 1'b0;
reg [63:0] timestamp = 64'd0;
reg uart_rx = 1'b1;
reg evt_ready = 1'b1;
wire evt_valid;
wire evt_trigger;
wire [127:0] evt_data;
wire [31:0] dropped;
integer event_count = 0;
integer data_count = 0;
integer end_count = 0;
integer stop_errors = 0;
integer break_errors = 0;
integer short_errors = 0;

always #5 clk = ~clk;
always @(posedge clk) timestamp <= timestamp + 64'd1;

uart_rx_monitor #(
    .CLK_HZ(100000000),
    .BAUD(10000000),
    .EXPECTED_BYTES(8),
    .GAP_BITS(12)
) dut (
    .clk(clk), .rst_n(rst_n), .timestamp(timestamp), .uart_rx(uart_rx),
    .evt_valid(evt_valid), .evt_ready(evt_ready),
    .evt_trigger(evt_trigger), .evt_data(evt_data),
    .dropped_event_count(dropped)
);

always @(posedge clk) begin
    if (evt_valid && evt_ready) begin
        event_count <= event_count + 1;
        if (evt_data[53:48] == 6'h01) begin
            data_count <= data_count + 1;
        end else if (evt_data[53:48] == 6'h02) begin
            end_count <= end_count + 1;
        end else if (evt_data[53:48] == 6'h3F) begin
            case (evt_data[47:40])
                8'h01: stop_errors <= stop_errors + 1;
                8'h02: break_errors <= break_errors + 1;
                8'h04: short_errors <= short_errors + 1;
            endcase
        end
    end
end

task send_byte;
    input [7:0] value;
    input good_stop;
    integer i;
    begin
        uart_rx = 1'b0; #(BIT_NS);
        for (i = 0; i < 8; i = i + 1) begin
            uart_rx = value[i]; #(BIT_NS);
        end
        uart_rx = good_stop; #(BIT_NS);
        uart_rx = 1'b1; #(BIT_NS);
    end
endtask

integer n;
initial begin
    repeat (5) @(posedge clk);
    rst_n = 1'b1;
    repeat (5) @(posedge clk);

    for (n = 0; n < 8; n = n + 1) send_byte(n[7:0], 1'b1);
    #(BIT_NS * 4);
    if (data_count != 8 || end_count != 1 || event_count != 10)
        $fatal(1, "normal transaction mismatch events=%0d data=%0d end=%0d",
               event_count, data_count, end_count);
    if (dropped != 0) $fatal(1, "unexpected normal-path drop");

    send_byte(8'hA5, 1'b1);
    send_byte(8'h5A, 1'b1);
    send_byte(8'h33, 1'b1);
    #(BIT_NS * 15);
    if (short_errors != 1) $fatal(1, "short transaction not detected");

    send_byte(8'h55, 1'b0);
    #(BIT_NS * 3);
    if (stop_errors != 1) $fatal(1, "bad stop not detected");

    uart_rx = 1'b0; #(BIT_NS * 14);
    uart_rx = 1'b1; #(BIT_NS * 3);
    if (break_errors != 1) $fatal(1, "break not detected");
    if (stop_errors != 1)
        $fatal(1, "break was incorrectly double-counted as bad stop");

    // The ready/valid payload must remain stable while the consumer stalls.
    evt_ready = 1'b0;
    send_byte(8'hC3, 1'b1);
    if (!evt_valid) $fatal(1, "no pending event under backpressure");
    begin : stable_check
        reg [127:0] held;
        reg held_trigger;
        held = evt_data;
        held_trigger = evt_trigger;
        repeat (20) begin
            @(posedge clk);
            if (evt_data !== held || evt_trigger !== held_trigger)
                $fatal(1, "ready/valid event changed while stalled");
        end
    end
    evt_ready = 1'b1;
    repeat (5) @(posedge clk);
    if (dropped == 0) $fatal(1, "stalled downstream loss not counted");

    $display("PASS: UART 115200-style 8N1 data, end, bad stop, break, short transaction and backpressure");
    $finish;
end
endmodule
