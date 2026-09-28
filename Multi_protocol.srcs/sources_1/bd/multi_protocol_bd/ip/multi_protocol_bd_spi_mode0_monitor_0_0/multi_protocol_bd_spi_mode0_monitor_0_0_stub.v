// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat Sep 26 16:49:59 2026
// Host        : LAPTOP-MK9F4NL5 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/Vivado/Project/Multi_protocol/Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/ip/multi_protocol_bd_spi_mode0_monitor_0_0/multi_protocol_bd_spi_mode0_monitor_0_0_stub.v
// Design      : multi_protocol_bd_spi_mode0_monitor_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "spi_mode0_monitor_bd,Vivado 2018.3" *)
module multi_protocol_bd_spi_mode0_monitor_0_0(clk, rst_n, timestamp, spi_sclk, spi_cs_n, 
  spi_mosi, spi_miso, evt_valid, evt_ready, evt_trigger, evt_data, monitor_active, 
  transaction_id, dropped_event_count)
/* synthesis syn_black_box black_box_pad_pin="clk,rst_n,timestamp[63:0],spi_sclk,spi_cs_n,spi_mosi,spi_miso,evt_valid,evt_ready,evt_trigger,evt_data[127:0],monitor_active,transaction_id[23:0],dropped_event_count[31:0]" */;
  input clk;
  input rst_n;
  input [63:0]timestamp;
  input spi_sclk;
  input spi_cs_n;
  input spi_mosi;
  input spi_miso;
  output evt_valid;
  input evt_ready;
  output evt_trigger;
  output [127:0]evt_data;
  output monitor_active;
  output [23:0]transaction_id;
  output [31:0]dropped_event_count;
endmodule
