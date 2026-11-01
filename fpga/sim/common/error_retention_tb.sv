`timescale 1ns/1ps
module error_retention_tb;
reg clk=0,rst_n=0,arm=0,ack=0,freeze=0,valid=0,rd=0;
reg [127:0] data=0;reg[3:0] index=0;
wire active,ready,over,rv;wire[31:0] id;wire[4:0] count;wire[3:0] trigger_index;wire[127:0] value;
always #5 clk=~clk;
event_snapshot_buffer #(.DEPTH(16)) dut(.clk(clk),.rst_n(rst_n),.arm(arm),.ack(ack),.freeze(freeze),.retain_errors(1'b1),.in_valid(valid),.in_event(data),.in_trigger(1'b0),.capture_active(active),.snapshot_ready(ready),.snapshot_id(id),.snapshot_count(count),.snapshot_trigger_index(trigger_index),.overwritten(over),.rd_en(rd),.rd_index(index),.rd_valid(rv),.rd_event(value));
task begin_run;begin @(negedge clk);arm=1;@(negedge clk);arm=0;end endtask
task put(input integer p,t,typ,flags);begin @(negedge clk);data=0;data[63:60]=p;data[55:48]=typ;data[55:54]=1;data[47:32]=flags;data[23:0]=t;valid=1;@(negedge clk);valid=0;end endtask
task finish(input integer expected,input integer overflow);begin @(negedge clk);freeze=1;@(negedge clk);freeze=0;repeat(2)@(negedge clk);#1;if(!ready||count!=expected||over!=overflow)$fatal(1,"count=%d expected=%d overflow=%d",count,expected,over);end endtask
integer p,i;
initial begin
 repeat(3)@(negedge clk);rst_n=1;
 for(p=1;p<=4;p=p+1)begin
  begin_run;
  for(i=1;i<=1000;i=i+1)begin
   put(p,i,0,0);put(p,i,1,8'h03);
   if(i==500)put(p,i,63,p==4?16'h0400:16'h0100);
   put(p,i,2,0);
  end
  finish(4,0);
  @(negedge clk);index=0;rd=1;@(negedge clk);rd=0;#1;
  if(value[23:0]!=500)$fatal(1,"early fault overwritten for protocol %d",p);
 end
 begin_run;
 for(i=1;i<=6;i=i+1)begin put(1,i,0,0);put(1,i,1,0);put(1,i,63,16'h0100);put(1,i,2,0);end
 finish(16,1);
 @(negedge clk);index=0;rd=1;@(negedge clk);rd=0;#1;if(value[23:0]!=1)$fatal(1,"archive overwrote first error");
 begin_run;put(1,20,0,0);put(1,20,63,16'h0200);finish(2,0);
 begin_run;put(3,21,0,0);put(3,21,63,16'h0200);put(3,21,2,0);finish(0,0);
 // SPI short and extra are semantic faults on END, not just ERROR records.
 begin_run;put(2,30,0,0);put(2,30,1,16'hff9f);put(2,30,1,16'hef00);put(2,30,2,0);finish(4,0);
 $display("ERROR_RETENTION_PASS: four protocols 1000 transactions, early error, overflow, missing END, INFO and SPI semantic");$finish;
end
endmodule


