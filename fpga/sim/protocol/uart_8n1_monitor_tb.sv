`timescale 1ns / 1ps

module uart_8n1_monitor_tb;
    reg clk = 1'b0;
    always #5 clk = ~clk;
    reg rst_n = 1'b0;
    reg uart_rx = 1'b1;
    reg evt_ready = 1'b1;
    reg [63:0] timestamp = 64'd0;
    wire evt_valid;
    wire evt_trigger;
    wire [127:0] evt_data;
    wire [31:0] dropped_event_count;
    integer seen = 0;
    integer errors = 0;
    reg [127:0] held_data;

    uart_8n1_monitor #(.CLOCK_HZ(1600000), .BAUD(100000),
                       .IDLE_BITS(12)) dut (
        .clk(clk), .rst_n(rst_n), .timestamp(timestamp),
        .uart_rx(uart_rx), .evt_valid(evt_valid), .evt_ready(evt_ready),
        .evt_trigger(evt_trigger), .evt_data(evt_data),
        .dropped_event_count(dropped_event_count)
    );

    always @(posedge clk) timestamp <= timestamp + 64'd1;

    always @(negedge clk) begin
        if (rst_n && evt_valid && evt_ready) begin
            if (evt_data[63:60] !== 4'd1 || evt_data[59:56] !== 4'd0)
                errors = errors + 1;
            case (seen)
                0: if (evt_data[53:48] !== 6'd0 || evt_data[23:0] !== 24'd1)
                    errors = errors + 1;
                1: if (evt_data[53:48] !== 6'd1 || evt_data[39:32] !== 8'hA5 ||
                       evt_data[23:0] !== 24'd1) errors = errors + 1;
                2: if (evt_data[53:48] !== 6'd1 || evt_data[39:32] !== 8'h5A ||
                       evt_data[23:0] !== 24'd1) errors = errors + 1;
                3: if (evt_data[53:48] !== 6'd2 || evt_data[23:0] !== 24'd1)
                    errors = errors + 1;
                4: if (evt_data[53:48] !== 6'd0 || evt_data[23:0] !== 24'd2)
                    errors = errors + 1;
                5: if (evt_data[53:48] !== 6'h3F || !evt_trigger ||
                       evt_data[47:40] !== 8'h01 ||
                       evt_data[39:32] !== 8'h55) errors = errors + 1;
                6: if (evt_data[53:48] !== 6'd2 || evt_data[23:0] !== 24'd2)
                    errors = errors + 1;
                default: errors = errors + 1;
            endcase
            seen = seen + 1;
        end
    end

    task send_byte(input [7:0] value, input bad_stop);
        integer i;
        begin
            uart_rx = 1'b0;
            repeat (16) @(negedge clk);
            for (i = 0; i < 8; i = i + 1) begin
                uart_rx = value[i];
                repeat (16) @(negedge clk);
            end
            uart_rx = !bad_stop;
            repeat (16) @(negedge clk);
            uart_rx = 1'b1;
        end
    endtask

    initial begin
        repeat (5) @(posedge clk);
        rst_n = 1'b1;
        repeat (5) @(posedge clk);
        // A short low glitch must not open a UART transaction.
        uart_rx = 1'b0;
        repeat (2) @(negedge clk);
        uart_rx = 1'b1;
        repeat (20) @(negedge clk);
        if (seen != 0) $fatal(1, "false start emitted an event");
        send_byte(8'hA5, 1'b0);
        fork
            send_byte(8'h5A, 1'b0);
            begin
                repeat (135) @(negedge clk);
                evt_ready = 1'b0;
                repeat (30) @(negedge clk);
                if (!evt_valid) $fatal(1, "backpressured DATA not held");
                held_data = evt_data;
                repeat (5) @(negedge clk);
                if (!evt_valid || evt_data !== held_data)
                    $fatal(1, "backpressured DATA changed");
                evt_ready = 1'b1;
            end
        join
        repeat (220) @(posedge clk);
        send_byte(8'h55, 1'b1);
        repeat (230) @(posedge clk);
        if (seen != 7 || errors != 0 || dropped_event_count != 0) begin
            $display("UART_MONITOR_FAIL seen=%0d errors=%0d dropped=%0d",
                     seen, errors, dropped_event_count);
            $fatal(1);
        end
        $display("UART_MONITOR_PASS");
        $finish;
    end
endmodule
