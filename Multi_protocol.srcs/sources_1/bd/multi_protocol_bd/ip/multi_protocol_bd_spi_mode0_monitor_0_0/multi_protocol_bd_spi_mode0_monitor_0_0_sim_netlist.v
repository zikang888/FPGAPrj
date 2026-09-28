// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat Sep 26 16:49:59 2026
// Host        : LAPTOP-MK9F4NL5 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/Vivado/Project/Multi_protocol/Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/ip/multi_protocol_bd_spi_mode0_monitor_0_0/multi_protocol_bd_spi_mode0_monitor_0_0_sim_netlist.v
// Design      : multi_protocol_bd_spi_mode0_monitor_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "multi_protocol_bd_spi_mode0_monitor_0_0,spi_mode0_monitor_bd,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "spi_mode0_monitor_bd,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module multi_protocol_bd_spi_mode0_monitor_0_0
   (clk,
    rst_n,
    timestamp,
    spi_sclk,
    spi_cs_n,
    spi_mosi,
    spi_miso,
    evt_valid,
    evt_ready,
    evt_trigger,
    evt_data,
    monitor_active,
    transaction_id,
    dropped_event_count);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN multi_protocol_bd_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst_n;
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

  wire \<const0> ;
  wire clk;
  wire [31:0]dropped_event_count;
  wire [127:0]\^evt_data ;
  wire evt_ready;
  wire evt_trigger;
  wire evt_valid;
  wire monitor_active;
  wire rst_n;
  wire spi_cs_n;
  wire spi_miso;
  wire spi_mosi;
  wire spi_sclk;
  wire [63:0]timestamp;
  wire [23:0]transaction_id;

  assign evt_data[127:64] = \^evt_data [127:64];
  assign evt_data[63] = \<const0> ;
  assign evt_data[62] = \<const0> ;
  assign evt_data[61] = \^evt_data [55];
  assign evt_data[60] = \<const0> ;
  assign evt_data[59] = \<const0> ;
  assign evt_data[58] = \<const0> ;
  assign evt_data[57] = \<const0> ;
  assign evt_data[56] = \<const0> ;
  assign evt_data[55] = \^evt_data [55];
  assign evt_data[54] = \^evt_data [55];
  assign evt_data[53] = \^evt_data [52];
  assign evt_data[52] = \^evt_data [52];
  assign evt_data[51] = \^evt_data [52];
  assign evt_data[50] = \^evt_data [52];
  assign evt_data[49:32] = \^evt_data [49:32];
  assign evt_data[31] = \<const0> ;
  assign evt_data[30] = \<const0> ;
  assign evt_data[29] = \<const0> ;
  assign evt_data[28] = \<const0> ;
  assign evt_data[27] = \<const0> ;
  assign evt_data[26] = \<const0> ;
  assign evt_data[25] = \^evt_data [25];
  assign evt_data[24] = \<const0> ;
  assign evt_data[23:0] = \^evt_data [23:0];
  GND GND
       (.G(\<const0> ));
  multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor_bd inst
       (.clk(clk),
        .dropped_event_count(dropped_event_count),
        .evt_data({\^evt_data [127:64],\^evt_data [55],\^evt_data [52],\^evt_data [49:32],\^evt_data [25],\^evt_data [23:0]}),
        .evt_ready(evt_ready),
        .evt_trigger(evt_trigger),
        .evt_valid_reg(evt_valid),
        .monitor_active_reg(monitor_active),
        .rst_n(rst_n),
        .spi_cs_n(spi_cs_n),
        .spi_miso(spi_miso),
        .spi_mosi(spi_mosi),
        .spi_sclk(spi_sclk),
        .timestamp(timestamp),
        .transaction_id(transaction_id));
endmodule

