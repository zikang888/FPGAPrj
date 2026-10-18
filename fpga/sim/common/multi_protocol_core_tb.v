`timescale 1ns / 1ps

module multi_protocol_core_tb;

reg clk = 1'b0;
reg resetn = 1'b0;
reg [15:0] awaddr = 16'd0;
reg awvalid = 1'b0;
wire awready;
reg [31:0] wdata = 32'd0;
reg [3:0] wstrb = 4'd0;
reg wvalid = 1'b0;
wire wready;
wire [1:0] bresp;
wire bvalid;
reg bready = 1'b1;
reg [15:0] araddr = 16'd0;
reg arvalid = 1'b0;
wire arready;
wire [31:0] rdata;
wire [1:0] rresp;
wire rvalid;
reg rready = 1'b1;
reg ext_evt_valid = 1'b0;
wire ext_evt_ready;
reg [127:0] ext_evt_data = 128'd0;
reg ext_evt_trigger = 1'b0;
reg [31:0] ext_evt_dropped_count = 32'd0;
wire led_heartbeat;
wire led_ps_active;

always #5 clk = ~clk;

multi_protocol_core dut (
    .s_axi_aclk(clk),
    .s_axi_aresetn(resetn),
    .s_axi_awaddr(awaddr),
    .s_axi_awvalid(awvalid),
    .s_axi_awready(awready),
    .s_axi_wdata(wdata),
    .s_axi_wstrb(wstrb),
    .s_axi_wvalid(wvalid),
    .s_axi_wready(wready),
    .s_axi_bresp(bresp),
    .s_axi_bvalid(bvalid),
    .s_axi_bready(bready),
    .s_axi_araddr(araddr),
    .s_axi_arvalid(arvalid),
    .s_axi_arready(arready),
    .s_axi_rdata(rdata),
    .s_axi_rresp(rresp),
    .s_axi_rvalid(rvalid),
    .s_axi_rready(rready),
    .ext_evt_valid(ext_evt_valid),
    .ext_evt_ready(ext_evt_ready),
    .ext_evt_data(ext_evt_data),
    .ext_evt_trigger(ext_evt_trigger),
    .ext_evt_dropped_count(ext_evt_dropped_count),
    .led_heartbeat(led_heartbeat),
    .led_ps_active(led_ps_active)
);

task axi_write;
    input [15:0] address;
    input [31:0] value;
    input [3:0] strobe;
    begin
        @(posedge clk);
        awaddr <= address;
        awvalid <= 1'b1;
        while (!awready) @(posedge clk);
        @(posedge clk);
        awvalid <= 1'b0;

        // Deliberately send W after AW to test independent AXI channels.
        @(posedge clk);
        wdata <= value;
        wstrb <= strobe;
        wvalid <= 1'b1;
        while (!wready) @(posedge clk);
        @(posedge clk);
        wvalid <= 1'b0;

        while (!bvalid) @(posedge clk);
        if (bresp != 2'b00) begin
            $fatal(1, "FAIL: BRESP at address %h", address);
        end
        @(posedge clk);
    end
endtask

task send_ext_event;
    input [23:0] transaction;
    input trigger;
    begin
        @(negedge clk);
        ext_evt_data <= {
            64'h0123_4567_89AB_CDEF,
            16'h0201,
            {15'd0, trigger},
            8'd1,
            transaction
        };
        ext_evt_trigger <= trigger;
        ext_evt_valid <= 1'b1;
        @(posedge clk);
        while (!ext_evt_ready) @(posedge clk);
        @(negedge clk);
        ext_evt_valid <= 1'b0;
        ext_evt_trigger <= 1'b0;
    end
endtask

task send_spi_event;
    input [63:0] event_time;
    input [5:0] event_type;
    input [15:0] flags;
    input [7:0] payload_length;
    input [23:0] transaction;
    input trigger;
    begin
        @(negedge clk);
        ext_evt_data <= {
            event_time,
            4'h2, 4'h0, 2'b11, event_type,
            flags,
            payload_length,
            transaction
        };
        ext_evt_trigger <= trigger;
        ext_evt_valid <= 1'b1;
        @(posedge clk);
        while (!ext_evt_ready) @(posedge clk);
        @(negedge clk);
        ext_evt_valid <= 1'b0;
        ext_evt_trigger <= 1'b0;
    end
endtask

task send_uart_event;
    input [5:0] event_type;
    input [15:0] flags;
    input [23:0] transaction;
    begin
        @(negedge clk);
        ext_evt_data <= {
            64'h1111_2222_3333_4444,
            4'h1, 4'h0, 2'b00, event_type,
            flags, (event_type == 6'h01 ? 8'd1 : 8'd0), transaction
        };
        ext_evt_trigger <= (event_type == 6'h3F);
        ext_evt_valid <= 1'b1;
        @(posedge clk);
        while (!ext_evt_ready) @(posedge clk);
        @(negedge clk);
        ext_evt_valid <= 1'b0;
        ext_evt_trigger <= 1'b0;
    end
endtask

task axi_read;
    input [15:0] address;
    output [31:0] value;
    begin
        @(posedge clk);
        araddr <= address;
        arvalid <= 1'b1;
        while (!arready) @(posedge clk);
        @(posedge clk);
        arvalid <= 1'b0;
        while (!rvalid) @(posedge clk);
        value = rdata;
        if (rresp != 2'b00) begin
            $fatal(1, "FAIL: RRESP at address %h", address);
        end
        @(posedge clk);
    end
endtask

reg [31:0] value;
reg [31:0] time_lo;
reg [31:0] time_hi;
integer index;

initial begin
    repeat (5) @(posedge clk);
    resetn <= 1'b1;
    repeat (3) @(posedge clk);

    axi_read(16'h0000, value);
    if (value !== 32'h4D50_5254) begin
        $fatal(1, "FAIL: SYS_ID = %h", value);
    end

    axi_read(16'h0004, value);
    if (value !== 32'h0001_0006) begin
        $fatal(1, "FAIL: VERSION = %h", value);
    end

    axi_read(16'h000C, value);
    if (value !== 32'h0000_003F) begin
        $fatal(1, "FAIL: CAPABILITIES = %h", value);
    end

    axi_write(16'h002C, 32'hA5A5_5A5A, 4'hF);
    axi_read(16'h002C, value);
    if (value !== 32'hA5A5_5A5A) begin
        $fatal(1, "FAIL: SCRATCH = %h", value);
    end

    axi_write(16'h002C, 32'h1122_3344, 4'b0101);
    axi_read(16'h002C, value);
    if (value !== 32'hA522_5A44) begin
        $fatal(1, "FAIL: WSTRB = %h", value);
    end

    axi_write(16'h0030, 32'h0000_0001, 4'hF);
    if (led_ps_active !== 1'b1) begin
        $fatal(1, "FAIL: LED output not asserted");
    end

    axi_read(16'h0024, time_lo);
    axi_read(16'h0028, time_hi);
    if ({time_hi, time_lo} == 64'd0) begin
        $fatal(1, "FAIL: timestamp did not advance");
    end

    axi_read(16'h00FC, value);
    if (value !== 32'd0) begin
        $fatal(1, "FAIL: undefined register = %h", value);
    end

    // End-to-end virtual event -> trigger snapshot -> AXI window.
    axi_write(16'h1000, 32'h0000_0001, 4'hF); // ARM
    axi_read(16'h1004, value);
    if ((value & 32'h1) == 0) begin
        $fatal(1, "FAIL: capture did not arm, status=%h", value);
    end

    axi_write(16'h1018, 32'h0000_0000, 4'hF);
    axi_write(16'h1018, 32'h0000_0001, 4'hF);
    axi_write(16'h1018, 32'h0000_0002, 4'hF);
    axi_write(16'h1018, 32'h8000_0003, 4'hF); // trigger event
    for (index = 4; index < 20; index = index + 1) begin
        axi_write(16'h1018, index[31:0], 4'hF);
    end

    axi_read(16'h1004, value);
    if ((value & 32'h2) == 0 || (value & 32'h1) != 0) begin
        $fatal(1, "FAIL: snapshot did not freeze, status=%h", value);
    end
    axi_read(16'h1008, value);
    if (value !== 32'd1) begin
        $fatal(1, "FAIL: snapshot id = %h", value);
    end
    axi_read(16'h100C, value);
    if (value !== 32'd8) begin
        $fatal(1, "FAIL: snapshot count = %h", value);
    end
    axi_read(16'h1010, value);
    if (value !== 32'd3) begin
        $fatal(1, "FAIL: trigger index = %h", value);
    end

    axi_read(16'h6000, value);
    if (value[23:0] !== 24'd0) begin
        $fatal(1, "FAIL: first snapshot transaction = %h", value);
    end
    axi_read(16'h6030, value);
    if (value[23:0] !== 24'd3) begin
        $fatal(1, "FAIL: trigger transaction = %h", value);
    end
    axi_read(16'h6034, value);
    if (value[0] !== 1'b1) begin
        $fatal(1, "FAIL: trigger flag missing = %h", value);
    end
    axi_read(16'h6070, value);
    if (value[23:0] !== 24'd7) begin
        $fatal(1, "FAIL: last snapshot transaction = %h", value);
    end

    axi_write(16'h1000, 32'h0000_0002, 4'hF); // ACK
    axi_read(16'h1004, value);
    if ((value & 32'h2) != 0) begin
        $fatal(1, "FAIL: ACK did not clear snapshot, status=%h", value);
    end

    // External ready/valid ingress -> arbiter -> same snapshot/AXI window.
    // Present the trigger while ARM is committing. The core must backpressure
    // it until the snapshot buffer is actually active, not consume it early.
    fork
        axi_write(16'h1000, 32'h0000_0001, 4'hF); // ARM
        begin
            wait (dut.arm_command);
            @(negedge clk);
            ext_evt_data <= {
                64'h0123_4567_89AB_CDEF,
                16'h0201,
                16'h0001,
                8'd1,
                24'hA0_0000
            };
            ext_evt_trigger <= 1'b1;
            ext_evt_valid <= 1'b1;
            @(posedge clk);
            while (!ext_evt_ready) @(posedge clk);
            @(negedge clk);
            ext_evt_valid <= 1'b0;
            ext_evt_trigger <= 1'b0;
        end
    join
    for (index = 1; index <= 16; index = index + 1) begin
        send_ext_event(24'hA0_0000 + index, 1'b0);
    end

    axi_read(16'h1004, value);
    if ((value & 32'h2) == 0 || (value & 32'h1) != 0) begin
        $fatal(1, "FAIL: external snapshot did not freeze, status=%h", value);
    end
    axi_read(16'h1008, value);
    if (value !== 32'd2) begin
        $fatal(1, "FAIL: external snapshot id = %h", value);
    end
    axi_read(16'h100C, value);
    if (value !== 32'd5) begin
        $fatal(1, "FAIL: external snapshot count = %h", value);
    end
    axi_read(16'h1010, value);
    if (value !== 32'd0) begin
        $fatal(1, "FAIL: external trigger index = %h", value);
    end
    axi_read(16'h6000, value);
    if (value[23:0] !== 24'hA0_0000) begin
        $fatal(1, "FAIL: first external snapshot event = %h", value);
    end
    axi_read(16'h6040, value);
    if (value[23:0] !== 24'hA0_0004) begin
        $fatal(1, "FAIL: last external snapshot event = %h", value);
    end

    axi_read(16'h0034, value);
    if (value !== 32'd0) begin
        $fatal(1, "FAIL: unexpected arbiter contention = %h", value);
    end

    ext_evt_dropped_count = 32'd7;
    axi_read(16'h0038, value);
    if (value !== 32'd7) begin
        $fatal(1, "FAIL: external producer drop count = %h", value);
    end
    axi_read(16'h1004, value);
    if ((value & 32'h8) == 0) begin
        $fatal(1, "FAIL: external producer drop status missing = %h", value);
    end

    // SPI acceptance statistics: first prove one clean JEDEC transaction.
    ext_evt_dropped_count = 32'd0;
    axi_write(16'h0064, 32'h0000_0001, 4'hF); // clear statistics
    send_spi_event(64'd100, 6'h00, 16'h0000, 8'd0, 24'd1, 1'b0);
    send_spi_event(64'd110, 6'h01, 16'hFF9F, 8'd2, 24'd1, 1'b0);
    send_spi_event(64'd120, 6'h01, 16'hEF00, 8'd2, 24'd1, 1'b0);
    send_spi_event(64'd130, 6'h01, 16'h4000, 8'd2, 24'd1, 1'b0);
    send_spi_event(64'd140, 6'h01, 16'h1800, 8'd2, 24'd1, 1'b0);
    send_spi_event(64'd150, 6'h02, 16'h0000, 8'd0, 24'd1, 1'b0);

    axi_read(16'h003C, value);
    if (value !== 32'd6) $fatal(1, "FAIL: SPI event count = %h", value);
    axi_read(16'h0040, value);
    if (value !== 32'd1) $fatal(1, "FAIL: SPI start count = %h", value);
    axi_read(16'h0044, value);
    if (value !== 32'd4) $fatal(1, "FAIL: SPI data count = %h", value);
    axi_read(16'h0048, value);
    if (value !== 32'd1) $fatal(1, "FAIL: SPI end count = %h", value);
    axi_read(16'h004C, value);
    if (value !== 32'd0) $fatal(1, "FAIL: clean SPI frame errors = %h", value);
    axi_read(16'h0050, value);
    if (value !== 32'd0) $fatal(1, "FAIL: clean SPI boundary errors = %h", value);
    axi_read(16'h0054, value);
    if (value !== 32'd0) $fatal(1, "FAIL: clean SPI duplicates = %h", value);
    axi_read(16'h0058, value);
    if (value !== 32'd0) $fatal(1, "FAIL: clean SPI sequence errors = %h", value);
    axi_read(16'h005C, value);
    if (value !== 32'd1) $fatal(1, "FAIL: clean SPI last transaction = %h", value);
    axi_read(16'h0060, value);
    if (value !== 32'h0000_0006) $fatal(1, "FAIL: clean SPI status = %h", value);
    axi_read(16'h0068, value);
    if (value !== 32'd0) $fatal(1, "FAIL: clean SPI short transactions = %h", value);
    axi_read(16'h006C, value);
    if (value !== 32'd0) $fatal(1, "FAIL: clean SPI extra bytes = %h", value);
    axi_read(16'h0070, value);
    if (value !== 32'd0) $fatal(1, "FAIL: clean SPI response mismatch = %h", value);

    // Exact duplicate events, transaction-ID gaps, an orphan DATA event and
    // a residual frame must all be distinguished by hardware counters.
    send_spi_event(64'd200, 6'h00, 16'h0000, 8'd0, 24'd2, 1'b0);
    send_spi_event(64'd210, 6'h01, 16'hAAAA, 8'd2, 24'd2, 1'b0);
    send_spi_event(64'd210, 6'h01, 16'hAAAA, 8'd2, 24'd2, 1'b0);
    send_spi_event(64'd220, 6'h02, 16'h0000, 8'd0, 24'd2, 1'b0);
    send_spi_event(64'd300, 6'h00, 16'h0000, 8'd0, 24'd4, 1'b0);
    send_spi_event(64'd310, 6'h02, 16'h0000, 8'd0, 24'd4, 1'b0);
    send_spi_event(64'd320, 6'h01, 16'h1234, 8'd2, 24'd5, 1'b0);
    send_spi_event(64'd330, 6'h00, 16'h0000, 8'd0, 24'd5, 1'b0);
    send_spi_event(64'd340, 6'h3F, 16'h0004, 8'd0, 24'd5, 1'b1);

    axi_read(16'h003C, value);
    if (value !== 32'd15) $fatal(1, "FAIL: SPI total event count = %h", value);
    axi_read(16'h0040, value);
    if (value !== 32'd4) $fatal(1, "FAIL: SPI total start count = %h", value);
    axi_read(16'h0044, value);
    if (value !== 32'd7) $fatal(1, "FAIL: SPI total data count = %h", value);
    axi_read(16'h0048, value);
    if (value !== 32'd3) $fatal(1, "FAIL: SPI total end count = %h", value);
    axi_read(16'h004C, value);
    if (value !== 32'd1) $fatal(1, "FAIL: SPI frame error count = %h", value);
    axi_read(16'h0050, value);
    if (value !== 32'd1) $fatal(1, "FAIL: SPI boundary error count = %h", value);
    axi_read(16'h0054, value);
    if (value !== 32'd1) $fatal(1, "FAIL: SPI duplicate count = %h", value);
    axi_read(16'h0058, value);
    if (value !== 32'd1) $fatal(1, "FAIL: SPI sequence error count = %h", value);
    axi_read(16'h005C, value);
    if (value !== 32'd5) $fatal(1, "FAIL: SPI last transaction = %h", value);
    axi_read(16'h0060, value);
    if (value !== 32'h0000_000E) $fatal(1, "FAIL: SPI error status = %h", value);

    // JEDEC semantic checks are intentionally restricted to command 0x9F:
    // two bytes are short, five are extra, and an incorrect EF/40/18 reply
    // is a response mismatch. A final clean transaction must not add errors.
    axi_write(16'h0064, 32'h0000_0001, 4'hF);
    send_spi_event(64'd400, 6'h00, 16'h0000, 8'd0, 24'd1, 1'b0);
    send_spi_event(64'd410, 6'h01, 16'hFF9F, 8'd2, 24'd1, 1'b0);
    send_spi_event(64'd420, 6'h01, 16'hEF00, 8'd2, 24'd1, 1'b0);
    send_spi_event(64'd430, 6'h02, 16'h0000, 8'd0, 24'd1, 1'b0);

    send_spi_event(64'd500, 6'h00, 16'h0000, 8'd0, 24'd2, 1'b0);
    send_spi_event(64'd510, 6'h01, 16'hFF9F, 8'd2, 24'd2, 1'b0);
    send_spi_event(64'd520, 6'h01, 16'hEF00, 8'd2, 24'd2, 1'b0);
    send_spi_event(64'd530, 6'h01, 16'h4000, 8'd2, 24'd2, 1'b0);
    send_spi_event(64'd540, 6'h01, 16'h1800, 8'd2, 24'd2, 1'b0);
    send_spi_event(64'd550, 6'h01, 16'hAA00, 8'd2, 24'd2, 1'b0);
    send_spi_event(64'd560, 6'h02, 16'h0000, 8'd0, 24'd2, 1'b0);

    send_spi_event(64'd600, 6'h00, 16'h0000, 8'd0, 24'd3, 1'b0);
    send_spi_event(64'd610, 6'h01, 16'hFF9F, 8'd2, 24'd3, 1'b0);
    send_spi_event(64'd620, 6'h01, 16'hEF00, 8'd2, 24'd3, 1'b0);
    send_spi_event(64'd630, 6'h01, 16'h4100, 8'd2, 24'd3, 1'b0);
    send_spi_event(64'd640, 6'h01, 16'h1800, 8'd2, 24'd3, 1'b0);
    send_spi_event(64'd650, 6'h02, 16'h0000, 8'd0, 24'd3, 1'b0);

    send_spi_event(64'd700, 6'h00, 16'h0000, 8'd0, 24'd4, 1'b0);
    send_spi_event(64'd710, 6'h01, 16'hFF9F, 8'd2, 24'd4, 1'b0);
    send_spi_event(64'd720, 6'h01, 16'hEF00, 8'd2, 24'd4, 1'b0);
    send_spi_event(64'd730, 6'h01, 16'h4000, 8'd2, 24'd4, 1'b0);
    send_spi_event(64'd740, 6'h01, 16'h1800, 8'd2, 24'd4, 1'b0);
    send_spi_event(64'd750, 6'h02, 16'h0000, 8'd0, 24'd4, 1'b0);

    axi_read(16'h0068, value);
    if (value !== 32'd1) $fatal(1, "FAIL: SPI short transaction count = %h", value);
    axi_read(16'h006C, value);
    if (value !== 32'd1) $fatal(1, "FAIL: SPI extra byte count = %h", value);
    axi_read(16'h0070, value);
    if (value !== 32'd1) $fatal(1, "FAIL: SPI response mismatch count = %h", value);
    axi_read(16'h0060, value);
    if (value !== 32'h0000_000E) $fatal(1, "FAIL: SPI semantic error status = %h", value);

    axi_write(16'h0064, 32'h0000_0001, 4'hF);
    axi_read(16'h003C, value);
    if (value !== 32'd0) $fatal(1, "FAIL: SPI statistics clear = %h", value);
    axi_read(16'h0060, value);
    if (value !== 32'd0) $fatal(1, "FAIL: SPI status clear = %h", value);
    axi_read(16'h0068, value);
    if (value !== 32'd0) $fatal(1, "FAIL: SPI semantic counters clear = %h", value);

    // UART statistics consume the same external stream without affecting SPI.
    axi_write(16'h0090, 32'h0000_0001, 4'hF);
    send_uart_event(6'h00, 16'h0000, 24'd7);
    send_uart_event(6'h01, 16'h0041, 24'd7);
    send_uart_event(6'h3F, 16'h0141, 24'd7);
    send_uart_event(6'h3F, 16'h0200, 24'd8);
    send_uart_event(6'h3F, 16'h0403, 24'd9);
    axi_read(16'h0074, value);
    if (value !== 32'd5) $fatal(1, "FAIL: UART event count = %h", value);
    axi_read(16'h0078, value);
    if (value !== 32'd1) $fatal(1, "FAIL: UART data count = %h", value);
    axi_read(16'h007C, value);
    if (value !== 32'd1) $fatal(1, "FAIL: UART stop count = %h", value);
    axi_read(16'h0080, value);
    if (value !== 32'd1) $fatal(1, "FAIL: UART break count = %h", value);
    axi_read(16'h0084, value);
    if (value !== 32'd1) $fatal(1, "FAIL: UART short count = %h", value);
    axi_read(16'h0088, value);
    if (value !== 32'd9) $fatal(1, "FAIL: UART last transaction = %h", value);
    axi_read(16'h008C, value);
    if ((value & 32'h8) == 0) $fatal(1, "FAIL: UART error status = %h", value);
    axi_write(16'h0090, 32'h0000_0001, 4'hF);
    axi_read(16'h0074, value);
    if (value !== 32'd0) $fatal(1, "FAIL: UART statistics clear = %h", value);

    $display("PASS: multi_protocol_core AXI, snapshots and SPI acceptance statistics");
    $finish;
end

endmodule
