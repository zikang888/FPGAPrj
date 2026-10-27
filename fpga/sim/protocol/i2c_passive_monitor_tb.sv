`timescale 1ns / 1ps

module i2c_passive_monitor_tb;
reg clk=0, rst_n=0, scl=1, sda=1;
reg [63:0] timestamp=0;
wire valid, trigger;
wire [127:0] data;
wire [31:0] dropped;
integer addr_nack=0, busy_nack=0, missing_stop=0, data_events=0;

always #50 clk=~clk;
always @(posedge clk) timestamp<=timestamp+1;

i2c_passive_monitor #(.CLK_HZ(10000000),.STUCK_US(40),
    .BUSY_WINDOW_US(2000)) dut(
    .clk(clk),.rst_n(rst_n),.timestamp(timestamp),
    .i2c_scl(scl),.i2c_sda(sda),.evt_valid(valid),.evt_ready(1'b1),
    .evt_trigger(trigger),.evt_data(data),.dropped_event_count(dropped));

always @(posedge clk) if(valid) begin
    if(data[53:48]==6'h01) data_events=data_events+1;
    if(data[53:48]==6'h3f) case(data[47:40])
        8'h01: addr_nack=addr_nack+1;
        8'h02: busy_nack=busy_nack+1;
        8'h05: missing_stop=missing_stop+1;
    endcase
end

task half; begin #5000; end endtask
task start_bus; begin
    sda=1; scl=1; half; sda=0; half; scl=0; half;
end endtask
task stop_bus; begin
    sda=0; scl=0; half; scl=1; half; sda=1; half;
end endtask
task write_byte(input [7:0] value,input ack); integer i; begin
    for(i=7;i>=0;i=i-1) begin
        scl=0; sda=value[i]; half; scl=1; half;
    end
    scl=0; sda=ack ? 0 : 1; half; scl=1; half;
    scl=0; sda=1; half;
end endtask

initial begin
    repeat(5) @(posedge clk); rst_n=1; repeat(5) @(posedge clk);
    // Normal AT24C256 write establishes the EEPROM busy window.
    start_bus; write_byte(8'hA0,1); write_byte(8'h01,1);
    write_byte(8'h00,1); write_byte(8'h5A,1); stop_bus;
    // Address 0x51 is absent and must be an address NACK.
    start_bus; write_byte(8'hA2,0); stop_bus;
    // Address 0x50 NACK during the post-write window is classified busy.
    start_bus; write_byte(8'hA0,0); stop_bus;
    // Valid address byte followed by an idle bus without a STOP.
    start_bus; write_byte(8'hA0,1);
    sda=1; scl=0; half; scl=1; #80000;
    if(addr_nack!=1 || busy_nack!=1 || missing_stop!=1)
        $fatal(1,"FAIL errors addr=%0d busy=%0d stop=%0d",
               addr_nack,busy_nack,missing_stop);
    if(data_events<7 || dropped!=0)
        $fatal(1,"FAIL data=%0d dropped=%0d",data_events,dropped);
    $display("PASS: I2C ACK/NACK, busy window and missing STOP monitor");
    $finish;
end
endmodule
