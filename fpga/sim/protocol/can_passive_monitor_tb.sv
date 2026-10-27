`timescale 1ns / 1ps

module can_passive_monitor_tb;
localparam integer BIT_NS=2000;
reg clk=0, rst_n=0, bus_drive=1, tx_intent=1, ack_enable=0, echo_enable=0, tx_request=0;
wire can_tx;
wire bus_rx = bus_drive & can_tx;
reg [63:0] timestamp=0;
wire valid, trigger;
wire [127:0] data;
wire [31:0] dropped;
reg logical_bits[0:127];
reg raw_bits[0:255];
integer logical_count,raw_count;
integer ack_errors=0,stuff_errors=0,crc_errors=0,end_events=0,data_events=0;
integer ack_drive_cycles=0;

always #5 clk=~clk;
always @(posedge clk) timestamp<=timestamp+1;

can_passive_monitor dut(
 .clk(clk),.rst_n(rst_n),.timestamp(timestamp),
 .can_tx_intent(can_tx),.can_rx_bus(bus_rx),
 .ack_enable(ack_enable),.can_tx(can_tx),
 .echo_enable(echo_enable),.tx_request(tx_request),.can_rx_level(),
 .evt_valid(valid),.evt_ready(1'b1),.evt_trigger(trigger),
 .evt_data(data),.dropped_event_count(dropped));

always @(posedge clk) if(valid) begin
    if(data[53:48]==6'h01) data_events=data_events+1;
    if(data[53:48]==6'h02) end_events=end_events+1;
    if(data[53:48]==6'h3f && data[47:40]==8'h01) ack_errors=ack_errors+1;
    if(data[53:48]==6'h3f && data[47:40]==8'h03) stuff_errors=stuff_errors+1;
    if(data[53:48]==6'h3f && data[47:40]==8'h04) crc_errors=crc_errors+1;
end
always @(posedge clk) if(!can_tx) ack_drive_cycles=ack_drive_cycles+1;

function [14:0] crc_next(input [14:0] value,input bit_value);
reg feedback; reg [14:0] shifted;
begin
    feedback=value[14]^bit_value;
    shifted={value[13:0],1'b0};
    crc_next=feedback ? (shifted^15'h4599) : shifted;
end endfunction

task drive_bit(input rx_value,input tx_value); begin
    bus_drive=rx_value; tx_intent=tx_value; #(BIT_NS);
end endtask

task send_frame(input no_ack,input bad_crc,input bad_stuff);
integer i,run,stuff_fault_index; reg previous; reg [14:0] crc;
begin
    logical_count=0;
    logical_bits[logical_count]=0; logical_count=logical_count+1;
    for(i=10;i>=0;i=i-1) begin
        logical_bits[logical_count]=(11'h321>>i)&1; logical_count=logical_count+1;
    end
    logical_bits[logical_count]=0; logical_count=logical_count+1; // RTR
    logical_bits[logical_count]=0; logical_count=logical_count+1; // IDE
    logical_bits[logical_count]=0; logical_count=logical_count+1; // r0
    for(i=3;i>=0;i=i-1) begin
        logical_bits[logical_count]=(4'h1>>i)&1; logical_count=logical_count+1;
    end
    for(i=7;i>=0;i=i-1) begin
        logical_bits[logical_count]=(8'hA5>>i)&1; logical_count=logical_count+1;
    end
    crc=0;
    for(i=0;i<logical_count;i=i+1) crc=crc_next(crc,logical_bits[i]);
    if(bad_crc) crc=crc^15'h0001;
    for(i=14;i>=0;i=i-1) begin
        logical_bits[logical_count]=(crc>>i)&1; logical_count=logical_count+1;
    end

    raw_count=0; run=0; previous=1; stuff_fault_index=-1;
    for(i=0;i<logical_count;i=i+1) begin
        raw_bits[raw_count]=logical_bits[i]; raw_count=raw_count+1;
        if(run==0 || logical_bits[i]!=previous) begin
            previous=logical_bits[i]; run=1;
        end else run=run+1;
        if(run==5) begin
            if(bad_stuff && stuff_fault_index<0)
                stuff_fault_index=raw_count;
            raw_bits[raw_count]=!previous; raw_count=raw_count+1;
            previous=!previous; run=1;
        end
    end
    if(stuff_fault_index>=0)
        raw_bits[stuff_fault_index]=!raw_bits[stuff_fault_index];
    repeat(5) drive_bit(1,1);
    for(i=0;i<raw_count;i=i+1) drive_bit(raw_bits[i],raw_bits[i]);
    drive_bit(1,1);                 // CRC delimiter
    drive_bit(no_ack ? 1 : 0,1);   // ACK slot; transmitter stays recessive
    drive_bit(1,1);                 // ACK delimiter
    repeat(7) drive_bit(1,1);       // EOF
    repeat(4) drive_bit(1,1);
end endtask

initial begin
    repeat(10) @(posedge clk); rst_n=1; repeat(10) @(posedge clk);
    send_frame(1,0,0);
    send_frame(0,1,0);
    ack_enable=1; echo_enable=1;
    send_frame(1,0,0);
    #600000;
    if(ack_errors!=2 || crc_errors!=1 || end_events!=4 || data_events!=4 || ack_drive_cycles==0)
        $fatal(1,"FAIL ack=%0d crc=%0d end=%0d data=%0d",
               ack_errors,crc_errors,end_events,data_events);
    if(dropped!=0) $fatal(1,"FAIL dropped=%0d",dropped);
    ack_enable=0; echo_enable=0;
    send_frame(1,0,1);
    #100000;
    if(stuff_errors!=1 || crc_errors!=1)
        $fatal(1,"FAIL primary classification stuff=%0d crc=%0d",
               stuff_errors,crc_errors);
    $display("PASS: CAN 2.0A receive, ACK, CRC and echo node");
    $finish;
end
endmodule
