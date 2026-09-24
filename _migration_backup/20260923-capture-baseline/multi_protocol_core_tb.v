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

initial begin
    repeat (5) @(posedge clk);
    resetn <= 1'b1;
    repeat (3) @(posedge clk);

    axi_read(16'h0000, value);
    if (value !== 32'h4D50_5254) begin
        $fatal(1, "FAIL: SYS_ID = %h", value);
    end

    axi_read(16'h0004, value);
    if (value !== 32'h0001_0000) begin
        $fatal(1, "FAIL: VERSION = %h", value);
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

    $display("PASS: multi_protocol_core AXI register test");
    $finish;
end

endmodule