(* ORIG_REF_NAME = "spi_mode0_monitor" *) 
module multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor
   (monitor_active_reg_0,
    evt_data,
    transaction_id,
    dropped_event_count,
    evt_valid_reg_0,
    evt_trigger,
    rst_n,
    spi_cs_n,
    clk,
    spi_sclk,
    spi_mosi,
    spi_miso,
    timestamp,
    evt_ready);
  output monitor_active_reg_0;
  output [108:0]evt_data;
  output [23:0]transaction_id;
  output [31:0]dropped_event_count;
  output evt_valid_reg_0;
  output evt_trigger;
  input rst_n;
  input spi_cs_n;
  input clk;
  input spi_sclk;
  input spi_mosi;
  input spi_miso;
  input [63:0]timestamp;
  input evt_ready;

  wire [2:0]bit_count;
  wire bit_count08_out;
  wire \bit_count[0]_i_1_n_0 ;
  wire \bit_count[1]_i_1_n_0 ;
  wire \bit_count[2]_i_1_n_0 ;
  wire clear;
  wire clk;
  wire cs_falling;
  wire [31:0]dropped_event_count;
  wire \dropped_event_count[31]_i_1_n_0 ;
  wire \dropped_event_count[3]_i_2_n_0 ;
  wire \dropped_event_count_reg[11]_i_1_n_0 ;
  wire \dropped_event_count_reg[11]_i_1_n_1 ;
  wire \dropped_event_count_reg[11]_i_1_n_2 ;
  wire \dropped_event_count_reg[11]_i_1_n_3 ;
  wire \dropped_event_count_reg[11]_i_1_n_4 ;
  wire \dropped_event_count_reg[11]_i_1_n_5 ;
  wire \dropped_event_count_reg[11]_i_1_n_6 ;
  wire \dropped_event_count_reg[11]_i_1_n_7 ;
  wire \dropped_event_count_reg[15]_i_1_n_0 ;
  wire \dropped_event_count_reg[15]_i_1_n_1 ;
  wire \dropped_event_count_reg[15]_i_1_n_2 ;
  wire \dropped_event_count_reg[15]_i_1_n_3 ;
  wire \dropped_event_count_reg[15]_i_1_n_4 ;
  wire \dropped_event_count_reg[15]_i_1_n_5 ;
  wire \dropped_event_count_reg[15]_i_1_n_6 ;
  wire \dropped_event_count_reg[15]_i_1_n_7 ;
  wire \dropped_event_count_reg[19]_i_1_n_0 ;
  wire \dropped_event_count_reg[19]_i_1_n_1 ;
  wire \dropped_event_count_reg[19]_i_1_n_2 ;
  wire \dropped_event_count_reg[19]_i_1_n_3 ;
  wire \dropped_event_count_reg[19]_i_1_n_4 ;
  wire \dropped_event_count_reg[19]_i_1_n_5 ;
  wire \dropped_event_count_reg[19]_i_1_n_6 ;
  wire \dropped_event_count_reg[19]_i_1_n_7 ;
  wire \dropped_event_count_reg[23]_i_1_n_0 ;
  wire \dropped_event_count_reg[23]_i_1_n_1 ;
  wire \dropped_event_count_reg[23]_i_1_n_2 ;
  wire \dropped_event_count_reg[23]_i_1_n_3 ;
  wire \dropped_event_count_reg[23]_i_1_n_4 ;
  wire \dropped_event_count_reg[23]_i_1_n_5 ;
  wire \dropped_event_count_reg[23]_i_1_n_6 ;
  wire \dropped_event_count_reg[23]_i_1_n_7 ;
  wire \dropped_event_count_reg[27]_i_1_n_0 ;
  wire \dropped_event_count_reg[27]_i_1_n_1 ;
  wire \dropped_event_count_reg[27]_i_1_n_2 ;
  wire \dropped_event_count_reg[27]_i_1_n_3 ;
  wire \dropped_event_count_reg[27]_i_1_n_4 ;
  wire \dropped_event_count_reg[27]_i_1_n_5 ;
  wire \dropped_event_count_reg[27]_i_1_n_6 ;
  wire \dropped_event_count_reg[27]_i_1_n_7 ;
  wire \dropped_event_count_reg[31]_i_2_n_1 ;
  wire \dropped_event_count_reg[31]_i_2_n_2 ;
  wire \dropped_event_count_reg[31]_i_2_n_3 ;
  wire \dropped_event_count_reg[31]_i_2_n_4 ;
  wire \dropped_event_count_reg[31]_i_2_n_5 ;
  wire \dropped_event_count_reg[31]_i_2_n_6 ;
  wire \dropped_event_count_reg[31]_i_2_n_7 ;
  wire \dropped_event_count_reg[3]_i_1_n_0 ;
  wire \dropped_event_count_reg[3]_i_1_n_1 ;
  wire \dropped_event_count_reg[3]_i_1_n_2 ;
  wire \dropped_event_count_reg[3]_i_1_n_3 ;
  wire \dropped_event_count_reg[3]_i_1_n_4 ;
  wire \dropped_event_count_reg[3]_i_1_n_5 ;
  wire \dropped_event_count_reg[3]_i_1_n_6 ;
  wire \dropped_event_count_reg[3]_i_1_n_7 ;
  wire \dropped_event_count_reg[7]_i_1_n_0 ;
  wire \dropped_event_count_reg[7]_i_1_n_1 ;
  wire \dropped_event_count_reg[7]_i_1_n_2 ;
  wire \dropped_event_count_reg[7]_i_1_n_3 ;
  wire \dropped_event_count_reg[7]_i_1_n_4 ;
  wire \dropped_event_count_reg[7]_i_1_n_5 ;
  wire \dropped_event_count_reg[7]_i_1_n_6 ;
  wire \dropped_event_count_reg[7]_i_1_n_7 ;
  wire [23:1]event_transaction_id;
  wire [108:0]evt_data;
  wire \evt_data[0]_i_1_n_0 ;
  wire \evt_data[10]_i_1_n_0 ;
  wire \evt_data[11]_i_1_n_0 ;
  wire \evt_data[127]_i_1_n_0 ;
  wire \evt_data[127]_i_2_n_0 ;
  wire \evt_data[127]_i_3_n_0 ;
  wire \evt_data[127]_i_4_n_0 ;
  wire \evt_data[127]_i_5_n_0 ;
  wire \evt_data[127]_i_6_n_0 ;
  wire \evt_data[12]_i_1_n_0 ;
  wire \evt_data[13]_i_1_n_0 ;
  wire \evt_data[14]_i_1_n_0 ;
  wire \evt_data[15]_i_1_n_0 ;
  wire \evt_data[16]_i_1_n_0 ;
  wire \evt_data[17]_i_1_n_0 ;
  wire \evt_data[18]_i_1_n_0 ;
  wire \evt_data[19]_i_1_n_0 ;
  wire \evt_data[1]_i_1_n_0 ;
  wire \evt_data[20]_i_1_n_0 ;
  wire \evt_data[21]_i_1_n_0 ;
  wire \evt_data[22]_i_1_n_0 ;
  wire \evt_data[23]_i_1_n_0 ;
  wire \evt_data[25]_i_1_n_0 ;
  wire \evt_data[2]_i_1_n_0 ;
  wire \evt_data[32]_i_1_n_0 ;
  wire \evt_data[33]_i_1_n_0 ;
  wire \evt_data[34]_i_1_n_0 ;
  wire \evt_data[3]_i_1_n_0 ;
  wire \evt_data[47]_i_1_n_0 ;
  wire \evt_data[48]_i_1_n_0 ;
  wire \evt_data[49]_i_1_n_0 ;
  wire \evt_data[4]_i_1_n_0 ;
  wire \evt_data[53]_i_1_n_0 ;
  wire \evt_data[5]_i_1_n_0 ;
  wire \evt_data[6]_i_1_n_0 ;
  wire \evt_data[7]_i_1_n_0 ;
  wire \evt_data[8]_i_1_n_0 ;
  wire \evt_data[9]_i_1_n_0 ;
  wire \evt_data_reg[12]_i_2_n_0 ;
  wire \evt_data_reg[12]_i_2_n_1 ;
  wire \evt_data_reg[12]_i_2_n_2 ;
  wire \evt_data_reg[12]_i_2_n_3 ;
  wire \evt_data_reg[16]_i_2_n_0 ;
  wire \evt_data_reg[16]_i_2_n_1 ;
  wire \evt_data_reg[16]_i_2_n_2 ;
  wire \evt_data_reg[16]_i_2_n_3 ;
  wire \evt_data_reg[20]_i_2_n_0 ;
  wire \evt_data_reg[20]_i_2_n_1 ;
  wire \evt_data_reg[20]_i_2_n_2 ;
  wire \evt_data_reg[20]_i_2_n_3 ;
  wire \evt_data_reg[23]_i_2_n_2 ;
  wire \evt_data_reg[23]_i_2_n_3 ;
  wire \evt_data_reg[4]_i_2_n_0 ;
  wire \evt_data_reg[4]_i_2_n_1 ;
  wire \evt_data_reg[4]_i_2_n_2 ;
  wire \evt_data_reg[4]_i_2_n_3 ;
  wire \evt_data_reg[8]_i_2_n_0 ;
  wire \evt_data_reg[8]_i_2_n_1 ;
  wire \evt_data_reg[8]_i_2_n_2 ;
  wire \evt_data_reg[8]_i_2_n_3 ;
  wire evt_ready;
  wire evt_trigger;
  wire evt_trigger_i_1_n_0;
  wire evt_trigger_i_2_n_0;
  wire evt_trigger_i_3_n_0;
  wire evt_valid_i_2_n_0;
  wire evt_valid_i_3_n_0;
  wire evt_valid_reg_0;
  wire miso_shift;
  wire \miso_shift_reg_n_0_[0] ;
  wire \miso_shift_reg_n_0_[1] ;
  wire \miso_shift_reg_n_0_[2] ;
  wire \miso_shift_reg_n_0_[3] ;
  wire \miso_shift_reg_n_0_[4] ;
  wire \miso_shift_reg_n_0_[5] ;
  wire \miso_shift_reg_n_0_[6] ;
  wire monitor_active_i_1_n_0;
  wire monitor_active_reg_0;
  wire \mosi_shift_reg_n_0_[0] ;
  wire \mosi_shift_reg_n_0_[1] ;
  wire \mosi_shift_reg_n_0_[2] ;
  wire \mosi_shift_reg_n_0_[3] ;
  wire \mosi_shift_reg_n_0_[4] ;
  wire \mosi_shift_reg_n_0_[5] ;
  wire \mosi_shift_reg_n_0_[6] ;
  wire rst_n;
  wire spi_cs_d;
  (* async_reg = "true" *) wire spi_cs_meta;
  wire spi_cs_n;
  (* async_reg = "true" *) wire spi_cs_sync;
  wire spi_miso;
  (* async_reg = "true" *) wire spi_miso_meta;
  (* async_reg = "true" *) wire spi_miso_sync;
  wire spi_mosi;
  (* async_reg = "true" *) wire spi_mosi_meta;
  (* async_reg = "true" *) wire spi_mosi_sync;
  wire spi_sclk;
  wire spi_sclk_d;
  (* async_reg = "true" *) wire spi_sclk_meta;
  (* async_reg = "true" *) wire spi_sclk_sync;
  wire [63:0]timestamp;
  wire [23:0]transaction_id;
  wire \transaction_id[3]_i_2_n_0 ;
  wire \transaction_id_reg[11]_i_1_n_0 ;
  wire \transaction_id_reg[11]_i_1_n_1 ;
  wire \transaction_id_reg[11]_i_1_n_2 ;
  wire \transaction_id_reg[11]_i_1_n_3 ;
  wire \transaction_id_reg[11]_i_1_n_4 ;
  wire \transaction_id_reg[11]_i_1_n_5 ;
  wire \transaction_id_reg[11]_i_1_n_6 ;
  wire \transaction_id_reg[11]_i_1_n_7 ;
  wire \transaction_id_reg[15]_i_1_n_0 ;
  wire \transaction_id_reg[15]_i_1_n_1 ;
  wire \transaction_id_reg[15]_i_1_n_2 ;
  wire \transaction_id_reg[15]_i_1_n_3 ;
  wire \transaction_id_reg[15]_i_1_n_4 ;
  wire \transaction_id_reg[15]_i_1_n_5 ;
  wire \transaction_id_reg[15]_i_1_n_6 ;
  wire \transaction_id_reg[15]_i_1_n_7 ;
  wire \transaction_id_reg[19]_i_1_n_0 ;
  wire \transaction_id_reg[19]_i_1_n_1 ;
  wire \transaction_id_reg[19]_i_1_n_2 ;
  wire \transaction_id_reg[19]_i_1_n_3 ;
  wire \transaction_id_reg[19]_i_1_n_4 ;
  wire \transaction_id_reg[19]_i_1_n_5 ;
  wire \transaction_id_reg[19]_i_1_n_6 ;
  wire \transaction_id_reg[19]_i_1_n_7 ;
  wire \transaction_id_reg[23]_i_2_n_1 ;
  wire \transaction_id_reg[23]_i_2_n_2 ;
  wire \transaction_id_reg[23]_i_2_n_3 ;
  wire \transaction_id_reg[23]_i_2_n_4 ;
  wire \transaction_id_reg[23]_i_2_n_5 ;
  wire \transaction_id_reg[23]_i_2_n_6 ;
  wire \transaction_id_reg[23]_i_2_n_7 ;
  wire \transaction_id_reg[3]_i_1_n_0 ;
  wire \transaction_id_reg[3]_i_1_n_1 ;
  wire \transaction_id_reg[3]_i_1_n_2 ;
  wire \transaction_id_reg[3]_i_1_n_3 ;
  wire \transaction_id_reg[3]_i_1_n_4 ;
  wire \transaction_id_reg[3]_i_1_n_5 ;
  wire \transaction_id_reg[3]_i_1_n_6 ;
  wire \transaction_id_reg[3]_i_1_n_7 ;
  wire \transaction_id_reg[7]_i_1_n_0 ;
  wire \transaction_id_reg[7]_i_1_n_1 ;
  wire \transaction_id_reg[7]_i_1_n_2 ;
  wire \transaction_id_reg[7]_i_1_n_3 ;
  wire \transaction_id_reg[7]_i_1_n_4 ;
  wire \transaction_id_reg[7]_i_1_n_5 ;
  wire \transaction_id_reg[7]_i_1_n_6 ;
  wire \transaction_id_reg[7]_i_1_n_7 ;
  wire [3:3]\NLW_dropped_event_count_reg[31]_i_2_CO_UNCONNECTED ;
  wire [3:2]\NLW_evt_data_reg[23]_i_2_CO_UNCONNECTED ;
  wire [3:3]\NLW_evt_data_reg[23]_i_2_O_UNCONNECTED ;
  wire [3:3]\NLW_transaction_id_reg[23]_i_2_CO_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h6006000066060000)) 
    \bit_count[0]_i_1 
       (.I0(bit_count[0]),
        .I1(bit_count08_out),
        .I2(spi_cs_d),
        .I3(spi_cs_sync),
        .I4(rst_n),
        .I5(monitor_active_reg_0),
        .O(\bit_count[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000006A)) 
    \bit_count[1]_i_1 
       (.I0(bit_count[1]),
        .I1(bit_count08_out),
        .I2(bit_count[0]),
        .I3(miso_shift),
        .I4(evt_trigger_i_2_n_0),
        .O(\bit_count[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000006AAA)) 
    \bit_count[2]_i_1 
       (.I0(bit_count[2]),
        .I1(bit_count08_out),
        .I2(bit_count[0]),
        .I3(bit_count[1]),
        .I4(miso_shift),
        .I5(evt_trigger_i_2_n_0),
        .O(\bit_count[2]_i_1_n_0 ));
  FDRE \bit_count_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\bit_count[0]_i_1_n_0 ),
        .Q(bit_count[0]),
        .R(1'b0));
  FDRE \bit_count_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\bit_count[1]_i_1_n_0 ),
        .Q(bit_count[1]),
        .R(1'b0));
  FDRE \bit_count_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\bit_count[2]_i_1_n_0 ),
        .Q(bit_count[2]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h08)) 
    \dropped_event_count[31]_i_1 
       (.I0(evt_valid_i_3_n_0),
        .I1(evt_valid_reg_0),
        .I2(evt_ready),
        .O(\dropped_event_count[31]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dropped_event_count[3]_i_2 
       (.I0(dropped_event_count[0]),
        .O(\dropped_event_count[3]_i_2_n_0 ));
  FDRE \dropped_event_count_reg[0] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[3]_i_1_n_7 ),
        .Q(dropped_event_count[0]),
        .R(clear));
  FDRE \dropped_event_count_reg[10] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[11]_i_1_n_5 ),
        .Q(dropped_event_count[10]),
        .R(clear));
  FDRE \dropped_event_count_reg[11] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[11]_i_1_n_4 ),
        .Q(dropped_event_count[11]),
        .R(clear));
  CARRY4 \dropped_event_count_reg[11]_i_1 
       (.CI(\dropped_event_count_reg[7]_i_1_n_0 ),
        .CO({\dropped_event_count_reg[11]_i_1_n_0 ,\dropped_event_count_reg[11]_i_1_n_1 ,\dropped_event_count_reg[11]_i_1_n_2 ,\dropped_event_count_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dropped_event_count_reg[11]_i_1_n_4 ,\dropped_event_count_reg[11]_i_1_n_5 ,\dropped_event_count_reg[11]_i_1_n_6 ,\dropped_event_count_reg[11]_i_1_n_7 }),
        .S(dropped_event_count[11:8]));
  FDRE \dropped_event_count_reg[12] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[15]_i_1_n_7 ),
        .Q(dropped_event_count[12]),
        .R(clear));
  FDRE \dropped_event_count_reg[13] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[15]_i_1_n_6 ),
        .Q(dropped_event_count[13]),
        .R(clear));
  FDRE \dropped_event_count_reg[14] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[15]_i_1_n_5 ),
        .Q(dropped_event_count[14]),
        .R(clear));
  FDRE \dropped_event_count_reg[15] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[15]_i_1_n_4 ),
        .Q(dropped_event_count[15]),
        .R(clear));
  CARRY4 \dropped_event_count_reg[15]_i_1 
       (.CI(\dropped_event_count_reg[11]_i_1_n_0 ),
        .CO({\dropped_event_count_reg[15]_i_1_n_0 ,\dropped_event_count_reg[15]_i_1_n_1 ,\dropped_event_count_reg[15]_i_1_n_2 ,\dropped_event_count_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dropped_event_count_reg[15]_i_1_n_4 ,\dropped_event_count_reg[15]_i_1_n_5 ,\dropped_event_count_reg[15]_i_1_n_6 ,\dropped_event_count_reg[15]_i_1_n_7 }),
        .S(dropped_event_count[15:12]));
  FDRE \dropped_event_count_reg[16] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[19]_i_1_n_7 ),
        .Q(dropped_event_count[16]),
        .R(clear));
  FDRE \dropped_event_count_reg[17] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[19]_i_1_n_6 ),
        .Q(dropped_event_count[17]),
        .R(clear));
  FDRE \dropped_event_count_reg[18] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[19]_i_1_n_5 ),
        .Q(dropped_event_count[18]),
        .R(clear));
  FDRE \dropped_event_count_reg[19] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[19]_i_1_n_4 ),
        .Q(dropped_event_count[19]),
        .R(clear));
  CARRY4 \dropped_event_count_reg[19]_i_1 
       (.CI(\dropped_event_count_reg[15]_i_1_n_0 ),
        .CO({\dropped_event_count_reg[19]_i_1_n_0 ,\dropped_event_count_reg[19]_i_1_n_1 ,\dropped_event_count_reg[19]_i_1_n_2 ,\dropped_event_count_reg[19]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dropped_event_count_reg[19]_i_1_n_4 ,\dropped_event_count_reg[19]_i_1_n_5 ,\dropped_event_count_reg[19]_i_1_n_6 ,\dropped_event_count_reg[19]_i_1_n_7 }),
        .S(dropped_event_count[19:16]));
  FDRE \dropped_event_count_reg[1] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[3]_i_1_n_6 ),
        .Q(dropped_event_count[1]),
        .R(clear));
  FDRE \dropped_event_count_reg[20] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[23]_i_1_n_7 ),
        .Q(dropped_event_count[20]),
        .R(clear));
  FDRE \dropped_event_count_reg[21] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[23]_i_1_n_6 ),
        .Q(dropped_event_count[21]),
        .R(clear));
  FDRE \dropped_event_count_reg[22] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[23]_i_1_n_5 ),
        .Q(dropped_event_count[22]),
        .R(clear));
  FDRE \dropped_event_count_reg[23] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[23]_i_1_n_4 ),
        .Q(dropped_event_count[23]),
        .R(clear));
  CARRY4 \dropped_event_count_reg[23]_i_1 
       (.CI(\dropped_event_count_reg[19]_i_1_n_0 ),
        .CO({\dropped_event_count_reg[23]_i_1_n_0 ,\dropped_event_count_reg[23]_i_1_n_1 ,\dropped_event_count_reg[23]_i_1_n_2 ,\dropped_event_count_reg[23]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dropped_event_count_reg[23]_i_1_n_4 ,\dropped_event_count_reg[23]_i_1_n_5 ,\dropped_event_count_reg[23]_i_1_n_6 ,\dropped_event_count_reg[23]_i_1_n_7 }),
        .S(dropped_event_count[23:20]));
  FDRE \dropped_event_count_reg[24] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[27]_i_1_n_7 ),
        .Q(dropped_event_count[24]),
        .R(clear));
  FDRE \dropped_event_count_reg[25] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[27]_i_1_n_6 ),
        .Q(dropped_event_count[25]),
        .R(clear));
  FDRE \dropped_event_count_reg[26] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[27]_i_1_n_5 ),
        .Q(dropped_event_count[26]),
        .R(clear));
  FDRE \dropped_event_count_reg[27] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[27]_i_1_n_4 ),
        .Q(dropped_event_count[27]),
        .R(clear));
  CARRY4 \dropped_event_count_reg[27]_i_1 
       (.CI(\dropped_event_count_reg[23]_i_1_n_0 ),
        .CO({\dropped_event_count_reg[27]_i_1_n_0 ,\dropped_event_count_reg[27]_i_1_n_1 ,\dropped_event_count_reg[27]_i_1_n_2 ,\dropped_event_count_reg[27]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dropped_event_count_reg[27]_i_1_n_4 ,\dropped_event_count_reg[27]_i_1_n_5 ,\dropped_event_count_reg[27]_i_1_n_6 ,\dropped_event_count_reg[27]_i_1_n_7 }),
        .S(dropped_event_count[27:24]));
  FDRE \dropped_event_count_reg[28] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[31]_i_2_n_7 ),
        .Q(dropped_event_count[28]),
        .R(clear));
  FDRE \dropped_event_count_reg[29] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[31]_i_2_n_6 ),
        .Q(dropped_event_count[29]),
        .R(clear));
  FDRE \dropped_event_count_reg[2] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[3]_i_1_n_5 ),
        .Q(dropped_event_count[2]),
        .R(clear));
  FDRE \dropped_event_count_reg[30] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[31]_i_2_n_5 ),
        .Q(dropped_event_count[30]),
        .R(clear));
  FDRE \dropped_event_count_reg[31] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[31]_i_2_n_4 ),
        .Q(dropped_event_count[31]),
        .R(clear));
  CARRY4 \dropped_event_count_reg[31]_i_2 
       (.CI(\dropped_event_count_reg[27]_i_1_n_0 ),
        .CO({\NLW_dropped_event_count_reg[31]_i_2_CO_UNCONNECTED [3],\dropped_event_count_reg[31]_i_2_n_1 ,\dropped_event_count_reg[31]_i_2_n_2 ,\dropped_event_count_reg[31]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dropped_event_count_reg[31]_i_2_n_4 ,\dropped_event_count_reg[31]_i_2_n_5 ,\dropped_event_count_reg[31]_i_2_n_6 ,\dropped_event_count_reg[31]_i_2_n_7 }),
        .S(dropped_event_count[31:28]));
  FDRE \dropped_event_count_reg[3] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[3]_i_1_n_4 ),
        .Q(dropped_event_count[3]),
        .R(clear));
  CARRY4 \dropped_event_count_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\dropped_event_count_reg[3]_i_1_n_0 ,\dropped_event_count_reg[3]_i_1_n_1 ,\dropped_event_count_reg[3]_i_1_n_2 ,\dropped_event_count_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\dropped_event_count_reg[3]_i_1_n_4 ,\dropped_event_count_reg[3]_i_1_n_5 ,\dropped_event_count_reg[3]_i_1_n_6 ,\dropped_event_count_reg[3]_i_1_n_7 }),
        .S({dropped_event_count[3:1],\dropped_event_count[3]_i_2_n_0 }));
  FDRE \dropped_event_count_reg[4] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[7]_i_1_n_7 ),
        .Q(dropped_event_count[4]),
        .R(clear));
  FDRE \dropped_event_count_reg[5] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[7]_i_1_n_6 ),
        .Q(dropped_event_count[5]),
        .R(clear));
  FDRE \dropped_event_count_reg[6] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[7]_i_1_n_5 ),
        .Q(dropped_event_count[6]),
        .R(clear));
  FDRE \dropped_event_count_reg[7] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[7]_i_1_n_4 ),
        .Q(dropped_event_count[7]),
        .R(clear));
  CARRY4 \dropped_event_count_reg[7]_i_1 
       (.CI(\dropped_event_count_reg[3]_i_1_n_0 ),
        .CO({\dropped_event_count_reg[7]_i_1_n_0 ,\dropped_event_count_reg[7]_i_1_n_1 ,\dropped_event_count_reg[7]_i_1_n_2 ,\dropped_event_count_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dropped_event_count_reg[7]_i_1_n_4 ,\dropped_event_count_reg[7]_i_1_n_5 ,\dropped_event_count_reg[7]_i_1_n_6 ,\dropped_event_count_reg[7]_i_1_n_7 }),
        .S(dropped_event_count[7:4]));
  FDRE \dropped_event_count_reg[8] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[11]_i_1_n_7 ),
        .Q(dropped_event_count[8]),
        .R(clear));
  FDRE \dropped_event_count_reg[9] 
       (.C(clk),
        .CE(\dropped_event_count[31]_i_1_n_0 ),
        .D(\dropped_event_count_reg[11]_i_1_n_6 ),
        .Q(dropped_event_count[9]),
        .R(clear));
  LUT4 #(
    .INIT(16'h8848)) 
    \evt_data[0]_i_1 
       (.I0(transaction_id[0]),
        .I1(rst_n),
        .I2(spi_cs_d),
        .I3(spi_cs_sync),
        .O(\evt_data[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[10]_i_1 
       (.I0(event_transaction_id[10]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[10]),
        .O(\evt_data[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[11]_i_1 
       (.I0(event_transaction_id[11]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[11]),
        .O(\evt_data[11]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \evt_data[127]_i_1 
       (.I0(\evt_data[127]_i_2_n_0 ),
        .I1(rst_n),
        .O(\evt_data[127]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAA8A8A8AFFFFFFFF)) 
    \evt_data[127]_i_2 
       (.I0(\evt_data[127]_i_3_n_0 ),
        .I1(evt_trigger_i_2_n_0),
        .I2(\evt_data[127]_i_4_n_0 ),
        .I3(\evt_data[127]_i_5_n_0 ),
        .I4(\evt_data[127]_i_6_n_0 ),
        .I5(rst_n),
        .O(\evt_data[127]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \evt_data[127]_i_3 
       (.I0(evt_ready),
        .I1(evt_valid_reg_0),
        .O(\evt_data[127]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \evt_data[127]_i_4 
       (.I0(spi_cs_sync),
        .I1(spi_cs_d),
        .O(\evt_data[127]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h4000)) 
    \evt_data[127]_i_5 
       (.I0(spi_cs_sync),
        .I1(bit_count[2]),
        .I2(bit_count[1]),
        .I3(bit_count[0]),
        .O(\evt_data[127]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h08)) 
    \evt_data[127]_i_6 
       (.I0(monitor_active_reg_0),
        .I1(spi_sclk_sync),
        .I2(spi_sclk_d),
        .O(\evt_data[127]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[12]_i_1 
       (.I0(event_transaction_id[12]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[12]),
        .O(\evt_data[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[13]_i_1 
       (.I0(event_transaction_id[13]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[13]),
        .O(\evt_data[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[14]_i_1 
       (.I0(event_transaction_id[14]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[14]),
        .O(\evt_data[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[15]_i_1 
       (.I0(event_transaction_id[15]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[15]),
        .O(\evt_data[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[16]_i_1 
       (.I0(event_transaction_id[16]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[16]),
        .O(\evt_data[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[17]_i_1 
       (.I0(event_transaction_id[17]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[17]),
        .O(\evt_data[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[18]_i_1 
       (.I0(event_transaction_id[18]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[18]),
        .O(\evt_data[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[19]_i_1 
       (.I0(event_transaction_id[19]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[19]),
        .O(\evt_data[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[1]_i_1 
       (.I0(event_transaction_id[1]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[1]),
        .O(\evt_data[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[20]_i_1 
       (.I0(event_transaction_id[20]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[20]),
        .O(\evt_data[20]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[21]_i_1 
       (.I0(event_transaction_id[21]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[21]),
        .O(\evt_data[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[22]_i_1 
       (.I0(event_transaction_id[22]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[22]),
        .O(\evt_data[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[23]_i_1 
       (.I0(event_transaction_id[23]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[23]),
        .O(\evt_data[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h9D00)) 
    \evt_data[25]_i_1 
       (.I0(spi_cs_d),
        .I1(spi_cs_sync),
        .I2(monitor_active_reg_0),
        .I3(rst_n),
        .O(\evt_data[25]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[2]_i_1 
       (.I0(event_transaction_id[2]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[2]),
        .O(\evt_data[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCA0CCC0C00000000)) 
    \evt_data[32]_i_1 
       (.I0(bit_count[0]),
        .I1(spi_mosi_sync),
        .I2(spi_cs_d),
        .I3(spi_cs_sync),
        .I4(monitor_active_reg_0),
        .I5(rst_n),
        .O(\evt_data[32]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCA0CCC0C00000000)) 
    \evt_data[33]_i_1 
       (.I0(bit_count[1]),
        .I1(\mosi_shift_reg_n_0_[0] ),
        .I2(spi_cs_d),
        .I3(spi_cs_sync),
        .I4(monitor_active_reg_0),
        .I5(rst_n),
        .O(\evt_data[33]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCA0CCC0C00000000)) 
    \evt_data[34]_i_1 
       (.I0(bit_count[2]),
        .I1(\mosi_shift_reg_n_0_[1] ),
        .I2(spi_cs_d),
        .I3(spi_cs_sync),
        .I4(monitor_active_reg_0),
        .I5(rst_n),
        .O(\evt_data[34]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[3]_i_1 
       (.I0(event_transaction_id[3]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[3]),
        .O(\evt_data[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h22AAA222)) 
    \evt_data[47]_i_1 
       (.I0(\evt_data[127]_i_2_n_0 ),
        .I1(rst_n),
        .I2(monitor_active_reg_0),
        .I3(spi_cs_sync),
        .I4(spi_cs_d),
        .O(\evt_data[47]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFE000000)) 
    \evt_data[48]_i_1 
       (.I0(bit_count[2]),
        .I1(bit_count[1]),
        .I2(bit_count[0]),
        .I3(spi_cs_sync),
        .I4(rst_n),
        .I5(\evt_data[25]_i_1_n_0 ),
        .O(\evt_data[48]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h4000)) 
    \evt_data[49]_i_1 
       (.I0(spi_cs_d),
        .I1(monitor_active_reg_0),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .O(\evt_data[49]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[4]_i_1 
       (.I0(event_transaction_id[4]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[4]),
        .O(\evt_data[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hAAA8)) 
    \evt_data[53]_i_1 
       (.I0(\evt_data[49]_i_1_n_0 ),
        .I1(bit_count[0]),
        .I2(bit_count[1]),
        .I3(bit_count[2]),
        .O(\evt_data[53]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[5]_i_1 
       (.I0(event_transaction_id[5]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[5]),
        .O(\evt_data[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[6]_i_1 
       (.I0(event_transaction_id[6]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[6]),
        .O(\evt_data[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[7]_i_1 
       (.I0(event_transaction_id[7]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[7]),
        .O(\evt_data[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[8]_i_1 
       (.I0(event_transaction_id[8]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[8]),
        .O(\evt_data[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFB000800)) 
    \evt_data[9]_i_1 
       (.I0(event_transaction_id[9]),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .I3(rst_n),
        .I4(transaction_id[9]),
        .O(\evt_data[9]_i_1_n_0 ));
  FDRE \evt_data_reg[0] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[0]_i_1_n_0 ),
        .Q(evt_data[0]),
        .R(1'b0));
  FDRE \evt_data_reg[100] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[36]),
        .Q(evt_data[81]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[101] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[37]),
        .Q(evt_data[82]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[102] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[38]),
        .Q(evt_data[83]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[103] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[39]),
        .Q(evt_data[84]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[104] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[40]),
        .Q(evt_data[85]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[105] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[41]),
        .Q(evt_data[86]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[106] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[42]),
        .Q(evt_data[87]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[107] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[43]),
        .Q(evt_data[88]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[108] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[44]),
        .Q(evt_data[89]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[109] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[45]),
        .Q(evt_data[90]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[10] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[10]_i_1_n_0 ),
        .Q(evt_data[10]),
        .R(1'b0));
  FDRE \evt_data_reg[110] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[46]),
        .Q(evt_data[91]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[111] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[47]),
        .Q(evt_data[92]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[112] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[48]),
        .Q(evt_data[93]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[113] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[49]),
        .Q(evt_data[94]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[114] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[50]),
        .Q(evt_data[95]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[115] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[51]),
        .Q(evt_data[96]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[116] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[52]),
        .Q(evt_data[97]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[117] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[53]),
        .Q(evt_data[98]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[118] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[54]),
        .Q(evt_data[99]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[119] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[55]),
        .Q(evt_data[100]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[11] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[11]_i_1_n_0 ),
        .Q(evt_data[11]),
        .R(1'b0));
  FDRE \evt_data_reg[120] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[56]),
        .Q(evt_data[101]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[121] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[57]),
        .Q(evt_data[102]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[122] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[58]),
        .Q(evt_data[103]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[123] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[59]),
        .Q(evt_data[104]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[124] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[60]),
        .Q(evt_data[105]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[125] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[61]),
        .Q(evt_data[106]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[126] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[62]),
        .Q(evt_data[107]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[127] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[63]),
        .Q(evt_data[108]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[12] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[12]_i_1_n_0 ),
        .Q(evt_data[12]),
        .R(1'b0));
  CARRY4 \evt_data_reg[12]_i_2 
       (.CI(\evt_data_reg[8]_i_2_n_0 ),
        .CO({\evt_data_reg[12]_i_2_n_0 ,\evt_data_reg[12]_i_2_n_1 ,\evt_data_reg[12]_i_2_n_2 ,\evt_data_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(event_transaction_id[12:9]),
        .S(transaction_id[12:9]));
  FDRE \evt_data_reg[13] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[13]_i_1_n_0 ),
        .Q(evt_data[13]),
        .R(1'b0));
  FDRE \evt_data_reg[14] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[14]_i_1_n_0 ),
        .Q(evt_data[14]),
        .R(1'b0));
  FDRE \evt_data_reg[15] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[15]_i_1_n_0 ),
        .Q(evt_data[15]),
        .R(1'b0));
  FDRE \evt_data_reg[16] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[16]_i_1_n_0 ),
        .Q(evt_data[16]),
        .R(1'b0));
  CARRY4 \evt_data_reg[16]_i_2 
       (.CI(\evt_data_reg[12]_i_2_n_0 ),
        .CO({\evt_data_reg[16]_i_2_n_0 ,\evt_data_reg[16]_i_2_n_1 ,\evt_data_reg[16]_i_2_n_2 ,\evt_data_reg[16]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(event_transaction_id[16:13]),
        .S(transaction_id[16:13]));
  FDRE \evt_data_reg[17] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[17]_i_1_n_0 ),
        .Q(evt_data[17]),
        .R(1'b0));
  FDRE \evt_data_reg[18] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[18]_i_1_n_0 ),
        .Q(evt_data[18]),
        .R(1'b0));
  FDRE \evt_data_reg[19] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[19]_i_1_n_0 ),
        .Q(evt_data[19]),
        .R(1'b0));
  FDRE \evt_data_reg[1] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[1]_i_1_n_0 ),
        .Q(evt_data[1]),
        .R(1'b0));
  FDRE \evt_data_reg[20] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[20]_i_1_n_0 ),
        .Q(evt_data[20]),
        .R(1'b0));
  CARRY4 \evt_data_reg[20]_i_2 
       (.CI(\evt_data_reg[16]_i_2_n_0 ),
        .CO({\evt_data_reg[20]_i_2_n_0 ,\evt_data_reg[20]_i_2_n_1 ,\evt_data_reg[20]_i_2_n_2 ,\evt_data_reg[20]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(event_transaction_id[20:17]),
        .S(transaction_id[20:17]));
  FDRE \evt_data_reg[21] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[21]_i_1_n_0 ),
        .Q(evt_data[21]),
        .R(1'b0));
  FDRE \evt_data_reg[22] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[22]_i_1_n_0 ),
        .Q(evt_data[22]),
        .R(1'b0));
  FDRE \evt_data_reg[23] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[23]_i_1_n_0 ),
        .Q(evt_data[23]),
        .R(1'b0));
  CARRY4 \evt_data_reg[23]_i_2 
       (.CI(\evt_data_reg[20]_i_2_n_0 ),
        .CO({\NLW_evt_data_reg[23]_i_2_CO_UNCONNECTED [3:2],\evt_data_reg[23]_i_2_n_2 ,\evt_data_reg[23]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_evt_data_reg[23]_i_2_O_UNCONNECTED [3],event_transaction_id[23:21]}),
        .S({1'b0,transaction_id[23:21]}));
  FDRE \evt_data_reg[25] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[25]_i_1_n_0 ),
        .Q(evt_data[24]),
        .R(1'b0));
  FDRE \evt_data_reg[2] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[2]_i_1_n_0 ),
        .Q(evt_data[2]),
        .R(1'b0));
  FDRE \evt_data_reg[32] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[32]_i_1_n_0 ),
        .Q(evt_data[25]),
        .R(1'b0));
  FDRE \evt_data_reg[33] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[33]_i_1_n_0 ),
        .Q(evt_data[26]),
        .R(1'b0));
  FDRE \evt_data_reg[34] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[34]_i_1_n_0 ),
        .Q(evt_data[27]),
        .R(1'b0));
  FDRE \evt_data_reg[35] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\mosi_shift_reg_n_0_[2] ),
        .Q(evt_data[28]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[36] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\mosi_shift_reg_n_0_[3] ),
        .Q(evt_data[29]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[37] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\mosi_shift_reg_n_0_[4] ),
        .Q(evt_data[30]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[38] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\mosi_shift_reg_n_0_[5] ),
        .Q(evt_data[31]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[39] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\mosi_shift_reg_n_0_[6] ),
        .Q(evt_data[32]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[3] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[3]_i_1_n_0 ),
        .Q(evt_data[3]),
        .R(1'b0));
  FDRE \evt_data_reg[40] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(spi_miso_sync),
        .Q(evt_data[33]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[41] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\miso_shift_reg_n_0_[0] ),
        .Q(evt_data[34]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[42] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\miso_shift_reg_n_0_[1] ),
        .Q(evt_data[35]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[43] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\miso_shift_reg_n_0_[2] ),
        .Q(evt_data[36]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[44] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\miso_shift_reg_n_0_[3] ),
        .Q(evt_data[37]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[45] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\miso_shift_reg_n_0_[4] ),
        .Q(evt_data[38]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[46] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\miso_shift_reg_n_0_[5] ),
        .Q(evt_data[39]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[47] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\miso_shift_reg_n_0_[6] ),
        .Q(evt_data[40]),
        .R(\evt_data[47]_i_1_n_0 ));
  FDRE \evt_data_reg[48] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[48]_i_1_n_0 ),
        .Q(evt_data[41]),
        .R(1'b0));
  FDRE \evt_data_reg[49] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[49]_i_1_n_0 ),
        .Q(evt_data[42]),
        .R(1'b0));
  FDRE \evt_data_reg[4] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[4]_i_1_n_0 ),
        .Q(evt_data[4]),
        .R(1'b0));
  CARRY4 \evt_data_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\evt_data_reg[4]_i_2_n_0 ,\evt_data_reg[4]_i_2_n_1 ,\evt_data_reg[4]_i_2_n_2 ,\evt_data_reg[4]_i_2_n_3 }),
        .CYINIT(transaction_id[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(event_transaction_id[4:1]),
        .S(transaction_id[4:1]));
  FDRE \evt_data_reg[53] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[53]_i_1_n_0 ),
        .Q(evt_data[43]),
        .R(1'b0));
  FDRE \evt_data_reg[5] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[5]_i_1_n_0 ),
        .Q(evt_data[5]),
        .R(1'b0));
  FDRE \evt_data_reg[61] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(rst_n),
        .Q(evt_data[44]),
        .R(1'b0));
  FDRE \evt_data_reg[64] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[0]),
        .Q(evt_data[45]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[65] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[1]),
        .Q(evt_data[46]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[66] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[2]),
        .Q(evt_data[47]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[67] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[3]),
        .Q(evt_data[48]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[68] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[4]),
        .Q(evt_data[49]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[69] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[5]),
        .Q(evt_data[50]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[6] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[6]_i_1_n_0 ),
        .Q(evt_data[6]),
        .R(1'b0));
  FDRE \evt_data_reg[70] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[6]),
        .Q(evt_data[51]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[71] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[7]),
        .Q(evt_data[52]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[72] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[8]),
        .Q(evt_data[53]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[73] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[9]),
        .Q(evt_data[54]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[74] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[10]),
        .Q(evt_data[55]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[75] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[11]),
        .Q(evt_data[56]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[76] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[12]),
        .Q(evt_data[57]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[77] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[13]),
        .Q(evt_data[58]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[78] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[14]),
        .Q(evt_data[59]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[79] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[15]),
        .Q(evt_data[60]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[7] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[7]_i_1_n_0 ),
        .Q(evt_data[7]),
        .R(1'b0));
  FDRE \evt_data_reg[80] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[16]),
        .Q(evt_data[61]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[81] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[17]),
        .Q(evt_data[62]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[82] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[18]),
        .Q(evt_data[63]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[83] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[19]),
        .Q(evt_data[64]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[84] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[20]),
        .Q(evt_data[65]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[85] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[21]),
        .Q(evt_data[66]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[86] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[22]),
        .Q(evt_data[67]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[87] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[23]),
        .Q(evt_data[68]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[88] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[24]),
        .Q(evt_data[69]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[89] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[25]),
        .Q(evt_data[70]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[8] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[8]_i_1_n_0 ),
        .Q(evt_data[8]),
        .R(1'b0));
  CARRY4 \evt_data_reg[8]_i_2 
       (.CI(\evt_data_reg[4]_i_2_n_0 ),
        .CO({\evt_data_reg[8]_i_2_n_0 ,\evt_data_reg[8]_i_2_n_1 ,\evt_data_reg[8]_i_2_n_2 ,\evt_data_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(event_transaction_id[8:5]),
        .S(transaction_id[8:5]));
  FDRE \evt_data_reg[90] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[26]),
        .Q(evt_data[71]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[91] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[27]),
        .Q(evt_data[72]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[92] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[28]),
        .Q(evt_data[73]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[93] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[29]),
        .Q(evt_data[74]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[94] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[30]),
        .Q(evt_data[75]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[95] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[31]),
        .Q(evt_data[76]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[96] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[32]),
        .Q(evt_data[77]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[97] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[33]),
        .Q(evt_data[78]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[98] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[34]),
        .Q(evt_data[79]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[99] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(timestamp[35]),
        .Q(evt_data[80]),
        .R(\evt_data[127]_i_1_n_0 ));
  FDRE \evt_data_reg[9] 
       (.C(clk),
        .CE(\evt_data[127]_i_2_n_0 ),
        .D(\evt_data[9]_i_1_n_0 ),
        .Q(evt_data[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h8F888FFF80888000)) 
    evt_trigger_i_1
       (.I0(evt_trigger_i_2_n_0),
        .I1(evt_trigger_i_3_n_0),
        .I2(evt_ready),
        .I3(evt_valid_reg_0),
        .I4(evt_valid_i_3_n_0),
        .I5(evt_trigger),
        .O(evt_trigger_i_1_n_0));
  LUT3 #(
    .INIT(8'h08)) 
    evt_trigger_i_2
       (.I0(spi_cs_sync),
        .I1(monitor_active_reg_0),
        .I2(spi_cs_d),
        .O(evt_trigger_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    evt_trigger_i_3
       (.I0(bit_count[2]),
        .I1(bit_count[1]),
        .I2(bit_count[0]),
        .O(evt_trigger_i_3_n_0));
  FDRE evt_trigger_reg
       (.C(clk),
        .CE(1'b1),
        .D(evt_trigger_i_1_n_0),
        .Q(evt_trigger),
        .R(clear));
  LUT1 #(
    .INIT(2'h1)) 
    evt_valid_i_1
       (.I0(rst_n),
        .O(clear));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    evt_valid_i_2
       (.I0(evt_ready),
        .I1(evt_valid_reg_0),
        .I2(evt_valid_i_3_n_0),
        .O(evt_valid_i_2_n_0));
  LUT6 #(
    .INIT(64'h66F6666644444444)) 
    evt_valid_i_3
       (.I0(spi_cs_sync),
        .I1(spi_cs_d),
        .I2(\evt_data[127]_i_5_n_0 ),
        .I3(spi_sclk_d),
        .I4(spi_sclk_sync),
        .I5(monitor_active_reg_0),
        .O(evt_valid_i_3_n_0));
  FDRE evt_valid_reg
       (.C(clk),
        .CE(1'b1),
        .D(evt_valid_i_2_n_0),
        .Q(evt_valid_reg_0),
        .R(clear));
  FDRE \miso_shift_reg[0] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(spi_miso_sync),
        .Q(\miso_shift_reg_n_0_[0] ),
        .R(miso_shift));
  FDRE \miso_shift_reg[1] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\miso_shift_reg_n_0_[0] ),
        .Q(\miso_shift_reg_n_0_[1] ),
        .R(miso_shift));
  FDRE \miso_shift_reg[2] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\miso_shift_reg_n_0_[1] ),
        .Q(\miso_shift_reg_n_0_[2] ),
        .R(miso_shift));
  FDRE \miso_shift_reg[3] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\miso_shift_reg_n_0_[2] ),
        .Q(\miso_shift_reg_n_0_[3] ),
        .R(miso_shift));
  FDRE \miso_shift_reg[4] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\miso_shift_reg_n_0_[3] ),
        .Q(\miso_shift_reg_n_0_[4] ),
        .R(miso_shift));
  FDRE \miso_shift_reg[5] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\miso_shift_reg_n_0_[4] ),
        .Q(\miso_shift_reg_n_0_[5] ),
        .R(miso_shift));
  FDRE \miso_shift_reg[6] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\miso_shift_reg_n_0_[5] ),
        .Q(\miso_shift_reg_n_0_[6] ),
        .R(miso_shift));
  LUT3 #(
    .INIT(8'h8E)) 
    monitor_active_i_1
       (.I0(monitor_active_reg_0),
        .I1(spi_cs_d),
        .I2(spi_cs_sync),
        .O(monitor_active_i_1_n_0));
  FDRE monitor_active_reg
       (.C(clk),
        .CE(1'b1),
        .D(monitor_active_i_1_n_0),
        .Q(monitor_active_reg_0),
        .R(clear));
  LUT3 #(
    .INIT(8'h2F)) 
    \mosi_shift[6]_i_1 
       (.I0(spi_cs_d),
        .I1(spi_cs_sync),
        .I2(rst_n),
        .O(miso_shift));
  LUT4 #(
    .INIT(16'h0400)) 
    \mosi_shift[6]_i_2 
       (.I0(spi_sclk_d),
        .I1(spi_sclk_sync),
        .I2(spi_cs_sync),
        .I3(monitor_active_reg_0),
        .O(bit_count08_out));
  FDRE \mosi_shift_reg[0] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(spi_mosi_sync),
        .Q(\mosi_shift_reg_n_0_[0] ),
        .R(miso_shift));
  FDRE \mosi_shift_reg[1] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\mosi_shift_reg_n_0_[0] ),
        .Q(\mosi_shift_reg_n_0_[1] ),
        .R(miso_shift));
  FDRE \mosi_shift_reg[2] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\mosi_shift_reg_n_0_[1] ),
        .Q(\mosi_shift_reg_n_0_[2] ),
        .R(miso_shift));
  FDRE \mosi_shift_reg[3] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\mosi_shift_reg_n_0_[2] ),
        .Q(\mosi_shift_reg_n_0_[3] ),
        .R(miso_shift));
  FDRE \mosi_shift_reg[4] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\mosi_shift_reg_n_0_[3] ),
        .Q(\mosi_shift_reg_n_0_[4] ),
        .R(miso_shift));
  FDRE \mosi_shift_reg[5] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\mosi_shift_reg_n_0_[4] ),
        .Q(\mosi_shift_reg_n_0_[5] ),
        .R(miso_shift));
  FDRE \mosi_shift_reg[6] 
       (.C(clk),
        .CE(bit_count08_out),
        .D(\mosi_shift_reg_n_0_[5] ),
        .Q(\mosi_shift_reg_n_0_[6] ),
        .R(miso_shift));
  FDSE spi_cs_d_reg
       (.C(clk),
        .CE(1'b1),
        .D(spi_cs_sync),
        .Q(spi_cs_d),
        .S(clear));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDSE spi_cs_meta_reg
       (.C(clk),
        .CE(1'b1),
        .D(spi_cs_n),
        .Q(spi_cs_meta),
        .S(clear));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDSE spi_cs_sync_reg
       (.C(clk),
        .CE(1'b1),
        .D(spi_cs_meta),
        .Q(spi_cs_sync),
        .S(clear));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE spi_miso_meta_reg
       (.C(clk),
        .CE(1'b1),
        .D(spi_miso),
        .Q(spi_miso_meta),
        .R(clear));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE spi_miso_sync_reg
       (.C(clk),
        .CE(1'b1),
        .D(spi_miso_meta),
        .Q(spi_miso_sync),
        .R(clear));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE spi_mosi_meta_reg
       (.C(clk),
        .CE(1'b1),
        .D(spi_mosi),
        .Q(spi_mosi_meta),
        .R(clear));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE spi_mosi_sync_reg
       (.C(clk),
        .CE(1'b1),
        .D(spi_mosi_meta),
        .Q(spi_mosi_sync),
        .R(clear));
  FDRE spi_sclk_d_reg
       (.C(clk),
        .CE(1'b1),
        .D(spi_sclk_sync),
        .Q(spi_sclk_d),
        .R(clear));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE spi_sclk_meta_reg
       (.C(clk),
        .CE(1'b1),
        .D(spi_sclk),
        .Q(spi_sclk_meta),
        .R(clear));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE spi_sclk_sync_reg
       (.C(clk),
        .CE(1'b1),
        .D(spi_sclk_meta),
        .Q(spi_sclk_sync),
        .R(clear));
  LUT2 #(
    .INIT(4'h2)) 
    \transaction_id[23]_i_1 
       (.I0(spi_cs_d),
        .I1(spi_cs_sync),
        .O(cs_falling));
  LUT1 #(
    .INIT(2'h1)) 
    \transaction_id[3]_i_2 
       (.I0(transaction_id[0]),
        .O(\transaction_id[3]_i_2_n_0 ));
  FDRE \transaction_id_reg[0] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[3]_i_1_n_7 ),
        .Q(transaction_id[0]),
        .R(clear));
  FDRE \transaction_id_reg[10] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[11]_i_1_n_5 ),
        .Q(transaction_id[10]),
        .R(clear));
  FDRE \transaction_id_reg[11] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[11]_i_1_n_4 ),
        .Q(transaction_id[11]),
        .R(clear));
  CARRY4 \transaction_id_reg[11]_i_1 
       (.CI(\transaction_id_reg[7]_i_1_n_0 ),
        .CO({\transaction_id_reg[11]_i_1_n_0 ,\transaction_id_reg[11]_i_1_n_1 ,\transaction_id_reg[11]_i_1_n_2 ,\transaction_id_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\transaction_id_reg[11]_i_1_n_4 ,\transaction_id_reg[11]_i_1_n_5 ,\transaction_id_reg[11]_i_1_n_6 ,\transaction_id_reg[11]_i_1_n_7 }),
        .S(transaction_id[11:8]));
  FDRE \transaction_id_reg[12] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[15]_i_1_n_7 ),
        .Q(transaction_id[12]),
        .R(clear));
  FDRE \transaction_id_reg[13] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[15]_i_1_n_6 ),
        .Q(transaction_id[13]),
        .R(clear));
  FDRE \transaction_id_reg[14] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[15]_i_1_n_5 ),
        .Q(transaction_id[14]),
        .R(clear));
  FDRE \transaction_id_reg[15] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[15]_i_1_n_4 ),
        .Q(transaction_id[15]),
        .R(clear));
  CARRY4 \transaction_id_reg[15]_i_1 
       (.CI(\transaction_id_reg[11]_i_1_n_0 ),
        .CO({\transaction_id_reg[15]_i_1_n_0 ,\transaction_id_reg[15]_i_1_n_1 ,\transaction_id_reg[15]_i_1_n_2 ,\transaction_id_reg[15]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\transaction_id_reg[15]_i_1_n_4 ,\transaction_id_reg[15]_i_1_n_5 ,\transaction_id_reg[15]_i_1_n_6 ,\transaction_id_reg[15]_i_1_n_7 }),
        .S(transaction_id[15:12]));
  FDRE \transaction_id_reg[16] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[19]_i_1_n_7 ),
        .Q(transaction_id[16]),
        .R(clear));
  FDRE \transaction_id_reg[17] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[19]_i_1_n_6 ),
        .Q(transaction_id[17]),
        .R(clear));
  FDRE \transaction_id_reg[18] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[19]_i_1_n_5 ),
        .Q(transaction_id[18]),
        .R(clear));
  FDRE \transaction_id_reg[19] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[19]_i_1_n_4 ),
        .Q(transaction_id[19]),
        .R(clear));
  CARRY4 \transaction_id_reg[19]_i_1 
       (.CI(\transaction_id_reg[15]_i_1_n_0 ),
        .CO({\transaction_id_reg[19]_i_1_n_0 ,\transaction_id_reg[19]_i_1_n_1 ,\transaction_id_reg[19]_i_1_n_2 ,\transaction_id_reg[19]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\transaction_id_reg[19]_i_1_n_4 ,\transaction_id_reg[19]_i_1_n_5 ,\transaction_id_reg[19]_i_1_n_6 ,\transaction_id_reg[19]_i_1_n_7 }),
        .S(transaction_id[19:16]));
  FDRE \transaction_id_reg[1] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[3]_i_1_n_6 ),
        .Q(transaction_id[1]),
        .R(clear));
  FDRE \transaction_id_reg[20] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[23]_i_2_n_7 ),
        .Q(transaction_id[20]),
        .R(clear));
  FDRE \transaction_id_reg[21] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[23]_i_2_n_6 ),
        .Q(transaction_id[21]),
        .R(clear));
  FDRE \transaction_id_reg[22] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[23]_i_2_n_5 ),
        .Q(transaction_id[22]),
        .R(clear));
  FDRE \transaction_id_reg[23] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[23]_i_2_n_4 ),
        .Q(transaction_id[23]),
        .R(clear));
  CARRY4 \transaction_id_reg[23]_i_2 
       (.CI(\transaction_id_reg[19]_i_1_n_0 ),
        .CO({\NLW_transaction_id_reg[23]_i_2_CO_UNCONNECTED [3],\transaction_id_reg[23]_i_2_n_1 ,\transaction_id_reg[23]_i_2_n_2 ,\transaction_id_reg[23]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\transaction_id_reg[23]_i_2_n_4 ,\transaction_id_reg[23]_i_2_n_5 ,\transaction_id_reg[23]_i_2_n_6 ,\transaction_id_reg[23]_i_2_n_7 }),
        .S(transaction_id[23:20]));
  FDRE \transaction_id_reg[2] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[3]_i_1_n_5 ),
        .Q(transaction_id[2]),
        .R(clear));
  FDRE \transaction_id_reg[3] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[3]_i_1_n_4 ),
        .Q(transaction_id[3]),
        .R(clear));
  CARRY4 \transaction_id_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\transaction_id_reg[3]_i_1_n_0 ,\transaction_id_reg[3]_i_1_n_1 ,\transaction_id_reg[3]_i_1_n_2 ,\transaction_id_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\transaction_id_reg[3]_i_1_n_4 ,\transaction_id_reg[3]_i_1_n_5 ,\transaction_id_reg[3]_i_1_n_6 ,\transaction_id_reg[3]_i_1_n_7 }),
        .S({transaction_id[3:1],\transaction_id[3]_i_2_n_0 }));
  FDRE \transaction_id_reg[4] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[7]_i_1_n_7 ),
        .Q(transaction_id[4]),
        .R(clear));
  FDRE \transaction_id_reg[5] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[7]_i_1_n_6 ),
        .Q(transaction_id[5]),
        .R(clear));
  FDRE \transaction_id_reg[6] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[7]_i_1_n_5 ),
        .Q(transaction_id[6]),
        .R(clear));
  FDRE \transaction_id_reg[7] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[7]_i_1_n_4 ),
        .Q(transaction_id[7]),
        .R(clear));
  CARRY4 \transaction_id_reg[7]_i_1 
       (.CI(\transaction_id_reg[3]_i_1_n_0 ),
        .CO({\transaction_id_reg[7]_i_1_n_0 ,\transaction_id_reg[7]_i_1_n_1 ,\transaction_id_reg[7]_i_1_n_2 ,\transaction_id_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\transaction_id_reg[7]_i_1_n_4 ,\transaction_id_reg[7]_i_1_n_5 ,\transaction_id_reg[7]_i_1_n_6 ,\transaction_id_reg[7]_i_1_n_7 }),
        .S(transaction_id[7:4]));
  FDRE \transaction_id_reg[8] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[11]_i_1_n_7 ),
        .Q(transaction_id[8]),
        .R(clear));
  FDRE \transaction_id_reg[9] 
       (.C(clk),
        .CE(cs_falling),
        .D(\transaction_id_reg[11]_i_1_n_6 ),
        .Q(transaction_id[9]),
        .R(clear));
endmodule

(* ORIG_REF_NAME = "spi_mode0_monitor_bd" *) 
module multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor_bd
   (monitor_active_reg,
    evt_data,
    transaction_id,
    dropped_event_count,
    evt_valid_reg,
    evt_trigger,
    rst_n,
    spi_cs_n,
    clk,
    spi_sclk,
    spi_mosi,
    spi_miso,
    timestamp,
    evt_ready);
  output monitor_active_reg;
  output [108:0]evt_data;
  output [23:0]transaction_id;
  output [31:0]dropped_event_count;
  output evt_valid_reg;
  output evt_trigger;
  input rst_n;
  input spi_cs_n;
  input clk;
  input spi_sclk;
  input spi_mosi;
  input spi_miso;
  input [63:0]timestamp;
  input evt_ready;

  wire clk;
  wire [31:0]dropped_event_count;
  wire [108:0]evt_data;
  wire evt_ready;
  wire evt_trigger;
  wire evt_valid_reg;
  wire monitor_active_reg;
  wire rst_n;
  wire spi_cs_n;
  wire spi_miso;
  wire spi_mosi;
  wire spi_sclk;
  wire [63:0]timestamp;
  wire [23:0]transaction_id;

  multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor implementation
       (.clk(clk),
        .dropped_event_count(dropped_event_count),
        .evt_data(evt_data),
        .evt_ready(evt_ready),
        .evt_trigger(evt_trigger),
        .evt_valid_reg_0(evt_valid_reg),
        .monitor_active_reg_0(monitor_active_reg),
        .rst_n(rst_n),
        .spi_cs_n(spi_cs_n),
        .spi_miso(spi_miso),
        .spi_mosi(spi_mosi),
        .spi_sclk(spi_sclk),
        .timestamp(timestamp),
        .transaction_id(transaction_id));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
