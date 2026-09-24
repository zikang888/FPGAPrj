// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Thu Sep 24 16:19:35 2026
// Host        : LAPTOP-MK9F4NL5 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/Vivado/Project/Multi_protocol/Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/ip/multi_protocol_bd_multi_protocol_core_0_0/multi_protocol_bd_multi_protocol_core_0_0_sim_netlist.v
// Design      : multi_protocol_bd_multi_protocol_core_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "multi_protocol_bd_multi_protocol_core_0_0,multi_protocol_core,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "multi_protocol_core,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module multi_protocol_bd_multi_protocol_core_0_0
   (s_axi_aclk,
    s_axi_aresetn,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    ext_evt_valid,
    ext_evt_ready,
    ext_evt_data,
    ext_evt_trigger,
    ext_evt_dropped_count,
    led_heartbeat,
    led_ps_active);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s_axi_aclk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_aclk, ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_aresetn, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN multi_protocol_bd_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input s_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s_axi_aresetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, PROTOCOL AXI4LITE, DATA_WIDTH 32, ADDR_WIDTH 16, FREQ_HZ 100000000, ID_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, SUPPORTS_NARROW_BURST 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1" *) input [15:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) input [3:0]s_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) input [15:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, PROTOCOL AXI4LITE, DATA_WIDTH 32, ADDR_WIDTH 16, FREQ_HZ 100000000, ID_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, SUPPORTS_NARROW_BURST 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_PROT 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_DOMAIN multi_protocol_bd_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input s_axi_rready;
  input ext_evt_valid;
  output ext_evt_ready;
  input [127:0]ext_evt_data;
  input ext_evt_trigger;
  input [31:0]ext_evt_dropped_count;
  output led_heartbeat;
  output led_ps_active;

  wire \<const0> ;
  wire [127:0]ext_evt_data;
  wire [31:0]ext_evt_dropped_count;
  wire ext_evt_ready;
  wire ext_evt_trigger;
  wire ext_evt_valid;
  wire led_heartbeat;
  wire led_ps_active;
  wire s_axi_aclk;
  wire [15:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [15:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;

  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  multi_protocol_bd_multi_protocol_core_0_0_multi_protocol_core inst
       (.ext_evt_data(ext_evt_data),
        .ext_evt_dropped_count(ext_evt_dropped_count),
        .ext_evt_ready(ext_evt_ready),
        .ext_evt_trigger(ext_evt_trigger),
        .ext_evt_valid(ext_evt_valid),
        .led_heartbeat(led_heartbeat),
        .led_ps_active(led_ps_active),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bvalid_reg_0(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid));
endmodule

(* ORIG_REF_NAME = "event_arbiter_2" *) 
module multi_protocol_bd_multi_protocol_core_0_0_event_arbiter_2
   (\s_axi_araddr[4] ,
    E,
    p_3_in,
    ext_evt_valid_0,
    ext_evt_ready,
    \wdata_reg_reg[0] ,
    \wdata_reg_reg[0]_0 ,
    \awaddr_reg_reg[12] ,
    aw_pending_reg,
    capture_arm_pulse_reg,
    s_axi_awaddr_15_sp_1,
    \awaddr_reg_reg[2] ,
    \wstrb_reg_reg[0] ,
    \awaddr_reg_reg[5] ,
    \awaddr_reg_reg[3] ,
    write_addr,
    \awaddr_reg_reg[15] ,
    s_axi_awaddr_6_sp_1,
    \awaddr_reg_reg[8] ,
    s_axi_awaddr_9_sp_1,
    aw_hs,
    in_event,
    \s_axi_araddr[5] ,
    \s_axi_araddr[5]_0 ,
    \s_axi_araddr[5]_1 ,
    \s_axi_araddr[5]_2 ,
    \s_axi_araddr[5]_3 ,
    \s_axi_araddr[5]_4 ,
    \s_axi_araddr[5]_5 ,
    \s_axi_araddr[5]_6 ,
    \s_axi_araddr[5]_7 ,
    \s_axi_araddr[4]_0 ,
    \s_axi_araddr[4]_1 ,
    \s_axi_araddr[4]_2 ,
    \s_axi_araddr[4]_3 ,
    \s_axi_araddr[4]_4 ,
    \s_axi_araddr[4]_5 ,
    \s_axi_araddr[4]_6 ,
    \s_axi_araddr[4]_7 ,
    \s_axi_araddr[4]_8 ,
    \s_axi_araddr[4]_9 ,
    \s_axi_araddr[4]_10 ,
    \s_axi_araddr[4]_11 ,
    \s_axi_araddr[4]_12 ,
    \s_axi_araddr[4]_13 ,
    \s_axi_araddr[4]_14 ,
    \s_axi_araddr[4]_15 ,
    \s_axi_araddr[4]_16 ,
    \s_axi_araddr[4]_17 ,
    \s_axi_araddr[4]_18 ,
    \s_axi_araddr[4]_19 ,
    \s_axi_araddr[4]_20 ,
    ext_evt_dropped_count_3_sp_1,
    virtual_evt_valid_reg,
    virtual_evt_valid_reg_0,
    clear,
    s_axi_aclk,
    \s_axi_rdata_reg[16] ,
    \s_axi_rdata_reg[16]_0 ,
    s_axi_araddr,
    \s_axi_rdata_reg[16]_1 ,
    virtual_evt_trigger_reg,
    virtual_evt_trigger_reg_0,
    virtual_evt_trigger_reg_1,
    ext_evt_valid,
    Q,
    aw_pending,
    s_axi_awaddr,
    \dropped_count_reg[31]_i_4 ,
    \scratch_reg_reg[0] ,
    s_axi_wstrb,
    s_axi_awready,
    s_axi_awvalid,
    ext_evt_ready_INST_0_i_4_0,
    s_axi_wready,
    s_axi_wvalid,
    \scratch_reg_reg[0]_0 ,
    s_axi_wdata,
    \dropped_count_reg[31]_i_6 ,
    ext_evt_data,
    memory_reg_1,
    \s_axi_rdata_reg[27] ,
    \s_axi_rdata_reg[27]_0 ,
    \s_axi_rdata_reg[26] ,
    \s_axi_rdata_reg[26]_0 ,
    \s_axi_rdata_reg[22] ,
    \s_axi_rdata_reg[22]_0 ,
    \s_axi_rdata_reg[20] ,
    \s_axi_rdata_reg[20]_0 ,
    \s_axi_rdata_reg[12] ,
    \s_axi_rdata_reg[12]_0 ,
    \s_axi_rdata_reg[6] ,
    \s_axi_rdata_reg[6]_0 ,
    \s_axi_rdata_reg[2] ,
    \s_axi_rdata_reg[2]_0 ,
    \s_axi_rdata_reg[1] ,
    \s_axi_rdata_reg[1]_0 ,
    \s_axi_rdata_reg[0] ,
    \s_axi_rdata_reg[0]_0 ,
    \s_axi_rdata_reg[31] ,
    ext_evt_dropped_count,
    \s_axi_rdata_reg[31]_i_9_0 ,
    \s_axi_rdata_reg[30] ,
    \s_axi_rdata_reg[29] ,
    \s_axi_rdata_reg[28] ,
    \s_axi_rdata_reg[25] ,
    \s_axi_rdata_reg[24] ,
    \s_axi_rdata_reg[23] ,
    \s_axi_rdata_reg[21] ,
    \s_axi_rdata_reg[19] ,
    \s_axi_rdata_reg[18] ,
    \s_axi_rdata_reg[17] ,
    \s_axi_rdata_reg[15] ,
    \s_axi_rdata_reg[14] ,
    \s_axi_rdata_reg[13] ,
    \s_axi_rdata_reg[11] ,
    \s_axi_rdata_reg[10] ,
    \s_axi_rdata_reg[9] ,
    \s_axi_rdata_reg[8] ,
    \s_axi_rdata_reg[7] ,
    \s_axi_rdata_reg[5] ,
    \s_axi_rdata_reg[4] ,
    virtual_evt_trigger_reg_2,
    virtual_evt_trigger_reg_3,
    virtual_evt_trigger_reg_4,
    virtual_evt_valid_reg_1,
    virtual_evt_valid_reg_2);
  output \s_axi_araddr[4] ;
  output [0:0]E;
  output p_3_in;
  output ext_evt_valid_0;
  output ext_evt_ready;
  output \wdata_reg_reg[0] ;
  output \wdata_reg_reg[0]_0 ;
  output \awaddr_reg_reg[12] ;
  output aw_pending_reg;
  output capture_arm_pulse_reg;
  output s_axi_awaddr_15_sp_1;
  output \awaddr_reg_reg[2] ;
  output \wstrb_reg_reg[0] ;
  output \awaddr_reg_reg[5] ;
  output \awaddr_reg_reg[3] ;
  output [0:0]write_addr;
  output \awaddr_reg_reg[15] ;
  output s_axi_awaddr_6_sp_1;
  output \awaddr_reg_reg[8] ;
  output s_axi_awaddr_9_sp_1;
  output aw_hs;
  output [127:0]in_event;
  output \s_axi_araddr[5] ;
  output \s_axi_araddr[5]_0 ;
  output \s_axi_araddr[5]_1 ;
  output \s_axi_araddr[5]_2 ;
  output \s_axi_araddr[5]_3 ;
  output \s_axi_araddr[5]_4 ;
  output \s_axi_araddr[5]_5 ;
  output \s_axi_araddr[5]_6 ;
  output \s_axi_araddr[5]_7 ;
  output \s_axi_araddr[4]_0 ;
  output \s_axi_araddr[4]_1 ;
  output \s_axi_araddr[4]_2 ;
  output \s_axi_araddr[4]_3 ;
  output \s_axi_araddr[4]_4 ;
  output \s_axi_araddr[4]_5 ;
  output \s_axi_araddr[4]_6 ;
  output \s_axi_araddr[4]_7 ;
  output \s_axi_araddr[4]_8 ;
  output \s_axi_araddr[4]_9 ;
  output \s_axi_araddr[4]_10 ;
  output \s_axi_araddr[4]_11 ;
  output \s_axi_araddr[4]_12 ;
  output \s_axi_araddr[4]_13 ;
  output \s_axi_araddr[4]_14 ;
  output \s_axi_araddr[4]_15 ;
  output \s_axi_araddr[4]_16 ;
  output \s_axi_araddr[4]_17 ;
  output \s_axi_araddr[4]_18 ;
  output \s_axi_araddr[4]_19 ;
  output \s_axi_araddr[4]_20 ;
  output ext_evt_dropped_count_3_sp_1;
  output virtual_evt_valid_reg;
  output virtual_evt_valid_reg_0;
  input clear;
  input s_axi_aclk;
  input \s_axi_rdata_reg[16] ;
  input \s_axi_rdata_reg[16]_0 ;
  input [3:0]s_axi_araddr;
  input \s_axi_rdata_reg[16]_1 ;
  input virtual_evt_trigger_reg;
  input virtual_evt_trigger_reg_0;
  input virtual_evt_trigger_reg_1;
  input ext_evt_valid;
  input [15:0]Q;
  input aw_pending;
  input [15:0]s_axi_awaddr;
  input [0:0]\dropped_count_reg[31]_i_4 ;
  input \scratch_reg_reg[0] ;
  input [0:0]s_axi_wstrb;
  input s_axi_awready;
  input s_axi_awvalid;
  input ext_evt_ready_INST_0_i_4_0;
  input s_axi_wready;
  input s_axi_wvalid;
  input [0:0]\scratch_reg_reg[0]_0 ;
  input [0:0]s_axi_wdata;
  input \dropped_count_reg[31]_i_6 ;
  input [127:0]ext_evt_data;
  input [91:0]memory_reg_1;
  input \s_axi_rdata_reg[27] ;
  input \s_axi_rdata_reg[27]_0 ;
  input \s_axi_rdata_reg[26] ;
  input \s_axi_rdata_reg[26]_0 ;
  input \s_axi_rdata_reg[22] ;
  input \s_axi_rdata_reg[22]_0 ;
  input \s_axi_rdata_reg[20] ;
  input \s_axi_rdata_reg[20]_0 ;
  input \s_axi_rdata_reg[12] ;
  input \s_axi_rdata_reg[12]_0 ;
  input \s_axi_rdata_reg[6] ;
  input \s_axi_rdata_reg[6]_0 ;
  input \s_axi_rdata_reg[2] ;
  input \s_axi_rdata_reg[2]_0 ;
  input \s_axi_rdata_reg[1] ;
  input \s_axi_rdata_reg[1]_0 ;
  input \s_axi_rdata_reg[0] ;
  input \s_axi_rdata_reg[0]_0 ;
  input \s_axi_rdata_reg[31] ;
  input [31:0]ext_evt_dropped_count;
  input [31:0]\s_axi_rdata_reg[31]_i_9_0 ;
  input \s_axi_rdata_reg[30] ;
  input \s_axi_rdata_reg[29] ;
  input \s_axi_rdata_reg[28] ;
  input \s_axi_rdata_reg[25] ;
  input \s_axi_rdata_reg[24] ;
  input \s_axi_rdata_reg[23] ;
  input \s_axi_rdata_reg[21] ;
  input \s_axi_rdata_reg[19] ;
  input \s_axi_rdata_reg[18] ;
  input \s_axi_rdata_reg[17] ;
  input \s_axi_rdata_reg[15] ;
  input \s_axi_rdata_reg[14] ;
  input \s_axi_rdata_reg[13] ;
  input \s_axi_rdata_reg[11] ;
  input \s_axi_rdata_reg[10] ;
  input \s_axi_rdata_reg[9] ;
  input \s_axi_rdata_reg[8] ;
  input \s_axi_rdata_reg[7] ;
  input \s_axi_rdata_reg[5] ;
  input \s_axi_rdata_reg[4] ;
  input virtual_evt_trigger_reg_2;
  input virtual_evt_trigger_reg_3;
  input virtual_evt_trigger_reg_4;
  input virtual_evt_valid_reg_1;
  input virtual_evt_valid_reg_2;

  wire [0:0]E;
  wire [15:0]Q;
  wire aw_hs;
  wire aw_pending;
  wire aw_pending_reg;
  wire \awaddr_reg_reg[12] ;
  wire \awaddr_reg_reg[15] ;
  wire \awaddr_reg_reg[2] ;
  wire \awaddr_reg_reg[3] ;
  wire \awaddr_reg_reg[5] ;
  wire \awaddr_reg_reg[8] ;
  wire capture_arm_pulse_reg;
  wire clear;
  wire \contention_count[0]_i_1_n_0 ;
  wire \contention_count[0]_i_3_n_0 ;
  wire \contention_count_reg[0]_i_2_n_0 ;
  wire \contention_count_reg[0]_i_2_n_1 ;
  wire \contention_count_reg[0]_i_2_n_2 ;
  wire \contention_count_reg[0]_i_2_n_3 ;
  wire \contention_count_reg[0]_i_2_n_4 ;
  wire \contention_count_reg[0]_i_2_n_5 ;
  wire \contention_count_reg[0]_i_2_n_6 ;
  wire \contention_count_reg[0]_i_2_n_7 ;
  wire \contention_count_reg[12]_i_1_n_0 ;
  wire \contention_count_reg[12]_i_1_n_1 ;
  wire \contention_count_reg[12]_i_1_n_2 ;
  wire \contention_count_reg[12]_i_1_n_3 ;
  wire \contention_count_reg[12]_i_1_n_4 ;
  wire \contention_count_reg[12]_i_1_n_5 ;
  wire \contention_count_reg[12]_i_1_n_6 ;
  wire \contention_count_reg[12]_i_1_n_7 ;
  wire \contention_count_reg[16]_i_1_n_0 ;
  wire \contention_count_reg[16]_i_1_n_1 ;
  wire \contention_count_reg[16]_i_1_n_2 ;
  wire \contention_count_reg[16]_i_1_n_3 ;
  wire \contention_count_reg[16]_i_1_n_4 ;
  wire \contention_count_reg[16]_i_1_n_5 ;
  wire \contention_count_reg[16]_i_1_n_6 ;
  wire \contention_count_reg[16]_i_1_n_7 ;
  wire \contention_count_reg[20]_i_1_n_0 ;
  wire \contention_count_reg[20]_i_1_n_1 ;
  wire \contention_count_reg[20]_i_1_n_2 ;
  wire \contention_count_reg[20]_i_1_n_3 ;
  wire \contention_count_reg[20]_i_1_n_4 ;
  wire \contention_count_reg[20]_i_1_n_5 ;
  wire \contention_count_reg[20]_i_1_n_6 ;
  wire \contention_count_reg[20]_i_1_n_7 ;
  wire \contention_count_reg[24]_i_1_n_0 ;
  wire \contention_count_reg[24]_i_1_n_1 ;
  wire \contention_count_reg[24]_i_1_n_2 ;
  wire \contention_count_reg[24]_i_1_n_3 ;
  wire \contention_count_reg[24]_i_1_n_4 ;
  wire \contention_count_reg[24]_i_1_n_5 ;
  wire \contention_count_reg[24]_i_1_n_6 ;
  wire \contention_count_reg[24]_i_1_n_7 ;
  wire \contention_count_reg[28]_i_1_n_1 ;
  wire \contention_count_reg[28]_i_1_n_2 ;
  wire \contention_count_reg[28]_i_1_n_3 ;
  wire \contention_count_reg[28]_i_1_n_4 ;
  wire \contention_count_reg[28]_i_1_n_5 ;
  wire \contention_count_reg[28]_i_1_n_6 ;
  wire \contention_count_reg[28]_i_1_n_7 ;
  wire \contention_count_reg[4]_i_1_n_0 ;
  wire \contention_count_reg[4]_i_1_n_1 ;
  wire \contention_count_reg[4]_i_1_n_2 ;
  wire \contention_count_reg[4]_i_1_n_3 ;
  wire \contention_count_reg[4]_i_1_n_4 ;
  wire \contention_count_reg[4]_i_1_n_5 ;
  wire \contention_count_reg[4]_i_1_n_6 ;
  wire \contention_count_reg[4]_i_1_n_7 ;
  wire \contention_count_reg[8]_i_1_n_0 ;
  wire \contention_count_reg[8]_i_1_n_1 ;
  wire \contention_count_reg[8]_i_1_n_2 ;
  wire \contention_count_reg[8]_i_1_n_3 ;
  wire \contention_count_reg[8]_i_1_n_4 ;
  wire \contention_count_reg[8]_i_1_n_5 ;
  wire \contention_count_reg[8]_i_1_n_6 ;
  wire \contention_count_reg[8]_i_1_n_7 ;
  wire [0:0]\dropped_count_reg[31]_i_4 ;
  wire \dropped_count_reg[31]_i_6 ;
  wire [127:0]ext_evt_data;
  wire [31:0]ext_evt_dropped_count;
  wire ext_evt_dropped_count_3_sn_1;
  wire ext_evt_ready;
  wire ext_evt_ready_INST_0_i_11_n_0;
  wire ext_evt_ready_INST_0_i_4_0;
  wire ext_evt_ready_INST_0_i_8_n_0;
  wire ext_evt_valid;
  wire ext_evt_valid_0;
  wire [127:0]in_event;
  wire last_grant;
  wire last_grant_i_1_n_0;
  wire [91:0]memory_reg_1;
  wire [31:0]p_1_in;
  wire p_3_in;
  wire s_axi_aclk;
  wire [3:0]s_axi_araddr;
  wire \s_axi_araddr[4] ;
  wire \s_axi_araddr[4]_0 ;
  wire \s_axi_araddr[4]_1 ;
  wire \s_axi_araddr[4]_10 ;
  wire \s_axi_araddr[4]_11 ;
  wire \s_axi_araddr[4]_12 ;
  wire \s_axi_araddr[4]_13 ;
  wire \s_axi_araddr[4]_14 ;
  wire \s_axi_araddr[4]_15 ;
  wire \s_axi_araddr[4]_16 ;
  wire \s_axi_araddr[4]_17 ;
  wire \s_axi_araddr[4]_18 ;
  wire \s_axi_araddr[4]_19 ;
  wire \s_axi_araddr[4]_2 ;
  wire \s_axi_araddr[4]_20 ;
  wire \s_axi_araddr[4]_3 ;
  wire \s_axi_araddr[4]_4 ;
  wire \s_axi_araddr[4]_5 ;
  wire \s_axi_araddr[4]_6 ;
  wire \s_axi_araddr[4]_7 ;
  wire \s_axi_araddr[4]_8 ;
  wire \s_axi_araddr[4]_9 ;
  wire \s_axi_araddr[5] ;
  wire \s_axi_araddr[5]_0 ;
  wire \s_axi_araddr[5]_1 ;
  wire \s_axi_araddr[5]_2 ;
  wire \s_axi_araddr[5]_3 ;
  wire \s_axi_araddr[5]_4 ;
  wire \s_axi_araddr[5]_5 ;
  wire \s_axi_araddr[5]_6 ;
  wire \s_axi_araddr[5]_7 ;
  wire [15:0]s_axi_awaddr;
  wire s_axi_awaddr_15_sn_1;
  wire s_axi_awaddr_6_sn_1;
  wire s_axi_awaddr_9_sn_1;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire \s_axi_rdata[0]_i_6_n_0 ;
  wire \s_axi_rdata[10]_i_7_n_0 ;
  wire \s_axi_rdata[11]_i_7_n_0 ;
  wire \s_axi_rdata[12]_i_5_n_0 ;
  wire \s_axi_rdata[13]_i_7_n_0 ;
  wire \s_axi_rdata[14]_i_7_n_0 ;
  wire \s_axi_rdata[15]_i_7_n_0 ;
  wire \s_axi_rdata[16]_i_6_n_0 ;
  wire \s_axi_rdata[17]_i_7_n_0 ;
  wire \s_axi_rdata[18]_i_7_n_0 ;
  wire \s_axi_rdata[19]_i_7_n_0 ;
  wire \s_axi_rdata[1]_i_6_n_0 ;
  wire \s_axi_rdata[20]_i_5_n_0 ;
  wire \s_axi_rdata[21]_i_7_n_0 ;
  wire \s_axi_rdata[22]_i_5_n_0 ;
  wire \s_axi_rdata[23]_i_7_n_0 ;
  wire \s_axi_rdata[24]_i_7_n_0 ;
  wire \s_axi_rdata[25]_i_7_n_0 ;
  wire \s_axi_rdata[26]_i_5_n_0 ;
  wire \s_axi_rdata[27]_i_8_n_0 ;
  wire \s_axi_rdata[28]_i_7_n_0 ;
  wire \s_axi_rdata[29]_i_7_n_0 ;
  wire \s_axi_rdata[2]_i_6_n_0 ;
  wire \s_axi_rdata[30]_i_7_n_0 ;
  wire \s_axi_rdata[31]_i_15_n_0 ;
  wire \s_axi_rdata[4]_i_8_n_0 ;
  wire \s_axi_rdata[5]_i_8_n_0 ;
  wire \s_axi_rdata[6]_i_6_n_0 ;
  wire \s_axi_rdata[7]_i_10_n_0 ;
  wire \s_axi_rdata[8]_i_8_n_0 ;
  wire \s_axi_rdata[9]_i_7_n_0 ;
  wire \s_axi_rdata_reg[0] ;
  wire \s_axi_rdata_reg[0]_0 ;
  wire \s_axi_rdata_reg[10] ;
  wire \s_axi_rdata_reg[11] ;
  wire \s_axi_rdata_reg[12] ;
  wire \s_axi_rdata_reg[12]_0 ;
  wire \s_axi_rdata_reg[13] ;
  wire \s_axi_rdata_reg[14] ;
  wire \s_axi_rdata_reg[15] ;
  wire \s_axi_rdata_reg[16] ;
  wire \s_axi_rdata_reg[16]_0 ;
  wire \s_axi_rdata_reg[16]_1 ;
  wire \s_axi_rdata_reg[17] ;
  wire \s_axi_rdata_reg[18] ;
  wire \s_axi_rdata_reg[19] ;
  wire \s_axi_rdata_reg[1] ;
  wire \s_axi_rdata_reg[1]_0 ;
  wire \s_axi_rdata_reg[20] ;
  wire \s_axi_rdata_reg[20]_0 ;
  wire \s_axi_rdata_reg[21] ;
  wire \s_axi_rdata_reg[22] ;
  wire \s_axi_rdata_reg[22]_0 ;
  wire \s_axi_rdata_reg[23] ;
  wire \s_axi_rdata_reg[24] ;
  wire \s_axi_rdata_reg[25] ;
  wire \s_axi_rdata_reg[26] ;
  wire \s_axi_rdata_reg[26]_0 ;
  wire \s_axi_rdata_reg[27] ;
  wire \s_axi_rdata_reg[27]_0 ;
  wire \s_axi_rdata_reg[28] ;
  wire \s_axi_rdata_reg[29] ;
  wire \s_axi_rdata_reg[2] ;
  wire \s_axi_rdata_reg[2]_0 ;
  wire \s_axi_rdata_reg[30] ;
  wire \s_axi_rdata_reg[31] ;
  wire [31:0]\s_axi_rdata_reg[31]_i_9_0 ;
  wire \s_axi_rdata_reg[4] ;
  wire \s_axi_rdata_reg[5] ;
  wire \s_axi_rdata_reg[6] ;
  wire \s_axi_rdata_reg[6]_0 ;
  wire \s_axi_rdata_reg[7] ;
  wire \s_axi_rdata_reg[8] ;
  wire \s_axi_rdata_reg[9] ;
  wire [0:0]s_axi_wdata;
  wire s_axi_wready;
  wire [0:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire \scratch_reg_reg[0] ;
  wire [0:0]\scratch_reg_reg[0]_0 ;
  wire virtual_evt_trigger_reg;
  wire virtual_evt_trigger_reg_0;
  wire virtual_evt_trigger_reg_1;
  wire virtual_evt_trigger_reg_2;
  wire virtual_evt_trigger_reg_3;
  wire virtual_evt_trigger_reg_4;
  wire virtual_evt_valid_reg;
  wire virtual_evt_valid_reg_0;
  wire virtual_evt_valid_reg_1;
  wire virtual_evt_valid_reg_2;
  wire \wdata_reg_reg[0] ;
  wire \wdata_reg_reg[0]_0 ;
  wire [0:0]write_addr;
  wire \wstrb_reg_reg[0] ;
  wire [3:3]\NLW_contention_count_reg[28]_i_1_CO_UNCONNECTED ;

  assign ext_evt_dropped_count_3_sp_1 = ext_evt_dropped_count_3_sn_1;
  assign s_axi_awaddr_15_sp_1 = s_axi_awaddr_15_sn_1;
  assign s_axi_awaddr_6_sp_1 = s_axi_awaddr_6_sn_1;
  assign s_axi_awaddr_9_sp_1 = s_axi_awaddr_9_sn_1;
  LUT2 #(
    .INIT(4'h8)) 
    \awaddr_reg[15]_i_1 
       (.I0(s_axi_awready),
        .I1(s_axi_awvalid),
        .O(aw_hs));
  LUT3 #(
    .INIT(8'h80)) 
    \contention_count[0]_i_1 
       (.I0(p_3_in),
        .I1(virtual_evt_trigger_reg),
        .I2(ext_evt_valid),
        .O(\contention_count[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \contention_count[0]_i_3 
       (.I0(p_1_in[0]),
        .O(\contention_count[0]_i_3_n_0 ));
  FDRE \contention_count_reg[0] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[0]_i_2_n_7 ),
        .Q(p_1_in[0]),
        .R(clear));
  CARRY4 \contention_count_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\contention_count_reg[0]_i_2_n_0 ,\contention_count_reg[0]_i_2_n_1 ,\contention_count_reg[0]_i_2_n_2 ,\contention_count_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\contention_count_reg[0]_i_2_n_4 ,\contention_count_reg[0]_i_2_n_5 ,\contention_count_reg[0]_i_2_n_6 ,\contention_count_reg[0]_i_2_n_7 }),
        .S({p_1_in[3:1],\contention_count[0]_i_3_n_0 }));
  FDRE \contention_count_reg[10] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[8]_i_1_n_5 ),
        .Q(p_1_in[10]),
        .R(clear));
  FDRE \contention_count_reg[11] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[8]_i_1_n_4 ),
        .Q(p_1_in[11]),
        .R(clear));
  FDRE \contention_count_reg[12] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[12]_i_1_n_7 ),
        .Q(p_1_in[12]),
        .R(clear));
  CARRY4 \contention_count_reg[12]_i_1 
       (.CI(\contention_count_reg[8]_i_1_n_0 ),
        .CO({\contention_count_reg[12]_i_1_n_0 ,\contention_count_reg[12]_i_1_n_1 ,\contention_count_reg[12]_i_1_n_2 ,\contention_count_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\contention_count_reg[12]_i_1_n_4 ,\contention_count_reg[12]_i_1_n_5 ,\contention_count_reg[12]_i_1_n_6 ,\contention_count_reg[12]_i_1_n_7 }),
        .S(p_1_in[15:12]));
  FDRE \contention_count_reg[13] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[12]_i_1_n_6 ),
        .Q(p_1_in[13]),
        .R(clear));
  FDRE \contention_count_reg[14] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[12]_i_1_n_5 ),
        .Q(p_1_in[14]),
        .R(clear));
  FDRE \contention_count_reg[15] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[12]_i_1_n_4 ),
        .Q(p_1_in[15]),
        .R(clear));
  FDRE \contention_count_reg[16] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[16]_i_1_n_7 ),
        .Q(p_1_in[16]),
        .R(clear));
  CARRY4 \contention_count_reg[16]_i_1 
       (.CI(\contention_count_reg[12]_i_1_n_0 ),
        .CO({\contention_count_reg[16]_i_1_n_0 ,\contention_count_reg[16]_i_1_n_1 ,\contention_count_reg[16]_i_1_n_2 ,\contention_count_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\contention_count_reg[16]_i_1_n_4 ,\contention_count_reg[16]_i_1_n_5 ,\contention_count_reg[16]_i_1_n_6 ,\contention_count_reg[16]_i_1_n_7 }),
        .S(p_1_in[19:16]));
  FDRE \contention_count_reg[17] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[16]_i_1_n_6 ),
        .Q(p_1_in[17]),
        .R(clear));
  FDRE \contention_count_reg[18] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[16]_i_1_n_5 ),
        .Q(p_1_in[18]),
        .R(clear));
  FDRE \contention_count_reg[19] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[16]_i_1_n_4 ),
        .Q(p_1_in[19]),
        .R(clear));
  FDRE \contention_count_reg[1] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[0]_i_2_n_6 ),
        .Q(p_1_in[1]),
        .R(clear));
  FDRE \contention_count_reg[20] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[20]_i_1_n_7 ),
        .Q(p_1_in[20]),
        .R(clear));
  CARRY4 \contention_count_reg[20]_i_1 
       (.CI(\contention_count_reg[16]_i_1_n_0 ),
        .CO({\contention_count_reg[20]_i_1_n_0 ,\contention_count_reg[20]_i_1_n_1 ,\contention_count_reg[20]_i_1_n_2 ,\contention_count_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\contention_count_reg[20]_i_1_n_4 ,\contention_count_reg[20]_i_1_n_5 ,\contention_count_reg[20]_i_1_n_6 ,\contention_count_reg[20]_i_1_n_7 }),
        .S(p_1_in[23:20]));
  FDRE \contention_count_reg[21] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[20]_i_1_n_6 ),
        .Q(p_1_in[21]),
        .R(clear));
  FDRE \contention_count_reg[22] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[20]_i_1_n_5 ),
        .Q(p_1_in[22]),
        .R(clear));
  FDRE \contention_count_reg[23] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[20]_i_1_n_4 ),
        .Q(p_1_in[23]),
        .R(clear));
  FDRE \contention_count_reg[24] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[24]_i_1_n_7 ),
        .Q(p_1_in[24]),
        .R(clear));
  CARRY4 \contention_count_reg[24]_i_1 
       (.CI(\contention_count_reg[20]_i_1_n_0 ),
        .CO({\contention_count_reg[24]_i_1_n_0 ,\contention_count_reg[24]_i_1_n_1 ,\contention_count_reg[24]_i_1_n_2 ,\contention_count_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\contention_count_reg[24]_i_1_n_4 ,\contention_count_reg[24]_i_1_n_5 ,\contention_count_reg[24]_i_1_n_6 ,\contention_count_reg[24]_i_1_n_7 }),
        .S(p_1_in[27:24]));
  FDRE \contention_count_reg[25] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[24]_i_1_n_6 ),
        .Q(p_1_in[25]),
        .R(clear));
  FDRE \contention_count_reg[26] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[24]_i_1_n_5 ),
        .Q(p_1_in[26]),
        .R(clear));
  FDRE \contention_count_reg[27] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[24]_i_1_n_4 ),
        .Q(p_1_in[27]),
        .R(clear));
  FDRE \contention_count_reg[28] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[28]_i_1_n_7 ),
        .Q(p_1_in[28]),
        .R(clear));
  CARRY4 \contention_count_reg[28]_i_1 
       (.CI(\contention_count_reg[24]_i_1_n_0 ),
        .CO({\NLW_contention_count_reg[28]_i_1_CO_UNCONNECTED [3],\contention_count_reg[28]_i_1_n_1 ,\contention_count_reg[28]_i_1_n_2 ,\contention_count_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\contention_count_reg[28]_i_1_n_4 ,\contention_count_reg[28]_i_1_n_5 ,\contention_count_reg[28]_i_1_n_6 ,\contention_count_reg[28]_i_1_n_7 }),
        .S(p_1_in[31:28]));
  FDRE \contention_count_reg[29] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[28]_i_1_n_6 ),
        .Q(p_1_in[29]),
        .R(clear));
  FDRE \contention_count_reg[2] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[0]_i_2_n_5 ),
        .Q(p_1_in[2]),
        .R(clear));
  FDRE \contention_count_reg[30] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[28]_i_1_n_5 ),
        .Q(p_1_in[30]),
        .R(clear));
  FDRE \contention_count_reg[31] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[28]_i_1_n_4 ),
        .Q(p_1_in[31]),
        .R(clear));
  FDRE \contention_count_reg[3] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[0]_i_2_n_4 ),
        .Q(p_1_in[3]),
        .R(clear));
  FDRE \contention_count_reg[4] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[4]_i_1_n_7 ),
        .Q(p_1_in[4]),
        .R(clear));
  CARRY4 \contention_count_reg[4]_i_1 
       (.CI(\contention_count_reg[0]_i_2_n_0 ),
        .CO({\contention_count_reg[4]_i_1_n_0 ,\contention_count_reg[4]_i_1_n_1 ,\contention_count_reg[4]_i_1_n_2 ,\contention_count_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\contention_count_reg[4]_i_1_n_4 ,\contention_count_reg[4]_i_1_n_5 ,\contention_count_reg[4]_i_1_n_6 ,\contention_count_reg[4]_i_1_n_7 }),
        .S(p_1_in[7:4]));
  FDRE \contention_count_reg[5] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[4]_i_1_n_6 ),
        .Q(p_1_in[5]),
        .R(clear));
  FDRE \contention_count_reg[6] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[4]_i_1_n_5 ),
        .Q(p_1_in[6]),
        .R(clear));
  FDRE \contention_count_reg[7] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[4]_i_1_n_4 ),
        .Q(p_1_in[7]),
        .R(clear));
  FDRE \contention_count_reg[8] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[8]_i_1_n_7 ),
        .Q(p_1_in[8]),
        .R(clear));
  CARRY4 \contention_count_reg[8]_i_1 
       (.CI(\contention_count_reg[4]_i_1_n_0 ),
        .CO({\contention_count_reg[8]_i_1_n_0 ,\contention_count_reg[8]_i_1_n_1 ,\contention_count_reg[8]_i_1_n_2 ,\contention_count_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\contention_count_reg[8]_i_1_n_4 ,\contention_count_reg[8]_i_1_n_5 ,\contention_count_reg[8]_i_1_n_6 ,\contention_count_reg[8]_i_1_n_7 }),
        .S(p_1_in[11:8]));
  FDRE \contention_count_reg[9] 
       (.C(s_axi_aclk),
        .CE(\contention_count[0]_i_1_n_0 ),
        .D(\contention_count_reg[8]_i_1_n_6 ),
        .Q(p_1_in[9]),
        .R(clear));
  LUT6 #(
    .INIT(64'h00000000FDFF0000)) 
    \dropped_count_reg[31]_i_7 
       (.I0(\wdata_reg_reg[0]_0 ),
        .I1(virtual_evt_trigger_reg_1),
        .I2(\awaddr_reg_reg[12] ),
        .I3(aw_pending_reg),
        .I4(capture_arm_pulse_reg),
        .I5(ext_evt_valid_0),
        .O(\wdata_reg_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h8)) 
    ext_evt_ready_INST_0
       (.I0(p_3_in),
        .I1(ext_evt_valid_0),
        .O(ext_evt_ready));
  LUT6 #(
    .INIT(64'hAAAAAAA2AAAAAAAA)) 
    ext_evt_ready_INST_0_i_1
       (.I0(capture_arm_pulse_reg),
        .I1(aw_pending_reg),
        .I2(\awaddr_reg_reg[12] ),
        .I3(s_axi_awaddr_15_sn_1),
        .I4(\awaddr_reg_reg[2] ),
        .I5(\wdata_reg_reg[0]_0 ),
        .O(p_3_in));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    ext_evt_ready_INST_0_i_10
       (.I0(s_axi_awaddr[9]),
        .I1(Q[9]),
        .I2(s_axi_awaddr[10]),
        .I3(aw_pending),
        .I4(Q[10]),
        .O(s_axi_awaddr_9_sn_1));
  LUT4 #(
    .INIT(16'hAABF)) 
    ext_evt_ready_INST_0_i_11
       (.I0(ext_evt_ready_INST_0_i_4_0),
        .I1(s_axi_wready),
        .I2(s_axi_wvalid),
        .I3(\scratch_reg_reg[0] ),
        .O(ext_evt_ready_INST_0_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    ext_evt_ready_INST_0_i_12
       (.I0(\dropped_count_reg[31]_i_4 ),
        .I1(\scratch_reg_reg[0] ),
        .I2(s_axi_wstrb),
        .O(\wstrb_reg_reg[0] ));
  LUT4 #(
    .INIT(16'h0004)) 
    ext_evt_ready_INST_0_i_13
       (.I0(Q[15]),
        .I1(aw_pending),
        .I2(Q[14]),
        .I3(Q[13]),
        .O(\awaddr_reg_reg[15] ));
  LUT5 #(
    .INIT(32'h00053305)) 
    ext_evt_ready_INST_0_i_14
       (.I0(s_axi_awaddr[6]),
        .I1(Q[6]),
        .I2(s_axi_awaddr[7]),
        .I3(aw_pending),
        .I4(Q[7]),
        .O(s_axi_awaddr_6_sn_1));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    ext_evt_ready_INST_0_i_15
       (.I0(Q[5]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[5]),
        .O(\awaddr_reg_reg[5] ));
  LUT3 #(
    .INIT(8'h2A)) 
    ext_evt_ready_INST_0_i_2
       (.I0(ext_evt_valid),
        .I1(last_grant),
        .I2(virtual_evt_trigger_reg),
        .O(ext_evt_valid_0));
  LUT3 #(
    .INIT(8'h54)) 
    ext_evt_ready_INST_0_i_3
       (.I0(\dropped_count_reg[31]_i_6 ),
        .I1(virtual_evt_trigger_reg),
        .I2(ext_evt_valid),
        .O(capture_arm_pulse_reg));
  LUT6 #(
    .INIT(64'h0000000001010100)) 
    ext_evt_ready_INST_0_i_4
       (.I0(ext_evt_ready_INST_0_i_8_n_0),
        .I1(\awaddr_reg_reg[8] ),
        .I2(s_axi_awaddr_9_sn_1),
        .I3(aw_pending),
        .I4(aw_hs),
        .I5(ext_evt_ready_INST_0_i_11_n_0),
        .O(aw_pending_reg));
  LUT6 #(
    .INIT(64'hFF77CF47FFFFFFFF)) 
    ext_evt_ready_INST_0_i_5
       (.I0(Q[12]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[12]),
        .I3(Q[1]),
        .I4(s_axi_awaddr[1]),
        .I5(\wstrb_reg_reg[0] ),
        .O(\awaddr_reg_reg[12] ));
  LUT6 #(
    .INIT(64'h55555554FFFFFFFF)) 
    ext_evt_ready_INST_0_i_6
       (.I0(\awaddr_reg_reg[15] ),
        .I1(s_axi_awaddr[15]),
        .I2(aw_pending),
        .I3(s_axi_awaddr[14]),
        .I4(s_axi_awaddr[13]),
        .I5(s_axi_awaddr_6_sn_1),
        .O(s_axi_awaddr_15_sn_1));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFB8)) 
    ext_evt_ready_INST_0_i_7
       (.I0(Q[2]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[2]),
        .I3(\awaddr_reg_reg[5] ),
        .I4(\awaddr_reg_reg[3] ),
        .I5(write_addr),
        .O(\awaddr_reg_reg[2] ));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    ext_evt_ready_INST_0_i_8
       (.I0(s_axi_awaddr[0]),
        .I1(Q[0]),
        .I2(s_axi_awaddr[11]),
        .I3(aw_pending),
        .I4(Q[11]),
        .O(ext_evt_ready_INST_0_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    ext_evt_ready_INST_0_i_9
       (.I0(Q[8]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[8]),
        .O(\awaddr_reg_reg[8] ));
  LUT3 #(
    .INIT(8'hB8)) 
    last_grant_i_1
       (.I0(ext_evt_valid_0),
        .I1(p_3_in),
        .I2(last_grant),
        .O(last_grant_i_1_n_0));
  FDRE last_grant_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(last_grant_i_1_n_0),
        .Q(last_grant),
        .R(clear));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[0]_i_2 
       (.I0(\scratch_reg_reg[0]_0 ),
        .I1(\scratch_reg_reg[0] ),
        .I2(s_axi_wdata),
        .O(\wdata_reg_reg[0]_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_10
       (.I0(ext_evt_data[24]),
        .I1(ext_evt_valid_0),
        .O(in_event[24]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_11
       (.I0(ext_evt_data[23]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[23]),
        .O(in_event[23]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_12
       (.I0(ext_evt_data[22]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[22]),
        .O(in_event[22]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_13
       (.I0(ext_evt_data[21]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[21]),
        .O(in_event[21]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_14
       (.I0(ext_evt_data[20]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[20]),
        .O(in_event[20]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_15
       (.I0(ext_evt_data[19]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[19]),
        .O(in_event[19]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_16
       (.I0(ext_evt_data[18]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[18]),
        .O(in_event[18]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_17
       (.I0(ext_evt_data[17]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[17]),
        .O(in_event[17]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_18
       (.I0(ext_evt_data[16]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[16]),
        .O(in_event[16]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_19
       (.I0(ext_evt_data[15]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[15]),
        .O(in_event[15]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_20
       (.I0(ext_evt_data[14]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[14]),
        .O(in_event[14]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_21
       (.I0(ext_evt_data[13]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[13]),
        .O(in_event[13]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_22
       (.I0(ext_evt_data[12]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[12]),
        .O(in_event[12]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_23
       (.I0(ext_evt_data[11]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[11]),
        .O(in_event[11]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_24
       (.I0(ext_evt_data[10]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[10]),
        .O(in_event[10]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_25
       (.I0(ext_evt_data[9]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[9]),
        .O(in_event[9]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_26
       (.I0(ext_evt_data[8]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[8]),
        .O(in_event[8]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_27
       (.I0(ext_evt_data[7]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[7]),
        .O(in_event[7]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_28
       (.I0(ext_evt_data[6]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[6]),
        .O(in_event[6]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_29
       (.I0(ext_evt_data[5]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[5]),
        .O(in_event[5]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_3
       (.I0(ext_evt_data[31]),
        .I1(ext_evt_valid_0),
        .O(in_event[31]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_30
       (.I0(ext_evt_data[4]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[4]),
        .O(in_event[4]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_31
       (.I0(ext_evt_data[3]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[3]),
        .O(in_event[3]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_32
       (.I0(ext_evt_data[2]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[2]),
        .O(in_event[2]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_33
       (.I0(ext_evt_data[1]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[1]),
        .O(in_event[1]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_34
       (.I0(ext_evt_data[0]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[0]),
        .O(in_event[0]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_35
       (.I0(ext_evt_data[63]),
        .I1(ext_evt_valid_0),
        .O(in_event[63]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_36
       (.I0(ext_evt_data[62]),
        .I1(ext_evt_valid_0),
        .O(in_event[62]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_37
       (.I0(ext_evt_data[61]),
        .I1(ext_evt_valid_0),
        .O(in_event[61]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_38
       (.I0(ext_evt_data[60]),
        .I1(ext_evt_valid_0),
        .O(in_event[60]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_39
       (.I0(ext_evt_data[59]),
        .I1(ext_evt_valid_0),
        .O(in_event[59]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_4
       (.I0(ext_evt_data[30]),
        .I1(ext_evt_valid_0),
        .O(in_event[30]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_40
       (.I0(ext_evt_data[58]),
        .I1(ext_evt_valid_0),
        .O(in_event[58]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_41
       (.I0(ext_evt_data[57]),
        .I1(ext_evt_valid_0),
        .O(in_event[57]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_42
       (.I0(ext_evt_data[56]),
        .I1(ext_evt_valid_0),
        .O(in_event[56]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_43
       (.I0(ext_evt_data[55]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[27]),
        .O(in_event[55]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_44
       (.I0(ext_evt_data[54]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[27]),
        .O(in_event[54]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_45
       (.I0(ext_evt_data[53]),
        .I1(ext_evt_valid_0),
        .O(in_event[53]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_46
       (.I0(ext_evt_data[52]),
        .I1(ext_evt_valid_0),
        .O(in_event[52]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_47
       (.I0(ext_evt_data[51]),
        .I1(ext_evt_valid_0),
        .O(in_event[51]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_48
       (.I0(ext_evt_data[50]),
        .I1(ext_evt_valid_0),
        .O(in_event[50]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_49
       (.I0(ext_evt_data[49]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[26]),
        .O(in_event[49]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_5
       (.I0(ext_evt_data[29]),
        .I1(ext_evt_valid_0),
        .O(in_event[29]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_50
       (.I0(ext_evt_data[48]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[25]),
        .O(in_event[48]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_51
       (.I0(ext_evt_data[47]),
        .I1(ext_evt_valid_0),
        .O(in_event[47]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_52
       (.I0(ext_evt_data[46]),
        .I1(ext_evt_valid_0),
        .O(in_event[46]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_53
       (.I0(ext_evt_data[45]),
        .I1(ext_evt_valid_0),
        .O(in_event[45]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_54
       (.I0(ext_evt_data[44]),
        .I1(ext_evt_valid_0),
        .O(in_event[44]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_55
       (.I0(ext_evt_data[43]),
        .I1(ext_evt_valid_0),
        .O(in_event[43]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_56
       (.I0(ext_evt_data[42]),
        .I1(ext_evt_valid_0),
        .O(in_event[42]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_57
       (.I0(ext_evt_data[41]),
        .I1(ext_evt_valid_0),
        .O(in_event[41]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_58
       (.I0(ext_evt_data[40]),
        .I1(ext_evt_valid_0),
        .O(in_event[40]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_59
       (.I0(ext_evt_data[39]),
        .I1(ext_evt_valid_0),
        .O(in_event[39]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_6
       (.I0(ext_evt_data[28]),
        .I1(ext_evt_valid_0),
        .O(in_event[28]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_60
       (.I0(ext_evt_data[38]),
        .I1(ext_evt_valid_0),
        .O(in_event[38]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_61
       (.I0(ext_evt_data[37]),
        .I1(ext_evt_valid_0),
        .O(in_event[37]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_62
       (.I0(ext_evt_data[36]),
        .I1(ext_evt_valid_0),
        .O(in_event[36]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_63
       (.I0(ext_evt_data[35]),
        .I1(ext_evt_valid_0),
        .O(in_event[35]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_64
       (.I0(ext_evt_data[34]),
        .I1(ext_evt_valid_0),
        .O(in_event[34]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_65
       (.I0(ext_evt_data[33]),
        .I1(ext_evt_valid_0),
        .O(in_event[33]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_66
       (.I0(ext_evt_data[32]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[24]),
        .O(in_event[32]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_67
       (.I0(ext_evt_data[67]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[31]),
        .O(in_event[67]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_68
       (.I0(ext_evt_data[66]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[30]),
        .O(in_event[66]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_69
       (.I0(ext_evt_data[65]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[29]),
        .O(in_event[65]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_7
       (.I0(ext_evt_data[27]),
        .I1(ext_evt_valid_0),
        .O(in_event[27]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_70
       (.I0(ext_evt_data[64]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[28]),
        .O(in_event[64]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_71
       (.I0(ext_evt_data[71]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[35]),
        .O(in_event[71]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_72
       (.I0(ext_evt_data[70]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[34]),
        .O(in_event[70]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_73
       (.I0(ext_evt_data[69]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[33]),
        .O(in_event[69]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_0_i_74
       (.I0(ext_evt_data[68]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[32]),
        .O(in_event[68]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_8
       (.I0(ext_evt_data[26]),
        .I1(ext_evt_valid_0),
        .O(in_event[26]));
  LUT2 #(
    .INIT(4'h8)) 
    memory_reg_0_i_9
       (.I0(ext_evt_data[25]),
        .I1(ext_evt_valid_0),
        .O(in_event[25]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_1
       (.I0(ext_evt_data[103]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[67]),
        .O(in_event[103]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_10
       (.I0(ext_evt_data[94]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[58]),
        .O(in_event[94]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_11
       (.I0(ext_evt_data[93]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[57]),
        .O(in_event[93]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_12
       (.I0(ext_evt_data[92]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[56]),
        .O(in_event[92]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_13
       (.I0(ext_evt_data[91]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[55]),
        .O(in_event[91]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_14
       (.I0(ext_evt_data[90]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[54]),
        .O(in_event[90]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_15
       (.I0(ext_evt_data[89]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[53]),
        .O(in_event[89]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_16
       (.I0(ext_evt_data[88]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[52]),
        .O(in_event[88]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_17
       (.I0(ext_evt_data[87]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[51]),
        .O(in_event[87]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_18
       (.I0(ext_evt_data[86]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[50]),
        .O(in_event[86]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_19
       (.I0(ext_evt_data[85]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[49]),
        .O(in_event[85]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_2
       (.I0(ext_evt_data[102]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[66]),
        .O(in_event[102]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_20
       (.I0(ext_evt_data[84]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[48]),
        .O(in_event[84]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_21
       (.I0(ext_evt_data[83]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[47]),
        .O(in_event[83]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_22
       (.I0(ext_evt_data[82]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[46]),
        .O(in_event[82]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_23
       (.I0(ext_evt_data[81]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[45]),
        .O(in_event[81]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_24
       (.I0(ext_evt_data[80]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[44]),
        .O(in_event[80]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_25
       (.I0(ext_evt_data[79]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[43]),
        .O(in_event[79]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_26
       (.I0(ext_evt_data[78]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[42]),
        .O(in_event[78]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_27
       (.I0(ext_evt_data[77]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[41]),
        .O(in_event[77]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_28
       (.I0(ext_evt_data[76]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[40]),
        .O(in_event[76]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_29
       (.I0(ext_evt_data[75]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[39]),
        .O(in_event[75]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_3
       (.I0(ext_evt_data[101]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[65]),
        .O(in_event[101]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_30
       (.I0(ext_evt_data[74]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[38]),
        .O(in_event[74]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_31
       (.I0(ext_evt_data[73]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[37]),
        .O(in_event[73]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_32
       (.I0(ext_evt_data[72]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[36]),
        .O(in_event[72]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_33
       (.I0(ext_evt_data[127]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[91]),
        .O(in_event[127]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_34
       (.I0(ext_evt_data[126]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[90]),
        .O(in_event[126]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_35
       (.I0(ext_evt_data[125]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[89]),
        .O(in_event[125]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_36
       (.I0(ext_evt_data[124]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[88]),
        .O(in_event[124]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_37
       (.I0(ext_evt_data[123]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[87]),
        .O(in_event[123]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_38
       (.I0(ext_evt_data[122]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[86]),
        .O(in_event[122]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_39
       (.I0(ext_evt_data[121]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[85]),
        .O(in_event[121]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_4
       (.I0(ext_evt_data[100]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[64]),
        .O(in_event[100]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_40
       (.I0(ext_evt_data[120]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[84]),
        .O(in_event[120]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_41
       (.I0(ext_evt_data[119]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[83]),
        .O(in_event[119]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_42
       (.I0(ext_evt_data[118]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[82]),
        .O(in_event[118]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_43
       (.I0(ext_evt_data[117]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[81]),
        .O(in_event[117]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_44
       (.I0(ext_evt_data[116]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[80]),
        .O(in_event[116]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_45
       (.I0(ext_evt_data[115]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[79]),
        .O(in_event[115]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_46
       (.I0(ext_evt_data[114]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[78]),
        .O(in_event[114]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_47
       (.I0(ext_evt_data[113]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[77]),
        .O(in_event[113]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_48
       (.I0(ext_evt_data[112]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[76]),
        .O(in_event[112]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_49
       (.I0(ext_evt_data[111]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[75]),
        .O(in_event[111]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_5
       (.I0(ext_evt_data[99]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[63]),
        .O(in_event[99]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_50
       (.I0(ext_evt_data[110]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[74]),
        .O(in_event[110]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_51
       (.I0(ext_evt_data[109]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[73]),
        .O(in_event[109]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_52
       (.I0(ext_evt_data[108]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[72]),
        .O(in_event[108]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_53
       (.I0(ext_evt_data[107]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[71]),
        .O(in_event[107]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_54
       (.I0(ext_evt_data[106]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[70]),
        .O(in_event[106]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_55
       (.I0(ext_evt_data[105]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[69]),
        .O(in_event[105]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_56
       (.I0(ext_evt_data[104]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[68]),
        .O(in_event[104]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_6
       (.I0(ext_evt_data[98]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[62]),
        .O(in_event[98]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_7
       (.I0(ext_evt_data[97]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[61]),
        .O(in_event[97]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_8
       (.I0(ext_evt_data[96]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[60]),
        .O(in_event[96]));
  LUT3 #(
    .INIT(8'hB8)) 
    memory_reg_1_i_9
       (.I0(ext_evt_data[95]),
        .I1(ext_evt_valid_0),
        .I2(memory_reg_1[59]),
        .O(in_event[95]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8A80)) 
    \s_axi_rdata[0]_i_4 
       (.I0(s_axi_araddr[3]),
        .I1(\s_axi_rdata[0]_i_6_n_0 ),
        .I2(s_axi_araddr[2]),
        .I3(\s_axi_rdata_reg[0] ),
        .I4(\s_axi_rdata_reg[0]_0 ),
        .I5(\s_axi_rdata_reg[16] ),
        .O(\s_axi_araddr[5]_7 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[0]_i_6 
       (.I0(ext_evt_dropped_count[0]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[0]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [0]),
        .O(\s_axi_rdata[0]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[10]_i_7 
       (.I0(ext_evt_dropped_count[10]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[10]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [10]),
        .O(\s_axi_rdata[10]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[11]_i_7 
       (.I0(ext_evt_dropped_count[11]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[11]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [11]),
        .O(\s_axi_rdata[11]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8A80)) 
    \s_axi_rdata[12]_i_4 
       (.I0(s_axi_araddr[3]),
        .I1(\s_axi_rdata[12]_i_5_n_0 ),
        .I2(s_axi_araddr[2]),
        .I3(\s_axi_rdata_reg[12] ),
        .I4(\s_axi_rdata_reg[12]_0 ),
        .I5(\s_axi_rdata_reg[16] ),
        .O(\s_axi_araddr[5]_3 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[12]_i_5 
       (.I0(ext_evt_dropped_count[12]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[12]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [12]),
        .O(\s_axi_rdata[12]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[13]_i_7 
       (.I0(ext_evt_dropped_count[13]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[13]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [13]),
        .O(\s_axi_rdata[13]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[14]_i_7 
       (.I0(ext_evt_dropped_count[14]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[14]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [14]),
        .O(\s_axi_rdata[14]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[15]_i_7 
       (.I0(ext_evt_dropped_count[15]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[15]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [15]),
        .O(\s_axi_rdata[15]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFEAEAAAAFFFFFFFF)) 
    \s_axi_rdata[16]_i_4 
       (.I0(\s_axi_rdata_reg[16] ),
        .I1(\s_axi_rdata_reg[16]_0 ),
        .I2(s_axi_araddr[2]),
        .I3(\s_axi_rdata[16]_i_6_n_0 ),
        .I4(s_axi_araddr[3]),
        .I5(\s_axi_rdata_reg[16]_1 ),
        .O(\s_axi_araddr[4] ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[16]_i_6 
       (.I0(ext_evt_dropped_count[16]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[16]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [16]),
        .O(\s_axi_rdata[16]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[17]_i_7 
       (.I0(ext_evt_dropped_count[17]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[17]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [17]),
        .O(\s_axi_rdata[17]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[18]_i_7 
       (.I0(ext_evt_dropped_count[18]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[18]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [18]),
        .O(\s_axi_rdata[18]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[19]_i_7 
       (.I0(ext_evt_dropped_count[19]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[19]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [19]),
        .O(\s_axi_rdata[19]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8A80)) 
    \s_axi_rdata[1]_i_4 
       (.I0(s_axi_araddr[3]),
        .I1(\s_axi_rdata[1]_i_6_n_0 ),
        .I2(s_axi_araddr[2]),
        .I3(\s_axi_rdata_reg[1] ),
        .I4(\s_axi_rdata_reg[1]_0 ),
        .I5(\s_axi_rdata_reg[16] ),
        .O(\s_axi_araddr[5]_6 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[1]_i_6 
       (.I0(ext_evt_dropped_count[1]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[1]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [1]),
        .O(\s_axi_rdata[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8A80)) 
    \s_axi_rdata[20]_i_4 
       (.I0(s_axi_araddr[3]),
        .I1(\s_axi_rdata[20]_i_5_n_0 ),
        .I2(s_axi_araddr[2]),
        .I3(\s_axi_rdata_reg[20] ),
        .I4(\s_axi_rdata_reg[20]_0 ),
        .I5(\s_axi_rdata_reg[16] ),
        .O(\s_axi_araddr[5]_2 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[20]_i_5 
       (.I0(ext_evt_dropped_count[20]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[20]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [20]),
        .O(\s_axi_rdata[20]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[21]_i_7 
       (.I0(ext_evt_dropped_count[21]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[21]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [21]),
        .O(\s_axi_rdata[21]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8A80)) 
    \s_axi_rdata[22]_i_4 
       (.I0(s_axi_araddr[3]),
        .I1(\s_axi_rdata[22]_i_5_n_0 ),
        .I2(s_axi_araddr[2]),
        .I3(\s_axi_rdata_reg[22] ),
        .I4(\s_axi_rdata_reg[22]_0 ),
        .I5(\s_axi_rdata_reg[16] ),
        .O(\s_axi_araddr[5]_1 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[22]_i_5 
       (.I0(ext_evt_dropped_count[22]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[22]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [22]),
        .O(\s_axi_rdata[22]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[23]_i_7 
       (.I0(ext_evt_dropped_count[23]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[23]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [23]),
        .O(\s_axi_rdata[23]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[24]_i_7 
       (.I0(ext_evt_dropped_count[24]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[24]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [24]),
        .O(\s_axi_rdata[24]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[25]_i_7 
       (.I0(ext_evt_dropped_count[25]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[25]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [25]),
        .O(\s_axi_rdata[25]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8A80)) 
    \s_axi_rdata[26]_i_4 
       (.I0(s_axi_araddr[3]),
        .I1(\s_axi_rdata[26]_i_5_n_0 ),
        .I2(s_axi_araddr[2]),
        .I3(\s_axi_rdata_reg[26] ),
        .I4(\s_axi_rdata_reg[26]_0 ),
        .I5(\s_axi_rdata_reg[16] ),
        .O(\s_axi_araddr[5]_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[26]_i_5 
       (.I0(ext_evt_dropped_count[26]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[26]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [26]),
        .O(\s_axi_rdata[26]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8A80)) 
    \s_axi_rdata[27]_i_5 
       (.I0(s_axi_araddr[3]),
        .I1(\s_axi_rdata[27]_i_8_n_0 ),
        .I2(s_axi_araddr[2]),
        .I3(\s_axi_rdata_reg[27] ),
        .I4(\s_axi_rdata_reg[27]_0 ),
        .I5(\s_axi_rdata_reg[16] ),
        .O(\s_axi_araddr[5] ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[27]_i_8 
       (.I0(ext_evt_dropped_count[27]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[27]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [27]),
        .O(\s_axi_rdata[27]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[28]_i_7 
       (.I0(ext_evt_dropped_count[28]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[28]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [28]),
        .O(\s_axi_rdata[28]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[29]_i_7 
       (.I0(ext_evt_dropped_count[29]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[29]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [29]),
        .O(\s_axi_rdata[29]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8A80)) 
    \s_axi_rdata[2]_i_4 
       (.I0(s_axi_araddr[3]),
        .I1(\s_axi_rdata[2]_i_6_n_0 ),
        .I2(s_axi_araddr[2]),
        .I3(\s_axi_rdata_reg[2] ),
        .I4(\s_axi_rdata_reg[2]_0 ),
        .I5(\s_axi_rdata_reg[16] ),
        .O(\s_axi_araddr[5]_5 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[2]_i_6 
       (.I0(ext_evt_dropped_count[2]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[2]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [2]),
        .O(\s_axi_rdata[2]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[30]_i_7 
       (.I0(ext_evt_dropped_count[30]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[30]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [30]),
        .O(\s_axi_rdata[30]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[31]_i_15 
       (.I0(ext_evt_dropped_count[31]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[31]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [31]),
        .O(\s_axi_rdata[31]_i_15_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[3]_i_8 
       (.I0(ext_evt_dropped_count[3]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[3]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [3]),
        .O(ext_evt_dropped_count_3_sn_1));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[4]_i_8 
       (.I0(ext_evt_dropped_count[4]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[4]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [4]),
        .O(\s_axi_rdata[4]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[5]_i_8 
       (.I0(ext_evt_dropped_count[5]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[5]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [5]),
        .O(\s_axi_rdata[5]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8A80)) 
    \s_axi_rdata[6]_i_4 
       (.I0(s_axi_araddr[3]),
        .I1(\s_axi_rdata[6]_i_6_n_0 ),
        .I2(s_axi_araddr[2]),
        .I3(\s_axi_rdata_reg[6] ),
        .I4(\s_axi_rdata_reg[6]_0 ),
        .I5(\s_axi_rdata_reg[16] ),
        .O(\s_axi_araddr[5]_4 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[6]_i_6 
       (.I0(ext_evt_dropped_count[6]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[6]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [6]),
        .O(\s_axi_rdata[6]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[7]_i_10 
       (.I0(ext_evt_dropped_count[7]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[7]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [7]),
        .O(\s_axi_rdata[7]_i_10_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[8]_i_8 
       (.I0(ext_evt_dropped_count[8]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[8]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [8]),
        .O(\s_axi_rdata[8]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \s_axi_rdata[9]_i_7 
       (.I0(ext_evt_dropped_count[9]),
        .I1(s_axi_araddr[1]),
        .I2(p_1_in[9]),
        .I3(s_axi_araddr[0]),
        .I4(\s_axi_rdata_reg[31]_i_9_0 [9]),
        .O(\s_axi_rdata[9]_i_7_n_0 ));
  MUXF7 \s_axi_rdata_reg[10]_i_4 
       (.I0(\s_axi_rdata_reg[10] ),
        .I1(\s_axi_rdata[10]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_15 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[11]_i_4 
       (.I0(\s_axi_rdata_reg[11] ),
        .I1(\s_axi_rdata[11]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_14 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[13]_i_4 
       (.I0(\s_axi_rdata_reg[13] ),
        .I1(\s_axi_rdata[13]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_13 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[14]_i_4 
       (.I0(\s_axi_rdata_reg[14] ),
        .I1(\s_axi_rdata[14]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_12 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[15]_i_4 
       (.I0(\s_axi_rdata_reg[15] ),
        .I1(\s_axi_rdata[15]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_11 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[17]_i_4 
       (.I0(\s_axi_rdata_reg[17] ),
        .I1(\s_axi_rdata[17]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_10 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[18]_i_4 
       (.I0(\s_axi_rdata_reg[18] ),
        .I1(\s_axi_rdata[18]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_9 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[19]_i_4 
       (.I0(\s_axi_rdata_reg[19] ),
        .I1(\s_axi_rdata[19]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_8 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[21]_i_4 
       (.I0(\s_axi_rdata_reg[21] ),
        .I1(\s_axi_rdata[21]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_7 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[23]_i_4 
       (.I0(\s_axi_rdata_reg[23] ),
        .I1(\s_axi_rdata[23]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_6 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[24]_i_4 
       (.I0(\s_axi_rdata_reg[24] ),
        .I1(\s_axi_rdata[24]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_5 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[25]_i_4 
       (.I0(\s_axi_rdata_reg[25] ),
        .I1(\s_axi_rdata[25]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_4 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[28]_i_4 
       (.I0(\s_axi_rdata_reg[28] ),
        .I1(\s_axi_rdata[28]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_3 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[29]_i_4 
       (.I0(\s_axi_rdata_reg[29] ),
        .I1(\s_axi_rdata[29]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_2 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[30]_i_4 
       (.I0(\s_axi_rdata_reg[30] ),
        .I1(\s_axi_rdata[30]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_1 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[31]_i_9 
       (.I0(\s_axi_rdata_reg[31] ),
        .I1(\s_axi_rdata[31]_i_15_n_0 ),
        .O(\s_axi_araddr[4]_0 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[4]_i_4 
       (.I0(\s_axi_rdata_reg[4] ),
        .I1(\s_axi_rdata[4]_i_8_n_0 ),
        .O(\s_axi_araddr[4]_20 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[5]_i_4 
       (.I0(\s_axi_rdata_reg[5] ),
        .I1(\s_axi_rdata[5]_i_8_n_0 ),
        .O(\s_axi_araddr[4]_19 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[7]_i_4 
       (.I0(\s_axi_rdata_reg[7] ),
        .I1(\s_axi_rdata[7]_i_10_n_0 ),
        .O(\s_axi_araddr[4]_18 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[8]_i_4 
       (.I0(\s_axi_rdata_reg[8] ),
        .I1(\s_axi_rdata[8]_i_8_n_0 ),
        .O(\s_axi_araddr[4]_17 ),
        .S(s_axi_araddr[2]));
  MUXF7 \s_axi_rdata_reg[9]_i_4 
       (.I0(\s_axi_rdata_reg[9] ),
        .I1(\s_axi_rdata[9]_i_7_n_0 ),
        .O(\s_axi_araddr[4]_16 ),
        .S(s_axi_araddr[2]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h5D00)) 
    \virtual_evt_data[127]_i_1 
       (.I0(virtual_evt_trigger_reg),
        .I1(p_3_in),
        .I2(ext_evt_valid_0),
        .I3(virtual_evt_trigger_reg_0),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \virtual_evt_data[48]_i_1 
       (.I0(Q[4]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[4]),
        .O(write_addr));
  LUT6 #(
    .INIT(64'h3F310F0F30310000)) 
    virtual_evt_trigger_i_1
       (.I0(virtual_evt_trigger_reg),
        .I1(virtual_evt_trigger_reg_2),
        .I2(\wdata_reg_reg[0] ),
        .I3(virtual_evt_trigger_reg_3),
        .I4(virtual_evt_trigger_reg_0),
        .I5(virtual_evt_trigger_reg_4),
        .O(virtual_evt_valid_reg));
  LUT6 #(
    .INIT(64'hFFDC505073505050)) 
    virtual_evt_valid_i_1
       (.I0(\wdata_reg_reg[0] ),
        .I1(write_addr),
        .I2(virtual_evt_trigger_reg),
        .I3(virtual_evt_valid_reg_1),
        .I4(virtual_evt_valid_reg_2),
        .I5(\awaddr_reg_reg[3] ),
        .O(virtual_evt_valid_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    virtual_evt_valid_i_4
       (.I0(Q[3]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[3]),
        .O(\awaddr_reg_reg[3] ));
endmodule

(* ORIG_REF_NAME = "event_snapshot_buffer" *) 
module multi_protocol_bd_multi_protocol_core_0_0_event_snapshot_buffer
   (clear,
    Q,
    SR,
    E,
    s_axi_aresetn_0,
    snapshot_ready_reg_0,
    D,
    capture_active_reg_0,
    \s_axi_araddr[5] ,
    \s_axi_araddr[0] ,
    s_axi_aresetn_1,
    S,
    DI,
    \snapshot_count_reg[8]_0 ,
    s_axi_arvalid_0,
    s_axi_aclk,
    \s_axi_rdata_reg[31] ,
    CO,
    \s_axi_rdata_reg[31]_0 ,
    s_axi_aresetn,
    \snapshot_rd_index_reg[0] ,
    s_axi_arvalid,
    \s_axi_rdata_reg[0] ,
    snapshot_rd_en,
    \s_axi_rdata_reg[31]_1 ,
    s_axi_araddr,
    \s_axi_rdata_reg[9] ,
    \dropped_count_reg_reg[0] ,
    \dropped_count_reg_reg[0]_0 ,
    \dropped_count_reg_reg[0]_1 ,
    dropped_count_reg0,
    dropped_count_reg00_in,
    \dropped_count_reg_reg[0]_2 ,
    p_3_in,
    \dropped_count_reg_reg[31] ,
    \dropped_count_reg_reg[31]_0 ,
    \dropped_count_reg_reg[31]_1 ,
    \dropped_count_reg_reg[31]_2 ,
    \dropped_count_reg_reg[31]_3 ,
    \post_remaining_reg[1]_0 ,
    ext_evt_trigger,
    capture_active_reg_1,
    ext_evt_valid,
    memory_reg_0_0,
    \s_axi_rdata_reg[0]_0 ,
    \s_axi_rdata_reg[1] ,
    \s_axi_rdata_reg[2] ,
    \s_axi_rdata_reg[4] ,
    \s_axi_rdata_reg[4]_0 ,
    \s_axi_rdata_reg[5] ,
    \s_axi_rdata_reg[5]_0 ,
    \s_axi_rdata_reg[6] ,
    \s_axi_rdata_reg[7] ,
    \s_axi_rdata_reg[7]_0 ,
    \s_axi_rdata_reg[8] ,
    \s_axi_rdata_reg[8]_0 ,
    \s_axi_rdata_reg[9]_0 ,
    \s_axi_rdata_reg[9]_1 ,
    \s_axi_rdata_reg[10] ,
    \s_axi_rdata_reg[10]_0 ,
    \s_axi_rdata_reg[11] ,
    \s_axi_rdata_reg[11]_0 ,
    \s_axi_rdata_reg[12] ,
    \s_axi_rdata_reg[13] ,
    \s_axi_rdata_reg[13]_0 ,
    \s_axi_rdata_reg[14] ,
    \s_axi_rdata_reg[14]_0 ,
    \s_axi_rdata_reg[15] ,
    \s_axi_rdata_reg[15]_0 ,
    \s_axi_rdata_reg[16] ,
    \s_axi_rdata_reg[17] ,
    \s_axi_rdata_reg[17]_0 ,
    \s_axi_rdata_reg[18] ,
    \s_axi_rdata_reg[18]_0 ,
    \s_axi_rdata_reg[19] ,
    \s_axi_rdata_reg[19]_0 ,
    \s_axi_rdata_reg[20] ,
    \s_axi_rdata_reg[21] ,
    \s_axi_rdata_reg[21]_0 ,
    \s_axi_rdata_reg[22] ,
    \s_axi_rdata_reg[23] ,
    \s_axi_rdata_reg[23]_0 ,
    \s_axi_rdata_reg[24] ,
    \s_axi_rdata_reg[24]_0 ,
    \s_axi_rdata_reg[25] ,
    \s_axi_rdata_reg[25]_0 ,
    \s_axi_rdata_reg[26] ,
    \s_axi_rdata_reg[27] ,
    \s_axi_rdata_reg[28] ,
    \s_axi_rdata_reg[28]_0 ,
    \s_axi_rdata_reg[29] ,
    \s_axi_rdata_reg[29]_0 ,
    \s_axi_rdata_reg[30] ,
    \s_axi_rdata_reg[30]_0 ,
    \s_axi_rdata_reg[31]_2 ,
    \s_axi_rdata_reg[31]_3 ,
    \s_axi_rdata_reg[3] ,
    \s_axi_rdata_reg[3]_0 ,
    \s_axi_rdata_reg[3]_1 ,
    \s_axi_rdata_reg[4]_1 ,
    \s_axi_rdata_reg[4]_2 ,
    \s_axi_rdata_reg[8]_1 ,
    \s_axi_rdata_reg[9]_2 ,
    \s_axi_rdata_reg[27]_0 ,
    \timestamp_shadow_reg[32] ,
    \timestamp_shadow_reg[32]_0 ,
    \s_axi_rdata_reg[3]_2 ,
    \s_axi_rdata_reg[3]_3 ,
    \s_axi_rdata_reg[3]_4 ,
    \s_axi_rdata_reg[3]_5 ,
    \s_axi_rdata_reg[0]_1 ,
    snapshot_ready_reg_1,
    s_axi_rready,
    s_axi_rvalid,
    in_event);
  output clear;
  output [0:0]Q;
  output [0:0]SR;
  output [0:0]E;
  output s_axi_aresetn_0;
  output [0:0]snapshot_ready_reg_0;
  output [31:0]D;
  output [0:0]capture_active_reg_0;
  output [31:0]\s_axi_araddr[5] ;
  output [0:0]\s_axi_araddr[0] ;
  output s_axi_aresetn_1;
  output [3:0]S;
  output [3:0]DI;
  output [0:0]\snapshot_count_reg[8]_0 ;
  output s_axi_arvalid_0;
  input s_axi_aclk;
  input \s_axi_rdata_reg[31] ;
  input [0:0]CO;
  input \s_axi_rdata_reg[31]_0 ;
  input s_axi_aresetn;
  input \snapshot_rd_index_reg[0] ;
  input s_axi_arvalid;
  input \s_axi_rdata_reg[0] ;
  input snapshot_rd_en;
  input [31:0]\s_axi_rdata_reg[31]_1 ;
  input [14:0]s_axi_araddr;
  input \s_axi_rdata_reg[9] ;
  input \dropped_count_reg_reg[0] ;
  input \dropped_count_reg_reg[0]_0 ;
  input \dropped_count_reg_reg[0]_1 ;
  input [31:0]dropped_count_reg0;
  input [30:0]dropped_count_reg00_in;
  input \dropped_count_reg_reg[0]_2 ;
  input p_3_in;
  input \dropped_count_reg_reg[31] ;
  input \dropped_count_reg_reg[31]_0 ;
  input \dropped_count_reg_reg[31]_1 ;
  input \dropped_count_reg_reg[31]_2 ;
  input \dropped_count_reg_reg[31]_3 ;
  input \post_remaining_reg[1]_0 ;
  input ext_evt_trigger;
  input capture_active_reg_1;
  input ext_evt_valid;
  input [7:0]memory_reg_0_0;
  input \s_axi_rdata_reg[0]_0 ;
  input \s_axi_rdata_reg[1] ;
  input \s_axi_rdata_reg[2] ;
  input \s_axi_rdata_reg[4] ;
  input \s_axi_rdata_reg[4]_0 ;
  input \s_axi_rdata_reg[5] ;
  input \s_axi_rdata_reg[5]_0 ;
  input \s_axi_rdata_reg[6] ;
  input \s_axi_rdata_reg[7] ;
  input \s_axi_rdata_reg[7]_0 ;
  input \s_axi_rdata_reg[8] ;
  input \s_axi_rdata_reg[8]_0 ;
  input \s_axi_rdata_reg[9]_0 ;
  input \s_axi_rdata_reg[9]_1 ;
  input \s_axi_rdata_reg[10] ;
  input \s_axi_rdata_reg[10]_0 ;
  input \s_axi_rdata_reg[11] ;
  input \s_axi_rdata_reg[11]_0 ;
  input \s_axi_rdata_reg[12] ;
  input \s_axi_rdata_reg[13] ;
  input \s_axi_rdata_reg[13]_0 ;
  input \s_axi_rdata_reg[14] ;
  input \s_axi_rdata_reg[14]_0 ;
  input \s_axi_rdata_reg[15] ;
  input \s_axi_rdata_reg[15]_0 ;
  input \s_axi_rdata_reg[16] ;
  input \s_axi_rdata_reg[17] ;
  input \s_axi_rdata_reg[17]_0 ;
  input \s_axi_rdata_reg[18] ;
  input \s_axi_rdata_reg[18]_0 ;
  input \s_axi_rdata_reg[19] ;
  input \s_axi_rdata_reg[19]_0 ;
  input \s_axi_rdata_reg[20] ;
  input \s_axi_rdata_reg[21] ;
  input \s_axi_rdata_reg[21]_0 ;
  input \s_axi_rdata_reg[22] ;
  input \s_axi_rdata_reg[23] ;
  input \s_axi_rdata_reg[23]_0 ;
  input \s_axi_rdata_reg[24] ;
  input \s_axi_rdata_reg[24]_0 ;
  input \s_axi_rdata_reg[25] ;
  input \s_axi_rdata_reg[25]_0 ;
  input \s_axi_rdata_reg[26] ;
  input \s_axi_rdata_reg[27] ;
  input \s_axi_rdata_reg[28] ;
  input \s_axi_rdata_reg[28]_0 ;
  input \s_axi_rdata_reg[29] ;
  input \s_axi_rdata_reg[29]_0 ;
  input \s_axi_rdata_reg[30] ;
  input \s_axi_rdata_reg[30]_0 ;
  input \s_axi_rdata_reg[31]_2 ;
  input \s_axi_rdata_reg[31]_3 ;
  input \s_axi_rdata_reg[3] ;
  input \s_axi_rdata_reg[3]_0 ;
  input \s_axi_rdata_reg[3]_1 ;
  input \s_axi_rdata_reg[4]_1 ;
  input \s_axi_rdata_reg[4]_2 ;
  input \s_axi_rdata_reg[8]_1 ;
  input \s_axi_rdata_reg[9]_2 ;
  input \s_axi_rdata_reg[27]_0 ;
  input \timestamp_shadow_reg[32] ;
  input \timestamp_shadow_reg[32]_0 ;
  input \s_axi_rdata_reg[3]_2 ;
  input \s_axi_rdata_reg[3]_3 ;
  input \s_axi_rdata_reg[3]_4 ;
  input \s_axi_rdata_reg[3]_5 ;
  input [1:0]\s_axi_rdata_reg[0]_1 ;
  input snapshot_ready_reg_1;
  input s_axi_rready;
  input s_axi_rvalid;
  input [127:0]in_event;

  wire [0:0]CO;
  wire [31:0]D;
  wire [3:0]DI;
  wire [0:0]E;
  wire [0:0]Q;
  wire [3:0]S;
  wire [0:0]SR;
  wire capture_active;
  wire capture_active111_out;
  wire capture_active_i_1_n_0;
  wire [0:0]capture_active_reg_0;
  wire capture_active_reg_1;
  wire [8:0]capture_count_reg__0;
  wire clear;
  wire [31:0]dropped_count_reg0;
  wire [30:0]dropped_count_reg00_in;
  wire \dropped_count_reg[31]_i_6_n_0 ;
  wire \dropped_count_reg_reg[0] ;
  wire \dropped_count_reg_reg[0]_0 ;
  wire \dropped_count_reg_reg[0]_1 ;
  wire \dropped_count_reg_reg[0]_2 ;
  wire \dropped_count_reg_reg[31] ;
  wire \dropped_count_reg_reg[31]_0 ;
  wire \dropped_count_reg_reg[31]_1 ;
  wire \dropped_count_reg_reg[31]_2 ;
  wire \dropped_count_reg_reg[31]_3 ;
  wire ext_evt_trigger;
  wire ext_evt_valid;
  wire [127:0]in_event;
  wire [7:0]memory_reg_0_0;
  wire memory_reg_0_i_1_n_0;
  wire memory_reg_0_i_2_n_0;
  wire [7:7]next_snapshot_start;
  wire [7:0]next_write_pointer;
  wire overwritten_i_1_n_0;
  wire overwritten_i_2_n_0;
  wire overwritten_i_3_n_0;
  wire p_3_in;
  wire post_remaining;
  wire \post_remaining[0]_i_1_n_0 ;
  wire \post_remaining[1]_i_1_n_0 ;
  wire \post_remaining[2]_i_1_n_0 ;
  wire \post_remaining[3]_i_1_n_0 ;
  wire \post_remaining[3]_i_3_n_0 ;
  wire \post_remaining[4]_i_1_n_0 ;
  wire \post_remaining[4]_i_2_n_0 ;
  wire \post_remaining_reg[1]_0 ;
  wire \post_remaining_reg_n_0_[0] ;
  wire \post_remaining_reg_n_0_[1] ;
  wire \post_remaining_reg_n_0_[2] ;
  wire \post_remaining_reg_n_0_[3] ;
  wire \post_remaining_reg_n_0_[4] ;
  wire rd_valid1;
  wire rd_valid1_carry__0_i_1_n_0;
  wire rd_valid1_carry_i_1_n_0;
  wire rd_valid1_carry_i_2_n_0;
  wire rd_valid1_carry_i_3_n_0;
  wire rd_valid1_carry_i_4_n_0;
  wire rd_valid1_carry_i_5_n_0;
  wire rd_valid1_carry_i_6_n_0;
  wire rd_valid1_carry_i_7_n_0;
  wire rd_valid1_carry_i_8_n_0;
  wire rd_valid1_carry_n_0;
  wire rd_valid1_carry_n_1;
  wire rd_valid1_carry_n_2;
  wire rd_valid1_carry_n_3;
  wire rd_valid_i_1_n_0;
  wire [7:0]read_physical_index;
  wire read_physical_index_carry__0_i_1_n_0;
  wire read_physical_index_carry__0_i_2_n_0;
  wire read_physical_index_carry__0_i_3_n_0;
  wire read_physical_index_carry__0_i_4_n_0;
  wire read_physical_index_carry__0_n_1;
  wire read_physical_index_carry__0_n_2;
  wire read_physical_index_carry__0_n_3;
  wire read_physical_index_carry_i_1_n_0;
  wire read_physical_index_carry_i_2_n_0;
  wire read_physical_index_carry_i_3_n_0;
  wire read_physical_index_carry_i_4_n_0;
  wire read_physical_index_carry_n_0;
  wire read_physical_index_carry_n_1;
  wire read_physical_index_carry_n_2;
  wire read_physical_index_carry_n_3;
  wire s_axi_aclk;
  wire [14:0]s_axi_araddr;
  wire [0:0]\s_axi_araddr[0] ;
  wire [31:0]\s_axi_araddr[5] ;
  wire s_axi_aresetn;
  wire s_axi_aresetn_0;
  wire s_axi_aresetn_1;
  wire s_axi_arvalid;
  wire s_axi_arvalid_0;
  wire \s_axi_rdata[0]_i_2_n_0 ;
  wire \s_axi_rdata[0]_i_3_n_0 ;
  wire \s_axi_rdata[0]_i_5_n_0 ;
  wire \s_axi_rdata[10]_i_2_n_0 ;
  wire \s_axi_rdata[10]_i_3_n_0 ;
  wire \s_axi_rdata[11]_i_2_n_0 ;
  wire \s_axi_rdata[11]_i_3_n_0 ;
  wire \s_axi_rdata[12]_i_2_n_0 ;
  wire \s_axi_rdata[12]_i_3_n_0 ;
  wire \s_axi_rdata[13]_i_2_n_0 ;
  wire \s_axi_rdata[13]_i_3_n_0 ;
  wire \s_axi_rdata[14]_i_2_n_0 ;
  wire \s_axi_rdata[14]_i_3_n_0 ;
  wire \s_axi_rdata[15]_i_2_n_0 ;
  wire \s_axi_rdata[15]_i_3_n_0 ;
  wire \s_axi_rdata[16]_i_2_n_0 ;
  wire \s_axi_rdata[16]_i_3_n_0 ;
  wire \s_axi_rdata[17]_i_2_n_0 ;
  wire \s_axi_rdata[17]_i_3_n_0 ;
  wire \s_axi_rdata[18]_i_2_n_0 ;
  wire \s_axi_rdata[18]_i_3_n_0 ;
  wire \s_axi_rdata[19]_i_2_n_0 ;
  wire \s_axi_rdata[19]_i_3_n_0 ;
  wire \s_axi_rdata[1]_i_2_n_0 ;
  wire \s_axi_rdata[1]_i_3_n_0 ;
  wire \s_axi_rdata[1]_i_5_n_0 ;
  wire \s_axi_rdata[20]_i_2_n_0 ;
  wire \s_axi_rdata[20]_i_3_n_0 ;
  wire \s_axi_rdata[21]_i_2_n_0 ;
  wire \s_axi_rdata[21]_i_3_n_0 ;
  wire \s_axi_rdata[22]_i_2_n_0 ;
  wire \s_axi_rdata[22]_i_3_n_0 ;
  wire \s_axi_rdata[23]_i_2_n_0 ;
  wire \s_axi_rdata[23]_i_3_n_0 ;
  wire \s_axi_rdata[24]_i_2_n_0 ;
  wire \s_axi_rdata[24]_i_3_n_0 ;
  wire \s_axi_rdata[25]_i_2_n_0 ;
  wire \s_axi_rdata[25]_i_3_n_0 ;
  wire \s_axi_rdata[26]_i_2_n_0 ;
  wire \s_axi_rdata[26]_i_3_n_0 ;
  wire \s_axi_rdata[27]_i_2_n_0 ;
  wire \s_axi_rdata[27]_i_3_n_0 ;
  wire \s_axi_rdata[27]_i_4_n_0 ;
  wire \s_axi_rdata[27]_i_6_n_0 ;
  wire \s_axi_rdata[28]_i_2_n_0 ;
  wire \s_axi_rdata[28]_i_3_n_0 ;
  wire \s_axi_rdata[29]_i_2_n_0 ;
  wire \s_axi_rdata[29]_i_3_n_0 ;
  wire \s_axi_rdata[2]_i_2_n_0 ;
  wire \s_axi_rdata[2]_i_3_n_0 ;
  wire \s_axi_rdata[2]_i_5_n_0 ;
  wire \s_axi_rdata[30]_i_2_n_0 ;
  wire \s_axi_rdata[30]_i_3_n_0 ;
  wire \s_axi_rdata[31]_i_6_n_0 ;
  wire \s_axi_rdata[31]_i_7_n_0 ;
  wire \s_axi_rdata[31]_i_8_n_0 ;
  wire \s_axi_rdata[3]_i_2_n_0 ;
  wire \s_axi_rdata[3]_i_3_n_0 ;
  wire \s_axi_rdata[3]_i_4_n_0 ;
  wire \s_axi_rdata[3]_i_5_n_0 ;
  wire \s_axi_rdata[3]_i_9_n_0 ;
  wire \s_axi_rdata[4]_i_2_n_0 ;
  wire \s_axi_rdata[4]_i_3_n_0 ;
  wire \s_axi_rdata[4]_i_6_n_0 ;
  wire \s_axi_rdata[5]_i_2_n_0 ;
  wire \s_axi_rdata[5]_i_3_n_0 ;
  wire \s_axi_rdata[5]_i_6_n_0 ;
  wire \s_axi_rdata[6]_i_2_n_0 ;
  wire \s_axi_rdata[6]_i_3_n_0 ;
  wire \s_axi_rdata[6]_i_5_n_0 ;
  wire \s_axi_rdata[7]_i_2_n_0 ;
  wire \s_axi_rdata[7]_i_3_n_0 ;
  wire \s_axi_rdata[7]_i_6_n_0 ;
  wire \s_axi_rdata[8]_i_2_n_0 ;
  wire \s_axi_rdata[8]_i_3_n_0 ;
  wire \s_axi_rdata[8]_i_6_n_0 ;
  wire \s_axi_rdata[9]_i_2_n_0 ;
  wire \s_axi_rdata[9]_i_3_n_0 ;
  wire \s_axi_rdata_reg[0] ;
  wire \s_axi_rdata_reg[0]_0 ;
  wire [1:0]\s_axi_rdata_reg[0]_1 ;
  wire \s_axi_rdata_reg[10] ;
  wire \s_axi_rdata_reg[10]_0 ;
  wire \s_axi_rdata_reg[11] ;
  wire \s_axi_rdata_reg[11]_0 ;
  wire \s_axi_rdata_reg[12] ;
  wire \s_axi_rdata_reg[13] ;
  wire \s_axi_rdata_reg[13]_0 ;
  wire \s_axi_rdata_reg[14] ;
  wire \s_axi_rdata_reg[14]_0 ;
  wire \s_axi_rdata_reg[15] ;
  wire \s_axi_rdata_reg[15]_0 ;
  wire \s_axi_rdata_reg[16] ;
  wire \s_axi_rdata_reg[17] ;
  wire \s_axi_rdata_reg[17]_0 ;
  wire \s_axi_rdata_reg[18] ;
  wire \s_axi_rdata_reg[18]_0 ;
  wire \s_axi_rdata_reg[19] ;
  wire \s_axi_rdata_reg[19]_0 ;
  wire \s_axi_rdata_reg[1] ;
  wire \s_axi_rdata_reg[20] ;
  wire \s_axi_rdata_reg[21] ;
  wire \s_axi_rdata_reg[21]_0 ;
  wire \s_axi_rdata_reg[22] ;
  wire \s_axi_rdata_reg[23] ;
  wire \s_axi_rdata_reg[23]_0 ;
  wire \s_axi_rdata_reg[24] ;
  wire \s_axi_rdata_reg[24]_0 ;
  wire \s_axi_rdata_reg[25] ;
  wire \s_axi_rdata_reg[25]_0 ;
  wire \s_axi_rdata_reg[26] ;
  wire \s_axi_rdata_reg[27] ;
  wire \s_axi_rdata_reg[27]_0 ;
  wire \s_axi_rdata_reg[28] ;
  wire \s_axi_rdata_reg[28]_0 ;
  wire \s_axi_rdata_reg[29] ;
  wire \s_axi_rdata_reg[29]_0 ;
  wire \s_axi_rdata_reg[2] ;
  wire \s_axi_rdata_reg[30] ;
  wire \s_axi_rdata_reg[30]_0 ;
  wire \s_axi_rdata_reg[31] ;
  wire \s_axi_rdata_reg[31]_0 ;
  wire [31:0]\s_axi_rdata_reg[31]_1 ;
  wire \s_axi_rdata_reg[31]_2 ;
  wire \s_axi_rdata_reg[31]_3 ;
  wire \s_axi_rdata_reg[3] ;
  wire \s_axi_rdata_reg[3]_0 ;
  wire \s_axi_rdata_reg[3]_1 ;
  wire \s_axi_rdata_reg[3]_2 ;
  wire \s_axi_rdata_reg[3]_3 ;
  wire \s_axi_rdata_reg[3]_4 ;
  wire \s_axi_rdata_reg[3]_5 ;
  wire \s_axi_rdata_reg[4] ;
  wire \s_axi_rdata_reg[4]_0 ;
  wire \s_axi_rdata_reg[4]_1 ;
  wire \s_axi_rdata_reg[4]_2 ;
  wire \s_axi_rdata_reg[5] ;
  wire \s_axi_rdata_reg[5]_0 ;
  wire \s_axi_rdata_reg[6] ;
  wire \s_axi_rdata_reg[7] ;
  wire \s_axi_rdata_reg[7]_0 ;
  wire \s_axi_rdata_reg[8] ;
  wire \s_axi_rdata_reg[8]_0 ;
  wire \s_axi_rdata_reg[8]_1 ;
  wire \s_axi_rdata_reg[9] ;
  wire \s_axi_rdata_reg[9]_0 ;
  wire \s_axi_rdata_reg[9]_1 ;
  wire \s_axi_rdata_reg[9]_2 ;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [8:1]sel0;
  wire [7:0]snapshot_count;
  wire \snapshot_count[0]_i_1_n_0 ;
  wire \snapshot_count[5]_i_1_n_0 ;
  wire \snapshot_count[6]_i_1_n_0 ;
  wire \snapshot_count[7]_i_2_n_0 ;
  wire \snapshot_count[8]_i_1_n_0 ;
  wire \snapshot_count[8]_i_2_n_0 ;
  wire \snapshot_count[8]_i_4_n_0 ;
  wire [0:0]\snapshot_count_reg[8]_0 ;
  wire [31:0]snapshot_id;
  wire \snapshot_id[0]_i_1_n_0 ;
  wire \snapshot_id[0]_i_3_n_0 ;
  wire \snapshot_id_reg[0]_i_2_n_0 ;
  wire \snapshot_id_reg[0]_i_2_n_1 ;
  wire \snapshot_id_reg[0]_i_2_n_2 ;
  wire \snapshot_id_reg[0]_i_2_n_3 ;
  wire \snapshot_id_reg[0]_i_2_n_4 ;
  wire \snapshot_id_reg[0]_i_2_n_5 ;
  wire \snapshot_id_reg[0]_i_2_n_6 ;
  wire \snapshot_id_reg[0]_i_2_n_7 ;
  wire \snapshot_id_reg[12]_i_1_n_0 ;
  wire \snapshot_id_reg[12]_i_1_n_1 ;
  wire \snapshot_id_reg[12]_i_1_n_2 ;
  wire \snapshot_id_reg[12]_i_1_n_3 ;
  wire \snapshot_id_reg[12]_i_1_n_4 ;
  wire \snapshot_id_reg[12]_i_1_n_5 ;
  wire \snapshot_id_reg[12]_i_1_n_6 ;
  wire \snapshot_id_reg[12]_i_1_n_7 ;
  wire \snapshot_id_reg[16]_i_1_n_0 ;
  wire \snapshot_id_reg[16]_i_1_n_1 ;
  wire \snapshot_id_reg[16]_i_1_n_2 ;
  wire \snapshot_id_reg[16]_i_1_n_3 ;
  wire \snapshot_id_reg[16]_i_1_n_4 ;
  wire \snapshot_id_reg[16]_i_1_n_5 ;
  wire \snapshot_id_reg[16]_i_1_n_6 ;
  wire \snapshot_id_reg[16]_i_1_n_7 ;
  wire \snapshot_id_reg[20]_i_1_n_0 ;
  wire \snapshot_id_reg[20]_i_1_n_1 ;
  wire \snapshot_id_reg[20]_i_1_n_2 ;
  wire \snapshot_id_reg[20]_i_1_n_3 ;
  wire \snapshot_id_reg[20]_i_1_n_4 ;
  wire \snapshot_id_reg[20]_i_1_n_5 ;
  wire \snapshot_id_reg[20]_i_1_n_6 ;
  wire \snapshot_id_reg[20]_i_1_n_7 ;
  wire \snapshot_id_reg[24]_i_1_n_0 ;
  wire \snapshot_id_reg[24]_i_1_n_1 ;
  wire \snapshot_id_reg[24]_i_1_n_2 ;
  wire \snapshot_id_reg[24]_i_1_n_3 ;
  wire \snapshot_id_reg[24]_i_1_n_4 ;
  wire \snapshot_id_reg[24]_i_1_n_5 ;
  wire \snapshot_id_reg[24]_i_1_n_6 ;
  wire \snapshot_id_reg[24]_i_1_n_7 ;
  wire \snapshot_id_reg[28]_i_1_n_1 ;
  wire \snapshot_id_reg[28]_i_1_n_2 ;
  wire \snapshot_id_reg[28]_i_1_n_3 ;
  wire \snapshot_id_reg[28]_i_1_n_4 ;
  wire \snapshot_id_reg[28]_i_1_n_5 ;
  wire \snapshot_id_reg[28]_i_1_n_6 ;
  wire \snapshot_id_reg[28]_i_1_n_7 ;
  wire \snapshot_id_reg[4]_i_1_n_0 ;
  wire \snapshot_id_reg[4]_i_1_n_1 ;
  wire \snapshot_id_reg[4]_i_1_n_2 ;
  wire \snapshot_id_reg[4]_i_1_n_3 ;
  wire \snapshot_id_reg[4]_i_1_n_4 ;
  wire \snapshot_id_reg[4]_i_1_n_5 ;
  wire \snapshot_id_reg[4]_i_1_n_6 ;
  wire \snapshot_id_reg[4]_i_1_n_7 ;
  wire \snapshot_id_reg[8]_i_1_n_0 ;
  wire \snapshot_id_reg[8]_i_1_n_1 ;
  wire \snapshot_id_reg[8]_i_1_n_2 ;
  wire \snapshot_id_reg[8]_i_1_n_3 ;
  wire \snapshot_id_reg[8]_i_1_n_4 ;
  wire \snapshot_id_reg[8]_i_1_n_5 ;
  wire \snapshot_id_reg[8]_i_1_n_6 ;
  wire \snapshot_id_reg[8]_i_1_n_7 ;
  wire snapshot_overwritten;
  wire snapshot_rd_en;
  wire [127:0]snapshot_rd_event;
  wire \snapshot_rd_index_reg[0] ;
  wire snapshot_rd_valid;
  wire snapshot_read_pending_i_2_n_0;
  wire snapshot_ready;
  wire snapshot_ready_i_1_n_0;
  wire [0:0]snapshot_ready_reg_0;
  wire snapshot_ready_reg_1;
  wire \snapshot_start[0]_i_1_n_0 ;
  wire \snapshot_start[1]_i_1_n_0 ;
  wire \snapshot_start[2]_i_1_n_0 ;
  wire \snapshot_start[3]_i_1_n_0 ;
  wire \snapshot_start[4]_i_1_n_0 ;
  wire \snapshot_start[5]_i_1_n_0 ;
  wire \snapshot_start[6]_i_1_n_0 ;
  wire \snapshot_start[7]_i_2_n_0 ;
  wire \snapshot_start[7]_i_3_n_0 ;
  wire \snapshot_start[7]_i_4_n_0 ;
  wire \snapshot_start_reg_n_0_[0] ;
  wire \snapshot_start_reg_n_0_[1] ;
  wire \snapshot_start_reg_n_0_[2] ;
  wire \snapshot_start_reg_n_0_[3] ;
  wire \snapshot_start_reg_n_0_[4] ;
  wire \snapshot_start_reg_n_0_[5] ;
  wire \snapshot_start_reg_n_0_[6] ;
  wire \snapshot_start_reg_n_0_[7] ;
  wire [7:0]snapshot_trigger_index;
  wire [7:0]snapshot_trigger_index00_out;
  wire snapshot_trigger_index0_carry__0_i_1_n_0;
  wire snapshot_trigger_index0_carry__0_i_2_n_0;
  wire snapshot_trigger_index0_carry__0_i_3_n_0;
  wire snapshot_trigger_index0_carry__0_i_4_n_0;
  wire snapshot_trigger_index0_carry__0_n_1;
  wire snapshot_trigger_index0_carry__0_n_2;
  wire snapshot_trigger_index0_carry__0_n_3;
  wire snapshot_trigger_index0_carry_i_1_n_0;
  wire snapshot_trigger_index0_carry_i_2_n_0;
  wire snapshot_trigger_index0_carry_i_3_n_0;
  wire snapshot_trigger_index0_carry_i_4_n_0;
  wire snapshot_trigger_index0_carry_n_0;
  wire snapshot_trigger_index0_carry_n_1;
  wire snapshot_trigger_index0_carry_n_2;
  wire snapshot_trigger_index0_carry_n_3;
  wire \timestamp_shadow[63]_i_3_n_0 ;
  wire \timestamp_shadow[63]_i_4_n_0 ;
  wire \timestamp_shadow_reg[32] ;
  wire \timestamp_shadow_reg[32]_0 ;
  wire \trigger_physical_index_reg_n_0_[0] ;
  wire \trigger_physical_index_reg_n_0_[1] ;
  wire \trigger_physical_index_reg_n_0_[2] ;
  wire \trigger_physical_index_reg_n_0_[3] ;
  wire \trigger_physical_index_reg_n_0_[4] ;
  wire \trigger_physical_index_reg_n_0_[5] ;
  wire \trigger_physical_index_reg_n_0_[6] ;
  wire \trigger_physical_index_reg_n_0_[7] ;
  wire trigger_seen8_out;
  wire trigger_seen_i_1_n_0;
  wire trigger_seen_reg_n_0;
  wire [7:0]write_pointer_reg__0;
  wire NLW_memory_reg_0_CASCADEOUTA_UNCONNECTED;
  wire NLW_memory_reg_0_CASCADEOUTB_UNCONNECTED;
  wire NLW_memory_reg_0_DBITERR_UNCONNECTED;
  wire NLW_memory_reg_0_SBITERR_UNCONNECTED;
  wire [7:0]NLW_memory_reg_0_ECCPARITY_UNCONNECTED;
  wire [8:0]NLW_memory_reg_0_RDADDRECC_UNCONNECTED;
  wire NLW_memory_reg_1_CASCADEOUTA_UNCONNECTED;
  wire NLW_memory_reg_1_CASCADEOUTB_UNCONNECTED;
  wire NLW_memory_reg_1_DBITERR_UNCONNECTED;
  wire NLW_memory_reg_1_SBITERR_UNCONNECTED;
  wire [31:24]NLW_memory_reg_1_DOBDO_UNCONNECTED;
  wire [3:0]NLW_memory_reg_1_DOPADOP_UNCONNECTED;
  wire [3:0]NLW_memory_reg_1_DOPBDOP_UNCONNECTED;
  wire [7:0]NLW_memory_reg_1_ECCPARITY_UNCONNECTED;
  wire [8:0]NLW_memory_reg_1_RDADDRECC_UNCONNECTED;
  wire [3:0]NLW_rd_valid1_carry_O_UNCONNECTED;
  wire [3:1]NLW_rd_valid1_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_rd_valid1_carry__0_O_UNCONNECTED;
  wire [3:3]NLW_read_physical_index_carry__0_CO_UNCONNECTED;
  wire [3:3]\NLW_snapshot_id_reg[28]_i_1_CO_UNCONNECTED ;
  wire [3:3]NLW_snapshot_trigger_index0_carry__0_CO_UNCONNECTED;

  LUT3 #(
    .INIT(8'hBA)) 
    capture_active_i_1
       (.I0(capture_active_reg_1),
        .I1(\snapshot_count[8]_i_2_n_0 ),
        .I2(capture_active),
        .O(capture_active_i_1_n_0));
  FDRE capture_active_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(capture_active_i_1_n_0),
        .Q(capture_active),
        .R(clear));
  LUT3 #(
    .INIT(8'hA8)) 
    \capture_count[8]_i_1 
       (.I0(capture_active),
        .I1(\dropped_count_reg_reg[0]_1 ),
        .I2(ext_evt_valid),
        .O(capture_active111_out));
  FDRE \capture_count_reg[0] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(\snapshot_count[0]_i_1_n_0 ),
        .Q(capture_count_reg__0[0]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \capture_count_reg[1] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(sel0[1]),
        .Q(capture_count_reg__0[1]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \capture_count_reg[2] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(sel0[2]),
        .Q(capture_count_reg__0[2]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \capture_count_reg[3] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(sel0[3]),
        .Q(capture_count_reg__0[3]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \capture_count_reg[4] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(sel0[4]),
        .Q(capture_count_reg__0[4]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \capture_count_reg[5] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(\snapshot_count[5]_i_1_n_0 ),
        .Q(capture_count_reg__0[5]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \capture_count_reg[6] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(\snapshot_count[6]_i_1_n_0 ),
        .Q(capture_count_reg__0[6]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \capture_count_reg[7] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(sel0[7]),
        .Q(capture_count_reg__0[7]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \capture_count_reg[8] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(sel0[8]),
        .Q(capture_count_reg__0[8]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h5557555555545555)) 
    \dropped_count_reg[0]_i_1 
       (.I0(\s_axi_rdata_reg[31]_1 [0]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[0]),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[10]_i_1 
       (.I0(dropped_count_reg00_in[9]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[10]),
        .O(D[10]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[11]_i_1 
       (.I0(dropped_count_reg00_in[10]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[11]),
        .O(D[11]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[12]_i_1 
       (.I0(dropped_count_reg00_in[11]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[12]),
        .O(D[12]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[13]_i_1 
       (.I0(dropped_count_reg00_in[12]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[13]),
        .O(D[13]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[14]_i_1 
       (.I0(dropped_count_reg00_in[13]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[14]),
        .O(D[14]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[15]_i_1 
       (.I0(dropped_count_reg00_in[14]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[15]),
        .O(D[15]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[16]_i_1 
       (.I0(dropped_count_reg00_in[15]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[16]),
        .O(D[16]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[17]_i_1 
       (.I0(dropped_count_reg00_in[16]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[17]),
        .O(D[17]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[18]_i_1 
       (.I0(dropped_count_reg00_in[17]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[18]),
        .O(D[18]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[19]_i_1 
       (.I0(dropped_count_reg00_in[18]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[19]),
        .O(D[19]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[1]_i_1 
       (.I0(dropped_count_reg00_in[0]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[1]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[20]_i_1 
       (.I0(dropped_count_reg00_in[19]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[20]),
        .O(D[20]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[21]_i_1 
       (.I0(dropped_count_reg00_in[20]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[21]),
        .O(D[21]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[22]_i_1 
       (.I0(dropped_count_reg00_in[21]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[22]),
        .O(D[22]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[23]_i_1 
       (.I0(dropped_count_reg00_in[22]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[23]),
        .O(D[23]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[24]_i_1 
       (.I0(dropped_count_reg00_in[23]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[24]),
        .O(D[24]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[25]_i_1 
       (.I0(dropped_count_reg00_in[24]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[25]),
        .O(D[25]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[26]_i_1 
       (.I0(dropped_count_reg00_in[25]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[26]),
        .O(D[26]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[27]_i_1 
       (.I0(dropped_count_reg00_in[26]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[27]),
        .O(D[27]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[28]_i_1 
       (.I0(dropped_count_reg00_in[27]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[28]),
        .O(D[28]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[29]_i_1 
       (.I0(dropped_count_reg00_in[28]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[29]),
        .O(D[29]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[2]_i_1 
       (.I0(dropped_count_reg00_in[1]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[2]),
        .O(D[2]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[30]_i_1 
       (.I0(dropped_count_reg00_in[29]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[30]),
        .O(D[30]));
  LUT5 #(
    .INIT(32'h75335500)) 
    \dropped_count_reg[31]_i_2 
       (.I0(capture_active),
        .I1(\dropped_count_reg_reg[0] ),
        .I2(\dropped_count_reg_reg[0]_2 ),
        .I3(p_3_in),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .O(capture_active_reg_0));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[31]_i_3 
       (.I0(dropped_count_reg00_in[30]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[31]),
        .O(D[31]));
  LUT6 #(
    .INIT(64'hAAAEAAAAFFFFFFFF)) 
    \dropped_count_reg[31]_i_6 
       (.I0(capture_active),
        .I1(\dropped_count_reg_reg[31] ),
        .I2(\dropped_count_reg_reg[31]_0 ),
        .I3(\dropped_count_reg_reg[31]_1 ),
        .I4(\dropped_count_reg_reg[31]_2 ),
        .I5(\dropped_count_reg_reg[31]_3 ),
        .O(\dropped_count_reg[31]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[3]_i_1 
       (.I0(dropped_count_reg00_in[2]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[3]),
        .O(D[3]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[4]_i_1 
       (.I0(dropped_count_reg00_in[3]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[4]),
        .O(D[4]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[5]_i_1 
       (.I0(dropped_count_reg00_in[4]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[5]),
        .O(D[5]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[6]_i_1 
       (.I0(dropped_count_reg00_in[5]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[6]),
        .O(D[6]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[7]_i_1 
       (.I0(dropped_count_reg00_in[6]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[7]),
        .O(D[7]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[8]_i_1 
       (.I0(dropped_count_reg00_in[7]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[8]),
        .O(D[8]));
  LUT6 #(
    .INIT(64'hAAABAAAAAAA8AAAA)) 
    \dropped_count_reg[9]_i_1 
       (.I0(dropped_count_reg00_in[8]),
        .I1(\dropped_count_reg[31]_i_6_n_0 ),
        .I2(\dropped_count_reg_reg[0] ),
        .I3(\dropped_count_reg_reg[0]_0 ),
        .I4(\dropped_count_reg_reg[0]_1 ),
        .I5(dropped_count_reg0[9]),
        .O(D[9]));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p8_d64" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "memory" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "511" *) 
  (* bram_slice_begin = "0" *) 
  (* bram_slice_end = "71" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "511" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "71" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    memory_reg_0
       (.ADDRARDADDR({1'b1,1'b1,read_physical_index,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,1'b1,write_pointer_reg__0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(NLW_memory_reg_0_CASCADEOUTA_UNCONNECTED),
        .CASCADEOUTB(NLW_memory_reg_0_CASCADEOUTB_UNCONNECTED),
        .CLKARDCLK(s_axi_aclk),
        .CLKBWRCLK(s_axi_aclk),
        .DBITERR(NLW_memory_reg_0_DBITERR_UNCONNECTED),
        .DIADI(in_event[31:0]),
        .DIBDI(in_event[63:32]),
        .DIPADIP(in_event[67:64]),
        .DIPBDIP(in_event[71:68]),
        .DOADO(snapshot_rd_event[31:0]),
        .DOBDO(snapshot_rd_event[63:32]),
        .DOPADOP(snapshot_rd_event[67:64]),
        .DOPBDOP(snapshot_rd_event[71:68]),
        .ECCPARITY(NLW_memory_reg_0_ECCPARITY_UNCONNECTED[7:0]),
        .ENARDEN(memory_reg_0_i_1_n_0),
        .ENBWREN(memory_reg_0_i_2_n_0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(NLW_memory_reg_0_RDADDRECC_UNCONNECTED[8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(clear),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(NLW_memory_reg_0_SBITERR_UNCONNECTED),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({s_axi_aresetn,s_axi_aresetn,s_axi_aresetn,s_axi_aresetn,s_axi_aresetn,s_axi_aresetn,s_axi_aresetn,s_axi_aresetn}));
  LUT4 #(
    .INIT(16'h80FF)) 
    memory_reg_0_i_1
       (.I0(snapshot_ready),
        .I1(rd_valid1),
        .I2(snapshot_rd_en),
        .I3(s_axi_aresetn),
        .O(memory_reg_0_i_1_n_0));
  LUT4 #(
    .INIT(16'h00A8)) 
    memory_reg_0_i_2
       (.I0(capture_active),
        .I1(ext_evt_valid),
        .I2(\dropped_count_reg_reg[0]_1 ),
        .I3(capture_active_reg_1),
        .O(memory_reg_0_i_2_n_0));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d56" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d56" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "32768" *) 
  (* RTL_RAM_NAME = "memory" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "511" *) 
  (* bram_slice_begin = "72" *) 
  (* bram_slice_end = "127" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "511" *) 
  (* ram_slice_begin = "72" *) 
  (* ram_slice_end = "127" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(72),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(72)) 
    memory_reg_1
       (.ADDRARDADDR({1'b1,1'b1,read_physical_index,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,1'b1,write_pointer_reg__0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(NLW_memory_reg_1_CASCADEOUTA_UNCONNECTED),
        .CASCADEOUTB(NLW_memory_reg_1_CASCADEOUTB_UNCONNECTED),
        .CLKARDCLK(s_axi_aclk),
        .CLKBWRCLK(s_axi_aclk),
        .DBITERR(NLW_memory_reg_1_DBITERR_UNCONNECTED),
        .DIADI(in_event[103:72]),
        .DIBDI({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,in_event[127:104]}),
        .DIPADIP({1'b1,1'b1,1'b1,1'b1}),
        .DIPBDIP({1'b1,1'b1,1'b1,1'b1}),
        .DOADO(snapshot_rd_event[103:72]),
        .DOBDO({NLW_memory_reg_1_DOBDO_UNCONNECTED[31:24],snapshot_rd_event[127:104]}),
        .DOPADOP(NLW_memory_reg_1_DOPADOP_UNCONNECTED[3:0]),
        .DOPBDOP(NLW_memory_reg_1_DOPBDOP_UNCONNECTED[3:0]),
        .ECCPARITY(NLW_memory_reg_1_ECCPARITY_UNCONNECTED[7:0]),
        .ENARDEN(memory_reg_0_i_1_n_0),
        .ENBWREN(memory_reg_0_i_2_n_0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(NLW_memory_reg_1_RDADDRECC_UNCONNECTED[8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(clear),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(NLW_memory_reg_1_SBITERR_UNCONNECTED),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({s_axi_aresetn,s_axi_aresetn,s_axi_aresetn,s_axi_aresetn,s_axi_aresetn,s_axi_aresetn,s_axi_aresetn,s_axi_aresetn}));
  LUT5 #(
    .INIT(32'h0000AE00)) 
    overwritten_i_1
       (.I0(snapshot_overwritten),
        .I1(overwritten_i_2_n_0),
        .I2(overwritten_i_3_n_0),
        .I3(s_axi_aresetn),
        .I4(capture_active_reg_1),
        .O(overwritten_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    overwritten_i_2
       (.I0(capture_count_reg__0[0]),
        .I1(capture_count_reg__0[8]),
        .I2(capture_count_reg__0[3]),
        .I3(capture_count_reg__0[7]),
        .I4(capture_count_reg__0[4]),
        .I5(capture_count_reg__0[6]),
        .O(overwritten_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFF1F)) 
    overwritten_i_3
       (.I0(ext_evt_valid),
        .I1(\dropped_count_reg_reg[0]_1 ),
        .I2(capture_active),
        .I3(capture_count_reg__0[1]),
        .I4(capture_count_reg__0[2]),
        .I5(capture_count_reg__0[5]),
        .O(overwritten_i_3_n_0));
  FDRE overwritten_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(overwritten_i_1_n_0),
        .Q(snapshot_overwritten),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \post_remaining[0]_i_1 
       (.I0(\post_remaining_reg_n_0_[0] ),
        .O(\post_remaining[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \post_remaining[1]_i_1 
       (.I0(\post_remaining_reg_n_0_[1] ),
        .I1(\post_remaining_reg_n_0_[0] ),
        .O(\post_remaining[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \post_remaining[2]_i_1 
       (.I0(\post_remaining_reg_n_0_[2] ),
        .I1(\post_remaining_reg_n_0_[0] ),
        .I2(\post_remaining_reg_n_0_[1] ),
        .O(\post_remaining[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF54040000)) 
    \post_remaining[3]_i_1 
       (.I0(trigger_seen_reg_n_0),
        .I1(\post_remaining_reg[1]_0 ),
        .I2(\dropped_count_reg_reg[0]_2 ),
        .I3(ext_evt_trigger),
        .I4(capture_active111_out),
        .I5(\snapshot_count[8]_i_1_n_0 ),
        .O(\post_remaining[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hA800)) 
    \post_remaining[3]_i_2 
       (.I0(trigger_seen_reg_n_0),
        .I1(ext_evt_valid),
        .I2(\dropped_count_reg_reg[0]_1 ),
        .I3(capture_active),
        .O(post_remaining));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \post_remaining[3]_i_3 
       (.I0(\post_remaining_reg_n_0_[3] ),
        .I1(\post_remaining_reg_n_0_[2] ),
        .I2(\post_remaining_reg_n_0_[1] ),
        .I3(\post_remaining_reg_n_0_[0] ),
        .O(\post_remaining[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEDEEEEE)) 
    \post_remaining[4]_i_1 
       (.I0(\post_remaining_reg_n_0_[4] ),
        .I1(trigger_seen8_out),
        .I2(post_remaining),
        .I3(\post_remaining_reg_n_0_[3] ),
        .I4(\post_remaining[4]_i_2_n_0 ),
        .I5(\snapshot_count[8]_i_1_n_0 ),
        .O(\post_remaining[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \post_remaining[4]_i_2 
       (.I0(\post_remaining_reg_n_0_[0] ),
        .I1(\post_remaining_reg_n_0_[1] ),
        .I2(\post_remaining_reg_n_0_[2] ),
        .O(\post_remaining[4]_i_2_n_0 ));
  FDRE \post_remaining_reg[0] 
       (.C(s_axi_aclk),
        .CE(post_remaining),
        .D(\post_remaining[0]_i_1_n_0 ),
        .Q(\post_remaining_reg_n_0_[0] ),
        .R(\post_remaining[3]_i_1_n_0 ));
  FDRE \post_remaining_reg[1] 
       (.C(s_axi_aclk),
        .CE(post_remaining),
        .D(\post_remaining[1]_i_1_n_0 ),
        .Q(\post_remaining_reg_n_0_[1] ),
        .R(\post_remaining[3]_i_1_n_0 ));
  FDRE \post_remaining_reg[2] 
       (.C(s_axi_aclk),
        .CE(post_remaining),
        .D(\post_remaining[2]_i_1_n_0 ),
        .Q(\post_remaining_reg_n_0_[2] ),
        .R(\post_remaining[3]_i_1_n_0 ));
  FDRE \post_remaining_reg[3] 
       (.C(s_axi_aclk),
        .CE(post_remaining),
        .D(\post_remaining[3]_i_3_n_0 ),
        .Q(\post_remaining_reg_n_0_[3] ),
        .R(\post_remaining[3]_i_1_n_0 ));
  FDRE \post_remaining_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\post_remaining[4]_i_1_n_0 ),
        .Q(\post_remaining_reg_n_0_[4] ),
        .R(1'b0));
  CARRY4 rd_valid1_carry
       (.CI(1'b0),
        .CO({rd_valid1_carry_n_0,rd_valid1_carry_n_1,rd_valid1_carry_n_2,rd_valid1_carry_n_3}),
        .CYINIT(1'b0),
        .DI({rd_valid1_carry_i_1_n_0,rd_valid1_carry_i_2_n_0,rd_valid1_carry_i_3_n_0,rd_valid1_carry_i_4_n_0}),
        .O(NLW_rd_valid1_carry_O_UNCONNECTED[3:0]),
        .S({rd_valid1_carry_i_5_n_0,rd_valid1_carry_i_6_n_0,rd_valid1_carry_i_7_n_0,rd_valid1_carry_i_8_n_0}));
  CARRY4 rd_valid1_carry__0
       (.CI(rd_valid1_carry_n_0),
        .CO({NLW_rd_valid1_carry__0_CO_UNCONNECTED[3:1],rd_valid1}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,Q}),
        .O(NLW_rd_valid1_carry__0_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,1'b0,rd_valid1_carry__0_i_1_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    rd_valid1_carry__0_i_1
       (.I0(Q),
        .O(rd_valid1_carry__0_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    rd_valid1_carry_i_1
       (.I0(snapshot_count[7]),
        .I1(memory_reg_0_0[7]),
        .I2(snapshot_count[6]),
        .I3(memory_reg_0_0[6]),
        .O(rd_valid1_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    rd_valid1_carry_i_2
       (.I0(snapshot_count[5]),
        .I1(memory_reg_0_0[5]),
        .I2(snapshot_count[4]),
        .I3(memory_reg_0_0[4]),
        .O(rd_valid1_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    rd_valid1_carry_i_3
       (.I0(snapshot_count[3]),
        .I1(memory_reg_0_0[3]),
        .I2(snapshot_count[2]),
        .I3(memory_reg_0_0[2]),
        .O(rd_valid1_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    rd_valid1_carry_i_4
       (.I0(snapshot_count[1]),
        .I1(memory_reg_0_0[1]),
        .I2(snapshot_count[0]),
        .I3(memory_reg_0_0[0]),
        .O(rd_valid1_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    rd_valid1_carry_i_5
       (.I0(memory_reg_0_0[7]),
        .I1(snapshot_count[7]),
        .I2(memory_reg_0_0[6]),
        .I3(snapshot_count[6]),
        .O(rd_valid1_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    rd_valid1_carry_i_6
       (.I0(memory_reg_0_0[5]),
        .I1(snapshot_count[5]),
        .I2(memory_reg_0_0[4]),
        .I3(snapshot_count[4]),
        .O(rd_valid1_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    rd_valid1_carry_i_7
       (.I0(memory_reg_0_0[3]),
        .I1(snapshot_count[3]),
        .I2(memory_reg_0_0[2]),
        .I3(snapshot_count[2]),
        .O(rd_valid1_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    rd_valid1_carry_i_8
       (.I0(memory_reg_0_0[1]),
        .I1(snapshot_count[1]),
        .I2(memory_reg_0_0[0]),
        .I3(snapshot_count[0]),
        .O(rd_valid1_carry_i_8_n_0));
  LUT3 #(
    .INIT(8'h80)) 
    rd_valid_i_1
       (.I0(snapshot_rd_en),
        .I1(rd_valid1),
        .I2(snapshot_ready),
        .O(rd_valid_i_1_n_0));
  FDRE rd_valid_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(rd_valid_i_1_n_0),
        .Q(snapshot_rd_valid),
        .R(clear));
  CARRY4 read_physical_index_carry
       (.CI(1'b0),
        .CO({read_physical_index_carry_n_0,read_physical_index_carry_n_1,read_physical_index_carry_n_2,read_physical_index_carry_n_3}),
        .CYINIT(1'b0),
        .DI({\snapshot_start_reg_n_0_[3] ,\snapshot_start_reg_n_0_[2] ,\snapshot_start_reg_n_0_[1] ,\snapshot_start_reg_n_0_[0] }),
        .O(read_physical_index[3:0]),
        .S({read_physical_index_carry_i_1_n_0,read_physical_index_carry_i_2_n_0,read_physical_index_carry_i_3_n_0,read_physical_index_carry_i_4_n_0}));
  CARRY4 read_physical_index_carry__0
       (.CI(read_physical_index_carry_n_0),
        .CO({NLW_read_physical_index_carry__0_CO_UNCONNECTED[3],read_physical_index_carry__0_n_1,read_physical_index_carry__0_n_2,read_physical_index_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,\snapshot_start_reg_n_0_[6] ,\snapshot_start_reg_n_0_[5] ,\snapshot_start_reg_n_0_[4] }),
        .O(read_physical_index[7:4]),
        .S({read_physical_index_carry__0_i_1_n_0,read_physical_index_carry__0_i_2_n_0,read_physical_index_carry__0_i_3_n_0,read_physical_index_carry__0_i_4_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    read_physical_index_carry__0_i_1
       (.I0(memory_reg_0_0[7]),
        .I1(\snapshot_start_reg_n_0_[7] ),
        .O(read_physical_index_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    read_physical_index_carry__0_i_2
       (.I0(\snapshot_start_reg_n_0_[6] ),
        .I1(memory_reg_0_0[6]),
        .O(read_physical_index_carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    read_physical_index_carry__0_i_3
       (.I0(\snapshot_start_reg_n_0_[5] ),
        .I1(memory_reg_0_0[5]),
        .O(read_physical_index_carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    read_physical_index_carry__0_i_4
       (.I0(\snapshot_start_reg_n_0_[4] ),
        .I1(memory_reg_0_0[4]),
        .O(read_physical_index_carry__0_i_4_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    read_physical_index_carry_i_1
       (.I0(\snapshot_start_reg_n_0_[3] ),
        .I1(memory_reg_0_0[3]),
        .O(read_physical_index_carry_i_1_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    read_physical_index_carry_i_2
       (.I0(\snapshot_start_reg_n_0_[2] ),
        .I1(memory_reg_0_0[2]),
        .O(read_physical_index_carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    read_physical_index_carry_i_3
       (.I0(\snapshot_start_reg_n_0_[1] ),
        .I1(memory_reg_0_0[1]),
        .O(read_physical_index_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    read_physical_index_carry_i_4
       (.I0(\snapshot_start_reg_n_0_[0] ),
        .I1(memory_reg_0_0[0]),
        .O(read_physical_index_carry_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    s_axi_awready_i_1
       (.I0(s_axi_aresetn),
        .O(clear));
  LUT1 #(
    .INIT(2'h1)) 
    s_axi_rdata2_carry__0_i_1
       (.I0(Q),
        .O(\snapshot_count_reg[8]_0 ));
  LUT4 #(
    .INIT(16'h22B2)) 
    s_axi_rdata2_carry_i_1
       (.I0(snapshot_count[7]),
        .I1(s_axi_araddr[10]),
        .I2(snapshot_count[6]),
        .I3(s_axi_araddr[9]),
        .O(DI[3]));
  LUT4 #(
    .INIT(16'h22B2)) 
    s_axi_rdata2_carry_i_2
       (.I0(snapshot_count[5]),
        .I1(s_axi_araddr[8]),
        .I2(snapshot_count[4]),
        .I3(s_axi_araddr[7]),
        .O(DI[2]));
  LUT4 #(
    .INIT(16'h22B2)) 
    s_axi_rdata2_carry_i_3
       (.I0(snapshot_count[3]),
        .I1(s_axi_araddr[6]),
        .I2(snapshot_count[2]),
        .I3(s_axi_araddr[5]),
        .O(DI[1]));
  LUT4 #(
    .INIT(16'h22B2)) 
    s_axi_rdata2_carry_i_4
       (.I0(snapshot_count[1]),
        .I1(s_axi_araddr[4]),
        .I2(snapshot_count[0]),
        .I3(s_axi_araddr[3]),
        .O(DI[0]));
  LUT4 #(
    .INIT(16'h9009)) 
    s_axi_rdata2_carry_i_5
       (.I0(s_axi_araddr[10]),
        .I1(snapshot_count[7]),
        .I2(s_axi_araddr[9]),
        .I3(snapshot_count[6]),
        .O(S[3]));
  LUT4 #(
    .INIT(16'h9009)) 
    s_axi_rdata2_carry_i_6
       (.I0(s_axi_araddr[8]),
        .I1(snapshot_count[5]),
        .I2(s_axi_araddr[7]),
        .I3(snapshot_count[4]),
        .O(S[2]));
  LUT4 #(
    .INIT(16'h9009)) 
    s_axi_rdata2_carry_i_7
       (.I0(s_axi_araddr[6]),
        .I1(snapshot_count[3]),
        .I2(s_axi_araddr[5]),
        .I3(snapshot_count[2]),
        .O(S[1]));
  LUT4 #(
    .INIT(16'h9009)) 
    s_axi_rdata2_carry_i_8
       (.I0(s_axi_araddr[4]),
        .I1(snapshot_count[1]),
        .I2(s_axi_araddr[3]),
        .I3(snapshot_count[0]),
        .O(S[0]));
  LUT6 #(
    .INIT(64'h404040FF40404040)) 
    \s_axi_rdata[0]_i_1 
       (.I0(\s_axi_rdata[0]_i_2_n_0 ),
        .I1(snapshot_rd_valid),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(\s_axi_rdata[27]_i_3_n_0 ),
        .I4(\s_axi_rdata[0]_i_3_n_0 ),
        .I5(\s_axi_rdata_reg[0]_0 ),
        .O(\s_axi_araddr[5] [0]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[0]_i_2 
       (.I0(snapshot_rd_event[32]),
        .I1(snapshot_rd_event[0]),
        .I2(snapshot_rd_event[64]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[96]),
        .O(\s_axi_rdata[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h47FF000000000000)) 
    \s_axi_rdata[0]_i_3 
       (.I0(\s_axi_rdata_reg[31]_1 [0]),
        .I1(\s_axi_rdata_reg[4]_2 ),
        .I2(snapshot_trigger_index[0]),
        .I3(\s_axi_rdata_reg[4]_1 ),
        .I4(\s_axi_rdata[0]_i_5_n_0 ),
        .I5(\s_axi_rdata_reg[9] ),
        .O(\s_axi_rdata[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAABFBBBFEEBFFFBF)) 
    \s_axi_rdata[0]_i_5 
       (.I0(s_axi_araddr[3]),
        .I1(s_axi_araddr[1]),
        .I2(capture_active),
        .I3(s_axi_araddr[2]),
        .I4(snapshot_id[0]),
        .I5(snapshot_count[0]),
        .O(\s_axi_rdata[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[10]_i_1 
       (.I0(\s_axi_rdata[10]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[10]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[10] ),
        .I5(\s_axi_rdata_reg[10]_0 ),
        .O(\s_axi_araddr[5] [10]));
  LUT6 #(
    .INIT(64'h3355000F3355FF0F)) 
    \s_axi_rdata[10]_i_2 
       (.I0(snapshot_rd_event[74]),
        .I1(snapshot_rd_event[106]),
        .I2(snapshot_rd_event[10]),
        .I3(\s_axi_rdata_reg[0]_1 [0]),
        .I4(\s_axi_rdata_reg[0]_1 [1]),
        .I5(snapshot_rd_event[42]),
        .O(\s_axi_rdata[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[10]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[10]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [10]),
        .O(\s_axi_rdata[10]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[11]_i_1 
       (.I0(\s_axi_rdata[11]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[11]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[11] ),
        .I5(\s_axi_rdata_reg[11]_0 ),
        .O(\s_axi_araddr[5] [11]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[11]_i_2 
       (.I0(snapshot_rd_event[43]),
        .I1(snapshot_rd_event[11]),
        .I2(snapshot_rd_event[75]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[107]),
        .O(\s_axi_rdata[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[11]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[11]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [11]),
        .O(\s_axi_rdata[11]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h404040FF40404040)) 
    \s_axi_rdata[12]_i_1 
       (.I0(\s_axi_rdata[12]_i_2_n_0 ),
        .I1(snapshot_rd_valid),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(\s_axi_rdata[27]_i_3_n_0 ),
        .I4(\s_axi_rdata[12]_i_3_n_0 ),
        .I5(\s_axi_rdata_reg[12] ),
        .O(\s_axi_araddr[5] [12]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[12]_i_2 
       (.I0(snapshot_rd_event[44]),
        .I1(snapshot_rd_event[12]),
        .I2(snapshot_rd_event[76]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[108]),
        .O(\s_axi_rdata[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCCCC44CCCC0CCCCC)) 
    \s_axi_rdata[12]_i_3 
       (.I0(\s_axi_rdata_reg[31]_1 [12]),
        .I1(\s_axi_rdata_reg[9] ),
        .I2(snapshot_id[12]),
        .I3(s_axi_araddr[1]),
        .I4(s_axi_araddr[2]),
        .I5(s_axi_araddr[3]),
        .O(\s_axi_rdata[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[13]_i_1 
       (.I0(\s_axi_rdata[13]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[13]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[13] ),
        .I5(\s_axi_rdata_reg[13]_0 ),
        .O(\s_axi_araddr[5] [13]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[13]_i_2 
       (.I0(snapshot_rd_event[45]),
        .I1(snapshot_rd_event[13]),
        .I2(snapshot_rd_event[77]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[109]),
        .O(\s_axi_rdata[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[13]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[13]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [13]),
        .O(\s_axi_rdata[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[14]_i_1 
       (.I0(\s_axi_rdata[14]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[14]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[14] ),
        .I5(\s_axi_rdata_reg[14]_0 ),
        .O(\s_axi_araddr[5] [14]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[14]_i_2 
       (.I0(snapshot_rd_event[46]),
        .I1(snapshot_rd_event[14]),
        .I2(snapshot_rd_event[78]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[110]),
        .O(\s_axi_rdata[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[14]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[14]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [14]),
        .O(\s_axi_rdata[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[15]_i_1 
       (.I0(\s_axi_rdata[15]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[15]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[15] ),
        .I5(\s_axi_rdata_reg[15]_0 ),
        .O(\s_axi_araddr[5] [15]));
  LUT6 #(
    .INIT(64'h00330F55FF330F55)) 
    \s_axi_rdata[15]_i_2 
       (.I0(snapshot_rd_event[15]),
        .I1(snapshot_rd_event[47]),
        .I2(snapshot_rd_event[79]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[111]),
        .O(\s_axi_rdata[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[15]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[15]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [15]),
        .O(\s_axi_rdata[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h404040FF40404040)) 
    \s_axi_rdata[16]_i_1 
       (.I0(\s_axi_rdata[16]_i_2_n_0 ),
        .I1(snapshot_rd_valid),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(\s_axi_rdata[27]_i_3_n_0 ),
        .I4(\s_axi_rdata[16]_i_3_n_0 ),
        .I5(\s_axi_rdata_reg[16] ),
        .O(\s_axi_araddr[5] [16]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[16]_i_2 
       (.I0(snapshot_rd_event[48]),
        .I1(snapshot_rd_event[16]),
        .I2(snapshot_rd_event[80]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[112]),
        .O(\s_axi_rdata[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCCCC44CCCC0CCCCC)) 
    \s_axi_rdata[16]_i_3 
       (.I0(\s_axi_rdata_reg[31]_1 [16]),
        .I1(\s_axi_rdata_reg[9] ),
        .I2(snapshot_id[16]),
        .I3(s_axi_araddr[1]),
        .I4(s_axi_araddr[2]),
        .I5(s_axi_araddr[3]),
        .O(\s_axi_rdata[16]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[17]_i_1 
       (.I0(\s_axi_rdata[17]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[17]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[17] ),
        .I5(\s_axi_rdata_reg[17]_0 ),
        .O(\s_axi_araddr[5] [17]));
  LUT6 #(
    .INIT(64'h33550F0033550FFF)) 
    \s_axi_rdata[17]_i_2 
       (.I0(snapshot_rd_event[81]),
        .I1(snapshot_rd_event[113]),
        .I2(snapshot_rd_event[49]),
        .I3(\s_axi_rdata_reg[0]_1 [0]),
        .I4(\s_axi_rdata_reg[0]_1 [1]),
        .I5(snapshot_rd_event[17]),
        .O(\s_axi_rdata[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[17]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[17]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [17]),
        .O(\s_axi_rdata[17]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[18]_i_1 
       (.I0(\s_axi_rdata[18]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[18]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[18] ),
        .I5(\s_axi_rdata_reg[18]_0 ),
        .O(\s_axi_araddr[5] [18]));
  LUT6 #(
    .INIT(64'h33550F0033550FFF)) 
    \s_axi_rdata[18]_i_2 
       (.I0(snapshot_rd_event[82]),
        .I1(snapshot_rd_event[114]),
        .I2(snapshot_rd_event[50]),
        .I3(\s_axi_rdata_reg[0]_1 [0]),
        .I4(\s_axi_rdata_reg[0]_1 [1]),
        .I5(snapshot_rd_event[18]),
        .O(\s_axi_rdata[18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[18]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[18]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [18]),
        .O(\s_axi_rdata[18]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[19]_i_1 
       (.I0(\s_axi_rdata[19]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[19]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[19] ),
        .I5(\s_axi_rdata_reg[19]_0 ),
        .O(\s_axi_araddr[5] [19]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[19]_i_2 
       (.I0(snapshot_rd_event[51]),
        .I1(snapshot_rd_event[19]),
        .I2(snapshot_rd_event[83]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[115]),
        .O(\s_axi_rdata[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[19]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[19]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [19]),
        .O(\s_axi_rdata[19]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h404040FF40404040)) 
    \s_axi_rdata[1]_i_1 
       (.I0(\s_axi_rdata[1]_i_2_n_0 ),
        .I1(snapshot_rd_valid),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(\s_axi_rdata[27]_i_3_n_0 ),
        .I4(\s_axi_rdata[1]_i_3_n_0 ),
        .I5(\s_axi_rdata_reg[1] ),
        .O(\s_axi_araddr[5] [1]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[1]_i_2 
       (.I0(snapshot_rd_event[33]),
        .I1(snapshot_rd_event[1]),
        .I2(snapshot_rd_event[65]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[97]),
        .O(\s_axi_rdata[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h47FF000000000000)) 
    \s_axi_rdata[1]_i_3 
       (.I0(\s_axi_rdata_reg[31]_1 [1]),
        .I1(\s_axi_rdata_reg[4]_2 ),
        .I2(snapshot_trigger_index[1]),
        .I3(\s_axi_rdata_reg[4]_1 ),
        .I4(\s_axi_rdata[1]_i_5_n_0 ),
        .I5(\s_axi_rdata_reg[9] ),
        .O(\s_axi_rdata[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAABFBBBFEEBFFFBF)) 
    \s_axi_rdata[1]_i_5 
       (.I0(s_axi_araddr[3]),
        .I1(s_axi_araddr[1]),
        .I2(snapshot_ready),
        .I3(s_axi_araddr[2]),
        .I4(snapshot_id[1]),
        .I5(snapshot_count[1]),
        .O(\s_axi_rdata[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h404040FF40404040)) 
    \s_axi_rdata[20]_i_1 
       (.I0(\s_axi_rdata[20]_i_2_n_0 ),
        .I1(snapshot_rd_valid),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(\s_axi_rdata[27]_i_3_n_0 ),
        .I4(\s_axi_rdata[20]_i_3_n_0 ),
        .I5(\s_axi_rdata_reg[20] ),
        .O(\s_axi_araddr[5] [20]));
  LUT6 #(
    .INIT(64'h3355000F3355FF0F)) 
    \s_axi_rdata[20]_i_2 
       (.I0(snapshot_rd_event[84]),
        .I1(snapshot_rd_event[116]),
        .I2(snapshot_rd_event[20]),
        .I3(\s_axi_rdata_reg[0]_1 [0]),
        .I4(\s_axi_rdata_reg[0]_1 [1]),
        .I5(snapshot_rd_event[52]),
        .O(\s_axi_rdata[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCCCC44CCCC0CCCCC)) 
    \s_axi_rdata[20]_i_3 
       (.I0(\s_axi_rdata_reg[31]_1 [20]),
        .I1(\s_axi_rdata_reg[9] ),
        .I2(snapshot_id[20]),
        .I3(s_axi_araddr[1]),
        .I4(s_axi_araddr[2]),
        .I5(s_axi_araddr[3]),
        .O(\s_axi_rdata[20]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[21]_i_1 
       (.I0(\s_axi_rdata[21]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[21]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[21] ),
        .I5(\s_axi_rdata_reg[21]_0 ),
        .O(\s_axi_araddr[5] [21]));
  LUT6 #(
    .INIT(64'h3355000F3355FF0F)) 
    \s_axi_rdata[21]_i_2 
       (.I0(snapshot_rd_event[85]),
        .I1(snapshot_rd_event[117]),
        .I2(snapshot_rd_event[21]),
        .I3(\s_axi_rdata_reg[0]_1 [0]),
        .I4(\s_axi_rdata_reg[0]_1 [1]),
        .I5(snapshot_rd_event[53]),
        .O(\s_axi_rdata[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[21]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[21]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [21]),
        .O(\s_axi_rdata[21]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h404040FF40404040)) 
    \s_axi_rdata[22]_i_1 
       (.I0(\s_axi_rdata[22]_i_2_n_0 ),
        .I1(snapshot_rd_valid),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(\s_axi_rdata[27]_i_3_n_0 ),
        .I4(\s_axi_rdata[22]_i_3_n_0 ),
        .I5(\s_axi_rdata_reg[22] ),
        .O(\s_axi_araddr[5] [22]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[22]_i_2 
       (.I0(snapshot_rd_event[54]),
        .I1(snapshot_rd_event[22]),
        .I2(snapshot_rd_event[86]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[118]),
        .O(\s_axi_rdata[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCCCC44CCCC0CCCCC)) 
    \s_axi_rdata[22]_i_3 
       (.I0(\s_axi_rdata_reg[31]_1 [22]),
        .I1(\s_axi_rdata_reg[9] ),
        .I2(snapshot_id[22]),
        .I3(s_axi_araddr[1]),
        .I4(s_axi_araddr[2]),
        .I5(s_axi_araddr[3]),
        .O(\s_axi_rdata[22]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[23]_i_1 
       (.I0(\s_axi_rdata[23]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[23]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[23] ),
        .I5(\s_axi_rdata_reg[23]_0 ),
        .O(\s_axi_araddr[5] [23]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[23]_i_2 
       (.I0(snapshot_rd_event[55]),
        .I1(snapshot_rd_event[23]),
        .I2(snapshot_rd_event[87]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[119]),
        .O(\s_axi_rdata[23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[23]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[23]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [23]),
        .O(\s_axi_rdata[23]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[24]_i_1 
       (.I0(\s_axi_rdata[24]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[24]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[24] ),
        .I5(\s_axi_rdata_reg[24]_0 ),
        .O(\s_axi_araddr[5] [24]));
  LUT6 #(
    .INIT(64'h00330F55FF330F55)) 
    \s_axi_rdata[24]_i_2 
       (.I0(snapshot_rd_event[24]),
        .I1(snapshot_rd_event[56]),
        .I2(snapshot_rd_event[88]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[120]),
        .O(\s_axi_rdata[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[24]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[24]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [24]),
        .O(\s_axi_rdata[24]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[25]_i_1 
       (.I0(\s_axi_rdata[25]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[25]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[25] ),
        .I5(\s_axi_rdata_reg[25]_0 ),
        .O(\s_axi_araddr[5] [25]));
  LUT6 #(
    .INIT(64'h00330F55FF330F55)) 
    \s_axi_rdata[25]_i_2 
       (.I0(snapshot_rd_event[25]),
        .I1(snapshot_rd_event[57]),
        .I2(snapshot_rd_event[89]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[121]),
        .O(\s_axi_rdata[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[25]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[25]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [25]),
        .O(\s_axi_rdata[25]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h404040FF40404040)) 
    \s_axi_rdata[26]_i_1 
       (.I0(\s_axi_rdata[26]_i_2_n_0 ),
        .I1(snapshot_rd_valid),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(\s_axi_rdata[27]_i_3_n_0 ),
        .I4(\s_axi_rdata[26]_i_3_n_0 ),
        .I5(\s_axi_rdata_reg[26] ),
        .O(\s_axi_araddr[5] [26]));
  LUT6 #(
    .INIT(64'h33550F0033550FFF)) 
    \s_axi_rdata[26]_i_2 
       (.I0(snapshot_rd_event[90]),
        .I1(snapshot_rd_event[122]),
        .I2(snapshot_rd_event[58]),
        .I3(\s_axi_rdata_reg[0]_1 [0]),
        .I4(\s_axi_rdata_reg[0]_1 [1]),
        .I5(snapshot_rd_event[26]),
        .O(\s_axi_rdata[26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCCCC44CCCC0CCCCC)) 
    \s_axi_rdata[26]_i_3 
       (.I0(\s_axi_rdata_reg[31]_1 [26]),
        .I1(\s_axi_rdata_reg[9] ),
        .I2(snapshot_id[26]),
        .I3(s_axi_araddr[1]),
        .I4(s_axi_araddr[2]),
        .I5(s_axi_araddr[3]),
        .O(\s_axi_rdata[26]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h404040FF40404040)) 
    \s_axi_rdata[27]_i_1 
       (.I0(\s_axi_rdata[27]_i_2_n_0 ),
        .I1(snapshot_rd_valid),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(\s_axi_rdata[27]_i_3_n_0 ),
        .I4(\s_axi_rdata[27]_i_4_n_0 ),
        .I5(\s_axi_rdata_reg[27] ),
        .O(\s_axi_araddr[5] [27]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[27]_i_2 
       (.I0(snapshot_rd_event[59]),
        .I1(snapshot_rd_event[27]),
        .I2(snapshot_rd_event[91]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[123]),
        .O(\s_axi_rdata[27]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \s_axi_rdata[27]_i_3 
       (.I0(\s_axi_rdata[27]_i_6_n_0 ),
        .I1(\s_axi_rdata_reg[27]_0 ),
        .I2(s_axi_araddr[6]),
        .I3(s_axi_araddr[9]),
        .I4(s_axi_araddr[8]),
        .O(\s_axi_rdata[27]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCCCC44CCCC0CCCCC)) 
    \s_axi_rdata[27]_i_4 
       (.I0(\s_axi_rdata_reg[31]_1 [27]),
        .I1(\s_axi_rdata_reg[9] ),
        .I2(snapshot_id[27]),
        .I3(s_axi_araddr[1]),
        .I4(s_axi_araddr[2]),
        .I5(s_axi_araddr[3]),
        .O(\s_axi_rdata[27]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFF8)) 
    \s_axi_rdata[27]_i_6 
       (.I0(\s_axi_rdata_reg[0] ),
        .I1(snapshot_rd_valid),
        .I2(s_axi_araddr[12]),
        .I3(s_axi_araddr[13]),
        .I4(s_axi_araddr[10]),
        .I5(s_axi_araddr[0]),
        .O(\s_axi_rdata[27]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[28]_i_1 
       (.I0(\s_axi_rdata[28]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[28]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[28] ),
        .I5(\s_axi_rdata_reg[28]_0 ),
        .O(\s_axi_araddr[5] [28]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[28]_i_2 
       (.I0(snapshot_rd_event[60]),
        .I1(snapshot_rd_event[28]),
        .I2(snapshot_rd_event[92]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[124]),
        .O(\s_axi_rdata[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[28]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[28]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [28]),
        .O(\s_axi_rdata[28]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[29]_i_1 
       (.I0(\s_axi_rdata[29]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[29]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[29] ),
        .I5(\s_axi_rdata_reg[29]_0 ),
        .O(\s_axi_araddr[5] [29]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[29]_i_2 
       (.I0(snapshot_rd_event[61]),
        .I1(snapshot_rd_event[29]),
        .I2(snapshot_rd_event[93]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[125]),
        .O(\s_axi_rdata[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[29]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[29]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [29]),
        .O(\s_axi_rdata[29]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h404040FF40404040)) 
    \s_axi_rdata[2]_i_1 
       (.I0(\s_axi_rdata[2]_i_2_n_0 ),
        .I1(snapshot_rd_valid),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(\s_axi_rdata[27]_i_3_n_0 ),
        .I4(\s_axi_rdata[2]_i_3_n_0 ),
        .I5(\s_axi_rdata_reg[2] ),
        .O(\s_axi_araddr[5] [2]));
  LUT6 #(
    .INIT(64'h00330F55FF330F55)) 
    \s_axi_rdata[2]_i_2 
       (.I0(snapshot_rd_event[2]),
        .I1(snapshot_rd_event[34]),
        .I2(snapshot_rd_event[66]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[98]),
        .O(\s_axi_rdata[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h47FF000000000000)) 
    \s_axi_rdata[2]_i_3 
       (.I0(\s_axi_rdata_reg[31]_1 [2]),
        .I1(\s_axi_rdata_reg[4]_2 ),
        .I2(snapshot_trigger_index[2]),
        .I3(\s_axi_rdata_reg[4]_1 ),
        .I4(\s_axi_rdata[2]_i_5_n_0 ),
        .I5(\s_axi_rdata_reg[9] ),
        .O(\s_axi_rdata[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAABFAFBFFABFFFBF)) 
    \s_axi_rdata[2]_i_5 
       (.I0(s_axi_araddr[3]),
        .I1(snapshot_overwritten),
        .I2(s_axi_araddr[1]),
        .I3(s_axi_araddr[2]),
        .I4(snapshot_id[2]),
        .I5(snapshot_count[2]),
        .O(\s_axi_rdata[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[30]_i_1 
       (.I0(\s_axi_rdata[30]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[30]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[30] ),
        .I5(\s_axi_rdata_reg[30]_0 ),
        .O(\s_axi_araddr[5] [30]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[30]_i_2 
       (.I0(snapshot_rd_event[62]),
        .I1(snapshot_rd_event[30]),
        .I2(snapshot_rd_event[94]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[126]),
        .O(\s_axi_rdata[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[30]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[30]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [30]),
        .O(\s_axi_rdata[30]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00001500FFFFFFFF)) 
    \s_axi_rdata[31]_i_1 
       (.I0(\s_axi_rdata_reg[31] ),
        .I1(snapshot_ready),
        .I2(CO),
        .I3(\s_axi_rdata_reg[31]_0 ),
        .I4(\s_axi_rdata[31]_i_6_n_0 ),
        .I5(s_axi_aresetn),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hFF808080)) 
    \s_axi_rdata[31]_i_2 
       (.I0(\snapshot_rd_index_reg[0] ),
        .I1(s_axi_arvalid),
        .I2(\s_axi_rdata_reg[31] ),
        .I3(snapshot_rd_valid),
        .I4(\s_axi_rdata_reg[0] ),
        .O(E));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[31]_i_3 
       (.I0(\s_axi_rdata[31]_i_7_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[31]_i_8_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[31]_2 ),
        .I5(\s_axi_rdata_reg[31]_3 ),
        .O(\s_axi_araddr[5] [31]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \s_axi_rdata[31]_i_6 
       (.I0(snapshot_rd_valid),
        .I1(\s_axi_rdata_reg[0] ),
        .O(\s_axi_rdata[31]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h3355000F3355FF0F)) 
    \s_axi_rdata[31]_i_7 
       (.I0(snapshot_rd_event[95]),
        .I1(snapshot_rd_event[127]),
        .I2(snapshot_rd_event[31]),
        .I3(\s_axi_rdata_reg[0]_1 [0]),
        .I4(\s_axi_rdata_reg[0]_1 [1]),
        .I5(snapshot_rd_event[63]),
        .O(\s_axi_rdata[31]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[31]_i_8 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[31]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [31]),
        .O(\s_axi_rdata[31]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4444444F)) 
    \s_axi_rdata[3]_i_1 
       (.I0(\s_axi_rdata[3]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[3]_i_3_n_0 ),
        .I3(\s_axi_rdata[3]_i_4_n_0 ),
        .I4(s_axi_araddr[3]),
        .I5(\s_axi_rdata[3]_i_5_n_0 ),
        .O(\s_axi_araddr[5] [3]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[3]_i_2 
       (.I0(snapshot_rd_event[35]),
        .I1(snapshot_rd_event[3]),
        .I2(snapshot_rd_event[67]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[99]),
        .O(\s_axi_rdata[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hABABABBBBBBBABBB)) 
    \s_axi_rdata[3]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[3] ),
        .I2(s_axi_araddr[4]),
        .I3(\s_axi_rdata_reg[3]_0 ),
        .I4(s_axi_araddr[3]),
        .I5(\s_axi_rdata_reg[3]_1 ),
        .O(\s_axi_rdata[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA00000020)) 
    \s_axi_rdata[3]_i_4 
       (.I0(\s_axi_rdata[3]_i_9_n_0 ),
        .I1(\s_axi_rdata_reg[3]_2 ),
        .I2(\s_axi_rdata_reg[3]_3 ),
        .I3(\s_axi_rdata_reg[3]_4 ),
        .I4(\s_axi_rdata_reg[3]_5 ),
        .I5(\timestamp_shadow_reg[32] ),
        .O(\s_axi_rdata[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h008C0080FFFFFFFF)) 
    \s_axi_rdata[3]_i_5 
       (.I0(\s_axi_rdata_reg[31]_1 [3]),
        .I1(s_axi_araddr[3]),
        .I2(s_axi_araddr[1]),
        .I3(s_axi_araddr[2]),
        .I4(snapshot_trigger_index[3]),
        .I5(\s_axi_rdata_reg[9] ),
        .O(\s_axi_rdata[3]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h57F7)) 
    \s_axi_rdata[3]_i_9 
       (.I0(s_axi_araddr[2]),
        .I1(snapshot_id[3]),
        .I2(s_axi_araddr[1]),
        .I3(snapshot_count[3]),
        .O(\s_axi_rdata[3]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[4]_i_1 
       (.I0(\s_axi_rdata[4]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[4]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[4] ),
        .I5(\s_axi_rdata_reg[4]_0 ),
        .O(\s_axi_araddr[5] [4]));
  LUT6 #(
    .INIT(64'h00330F55FF330F55)) 
    \s_axi_rdata[4]_i_2 
       (.I0(snapshot_rd_event[4]),
        .I1(snapshot_rd_event[36]),
        .I2(snapshot_rd_event[68]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[100]),
        .O(\s_axi_rdata[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hABABABBBBBBBABBB)) 
    \s_axi_rdata[4]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata[4]_i_6_n_0 ),
        .I2(\s_axi_rdata_reg[4]_1 ),
        .I3(snapshot_trigger_index[4]),
        .I4(\s_axi_rdata_reg[4]_2 ),
        .I5(\s_axi_rdata_reg[31]_1 [4]),
        .O(\s_axi_rdata[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h22200020FFFFFFFF)) 
    \s_axi_rdata[4]_i_6 
       (.I0(s_axi_araddr[2]),
        .I1(s_axi_araddr[3]),
        .I2(snapshot_id[4]),
        .I3(s_axi_araddr[1]),
        .I4(snapshot_count[4]),
        .I5(\s_axi_rdata_reg[9] ),
        .O(\s_axi_rdata[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[5]_i_1 
       (.I0(\s_axi_rdata[5]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[5]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[5] ),
        .I5(\s_axi_rdata_reg[5]_0 ),
        .O(\s_axi_araddr[5] [5]));
  LUT6 #(
    .INIT(64'h00330F55FF330F55)) 
    \s_axi_rdata[5]_i_2 
       (.I0(snapshot_rd_event[5]),
        .I1(snapshot_rd_event[37]),
        .I2(snapshot_rd_event[69]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[101]),
        .O(\s_axi_rdata[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hABABABBBBBBBABBB)) 
    \s_axi_rdata[5]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata[5]_i_6_n_0 ),
        .I2(\s_axi_rdata_reg[4]_1 ),
        .I3(snapshot_trigger_index[5]),
        .I4(\s_axi_rdata_reg[4]_2 ),
        .I5(\s_axi_rdata_reg[31]_1 [5]),
        .O(\s_axi_rdata[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h22200020FFFFFFFF)) 
    \s_axi_rdata[5]_i_6 
       (.I0(s_axi_araddr[2]),
        .I1(s_axi_araddr[3]),
        .I2(snapshot_id[5]),
        .I3(s_axi_araddr[1]),
        .I4(snapshot_count[5]),
        .I5(\s_axi_rdata_reg[9] ),
        .O(\s_axi_rdata[5]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h404040FF40404040)) 
    \s_axi_rdata[6]_i_1 
       (.I0(\s_axi_rdata[6]_i_2_n_0 ),
        .I1(snapshot_rd_valid),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(\s_axi_rdata[27]_i_3_n_0 ),
        .I4(\s_axi_rdata[6]_i_3_n_0 ),
        .I5(\s_axi_rdata_reg[6] ),
        .O(\s_axi_araddr[5] [6]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[6]_i_2 
       (.I0(snapshot_rd_event[38]),
        .I1(snapshot_rd_event[6]),
        .I2(snapshot_rd_event[70]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[102]),
        .O(\s_axi_rdata[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FF73FF7F)) 
    \s_axi_rdata[6]_i_3 
       (.I0(\s_axi_rdata_reg[31]_1 [6]),
        .I1(s_axi_araddr[3]),
        .I2(s_axi_araddr[1]),
        .I3(s_axi_araddr[2]),
        .I4(snapshot_trigger_index[6]),
        .I5(\s_axi_rdata[6]_i_5_n_0 ),
        .O(\s_axi_rdata[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h22200020FFFFFFFF)) 
    \s_axi_rdata[6]_i_5 
       (.I0(s_axi_araddr[2]),
        .I1(s_axi_araddr[3]),
        .I2(snapshot_id[6]),
        .I3(s_axi_araddr[1]),
        .I4(snapshot_count[6]),
        .I5(\s_axi_rdata_reg[9] ),
        .O(\s_axi_rdata[6]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[7]_i_1 
       (.I0(\s_axi_rdata[7]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[7]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[7] ),
        .I5(\s_axi_rdata_reg[7]_0 ),
        .O(\s_axi_araddr[5] [7]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[7]_i_2 
       (.I0(snapshot_rd_event[39]),
        .I1(snapshot_rd_event[7]),
        .I2(snapshot_rd_event[71]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[103]),
        .O(\s_axi_rdata[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hABABABBBBBBBABBB)) 
    \s_axi_rdata[7]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata[7]_i_6_n_0 ),
        .I2(\s_axi_rdata_reg[4]_1 ),
        .I3(snapshot_trigger_index[7]),
        .I4(\s_axi_rdata_reg[4]_2 ),
        .I5(\s_axi_rdata_reg[31]_1 [7]),
        .O(\s_axi_rdata[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h22200020FFFFFFFF)) 
    \s_axi_rdata[7]_i_6 
       (.I0(s_axi_araddr[2]),
        .I1(s_axi_araddr[3]),
        .I2(snapshot_id[7]),
        .I3(s_axi_araddr[1]),
        .I4(snapshot_count[7]),
        .I5(\s_axi_rdata_reg[9] ),
        .O(\s_axi_rdata[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[8]_i_1 
       (.I0(\s_axi_rdata[8]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[8]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[8] ),
        .I5(\s_axi_rdata_reg[8]_0 ),
        .O(\s_axi_araddr[5] [8]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[8]_i_2 
       (.I0(snapshot_rd_event[40]),
        .I1(snapshot_rd_event[8]),
        .I2(snapshot_rd_event[72]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[104]),
        .O(\s_axi_rdata[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAEFAAAAAAAAAAAA)) 
    \s_axi_rdata[8]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[8]_1 ),
        .I2(\s_axi_rdata_reg[31]_1 [8]),
        .I3(s_axi_araddr[0]),
        .I4(s_axi_araddr[11]),
        .I5(\s_axi_rdata[8]_i_6_n_0 ),
        .O(\s_axi_rdata[8]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFF1DFFFF)) 
    \s_axi_rdata[8]_i_6 
       (.I0(snapshot_id[8]),
        .I1(s_axi_araddr[1]),
        .I2(Q),
        .I3(s_axi_araddr[3]),
        .I4(s_axi_araddr[2]),
        .O(\s_axi_rdata[8]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h4F4F4F4F4F444444)) 
    \s_axi_rdata[9]_i_1 
       (.I0(\s_axi_rdata[9]_i_2_n_0 ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(\s_axi_rdata[9]_i_3_n_0 ),
        .I3(s_axi_araddr[4]),
        .I4(\s_axi_rdata_reg[9]_0 ),
        .I5(\s_axi_rdata_reg[9]_1 ),
        .O(\s_axi_araddr[5] [9]));
  LUT6 #(
    .INIT(64'h00550F33FF550F33)) 
    \s_axi_rdata[9]_i_2 
       (.I0(snapshot_rd_event[41]),
        .I1(snapshot_rd_event[9]),
        .I2(snapshot_rd_event[73]),
        .I3(\s_axi_rdata_reg[0]_1 [1]),
        .I4(\s_axi_rdata_reg[0]_1 [0]),
        .I5(snapshot_rd_event[105]),
        .O(\s_axi_rdata[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEFAAAAAAEFAAEFAA)) 
    \s_axi_rdata[9]_i_3 
       (.I0(\s_axi_rdata[27]_i_3_n_0 ),
        .I1(\s_axi_rdata_reg[9]_2 ),
        .I2(snapshot_id[9]),
        .I3(\s_axi_rdata_reg[9] ),
        .I4(\s_axi_rdata_reg[8]_1 ),
        .I5(\s_axi_rdata_reg[31]_1 [9]),
        .O(\s_axi_rdata[9]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF0000F8FFF8F8)) 
    s_axi_rvalid_i_1
       (.I0(s_axi_arvalid),
        .I1(\snapshot_rd_index_reg[0] ),
        .I2(\s_axi_rdata[31]_i_6_n_0 ),
        .I3(s_axi_rready),
        .I4(s_axi_rvalid),
        .I5(snapshot_ready_reg_0),
        .O(s_axi_arvalid_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \snapshot_count[0]_i_1 
       (.I0(capture_count_reg__0[0]),
        .I1(capture_count_reg__0[8]),
        .O(\snapshot_count[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \snapshot_count[1]_i_1 
       (.I0(capture_count_reg__0[1]),
        .I1(capture_count_reg__0[8]),
        .I2(capture_count_reg__0[0]),
        .O(sel0[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hA6AA)) 
    \snapshot_count[2]_i_1 
       (.I0(capture_count_reg__0[2]),
        .I1(capture_count_reg__0[0]),
        .I2(capture_count_reg__0[8]),
        .I3(capture_count_reg__0[1]),
        .O(sel0[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hBFFF4000)) 
    \snapshot_count[3]_i_1 
       (.I0(capture_count_reg__0[8]),
        .I1(capture_count_reg__0[1]),
        .I2(capture_count_reg__0[2]),
        .I3(capture_count_reg__0[0]),
        .I4(capture_count_reg__0[3]),
        .O(sel0[3]));
  LUT6 #(
    .INIT(64'h9AAAAAAAAAAAAAAA)) 
    \snapshot_count[4]_i_1 
       (.I0(capture_count_reg__0[4]),
        .I1(capture_count_reg__0[8]),
        .I2(capture_count_reg__0[1]),
        .I3(capture_count_reg__0[2]),
        .I4(capture_count_reg__0[0]),
        .I5(capture_count_reg__0[3]),
        .O(sel0[4]));
  LUT3 #(
    .INIT(8'h6A)) 
    \snapshot_count[5]_i_1 
       (.I0(capture_count_reg__0[5]),
        .I1(\snapshot_count[7]_i_2_n_0 ),
        .I2(capture_count_reg__0[4]),
        .O(\snapshot_count[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \snapshot_count[6]_i_1 
       (.I0(capture_count_reg__0[6]),
        .I1(capture_count_reg__0[5]),
        .I2(capture_count_reg__0[4]),
        .I3(\snapshot_count[7]_i_2_n_0 ),
        .O(\snapshot_count[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \snapshot_count[7]_i_1 
       (.I0(capture_count_reg__0[7]),
        .I1(\snapshot_count[7]_i_2_n_0 ),
        .I2(capture_count_reg__0[4]),
        .I3(capture_count_reg__0[5]),
        .I4(capture_count_reg__0[6]),
        .O(sel0[7]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    \snapshot_count[7]_i_2 
       (.I0(capture_count_reg__0[3]),
        .I1(capture_count_reg__0[0]),
        .I2(capture_count_reg__0[2]),
        .I3(capture_count_reg__0[1]),
        .I4(capture_count_reg__0[8]),
        .O(\snapshot_count[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \snapshot_count[8]_i_1 
       (.I0(capture_active_reg_1),
        .I1(s_axi_aresetn),
        .O(\snapshot_count[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \snapshot_count[8]_i_2 
       (.I0(post_remaining),
        .I1(\post_remaining_reg_n_0_[3] ),
        .I2(\post_remaining_reg_n_0_[2] ),
        .I3(\post_remaining_reg_n_0_[4] ),
        .I4(\post_remaining_reg_n_0_[1] ),
        .I5(\post_remaining_reg_n_0_[0] ),
        .O(\snapshot_count[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hFFFF0080)) 
    \snapshot_count[8]_i_3 
       (.I0(capture_count_reg__0[1]),
        .I1(capture_count_reg__0[2]),
        .I2(capture_count_reg__0[0]),
        .I3(\snapshot_count[8]_i_4_n_0 ),
        .I4(capture_count_reg__0[8]),
        .O(sel0[8]));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \snapshot_count[8]_i_4 
       (.I0(capture_count_reg__0[7]),
        .I1(capture_count_reg__0[4]),
        .I2(capture_count_reg__0[6]),
        .I3(capture_count_reg__0[3]),
        .I4(capture_count_reg__0[5]),
        .O(\snapshot_count[8]_i_4_n_0 ));
  FDRE \snapshot_count_reg[0] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(\snapshot_count[0]_i_1_n_0 ),
        .Q(snapshot_count[0]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_count_reg[1] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(sel0[1]),
        .Q(snapshot_count[1]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_count_reg[2] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(sel0[2]),
        .Q(snapshot_count[2]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_count_reg[3] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(sel0[3]),
        .Q(snapshot_count[3]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_count_reg[4] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(sel0[4]),
        .Q(snapshot_count[4]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_count_reg[5] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(\snapshot_count[5]_i_1_n_0 ),
        .Q(snapshot_count[5]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_count_reg[6] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(\snapshot_count[6]_i_1_n_0 ),
        .Q(snapshot_count[6]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_count_reg[7] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(sel0[7]),
        .Q(snapshot_count[7]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_count_reg[8] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(sel0[8]),
        .Q(Q),
        .R(\snapshot_count[8]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \snapshot_id[0]_i_1 
       (.I0(\snapshot_count[8]_i_2_n_0 ),
        .I1(capture_active_reg_1),
        .O(\snapshot_id[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \snapshot_id[0]_i_3 
       (.I0(snapshot_id[0]),
        .O(\snapshot_id[0]_i_3_n_0 ));
  FDRE \snapshot_id_reg[0] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[0]_i_2_n_7 ),
        .Q(snapshot_id[0]),
        .R(clear));
  CARRY4 \snapshot_id_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\snapshot_id_reg[0]_i_2_n_0 ,\snapshot_id_reg[0]_i_2_n_1 ,\snapshot_id_reg[0]_i_2_n_2 ,\snapshot_id_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\snapshot_id_reg[0]_i_2_n_4 ,\snapshot_id_reg[0]_i_2_n_5 ,\snapshot_id_reg[0]_i_2_n_6 ,\snapshot_id_reg[0]_i_2_n_7 }),
        .S({snapshot_id[3:1],\snapshot_id[0]_i_3_n_0 }));
  FDRE \snapshot_id_reg[10] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[8]_i_1_n_5 ),
        .Q(snapshot_id[10]),
        .R(clear));
  FDRE \snapshot_id_reg[11] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[8]_i_1_n_4 ),
        .Q(snapshot_id[11]),
        .R(clear));
  FDRE \snapshot_id_reg[12] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[12]_i_1_n_7 ),
        .Q(snapshot_id[12]),
        .R(clear));
  CARRY4 \snapshot_id_reg[12]_i_1 
       (.CI(\snapshot_id_reg[8]_i_1_n_0 ),
        .CO({\snapshot_id_reg[12]_i_1_n_0 ,\snapshot_id_reg[12]_i_1_n_1 ,\snapshot_id_reg[12]_i_1_n_2 ,\snapshot_id_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\snapshot_id_reg[12]_i_1_n_4 ,\snapshot_id_reg[12]_i_1_n_5 ,\snapshot_id_reg[12]_i_1_n_6 ,\snapshot_id_reg[12]_i_1_n_7 }),
        .S(snapshot_id[15:12]));
  FDRE \snapshot_id_reg[13] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[12]_i_1_n_6 ),
        .Q(snapshot_id[13]),
        .R(clear));
  FDRE \snapshot_id_reg[14] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[12]_i_1_n_5 ),
        .Q(snapshot_id[14]),
        .R(clear));
  FDRE \snapshot_id_reg[15] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[12]_i_1_n_4 ),
        .Q(snapshot_id[15]),
        .R(clear));
  FDRE \snapshot_id_reg[16] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[16]_i_1_n_7 ),
        .Q(snapshot_id[16]),
        .R(clear));
  CARRY4 \snapshot_id_reg[16]_i_1 
       (.CI(\snapshot_id_reg[12]_i_1_n_0 ),
        .CO({\snapshot_id_reg[16]_i_1_n_0 ,\snapshot_id_reg[16]_i_1_n_1 ,\snapshot_id_reg[16]_i_1_n_2 ,\snapshot_id_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\snapshot_id_reg[16]_i_1_n_4 ,\snapshot_id_reg[16]_i_1_n_5 ,\snapshot_id_reg[16]_i_1_n_6 ,\snapshot_id_reg[16]_i_1_n_7 }),
        .S(snapshot_id[19:16]));
  FDRE \snapshot_id_reg[17] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[16]_i_1_n_6 ),
        .Q(snapshot_id[17]),
        .R(clear));
  FDRE \snapshot_id_reg[18] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[16]_i_1_n_5 ),
        .Q(snapshot_id[18]),
        .R(clear));
  FDRE \snapshot_id_reg[19] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[16]_i_1_n_4 ),
        .Q(snapshot_id[19]),
        .R(clear));
  FDRE \snapshot_id_reg[1] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[0]_i_2_n_6 ),
        .Q(snapshot_id[1]),
        .R(clear));
  FDRE \snapshot_id_reg[20] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[20]_i_1_n_7 ),
        .Q(snapshot_id[20]),
        .R(clear));
  CARRY4 \snapshot_id_reg[20]_i_1 
       (.CI(\snapshot_id_reg[16]_i_1_n_0 ),
        .CO({\snapshot_id_reg[20]_i_1_n_0 ,\snapshot_id_reg[20]_i_1_n_1 ,\snapshot_id_reg[20]_i_1_n_2 ,\snapshot_id_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\snapshot_id_reg[20]_i_1_n_4 ,\snapshot_id_reg[20]_i_1_n_5 ,\snapshot_id_reg[20]_i_1_n_6 ,\snapshot_id_reg[20]_i_1_n_7 }),
        .S(snapshot_id[23:20]));
  FDRE \snapshot_id_reg[21] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[20]_i_1_n_6 ),
        .Q(snapshot_id[21]),
        .R(clear));
  FDRE \snapshot_id_reg[22] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[20]_i_1_n_5 ),
        .Q(snapshot_id[22]),
        .R(clear));
  FDRE \snapshot_id_reg[23] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[20]_i_1_n_4 ),
        .Q(snapshot_id[23]),
        .R(clear));
  FDRE \snapshot_id_reg[24] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[24]_i_1_n_7 ),
        .Q(snapshot_id[24]),
        .R(clear));
  CARRY4 \snapshot_id_reg[24]_i_1 
       (.CI(\snapshot_id_reg[20]_i_1_n_0 ),
        .CO({\snapshot_id_reg[24]_i_1_n_0 ,\snapshot_id_reg[24]_i_1_n_1 ,\snapshot_id_reg[24]_i_1_n_2 ,\snapshot_id_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\snapshot_id_reg[24]_i_1_n_4 ,\snapshot_id_reg[24]_i_1_n_5 ,\snapshot_id_reg[24]_i_1_n_6 ,\snapshot_id_reg[24]_i_1_n_7 }),
        .S(snapshot_id[27:24]));
  FDRE \snapshot_id_reg[25] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[24]_i_1_n_6 ),
        .Q(snapshot_id[25]),
        .R(clear));
  FDRE \snapshot_id_reg[26] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[24]_i_1_n_5 ),
        .Q(snapshot_id[26]),
        .R(clear));
  FDRE \snapshot_id_reg[27] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[24]_i_1_n_4 ),
        .Q(snapshot_id[27]),
        .R(clear));
  FDRE \snapshot_id_reg[28] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[28]_i_1_n_7 ),
        .Q(snapshot_id[28]),
        .R(clear));
  CARRY4 \snapshot_id_reg[28]_i_1 
       (.CI(\snapshot_id_reg[24]_i_1_n_0 ),
        .CO({\NLW_snapshot_id_reg[28]_i_1_CO_UNCONNECTED [3],\snapshot_id_reg[28]_i_1_n_1 ,\snapshot_id_reg[28]_i_1_n_2 ,\snapshot_id_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\snapshot_id_reg[28]_i_1_n_4 ,\snapshot_id_reg[28]_i_1_n_5 ,\snapshot_id_reg[28]_i_1_n_6 ,\snapshot_id_reg[28]_i_1_n_7 }),
        .S(snapshot_id[31:28]));
  FDRE \snapshot_id_reg[29] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[28]_i_1_n_6 ),
        .Q(snapshot_id[29]),
        .R(clear));
  FDRE \snapshot_id_reg[2] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[0]_i_2_n_5 ),
        .Q(snapshot_id[2]),
        .R(clear));
  FDRE \snapshot_id_reg[30] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[28]_i_1_n_5 ),
        .Q(snapshot_id[30]),
        .R(clear));
  FDRE \snapshot_id_reg[31] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[28]_i_1_n_4 ),
        .Q(snapshot_id[31]),
        .R(clear));
  FDRE \snapshot_id_reg[3] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[0]_i_2_n_4 ),
        .Q(snapshot_id[3]),
        .R(clear));
  FDRE \snapshot_id_reg[4] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[4]_i_1_n_7 ),
        .Q(snapshot_id[4]),
        .R(clear));
  CARRY4 \snapshot_id_reg[4]_i_1 
       (.CI(\snapshot_id_reg[0]_i_2_n_0 ),
        .CO({\snapshot_id_reg[4]_i_1_n_0 ,\snapshot_id_reg[4]_i_1_n_1 ,\snapshot_id_reg[4]_i_1_n_2 ,\snapshot_id_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\snapshot_id_reg[4]_i_1_n_4 ,\snapshot_id_reg[4]_i_1_n_5 ,\snapshot_id_reg[4]_i_1_n_6 ,\snapshot_id_reg[4]_i_1_n_7 }),
        .S(snapshot_id[7:4]));
  FDRE \snapshot_id_reg[5] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[4]_i_1_n_6 ),
        .Q(snapshot_id[5]),
        .R(clear));
  FDRE \snapshot_id_reg[6] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[4]_i_1_n_5 ),
        .Q(snapshot_id[6]),
        .R(clear));
  FDRE \snapshot_id_reg[7] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[4]_i_1_n_4 ),
        .Q(snapshot_id[7]),
        .R(clear));
  FDRE \snapshot_id_reg[8] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[8]_i_1_n_7 ),
        .Q(snapshot_id[8]),
        .R(clear));
  CARRY4 \snapshot_id_reg[8]_i_1 
       (.CI(\snapshot_id_reg[4]_i_1_n_0 ),
        .CO({\snapshot_id_reg[8]_i_1_n_0 ,\snapshot_id_reg[8]_i_1_n_1 ,\snapshot_id_reg[8]_i_1_n_2 ,\snapshot_id_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\snapshot_id_reg[8]_i_1_n_4 ,\snapshot_id_reg[8]_i_1_n_5 ,\snapshot_id_reg[8]_i_1_n_6 ,\snapshot_id_reg[8]_i_1_n_7 }),
        .S(snapshot_id[11:8]));
  FDRE \snapshot_id_reg[9] 
       (.C(s_axi_aclk),
        .CE(\snapshot_id[0]_i_1_n_0 ),
        .D(\snapshot_id_reg[8]_i_1_n_6 ),
        .Q(snapshot_id[9]),
        .R(clear));
  LUT2 #(
    .INIT(4'h8)) 
    snapshot_rd_en_i_1
       (.I0(snapshot_ready_reg_0),
        .I1(s_axi_aresetn),
        .O(s_axi_aresetn_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h0010F010)) 
    snapshot_read_pending_i_1
       (.I0(snapshot_read_pending_i_2_n_0),
        .I1(\s_axi_rdata_reg[31] ),
        .I2(s_axi_aresetn),
        .I3(\s_axi_rdata_reg[0] ),
        .I4(snapshot_rd_valid),
        .O(s_axi_aresetn_1));
  LUT4 #(
    .INIT(16'h7FFF)) 
    snapshot_read_pending_i_2
       (.I0(s_axi_arvalid),
        .I1(\snapshot_rd_index_reg[0] ),
        .I2(snapshot_ready),
        .I3(CO),
        .O(snapshot_read_pending_i_2_n_0));
  LUT5 #(
    .INIT(32'h20302020)) 
    snapshot_ready_i_1
       (.I0(\snapshot_count[8]_i_2_n_0 ),
        .I1(capture_active_reg_1),
        .I2(s_axi_aresetn),
        .I3(snapshot_ready_reg_1),
        .I4(snapshot_ready),
        .O(snapshot_ready_i_1_n_0));
  FDRE snapshot_ready_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(snapshot_ready_i_1_n_0),
        .Q(snapshot_ready),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \snapshot_start[0]_i_1 
       (.I0(write_pointer_reg__0[0]),
        .I1(\snapshot_start[7]_i_3_n_0 ),
        .O(\snapshot_start[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \snapshot_start[1]_i_1 
       (.I0(write_pointer_reg__0[1]),
        .I1(write_pointer_reg__0[0]),
        .I2(\snapshot_start[7]_i_3_n_0 ),
        .O(\snapshot_start[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0078)) 
    \snapshot_start[2]_i_1 
       (.I0(write_pointer_reg__0[0]),
        .I1(write_pointer_reg__0[1]),
        .I2(write_pointer_reg__0[2]),
        .I3(\snapshot_start[7]_i_3_n_0 ),
        .O(\snapshot_start[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h00007F80)) 
    \snapshot_start[3]_i_1 
       (.I0(write_pointer_reg__0[2]),
        .I1(write_pointer_reg__0[1]),
        .I2(write_pointer_reg__0[0]),
        .I3(write_pointer_reg__0[3]),
        .I4(\snapshot_start[7]_i_3_n_0 ),
        .O(\snapshot_start[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000007FFF8000)) 
    \snapshot_start[4]_i_1 
       (.I0(write_pointer_reg__0[3]),
        .I1(write_pointer_reg__0[0]),
        .I2(write_pointer_reg__0[1]),
        .I3(write_pointer_reg__0[2]),
        .I4(write_pointer_reg__0[4]),
        .I5(\snapshot_start[7]_i_3_n_0 ),
        .O(\snapshot_start[4]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \snapshot_start[5]_i_1 
       (.I0(next_write_pointer[5]),
        .I1(\snapshot_start[7]_i_3_n_0 ),
        .O(\snapshot_start[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h06)) 
    \snapshot_start[6]_i_1 
       (.I0(\snapshot_start[7]_i_2_n_0 ),
        .I1(write_pointer_reg__0[6]),
        .I2(\snapshot_start[7]_i_3_n_0 ),
        .O(\snapshot_start[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h006A)) 
    \snapshot_start[7]_i_1 
       (.I0(write_pointer_reg__0[7]),
        .I1(\snapshot_start[7]_i_2_n_0 ),
        .I2(write_pointer_reg__0[6]),
        .I3(\snapshot_start[7]_i_3_n_0 ),
        .O(next_snapshot_start));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \snapshot_start[7]_i_2 
       (.I0(write_pointer_reg__0[5]),
        .I1(write_pointer_reg__0[3]),
        .I2(write_pointer_reg__0[0]),
        .I3(write_pointer_reg__0[1]),
        .I4(write_pointer_reg__0[2]),
        .I5(write_pointer_reg__0[4]),
        .O(\snapshot_start[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF7FFFFFFE)) 
    \snapshot_start[7]_i_3 
       (.I0(capture_count_reg__0[4]),
        .I1(\snapshot_count[7]_i_2_n_0 ),
        .I2(capture_count_reg__0[7]),
        .I3(capture_count_reg__0[5]),
        .I4(capture_count_reg__0[6]),
        .I5(\snapshot_start[7]_i_4_n_0 ),
        .O(\snapshot_start[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFEFFFF7FFEFF)) 
    \snapshot_start[7]_i_4 
       (.I0(capture_count_reg__0[3]),
        .I1(capture_count_reg__0[2]),
        .I2(capture_count_reg__0[0]),
        .I3(capture_count_reg__0[8]),
        .I4(capture_count_reg__0[1]),
        .I5(\snapshot_count[8]_i_4_n_0 ),
        .O(\snapshot_start[7]_i_4_n_0 ));
  FDRE \snapshot_start_reg[0] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(\snapshot_start[0]_i_1_n_0 ),
        .Q(\snapshot_start_reg_n_0_[0] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_start_reg[1] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(\snapshot_start[1]_i_1_n_0 ),
        .Q(\snapshot_start_reg_n_0_[1] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_start_reg[2] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(\snapshot_start[2]_i_1_n_0 ),
        .Q(\snapshot_start_reg_n_0_[2] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_start_reg[3] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(\snapshot_start[3]_i_1_n_0 ),
        .Q(\snapshot_start_reg_n_0_[3] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_start_reg[4] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(\snapshot_start[4]_i_1_n_0 ),
        .Q(\snapshot_start_reg_n_0_[4] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_start_reg[5] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(\snapshot_start[5]_i_1_n_0 ),
        .Q(\snapshot_start_reg_n_0_[5] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_start_reg[6] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(\snapshot_start[6]_i_1_n_0 ),
        .Q(\snapshot_start_reg_n_0_[6] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_start_reg[7] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(next_snapshot_start),
        .Q(\snapshot_start_reg_n_0_[7] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  CARRY4 snapshot_trigger_index0_carry
       (.CI(1'b0),
        .CO({snapshot_trigger_index0_carry_n_0,snapshot_trigger_index0_carry_n_1,snapshot_trigger_index0_carry_n_2,snapshot_trigger_index0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({\trigger_physical_index_reg_n_0_[3] ,\trigger_physical_index_reg_n_0_[2] ,\trigger_physical_index_reg_n_0_[1] ,\trigger_physical_index_reg_n_0_[0] }),
        .O(snapshot_trigger_index00_out[3:0]),
        .S({snapshot_trigger_index0_carry_i_1_n_0,snapshot_trigger_index0_carry_i_2_n_0,snapshot_trigger_index0_carry_i_3_n_0,snapshot_trigger_index0_carry_i_4_n_0}));
  CARRY4 snapshot_trigger_index0_carry__0
       (.CI(snapshot_trigger_index0_carry_n_0),
        .CO({NLW_snapshot_trigger_index0_carry__0_CO_UNCONNECTED[3],snapshot_trigger_index0_carry__0_n_1,snapshot_trigger_index0_carry__0_n_2,snapshot_trigger_index0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,\trigger_physical_index_reg_n_0_[6] ,\trigger_physical_index_reg_n_0_[5] ,\trigger_physical_index_reg_n_0_[4] }),
        .O(snapshot_trigger_index00_out[7:4]),
        .S({snapshot_trigger_index0_carry__0_i_1_n_0,snapshot_trigger_index0_carry__0_i_2_n_0,snapshot_trigger_index0_carry__0_i_3_n_0,snapshot_trigger_index0_carry__0_i_4_n_0}));
  LUT5 #(
    .INIT(32'h55556999)) 
    snapshot_trigger_index0_carry__0_i_1
       (.I0(\trigger_physical_index_reg_n_0_[7] ),
        .I1(write_pointer_reg__0[7]),
        .I2(\snapshot_start[7]_i_2_n_0 ),
        .I3(write_pointer_reg__0[6]),
        .I4(\snapshot_start[7]_i_3_n_0 ),
        .O(snapshot_trigger_index0_carry__0_i_1_n_0));
  LUT4 #(
    .INIT(16'h5665)) 
    snapshot_trigger_index0_carry__0_i_2
       (.I0(\trigger_physical_index_reg_n_0_[6] ),
        .I1(\snapshot_start[7]_i_3_n_0 ),
        .I2(write_pointer_reg__0[6]),
        .I3(\snapshot_start[7]_i_2_n_0 ),
        .O(snapshot_trigger_index0_carry__0_i_2_n_0));
  LUT3 #(
    .INIT(8'h65)) 
    snapshot_trigger_index0_carry__0_i_3
       (.I0(\trigger_physical_index_reg_n_0_[5] ),
        .I1(\snapshot_start[7]_i_3_n_0 ),
        .I2(next_write_pointer[5]),
        .O(snapshot_trigger_index0_carry__0_i_3_n_0));
  LUT3 #(
    .INIT(8'h65)) 
    snapshot_trigger_index0_carry__0_i_4
       (.I0(\trigger_physical_index_reg_n_0_[4] ),
        .I1(\snapshot_start[7]_i_3_n_0 ),
        .I2(next_write_pointer[4]),
        .O(snapshot_trigger_index0_carry__0_i_4_n_0));
  LUT6 #(
    .INIT(64'h5665656565656565)) 
    snapshot_trigger_index0_carry_i_1
       (.I0(\trigger_physical_index_reg_n_0_[3] ),
        .I1(\snapshot_start[7]_i_3_n_0 ),
        .I2(write_pointer_reg__0[3]),
        .I3(write_pointer_reg__0[0]),
        .I4(write_pointer_reg__0[1]),
        .I5(write_pointer_reg__0[2]),
        .O(snapshot_trigger_index0_carry_i_1_n_0));
  LUT5 #(
    .INIT(32'h56656565)) 
    snapshot_trigger_index0_carry_i_2
       (.I0(\trigger_physical_index_reg_n_0_[2] ),
        .I1(\snapshot_start[7]_i_3_n_0 ),
        .I2(write_pointer_reg__0[2]),
        .I3(write_pointer_reg__0[1]),
        .I4(write_pointer_reg__0[0]),
        .O(snapshot_trigger_index0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h5665)) 
    snapshot_trigger_index0_carry_i_3
       (.I0(\trigger_physical_index_reg_n_0_[1] ),
        .I1(\snapshot_start[7]_i_3_n_0 ),
        .I2(write_pointer_reg__0[0]),
        .I3(write_pointer_reg__0[1]),
        .O(snapshot_trigger_index0_carry_i_3_n_0));
  LUT3 #(
    .INIT(8'h56)) 
    snapshot_trigger_index0_carry_i_4
       (.I0(\trigger_physical_index_reg_n_0_[0] ),
        .I1(\snapshot_start[7]_i_3_n_0 ),
        .I2(write_pointer_reg__0[0]),
        .O(snapshot_trigger_index0_carry_i_4_n_0));
  FDRE \snapshot_trigger_index_reg[0] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(snapshot_trigger_index00_out[0]),
        .Q(snapshot_trigger_index[0]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_trigger_index_reg[1] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(snapshot_trigger_index00_out[1]),
        .Q(snapshot_trigger_index[1]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_trigger_index_reg[2] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(snapshot_trigger_index00_out[2]),
        .Q(snapshot_trigger_index[2]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_trigger_index_reg[3] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(snapshot_trigger_index00_out[3]),
        .Q(snapshot_trigger_index[3]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_trigger_index_reg[4] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(snapshot_trigger_index00_out[4]),
        .Q(snapshot_trigger_index[4]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_trigger_index_reg[5] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(snapshot_trigger_index00_out[5]),
        .Q(snapshot_trigger_index[5]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_trigger_index_reg[6] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(snapshot_trigger_index00_out[6]),
        .Q(snapshot_trigger_index[6]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \snapshot_trigger_index_reg[7] 
       (.C(s_axi_aclk),
        .CE(\snapshot_count[8]_i_2_n_0 ),
        .D(snapshot_trigger_index00_out[7]),
        .Q(snapshot_trigger_index[7]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    \snapshot_word_select[1]_i_1 
       (.I0(\s_axi_rdata_reg[31] ),
        .I1(\s_axi_rdata[31]_i_6_n_0 ),
        .I2(CO),
        .I3(snapshot_ready),
        .I4(\snapshot_rd_index_reg[0] ),
        .I5(s_axi_arvalid),
        .O(snapshot_ready_reg_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \timestamp_shadow[63]_i_1 
       (.I0(s_axi_araddr[0]),
        .I1(s_axi_araddr[10]),
        .I2(\timestamp_shadow_reg[32] ),
        .I3(s_axi_araddr[12]),
        .I4(s_axi_araddr[13]),
        .I5(\timestamp_shadow[63]_i_3_n_0 ),
        .O(\s_axi_araddr[0] ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFEFFFFF)) 
    \timestamp_shadow[63]_i_3 
       (.I0(s_axi_araddr[11]),
        .I1(s_axi_araddr[14]),
        .I2(s_axi_araddr[4]),
        .I3(s_axi_araddr[3]),
        .I4(\timestamp_shadow[63]_i_4_n_0 ),
        .I5(\timestamp_shadow_reg[32]_0 ),
        .O(\timestamp_shadow[63]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0888)) 
    \timestamp_shadow[63]_i_4 
       (.I0(s_axi_arvalid),
        .I1(\snapshot_rd_index_reg[0] ),
        .I2(\s_axi_rdata_reg[0] ),
        .I3(snapshot_rd_valid),
        .O(\timestamp_shadow[63]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00008A80)) 
    \trigger_physical_index[7]_i_1 
       (.I0(capture_active111_out),
        .I1(ext_evt_trigger),
        .I2(\dropped_count_reg_reg[0]_2 ),
        .I3(\post_remaining_reg[1]_0 ),
        .I4(trigger_seen_reg_n_0),
        .O(trigger_seen8_out));
  FDRE \trigger_physical_index_reg[0] 
       (.C(s_axi_aclk),
        .CE(trigger_seen8_out),
        .D(write_pointer_reg__0[0]),
        .Q(\trigger_physical_index_reg_n_0_[0] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \trigger_physical_index_reg[1] 
       (.C(s_axi_aclk),
        .CE(trigger_seen8_out),
        .D(write_pointer_reg__0[1]),
        .Q(\trigger_physical_index_reg_n_0_[1] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \trigger_physical_index_reg[2] 
       (.C(s_axi_aclk),
        .CE(trigger_seen8_out),
        .D(write_pointer_reg__0[2]),
        .Q(\trigger_physical_index_reg_n_0_[2] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \trigger_physical_index_reg[3] 
       (.C(s_axi_aclk),
        .CE(trigger_seen8_out),
        .D(write_pointer_reg__0[3]),
        .Q(\trigger_physical_index_reg_n_0_[3] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \trigger_physical_index_reg[4] 
       (.C(s_axi_aclk),
        .CE(trigger_seen8_out),
        .D(write_pointer_reg__0[4]),
        .Q(\trigger_physical_index_reg_n_0_[4] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \trigger_physical_index_reg[5] 
       (.C(s_axi_aclk),
        .CE(trigger_seen8_out),
        .D(write_pointer_reg__0[5]),
        .Q(\trigger_physical_index_reg_n_0_[5] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \trigger_physical_index_reg[6] 
       (.C(s_axi_aclk),
        .CE(trigger_seen8_out),
        .D(write_pointer_reg__0[6]),
        .Q(\trigger_physical_index_reg_n_0_[6] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \trigger_physical_index_reg[7] 
       (.C(s_axi_aclk),
        .CE(trigger_seen8_out),
        .D(write_pointer_reg__0[7]),
        .Q(\trigger_physical_index_reg_n_0_[7] ),
        .R(\snapshot_count[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EAEEEAAA)) 
    trigger_seen_i_1
       (.I0(trigger_seen_reg_n_0),
        .I1(capture_active111_out),
        .I2(ext_evt_trigger),
        .I3(\dropped_count_reg_reg[0]_2 ),
        .I4(\post_remaining_reg[1]_0 ),
        .I5(\snapshot_count[8]_i_1_n_0 ),
        .O(trigger_seen_i_1_n_0));
  FDRE trigger_seen_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(trigger_seen_i_1_n_0),
        .Q(trigger_seen_reg_n_0),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \write_pointer[0]_i_1 
       (.I0(write_pointer_reg__0[0]),
        .O(next_write_pointer[0]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \write_pointer[1]_i_1 
       (.I0(write_pointer_reg__0[0]),
        .I1(write_pointer_reg__0[1]),
        .O(next_write_pointer[1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \write_pointer[2]_i_1 
       (.I0(write_pointer_reg__0[2]),
        .I1(write_pointer_reg__0[1]),
        .I2(write_pointer_reg__0[0]),
        .O(next_write_pointer[2]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \write_pointer[3]_i_1 
       (.I0(write_pointer_reg__0[3]),
        .I1(write_pointer_reg__0[0]),
        .I2(write_pointer_reg__0[1]),
        .I3(write_pointer_reg__0[2]),
        .O(next_write_pointer[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \write_pointer[4]_i_1 
       (.I0(write_pointer_reg__0[4]),
        .I1(write_pointer_reg__0[2]),
        .I2(write_pointer_reg__0[1]),
        .I3(write_pointer_reg__0[0]),
        .I4(write_pointer_reg__0[3]),
        .O(next_write_pointer[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \write_pointer[5]_i_1 
       (.I0(write_pointer_reg__0[5]),
        .I1(write_pointer_reg__0[3]),
        .I2(write_pointer_reg__0[0]),
        .I3(write_pointer_reg__0[1]),
        .I4(write_pointer_reg__0[2]),
        .I5(write_pointer_reg__0[4]),
        .O(next_write_pointer[5]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \write_pointer[6]_i_1 
       (.I0(write_pointer_reg__0[6]),
        .I1(\snapshot_start[7]_i_2_n_0 ),
        .O(next_write_pointer[6]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \write_pointer[7]_i_1 
       (.I0(write_pointer_reg__0[7]),
        .I1(\snapshot_start[7]_i_2_n_0 ),
        .I2(write_pointer_reg__0[6]),
        .O(next_write_pointer[7]));
  FDRE \write_pointer_reg[0] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(next_write_pointer[0]),
        .Q(write_pointer_reg__0[0]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \write_pointer_reg[1] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(next_write_pointer[1]),
        .Q(write_pointer_reg__0[1]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \write_pointer_reg[2] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(next_write_pointer[2]),
        .Q(write_pointer_reg__0[2]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \write_pointer_reg[3] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(next_write_pointer[3]),
        .Q(write_pointer_reg__0[3]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \write_pointer_reg[4] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(next_write_pointer[4]),
        .Q(write_pointer_reg__0[4]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \write_pointer_reg[5] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(next_write_pointer[5]),
        .Q(write_pointer_reg__0[5]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \write_pointer_reg[6] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(next_write_pointer[6]),
        .Q(write_pointer_reg__0[6]),
        .R(\snapshot_count[8]_i_1_n_0 ));
  FDRE \write_pointer_reg[7] 
       (.C(s_axi_aclk),
        .CE(capture_active111_out),
        .D(next_write_pointer[7]),
        .Q(write_pointer_reg__0[7]),
        .R(\snapshot_count[8]_i_1_n_0 ));
endmodule

(* ORIG_REF_NAME = "multi_protocol_core" *) 
module multi_protocol_bd_multi_protocol_core_0_0_multi_protocol_core
   (s_axi_arready,
    led_heartbeat,
    s_axi_wready,
    s_axi_awready,
    led_ps_active,
    s_axi_rdata,
    ext_evt_ready,
    s_axi_bvalid_reg_0,
    s_axi_rvalid,
    s_axi_wdata,
    s_axi_aresetn,
    s_axi_wstrb,
    s_axi_arvalid,
    s_axi_araddr,
    s_axi_aclk,
    s_axi_awaddr,
    ext_evt_valid,
    s_axi_awvalid,
    s_axi_wvalid,
    ext_evt_trigger,
    ext_evt_data,
    ext_evt_dropped_count,
    s_axi_bready,
    s_axi_rready);
  output s_axi_arready;
  output led_heartbeat;
  output s_axi_wready;
  output s_axi_awready;
  output led_ps_active;
  output [31:0]s_axi_rdata;
  output ext_evt_ready;
  output s_axi_bvalid_reg_0;
  output s_axi_rvalid;
  input [31:0]s_axi_wdata;
  input s_axi_aresetn;
  input [3:0]s_axi_wstrb;
  input s_axi_arvalid;
  input [15:0]s_axi_araddr;
  input s_axi_aclk;
  input [15:0]s_axi_awaddr;
  input ext_evt_valid;
  input s_axi_awvalid;
  input s_axi_wvalid;
  input ext_evt_trigger;
  input [127:0]ext_evt_data;
  input [31:0]ext_evt_dropped_count;
  input s_axi_bready;
  input s_axi_rready;

  wire aw_hs;
  wire aw_pending;
  wire aw_pending_i_1_n_0;
  wire [15:0]awaddr_reg;
  wire capture_ack_pulse_i_1_n_0;
  wire capture_ack_pulse_reg_n_0;
  wire capture_arm_pulse_i_1_n_0;
  wire capture_arm_pulse_i_2_n_0;
  wire capture_arm_pulse_i_3_n_0;
  wire capture_arm_pulse_i_4_n_0;
  wire capture_arm_pulse_i_5_n_0;
  wire capture_arm_pulse_reg_n_0;
  wire capture_buffer_n_2;
  wire capture_buffer_n_3;
  wire capture_buffer_n_38;
  wire capture_buffer_n_39;
  wire capture_buffer_n_4;
  wire capture_buffer_n_40;
  wire capture_buffer_n_41;
  wire capture_buffer_n_42;
  wire capture_buffer_n_43;
  wire capture_buffer_n_44;
  wire capture_buffer_n_45;
  wire capture_buffer_n_46;
  wire capture_buffer_n_47;
  wire capture_buffer_n_48;
  wire capture_buffer_n_49;
  wire capture_buffer_n_50;
  wire capture_buffer_n_51;
  wire capture_buffer_n_52;
  wire capture_buffer_n_53;
  wire capture_buffer_n_54;
  wire capture_buffer_n_55;
  wire capture_buffer_n_56;
  wire capture_buffer_n_57;
  wire capture_buffer_n_58;
  wire capture_buffer_n_59;
  wire capture_buffer_n_60;
  wire capture_buffer_n_61;
  wire capture_buffer_n_62;
  wire capture_buffer_n_63;
  wire capture_buffer_n_64;
  wire capture_buffer_n_65;
  wire capture_buffer_n_66;
  wire capture_buffer_n_67;
  wire capture_buffer_n_68;
  wire capture_buffer_n_69;
  wire capture_buffer_n_70;
  wire capture_buffer_n_71;
  wire capture_buffer_n_72;
  wire capture_buffer_n_73;
  wire capture_buffer_n_74;
  wire capture_buffer_n_75;
  wire capture_buffer_n_76;
  wire capture_buffer_n_77;
  wire capture_buffer_n_78;
  wire capture_buffer_n_79;
  wire capture_buffer_n_80;
  wire capture_buffer_n_81;
  wire capture_buffer_n_82;
  wire [127:0]capture_event_data;
  wire clear;
  wire [25:1]data0;
  wire [31:0]data5;
  wire [31:0]dropped_count_reg;
  wire [31:0]dropped_count_reg0;
  wire [31:1]dropped_count_reg00_in;
  wire dropped_count_reg0_carry__0_n_0;
  wire dropped_count_reg0_carry__0_n_1;
  wire dropped_count_reg0_carry__0_n_2;
  wire dropped_count_reg0_carry__0_n_3;
  wire dropped_count_reg0_carry__1_n_0;
  wire dropped_count_reg0_carry__1_n_1;
  wire dropped_count_reg0_carry__1_n_2;
  wire dropped_count_reg0_carry__1_n_3;
  wire dropped_count_reg0_carry__2_n_0;
  wire dropped_count_reg0_carry__2_n_1;
  wire dropped_count_reg0_carry__2_n_2;
  wire dropped_count_reg0_carry__2_n_3;
  wire dropped_count_reg0_carry__3_n_0;
  wire dropped_count_reg0_carry__3_n_1;
  wire dropped_count_reg0_carry__3_n_2;
  wire dropped_count_reg0_carry__3_n_3;
  wire dropped_count_reg0_carry__4_n_0;
  wire dropped_count_reg0_carry__4_n_1;
  wire dropped_count_reg0_carry__4_n_2;
  wire dropped_count_reg0_carry__4_n_3;
  wire dropped_count_reg0_carry__5_n_0;
  wire dropped_count_reg0_carry__5_n_1;
  wire dropped_count_reg0_carry__5_n_2;
  wire dropped_count_reg0_carry__5_n_3;
  wire dropped_count_reg0_carry__6_n_1;
  wire dropped_count_reg0_carry__6_n_2;
  wire dropped_count_reg0_carry__6_n_3;
  wire dropped_count_reg0_carry_i_1_n_0;
  wire dropped_count_reg0_carry_n_0;
  wire dropped_count_reg0_carry_n_1;
  wire dropped_count_reg0_carry_n_2;
  wire dropped_count_reg0_carry_n_3;
  wire \dropped_count_reg0_inferred__0/i__carry__0_n_0 ;
  wire \dropped_count_reg0_inferred__0/i__carry__0_n_1 ;
  wire \dropped_count_reg0_inferred__0/i__carry__0_n_2 ;
  wire \dropped_count_reg0_inferred__0/i__carry__0_n_3 ;
  wire \dropped_count_reg0_inferred__0/i__carry__1_n_0 ;
  wire \dropped_count_reg0_inferred__0/i__carry__1_n_1 ;
  wire \dropped_count_reg0_inferred__0/i__carry__1_n_2 ;
  wire \dropped_count_reg0_inferred__0/i__carry__1_n_3 ;
  wire \dropped_count_reg0_inferred__0/i__carry__2_n_0 ;
  wire \dropped_count_reg0_inferred__0/i__carry__2_n_1 ;
  wire \dropped_count_reg0_inferred__0/i__carry__2_n_2 ;
  wire \dropped_count_reg0_inferred__0/i__carry__2_n_3 ;
  wire \dropped_count_reg0_inferred__0/i__carry__3_n_0 ;
  wire \dropped_count_reg0_inferred__0/i__carry__3_n_1 ;
  wire \dropped_count_reg0_inferred__0/i__carry__3_n_2 ;
  wire \dropped_count_reg0_inferred__0/i__carry__3_n_3 ;
  wire \dropped_count_reg0_inferred__0/i__carry__4_n_0 ;
  wire \dropped_count_reg0_inferred__0/i__carry__4_n_1 ;
  wire \dropped_count_reg0_inferred__0/i__carry__4_n_2 ;
  wire \dropped_count_reg0_inferred__0/i__carry__4_n_3 ;
  wire \dropped_count_reg0_inferred__0/i__carry__5_n_0 ;
  wire \dropped_count_reg0_inferred__0/i__carry__5_n_1 ;
  wire \dropped_count_reg0_inferred__0/i__carry__5_n_2 ;
  wire \dropped_count_reg0_inferred__0/i__carry__5_n_3 ;
  wire \dropped_count_reg0_inferred__0/i__carry__6_n_2 ;
  wire \dropped_count_reg0_inferred__0/i__carry__6_n_3 ;
  wire \dropped_count_reg0_inferred__0/i__carry_n_0 ;
  wire \dropped_count_reg0_inferred__0/i__carry_n_1 ;
  wire \dropped_count_reg0_inferred__0/i__carry_n_2 ;
  wire \dropped_count_reg0_inferred__0/i__carry_n_3 ;
  wire \dropped_count_reg[31]_i_10_n_0 ;
  wire \dropped_count_reg[31]_i_11_n_0 ;
  wire \dropped_count_reg[31]_i_1_n_0 ;
  wire \dropped_count_reg[31]_i_4_n_0 ;
  wire \dropped_count_reg[31]_i_5_n_0 ;
  wire \dropped_count_reg[31]_i_8_n_0 ;
  wire \dropped_count_reg[31]_i_9_n_0 ;
  wire event_arbiter_n_0;
  wire event_arbiter_n_10;
  wire event_arbiter_n_11;
  wire event_arbiter_n_12;
  wire event_arbiter_n_13;
  wire event_arbiter_n_14;
  wire event_arbiter_n_149;
  wire event_arbiter_n_150;
  wire event_arbiter_n_151;
  wire event_arbiter_n_152;
  wire event_arbiter_n_153;
  wire event_arbiter_n_154;
  wire event_arbiter_n_155;
  wire event_arbiter_n_156;
  wire event_arbiter_n_157;
  wire event_arbiter_n_158;
  wire event_arbiter_n_159;
  wire event_arbiter_n_16;
  wire event_arbiter_n_160;
  wire event_arbiter_n_161;
  wire event_arbiter_n_162;
  wire event_arbiter_n_163;
  wire event_arbiter_n_164;
  wire event_arbiter_n_165;
  wire event_arbiter_n_166;
  wire event_arbiter_n_167;
  wire event_arbiter_n_168;
  wire event_arbiter_n_169;
  wire event_arbiter_n_17;
  wire event_arbiter_n_170;
  wire event_arbiter_n_171;
  wire event_arbiter_n_172;
  wire event_arbiter_n_173;
  wire event_arbiter_n_174;
  wire event_arbiter_n_175;
  wire event_arbiter_n_176;
  wire event_arbiter_n_177;
  wire event_arbiter_n_178;
  wire event_arbiter_n_179;
  wire event_arbiter_n_18;
  wire event_arbiter_n_180;
  wire event_arbiter_n_181;
  wire event_arbiter_n_19;
  wire event_arbiter_n_3;
  wire event_arbiter_n_5;
  wire event_arbiter_n_6;
  wire event_arbiter_n_7;
  wire event_arbiter_n_8;
  wire event_arbiter_n_9;
  wire [127:0]ext_evt_data;
  wire [31:0]ext_evt_dropped_count;
  wire ext_evt_ready;
  wire ext_evt_trigger;
  wire ext_evt_valid;
  wire [25:0]heartbeat_counter;
  wire heartbeat_counter0_carry__0_n_0;
  wire heartbeat_counter0_carry__0_n_1;
  wire heartbeat_counter0_carry__0_n_2;
  wire heartbeat_counter0_carry__0_n_3;
  wire heartbeat_counter0_carry__1_n_0;
  wire heartbeat_counter0_carry__1_n_1;
  wire heartbeat_counter0_carry__1_n_2;
  wire heartbeat_counter0_carry__1_n_3;
  wire heartbeat_counter0_carry__2_n_0;
  wire heartbeat_counter0_carry__2_n_1;
  wire heartbeat_counter0_carry__2_n_2;
  wire heartbeat_counter0_carry__2_n_3;
  wire heartbeat_counter0_carry__3_n_0;
  wire heartbeat_counter0_carry__3_n_1;
  wire heartbeat_counter0_carry__3_n_2;
  wire heartbeat_counter0_carry__3_n_3;
  wire heartbeat_counter0_carry__4_n_0;
  wire heartbeat_counter0_carry__4_n_1;
  wire heartbeat_counter0_carry__4_n_2;
  wire heartbeat_counter0_carry__4_n_3;
  wire heartbeat_counter0_carry_n_0;
  wire heartbeat_counter0_carry_n_1;
  wire heartbeat_counter0_carry_n_2;
  wire heartbeat_counter0_carry_n_3;
  wire \heartbeat_counter_reg_n_0_[0] ;
  wire \heartbeat_counter_reg_n_0_[10] ;
  wire \heartbeat_counter_reg_n_0_[11] ;
  wire \heartbeat_counter_reg_n_0_[12] ;
  wire \heartbeat_counter_reg_n_0_[13] ;
  wire \heartbeat_counter_reg_n_0_[14] ;
  wire \heartbeat_counter_reg_n_0_[15] ;
  wire \heartbeat_counter_reg_n_0_[16] ;
  wire \heartbeat_counter_reg_n_0_[17] ;
  wire \heartbeat_counter_reg_n_0_[18] ;
  wire \heartbeat_counter_reg_n_0_[19] ;
  wire \heartbeat_counter_reg_n_0_[1] ;
  wire \heartbeat_counter_reg_n_0_[20] ;
  wire \heartbeat_counter_reg_n_0_[21] ;
  wire \heartbeat_counter_reg_n_0_[22] ;
  wire \heartbeat_counter_reg_n_0_[23] ;
  wire \heartbeat_counter_reg_n_0_[24] ;
  wire \heartbeat_counter_reg_n_0_[25] ;
  wire \heartbeat_counter_reg_n_0_[2] ;
  wire \heartbeat_counter_reg_n_0_[3] ;
  wire \heartbeat_counter_reg_n_0_[4] ;
  wire \heartbeat_counter_reg_n_0_[5] ;
  wire \heartbeat_counter_reg_n_0_[6] ;
  wire \heartbeat_counter_reg_n_0_[7] ;
  wire \heartbeat_counter_reg_n_0_[8] ;
  wire \heartbeat_counter_reg_n_0_[9] ;
  wire heartbeat_state_i_1_n_0;
  wire heartbeat_state_i_2_n_0;
  wire heartbeat_state_i_3_n_0;
  wire heartbeat_state_i_4_n_0;
  wire heartbeat_state_i_5_n_0;
  wire heartbeat_state_i_6_n_0;
  wire heartbeat_state_i_7_n_0;
  wire heartbeat_state_i_8_n_0;
  wire [31:0]io_mode_reg;
  wire \io_mode_reg[15]_i_1_n_0 ;
  wire \io_mode_reg[23]_i_1_n_0 ;
  wire \io_mode_reg[31]_i_1_n_0 ;
  wire \io_mode_reg[7]_i_1_n_0 ;
  wire [31:0]irq_enable_reg;
  wire \irq_enable_reg[15]_i_1_n_0 ;
  wire \irq_enable_reg[23]_i_1_n_0 ;
  wire \irq_enable_reg[31]_i_1_n_0 ;
  wire \irq_enable_reg[31]_i_2_n_0 ;
  wire \irq_enable_reg[31]_i_3_n_0 ;
  wire \irq_enable_reg[7]_i_1_n_0 ;
  wire [31:1]led_ctrl_reg;
  wire \led_ctrl_reg[0]_i_10_n_0 ;
  wire \led_ctrl_reg[0]_i_11_n_0 ;
  wire \led_ctrl_reg[0]_i_12_n_0 ;
  wire \led_ctrl_reg[0]_i_13_n_0 ;
  wire \led_ctrl_reg[0]_i_1_n_0 ;
  wire \led_ctrl_reg[0]_i_3_n_0 ;
  wire \led_ctrl_reg[0]_i_4_n_0 ;
  wire \led_ctrl_reg[0]_i_5_n_0 ;
  wire \led_ctrl_reg[0]_i_6_n_0 ;
  wire \led_ctrl_reg[0]_i_7_n_0 ;
  wire \led_ctrl_reg[0]_i_8_n_0 ;
  wire \led_ctrl_reg[0]_i_9_n_0 ;
  wire \led_ctrl_reg[10]_i_1_n_0 ;
  wire \led_ctrl_reg[11]_i_1_n_0 ;
  wire \led_ctrl_reg[12]_i_1_n_0 ;
  wire \led_ctrl_reg[13]_i_1_n_0 ;
  wire \led_ctrl_reg[14]_i_1_n_0 ;
  wire \led_ctrl_reg[15]_i_1_n_0 ;
  wire \led_ctrl_reg[15]_i_2_n_0 ;
  wire \led_ctrl_reg[15]_i_3_n_0 ;
  wire \led_ctrl_reg[16]_i_1_n_0 ;
  wire \led_ctrl_reg[17]_i_1_n_0 ;
  wire \led_ctrl_reg[18]_i_1_n_0 ;
  wire \led_ctrl_reg[19]_i_1_n_0 ;
  wire \led_ctrl_reg[20]_i_1_n_0 ;
  wire \led_ctrl_reg[21]_i_1_n_0 ;
  wire \led_ctrl_reg[22]_i_1_n_0 ;
  wire \led_ctrl_reg[23]_i_1_n_0 ;
  wire \led_ctrl_reg[23]_i_2_n_0 ;
  wire \led_ctrl_reg[23]_i_3_n_0 ;
  wire \led_ctrl_reg[24]_i_1_n_0 ;
  wire \led_ctrl_reg[25]_i_1_n_0 ;
  wire \led_ctrl_reg[26]_i_1_n_0 ;
  wire \led_ctrl_reg[27]_i_1_n_0 ;
  wire \led_ctrl_reg[28]_i_1_n_0 ;
  wire \led_ctrl_reg[29]_i_1_n_0 ;
  wire \led_ctrl_reg[30]_i_1_n_0 ;
  wire \led_ctrl_reg[31]_i_1_n_0 ;
  wire \led_ctrl_reg[31]_i_3_n_0 ;
  wire \led_ctrl_reg[3]_i_1_n_0 ;
  wire \led_ctrl_reg[4]_i_1_n_0 ;
  wire \led_ctrl_reg[5]_i_1_n_0 ;
  wire \led_ctrl_reg[6]_i_1_n_0 ;
  wire \led_ctrl_reg[7]_i_1_n_0 ;
  wire \led_ctrl_reg[8]_i_1_n_0 ;
  wire \led_ctrl_reg[9]_i_1_n_0 ;
  wire led_heartbeat;
  wire led_ps_active;
  wire p_0_in10_in;
  wire p_0_in13_in;
  wire p_0_in15_in;
  wire [31:7]p_1_in__0;
  wire [31:0]p_2_in__0;
  wire p_3_in;
  wire s_axi_aclk;
  wire [15:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arready0;
  wire s_axi_arvalid;
  wire [15:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awready0;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid_i_1_n_0;
  wire s_axi_bvalid_reg_0;
  wire [31:0]s_axi_rdata;
  wire s_axi_rdata2;
  wire s_axi_rdata2_carry_n_0;
  wire s_axi_rdata2_carry_n_1;
  wire s_axi_rdata2_carry_n_2;
  wire s_axi_rdata2_carry_n_3;
  wire \s_axi_rdata[0]_i_7_n_0 ;
  wire \s_axi_rdata[0]_i_8_n_0 ;
  wire \s_axi_rdata[10]_i_5_n_0 ;
  wire \s_axi_rdata[10]_i_6_n_0 ;
  wire \s_axi_rdata[11]_i_5_n_0 ;
  wire \s_axi_rdata[11]_i_6_n_0 ;
  wire \s_axi_rdata[12]_i_6_n_0 ;
  wire \s_axi_rdata[12]_i_7_n_0 ;
  wire \s_axi_rdata[13]_i_5_n_0 ;
  wire \s_axi_rdata[13]_i_6_n_0 ;
  wire \s_axi_rdata[14]_i_5_n_0 ;
  wire \s_axi_rdata[14]_i_6_n_0 ;
  wire \s_axi_rdata[15]_i_5_n_0 ;
  wire \s_axi_rdata[15]_i_6_n_0 ;
  wire \s_axi_rdata[16]_i_5_n_0 ;
  wire \s_axi_rdata[16]_i_7_n_0 ;
  wire \s_axi_rdata[17]_i_5_n_0 ;
  wire \s_axi_rdata[17]_i_6_n_0 ;
  wire \s_axi_rdata[18]_i_5_n_0 ;
  wire \s_axi_rdata[18]_i_6_n_0 ;
  wire \s_axi_rdata[19]_i_5_n_0 ;
  wire \s_axi_rdata[19]_i_6_n_0 ;
  wire \s_axi_rdata[1]_i_7_n_0 ;
  wire \s_axi_rdata[1]_i_8_n_0 ;
  wire \s_axi_rdata[20]_i_6_n_0 ;
  wire \s_axi_rdata[20]_i_7_n_0 ;
  wire \s_axi_rdata[21]_i_5_n_0 ;
  wire \s_axi_rdata[21]_i_6_n_0 ;
  wire \s_axi_rdata[22]_i_6_n_0 ;
  wire \s_axi_rdata[22]_i_7_n_0 ;
  wire \s_axi_rdata[23]_i_5_n_0 ;
  wire \s_axi_rdata[23]_i_6_n_0 ;
  wire \s_axi_rdata[24]_i_5_n_0 ;
  wire \s_axi_rdata[24]_i_6_n_0 ;
  wire \s_axi_rdata[25]_i_5_n_0 ;
  wire \s_axi_rdata[25]_i_6_n_0 ;
  wire \s_axi_rdata[26]_i_6_n_0 ;
  wire \s_axi_rdata[26]_i_7_n_0 ;
  wire \s_axi_rdata[27]_i_10_n_0 ;
  wire \s_axi_rdata[27]_i_7_n_0 ;
  wire \s_axi_rdata[27]_i_9_n_0 ;
  wire \s_axi_rdata[28]_i_5_n_0 ;
  wire \s_axi_rdata[28]_i_6_n_0 ;
  wire \s_axi_rdata[29]_i_5_n_0 ;
  wire \s_axi_rdata[29]_i_6_n_0 ;
  wire \s_axi_rdata[29]_i_8_n_0 ;
  wire \s_axi_rdata[29]_i_9_n_0 ;
  wire \s_axi_rdata[2]_i_7_n_0 ;
  wire \s_axi_rdata[2]_i_8_n_0 ;
  wire \s_axi_rdata[30]_i_5_n_0 ;
  wire \s_axi_rdata[30]_i_6_n_0 ;
  wire \s_axi_rdata[30]_i_8_n_0 ;
  wire \s_axi_rdata[30]_i_9_n_0 ;
  wire \s_axi_rdata[31]_i_10_n_0 ;
  wire \s_axi_rdata[31]_i_11_n_0 ;
  wire \s_axi_rdata[31]_i_12_n_0 ;
  wire \s_axi_rdata[31]_i_13_n_0 ;
  wire \s_axi_rdata[31]_i_14_n_0 ;
  wire \s_axi_rdata[31]_i_16_n_0 ;
  wire \s_axi_rdata[31]_i_4_n_0 ;
  wire \s_axi_rdata[31]_i_5_n_0 ;
  wire \s_axi_rdata[3]_i_10_n_0 ;
  wire \s_axi_rdata[3]_i_11_n_0 ;
  wire \s_axi_rdata[3]_i_12_n_0 ;
  wire \s_axi_rdata[3]_i_13_n_0 ;
  wire \s_axi_rdata[3]_i_14_n_0 ;
  wire \s_axi_rdata[3]_i_15_n_0 ;
  wire \s_axi_rdata[3]_i_16_n_0 ;
  wire \s_axi_rdata[3]_i_17_n_0 ;
  wire \s_axi_rdata[3]_i_18_n_0 ;
  wire \s_axi_rdata[3]_i_19_n_0 ;
  wire \s_axi_rdata[3]_i_20_n_0 ;
  wire \s_axi_rdata[3]_i_21_n_0 ;
  wire \s_axi_rdata[3]_i_22_n_0 ;
  wire \s_axi_rdata[3]_i_23_n_0 ;
  wire \s_axi_rdata[3]_i_24_n_0 ;
  wire \s_axi_rdata[3]_i_25_n_0 ;
  wire \s_axi_rdata[3]_i_26_n_0 ;
  wire \s_axi_rdata[3]_i_27_n_0 ;
  wire \s_axi_rdata[3]_i_28_n_0 ;
  wire \s_axi_rdata[3]_i_29_n_0 ;
  wire \s_axi_rdata[3]_i_6_n_0 ;
  wire \s_axi_rdata[3]_i_7_n_0 ;
  wire \s_axi_rdata[4]_i_5_n_0 ;
  wire \s_axi_rdata[4]_i_7_n_0 ;
  wire \s_axi_rdata[5]_i_5_n_0 ;
  wire \s_axi_rdata[5]_i_7_n_0 ;
  wire \s_axi_rdata[6]_i_7_n_0 ;
  wire \s_axi_rdata[6]_i_8_n_0 ;
  wire \s_axi_rdata[7]_i_5_n_0 ;
  wire \s_axi_rdata[7]_i_7_n_0 ;
  wire \s_axi_rdata[7]_i_8_n_0 ;
  wire \s_axi_rdata[7]_i_9_n_0 ;
  wire \s_axi_rdata[8]_i_5_n_0 ;
  wire \s_axi_rdata[8]_i_7_n_0 ;
  wire \s_axi_rdata[9]_i_5_n_0 ;
  wire \s_axi_rdata[9]_i_6_n_0 ;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire s_axi_wready0;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire [31:0]scratch_reg;
  wire \scratch_reg[15]_i_1_n_0 ;
  wire \scratch_reg[23]_i_1_n_0 ;
  wire \scratch_reg[31]_i_1_n_0 ;
  wire \scratch_reg[31]_i_2_n_0 ;
  wire \scratch_reg[31]_i_3_n_0 ;
  wire \scratch_reg[31]_i_4_n_0 ;
  wire \scratch_reg[31]_i_5_n_0 ;
  wire \scratch_reg[31]_i_6_n_0 ;
  wire \scratch_reg[31]_i_7_n_0 ;
  wire \scratch_reg[7]_i_1_n_0 ;
  wire [8:8]snapshot_count;
  wire snapshot_rd_en;
  wire snapshot_rd_index;
  wire \snapshot_rd_index_reg_n_0_[0] ;
  wire \snapshot_rd_index_reg_n_0_[1] ;
  wire \snapshot_rd_index_reg_n_0_[2] ;
  wire \snapshot_rd_index_reg_n_0_[3] ;
  wire \snapshot_rd_index_reg_n_0_[4] ;
  wire \snapshot_rd_index_reg_n_0_[5] ;
  wire \snapshot_rd_index_reg_n_0_[6] ;
  wire \snapshot_rd_index_reg_n_0_[7] ;
  wire snapshot_read_pending_reg_n_0;
  wire [1:0]snapshot_word_select;
  wire [31:0]sys_ctrl_reg;
  wire \sys_ctrl_reg[31]_i_2_n_0 ;
  wire \sys_ctrl_reg[31]_i_3_n_0 ;
  wire \timestamp_counter[0]_i_2_n_0 ;
  wire [63:0]timestamp_counter_reg;
  wire \timestamp_counter_reg[0]_i_1_n_0 ;
  wire \timestamp_counter_reg[0]_i_1_n_1 ;
  wire \timestamp_counter_reg[0]_i_1_n_2 ;
  wire \timestamp_counter_reg[0]_i_1_n_3 ;
  wire \timestamp_counter_reg[0]_i_1_n_4 ;
  wire \timestamp_counter_reg[0]_i_1_n_5 ;
  wire \timestamp_counter_reg[0]_i_1_n_6 ;
  wire \timestamp_counter_reg[0]_i_1_n_7 ;
  wire \timestamp_counter_reg[12]_i_1_n_0 ;
  wire \timestamp_counter_reg[12]_i_1_n_1 ;
  wire \timestamp_counter_reg[12]_i_1_n_2 ;
  wire \timestamp_counter_reg[12]_i_1_n_3 ;
  wire \timestamp_counter_reg[12]_i_1_n_4 ;
  wire \timestamp_counter_reg[12]_i_1_n_5 ;
  wire \timestamp_counter_reg[12]_i_1_n_6 ;
  wire \timestamp_counter_reg[12]_i_1_n_7 ;
  wire \timestamp_counter_reg[16]_i_1_n_0 ;
  wire \timestamp_counter_reg[16]_i_1_n_1 ;
  wire \timestamp_counter_reg[16]_i_1_n_2 ;
  wire \timestamp_counter_reg[16]_i_1_n_3 ;
  wire \timestamp_counter_reg[16]_i_1_n_4 ;
  wire \timestamp_counter_reg[16]_i_1_n_5 ;
  wire \timestamp_counter_reg[16]_i_1_n_6 ;
  wire \timestamp_counter_reg[16]_i_1_n_7 ;
  wire \timestamp_counter_reg[20]_i_1_n_0 ;
  wire \timestamp_counter_reg[20]_i_1_n_1 ;
  wire \timestamp_counter_reg[20]_i_1_n_2 ;
  wire \timestamp_counter_reg[20]_i_1_n_3 ;
  wire \timestamp_counter_reg[20]_i_1_n_4 ;
  wire \timestamp_counter_reg[20]_i_1_n_5 ;
  wire \timestamp_counter_reg[20]_i_1_n_6 ;
  wire \timestamp_counter_reg[20]_i_1_n_7 ;
  wire \timestamp_counter_reg[24]_i_1_n_0 ;
  wire \timestamp_counter_reg[24]_i_1_n_1 ;
  wire \timestamp_counter_reg[24]_i_1_n_2 ;
  wire \timestamp_counter_reg[24]_i_1_n_3 ;
  wire \timestamp_counter_reg[24]_i_1_n_4 ;
  wire \timestamp_counter_reg[24]_i_1_n_5 ;
  wire \timestamp_counter_reg[24]_i_1_n_6 ;
  wire \timestamp_counter_reg[24]_i_1_n_7 ;
  wire \timestamp_counter_reg[28]_i_1_n_0 ;
  wire \timestamp_counter_reg[28]_i_1_n_1 ;
  wire \timestamp_counter_reg[28]_i_1_n_2 ;
  wire \timestamp_counter_reg[28]_i_1_n_3 ;
  wire \timestamp_counter_reg[28]_i_1_n_4 ;
  wire \timestamp_counter_reg[28]_i_1_n_5 ;
  wire \timestamp_counter_reg[28]_i_1_n_6 ;
  wire \timestamp_counter_reg[28]_i_1_n_7 ;
  wire \timestamp_counter_reg[32]_i_1_n_0 ;
  wire \timestamp_counter_reg[32]_i_1_n_1 ;
  wire \timestamp_counter_reg[32]_i_1_n_2 ;
  wire \timestamp_counter_reg[32]_i_1_n_3 ;
  wire \timestamp_counter_reg[32]_i_1_n_4 ;
  wire \timestamp_counter_reg[32]_i_1_n_5 ;
  wire \timestamp_counter_reg[32]_i_1_n_6 ;
  wire \timestamp_counter_reg[32]_i_1_n_7 ;
  wire \timestamp_counter_reg[36]_i_1_n_0 ;
  wire \timestamp_counter_reg[36]_i_1_n_1 ;
  wire \timestamp_counter_reg[36]_i_1_n_2 ;
  wire \timestamp_counter_reg[36]_i_1_n_3 ;
  wire \timestamp_counter_reg[36]_i_1_n_4 ;
  wire \timestamp_counter_reg[36]_i_1_n_5 ;
  wire \timestamp_counter_reg[36]_i_1_n_6 ;
  wire \timestamp_counter_reg[36]_i_1_n_7 ;
  wire \timestamp_counter_reg[40]_i_1_n_0 ;
  wire \timestamp_counter_reg[40]_i_1_n_1 ;
  wire \timestamp_counter_reg[40]_i_1_n_2 ;
  wire \timestamp_counter_reg[40]_i_1_n_3 ;
  wire \timestamp_counter_reg[40]_i_1_n_4 ;
  wire \timestamp_counter_reg[40]_i_1_n_5 ;
  wire \timestamp_counter_reg[40]_i_1_n_6 ;
  wire \timestamp_counter_reg[40]_i_1_n_7 ;
  wire \timestamp_counter_reg[44]_i_1_n_0 ;
  wire \timestamp_counter_reg[44]_i_1_n_1 ;
  wire \timestamp_counter_reg[44]_i_1_n_2 ;
  wire \timestamp_counter_reg[44]_i_1_n_3 ;
  wire \timestamp_counter_reg[44]_i_1_n_4 ;
  wire \timestamp_counter_reg[44]_i_1_n_5 ;
  wire \timestamp_counter_reg[44]_i_1_n_6 ;
  wire \timestamp_counter_reg[44]_i_1_n_7 ;
  wire \timestamp_counter_reg[48]_i_1_n_0 ;
  wire \timestamp_counter_reg[48]_i_1_n_1 ;
  wire \timestamp_counter_reg[48]_i_1_n_2 ;
  wire \timestamp_counter_reg[48]_i_1_n_3 ;
  wire \timestamp_counter_reg[48]_i_1_n_4 ;
  wire \timestamp_counter_reg[48]_i_1_n_5 ;
  wire \timestamp_counter_reg[48]_i_1_n_6 ;
  wire \timestamp_counter_reg[48]_i_1_n_7 ;
  wire \timestamp_counter_reg[4]_i_1_n_0 ;
  wire \timestamp_counter_reg[4]_i_1_n_1 ;
  wire \timestamp_counter_reg[4]_i_1_n_2 ;
  wire \timestamp_counter_reg[4]_i_1_n_3 ;
  wire \timestamp_counter_reg[4]_i_1_n_4 ;
  wire \timestamp_counter_reg[4]_i_1_n_5 ;
  wire \timestamp_counter_reg[4]_i_1_n_6 ;
  wire \timestamp_counter_reg[4]_i_1_n_7 ;
  wire \timestamp_counter_reg[52]_i_1_n_0 ;
  wire \timestamp_counter_reg[52]_i_1_n_1 ;
  wire \timestamp_counter_reg[52]_i_1_n_2 ;
  wire \timestamp_counter_reg[52]_i_1_n_3 ;
  wire \timestamp_counter_reg[52]_i_1_n_4 ;
  wire \timestamp_counter_reg[52]_i_1_n_5 ;
  wire \timestamp_counter_reg[52]_i_1_n_6 ;
  wire \timestamp_counter_reg[52]_i_1_n_7 ;
  wire \timestamp_counter_reg[56]_i_1_n_0 ;
  wire \timestamp_counter_reg[56]_i_1_n_1 ;
  wire \timestamp_counter_reg[56]_i_1_n_2 ;
  wire \timestamp_counter_reg[56]_i_1_n_3 ;
  wire \timestamp_counter_reg[56]_i_1_n_4 ;
  wire \timestamp_counter_reg[56]_i_1_n_5 ;
  wire \timestamp_counter_reg[56]_i_1_n_6 ;
  wire \timestamp_counter_reg[56]_i_1_n_7 ;
  wire \timestamp_counter_reg[60]_i_1_n_1 ;
  wire \timestamp_counter_reg[60]_i_1_n_2 ;
  wire \timestamp_counter_reg[60]_i_1_n_3 ;
  wire \timestamp_counter_reg[60]_i_1_n_4 ;
  wire \timestamp_counter_reg[60]_i_1_n_5 ;
  wire \timestamp_counter_reg[60]_i_1_n_6 ;
  wire \timestamp_counter_reg[60]_i_1_n_7 ;
  wire \timestamp_counter_reg[8]_i_1_n_0 ;
  wire \timestamp_counter_reg[8]_i_1_n_1 ;
  wire \timestamp_counter_reg[8]_i_1_n_2 ;
  wire \timestamp_counter_reg[8]_i_1_n_3 ;
  wire \timestamp_counter_reg[8]_i_1_n_4 ;
  wire \timestamp_counter_reg[8]_i_1_n_5 ;
  wire \timestamp_counter_reg[8]_i_1_n_6 ;
  wire \timestamp_counter_reg[8]_i_1_n_7 ;
  wire \timestamp_shadow[63]_i_2_n_0 ;
  wire \timestamp_shadow[63]_i_5_n_0 ;
  wire \virtual_evt_data[0]_i_1_n_0 ;
  wire \virtual_evt_data[10]_i_1_n_0 ;
  wire \virtual_evt_data[11]_i_1_n_0 ;
  wire \virtual_evt_data[127]_i_2_n_0 ;
  wire \virtual_evt_data[127]_i_3_n_0 ;
  wire \virtual_evt_data[127]_i_4_n_0 ;
  wire \virtual_evt_data[127]_i_5_n_0 ;
  wire \virtual_evt_data[127]_i_6_n_0 ;
  wire \virtual_evt_data[127]_i_7_n_0 ;
  wire \virtual_evt_data[12]_i_1_n_0 ;
  wire \virtual_evt_data[13]_i_1_n_0 ;
  wire \virtual_evt_data[14]_i_1_n_0 ;
  wire \virtual_evt_data[15]_i_1_n_0 ;
  wire \virtual_evt_data[16]_i_1_n_0 ;
  wire \virtual_evt_data[17]_i_1_n_0 ;
  wire \virtual_evt_data[18]_i_1_n_0 ;
  wire \virtual_evt_data[19]_i_1_n_0 ;
  wire \virtual_evt_data[1]_i_1_n_0 ;
  wire \virtual_evt_data[20]_i_1_n_0 ;
  wire \virtual_evt_data[21]_i_1_n_0 ;
  wire \virtual_evt_data[22]_i_1_n_0 ;
  wire \virtual_evt_data[23]_i_1_n_0 ;
  wire \virtual_evt_data[2]_i_1_n_0 ;
  wire \virtual_evt_data[32]_i_1_n_0 ;
  wire \virtual_evt_data[3]_i_1_n_0 ;
  wire \virtual_evt_data[49]_i_1_n_0 ;
  wire \virtual_evt_data[4]_i_1_n_0 ;
  wire \virtual_evt_data[5]_i_1_n_0 ;
  wire \virtual_evt_data[6]_i_1_n_0 ;
  wire \virtual_evt_data[7]_i_1_n_0 ;
  wire \virtual_evt_data[8]_i_1_n_0 ;
  wire \virtual_evt_data[9]_i_1_n_0 ;
  wire \virtual_evt_data_reg_n_0_[0] ;
  wire \virtual_evt_data_reg_n_0_[100] ;
  wire \virtual_evt_data_reg_n_0_[101] ;
  wire \virtual_evt_data_reg_n_0_[102] ;
  wire \virtual_evt_data_reg_n_0_[103] ;
  wire \virtual_evt_data_reg_n_0_[104] ;
  wire \virtual_evt_data_reg_n_0_[105] ;
  wire \virtual_evt_data_reg_n_0_[106] ;
  wire \virtual_evt_data_reg_n_0_[107] ;
  wire \virtual_evt_data_reg_n_0_[108] ;
  wire \virtual_evt_data_reg_n_0_[109] ;
  wire \virtual_evt_data_reg_n_0_[10] ;
  wire \virtual_evt_data_reg_n_0_[110] ;
  wire \virtual_evt_data_reg_n_0_[111] ;
  wire \virtual_evt_data_reg_n_0_[112] ;
  wire \virtual_evt_data_reg_n_0_[113] ;
  wire \virtual_evt_data_reg_n_0_[114] ;
  wire \virtual_evt_data_reg_n_0_[115] ;
  wire \virtual_evt_data_reg_n_0_[116] ;
  wire \virtual_evt_data_reg_n_0_[117] ;
  wire \virtual_evt_data_reg_n_0_[118] ;
  wire \virtual_evt_data_reg_n_0_[119] ;
  wire \virtual_evt_data_reg_n_0_[11] ;
  wire \virtual_evt_data_reg_n_0_[120] ;
  wire \virtual_evt_data_reg_n_0_[121] ;
  wire \virtual_evt_data_reg_n_0_[122] ;
  wire \virtual_evt_data_reg_n_0_[123] ;
  wire \virtual_evt_data_reg_n_0_[124] ;
  wire \virtual_evt_data_reg_n_0_[125] ;
  wire \virtual_evt_data_reg_n_0_[126] ;
  wire \virtual_evt_data_reg_n_0_[127] ;
  wire \virtual_evt_data_reg_n_0_[12] ;
  wire \virtual_evt_data_reg_n_0_[13] ;
  wire \virtual_evt_data_reg_n_0_[14] ;
  wire \virtual_evt_data_reg_n_0_[15] ;
  wire \virtual_evt_data_reg_n_0_[16] ;
  wire \virtual_evt_data_reg_n_0_[17] ;
  wire \virtual_evt_data_reg_n_0_[18] ;
  wire \virtual_evt_data_reg_n_0_[19] ;
  wire \virtual_evt_data_reg_n_0_[1] ;
  wire \virtual_evt_data_reg_n_0_[20] ;
  wire \virtual_evt_data_reg_n_0_[21] ;
  wire \virtual_evt_data_reg_n_0_[22] ;
  wire \virtual_evt_data_reg_n_0_[23] ;
  wire \virtual_evt_data_reg_n_0_[2] ;
  wire \virtual_evt_data_reg_n_0_[32] ;
  wire \virtual_evt_data_reg_n_0_[3] ;
  wire \virtual_evt_data_reg_n_0_[48] ;
  wire \virtual_evt_data_reg_n_0_[49] ;
  wire \virtual_evt_data_reg_n_0_[4] ;
  wire \virtual_evt_data_reg_n_0_[55] ;
  wire \virtual_evt_data_reg_n_0_[5] ;
  wire \virtual_evt_data_reg_n_0_[64] ;
  wire \virtual_evt_data_reg_n_0_[65] ;
  wire \virtual_evt_data_reg_n_0_[66] ;
  wire \virtual_evt_data_reg_n_0_[67] ;
  wire \virtual_evt_data_reg_n_0_[68] ;
  wire \virtual_evt_data_reg_n_0_[69] ;
  wire \virtual_evt_data_reg_n_0_[6] ;
  wire \virtual_evt_data_reg_n_0_[70] ;
  wire \virtual_evt_data_reg_n_0_[71] ;
  wire \virtual_evt_data_reg_n_0_[72] ;
  wire \virtual_evt_data_reg_n_0_[73] ;
  wire \virtual_evt_data_reg_n_0_[74] ;
  wire \virtual_evt_data_reg_n_0_[75] ;
  wire \virtual_evt_data_reg_n_0_[76] ;
  wire \virtual_evt_data_reg_n_0_[77] ;
  wire \virtual_evt_data_reg_n_0_[78] ;
  wire \virtual_evt_data_reg_n_0_[79] ;
  wire \virtual_evt_data_reg_n_0_[7] ;
  wire \virtual_evt_data_reg_n_0_[80] ;
  wire \virtual_evt_data_reg_n_0_[81] ;
  wire \virtual_evt_data_reg_n_0_[82] ;
  wire \virtual_evt_data_reg_n_0_[83] ;
  wire \virtual_evt_data_reg_n_0_[84] ;
  wire \virtual_evt_data_reg_n_0_[85] ;
  wire \virtual_evt_data_reg_n_0_[86] ;
  wire \virtual_evt_data_reg_n_0_[87] ;
  wire \virtual_evt_data_reg_n_0_[88] ;
  wire \virtual_evt_data_reg_n_0_[89] ;
  wire \virtual_evt_data_reg_n_0_[8] ;
  wire \virtual_evt_data_reg_n_0_[90] ;
  wire \virtual_evt_data_reg_n_0_[91] ;
  wire \virtual_evt_data_reg_n_0_[92] ;
  wire \virtual_evt_data_reg_n_0_[93] ;
  wire \virtual_evt_data_reg_n_0_[94] ;
  wire \virtual_evt_data_reg_n_0_[95] ;
  wire \virtual_evt_data_reg_n_0_[96] ;
  wire \virtual_evt_data_reg_n_0_[97] ;
  wire \virtual_evt_data_reg_n_0_[98] ;
  wire \virtual_evt_data_reg_n_0_[99] ;
  wire \virtual_evt_data_reg_n_0_[9] ;
  wire virtual_evt_trigger_i_2_n_0;
  wire virtual_evt_trigger_i_3_n_0;
  wire virtual_evt_trigger_i_4_n_0;
  wire virtual_evt_trigger_i_5_n_0;
  wire virtual_evt_trigger_reg_n_0;
  wire virtual_evt_valid7_out;
  wire virtual_evt_valid_i_2_n_0;
  wire virtual_evt_valid_i_3_n_0;
  wire virtual_evt_valid_i_5_n_0;
  wire virtual_evt_valid_reg_n_0;
  wire w_hs;
  wire w_pending_i_1_n_0;
  wire w_pending_reg_n_0;
  wire [31:0]wdata_reg;
  wire [4:4]write_addr;
  wire [3:0]wstrb_reg;
  wire [3:3]NLW_dropped_count_reg0_carry__6_CO_UNCONNECTED;
  wire [3:2]\NLW_dropped_count_reg0_inferred__0/i__carry__6_CO_UNCONNECTED ;
  wire [3:3]\NLW_dropped_count_reg0_inferred__0/i__carry__6_O_UNCONNECTED ;
  wire [3:0]NLW_heartbeat_counter0_carry__5_CO_UNCONNECTED;
  wire [3:1]NLW_heartbeat_counter0_carry__5_O_UNCONNECTED;
  wire [3:0]NLW_s_axi_rdata2_carry_O_UNCONNECTED;
  wire [3:1]NLW_s_axi_rdata2_carry__0_CO_UNCONNECTED;
  wire [3:0]NLW_s_axi_rdata2_carry__0_O_UNCONNECTED;
  wire [3:3]\NLW_timestamp_counter_reg[60]_i_1_CO_UNCONNECTED ;

  LUT6 #(
    .INIT(64'hF1F1F10000000000)) 
    aw_pending_i_1
       (.I0(w_pending_reg_n_0),
        .I1(w_hs),
        .I2(s_axi_bvalid_reg_0),
        .I3(aw_hs),
        .I4(aw_pending),
        .I5(s_axi_aresetn),
        .O(aw_pending_i_1_n_0));
  FDRE aw_pending_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(aw_pending_i_1_n_0),
        .Q(aw_pending),
        .R(1'b0));
  FDRE \awaddr_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[0]),
        .Q(awaddr_reg[0]),
        .R(clear));
  FDRE \awaddr_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[10]),
        .Q(awaddr_reg[10]),
        .R(clear));
  FDRE \awaddr_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[11]),
        .Q(awaddr_reg[11]),
        .R(clear));
  FDRE \awaddr_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[12]),
        .Q(awaddr_reg[12]),
        .R(clear));
  FDRE \awaddr_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[13]),
        .Q(awaddr_reg[13]),
        .R(clear));
  FDRE \awaddr_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[14]),
        .Q(awaddr_reg[14]),
        .R(clear));
  FDRE \awaddr_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[15]),
        .Q(awaddr_reg[15]),
        .R(clear));
  FDRE \awaddr_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[1]),
        .Q(awaddr_reg[1]),
        .R(clear));
  FDRE \awaddr_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[2]),
        .Q(awaddr_reg[2]),
        .R(clear));
  FDRE \awaddr_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[3]),
        .Q(awaddr_reg[3]),
        .R(clear));
  FDRE \awaddr_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[4]),
        .Q(awaddr_reg[4]),
        .R(clear));
  FDRE \awaddr_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[5]),
        .Q(awaddr_reg[5]),
        .R(clear));
  FDRE \awaddr_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[6]),
        .Q(awaddr_reg[6]),
        .R(clear));
  FDRE \awaddr_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[7]),
        .Q(awaddr_reg[7]),
        .R(clear));
  FDRE \awaddr_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[8]),
        .Q(awaddr_reg[8]),
        .R(clear));
  FDRE \awaddr_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(aw_hs),
        .D(s_axi_awaddr[9]),
        .Q(awaddr_reg[9]),
        .R(clear));
  LUT5 #(
    .INIT(32'h00001000)) 
    capture_ack_pulse_i_1
       (.I0(capture_arm_pulse_i_2_n_0),
        .I1(capture_arm_pulse_i_3_n_0),
        .I2(p_0_in15_in),
        .I3(s_axi_aresetn),
        .I4(capture_arm_pulse_i_4_n_0),
        .O(capture_ack_pulse_i_1_n_0));
  FDRE capture_ack_pulse_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(capture_ack_pulse_i_1_n_0),
        .Q(capture_ack_pulse_reg_n_0),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00001000)) 
    capture_arm_pulse_i_1
       (.I0(capture_arm_pulse_i_2_n_0),
        .I1(capture_arm_pulse_i_3_n_0),
        .I2(event_arbiter_n_6),
        .I3(s_axi_aresetn),
        .I4(capture_arm_pulse_i_4_n_0),
        .O(capture_arm_pulse_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEFFFEEE)) 
    capture_arm_pulse_i_2
       (.I0(event_arbiter_n_19),
        .I1(event_arbiter_n_18),
        .I2(awaddr_reg[11]),
        .I3(aw_pending),
        .I4(s_axi_awaddr[11]),
        .I5(\led_ctrl_reg[0]_i_10_n_0 ),
        .O(capture_arm_pulse_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFEFFFF)) 
    capture_arm_pulse_i_3
       (.I0(capture_arm_pulse_i_5_n_0),
        .I1(event_arbiter_n_14),
        .I2(write_addr),
        .I3(event_arbiter_n_10),
        .I4(event_arbiter_n_12),
        .I5(\dropped_count_reg[31]_i_8_n_0 ),
        .O(capture_arm_pulse_i_3_n_0));
  LUT6 #(
    .INIT(64'hF1F1F1F1F1FFFFFF)) 
    capture_arm_pulse_i_4
       (.I0(w_pending_reg_n_0),
        .I1(w_hs),
        .I2(s_axi_bvalid_reg_0),
        .I3(s_axi_awready),
        .I4(s_axi_awvalid),
        .I5(aw_pending),
        .O(capture_arm_pulse_i_4_n_0));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    capture_arm_pulse_i_5
       (.I0(s_axi_awaddr[5]),
        .I1(awaddr_reg[5]),
        .I2(s_axi_awaddr[2]),
        .I3(aw_pending),
        .I4(awaddr_reg[2]),
        .O(capture_arm_pulse_i_5_n_0));
  FDRE capture_arm_pulse_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(capture_arm_pulse_i_1_n_0),
        .Q(capture_arm_pulse_reg_n_0),
        .R(1'b0));
  multi_protocol_bd_multi_protocol_core_0_0_event_snapshot_buffer capture_buffer
       (.CO(s_axi_rdata2),
        .D(p_2_in__0),
        .DI({capture_buffer_n_77,capture_buffer_n_78,capture_buffer_n_79,capture_buffer_n_80}),
        .E(capture_buffer_n_3),
        .Q(snapshot_count),
        .S({capture_buffer_n_73,capture_buffer_n_74,capture_buffer_n_75,capture_buffer_n_76}),
        .SR(capture_buffer_n_2),
        .capture_active_reg_0(capture_buffer_n_38),
        .capture_active_reg_1(capture_arm_pulse_reg_n_0),
        .clear(clear),
        .dropped_count_reg0(dropped_count_reg0),
        .dropped_count_reg00_in(dropped_count_reg00_in),
        .\dropped_count_reg_reg[0] (\dropped_count_reg[31]_i_5_n_0 ),
        .\dropped_count_reg_reg[0]_0 (event_arbiter_n_5),
        .\dropped_count_reg_reg[0]_1 (virtual_evt_valid_reg_n_0),
        .\dropped_count_reg_reg[0]_2 (event_arbiter_n_3),
        .\dropped_count_reg_reg[31] (event_arbiter_n_6),
        .\dropped_count_reg_reg[31]_0 (\dropped_count_reg[31]_i_10_n_0 ),
        .\dropped_count_reg_reg[31]_1 (event_arbiter_n_7),
        .\dropped_count_reg_reg[31]_2 (event_arbiter_n_8),
        .\dropped_count_reg_reg[31]_3 (event_arbiter_n_9),
        .ext_evt_trigger(ext_evt_trigger),
        .ext_evt_valid(ext_evt_valid),
        .in_event(capture_event_data),
        .memory_reg_0_0({\snapshot_rd_index_reg_n_0_[7] ,\snapshot_rd_index_reg_n_0_[6] ,\snapshot_rd_index_reg_n_0_[5] ,\snapshot_rd_index_reg_n_0_[4] ,\snapshot_rd_index_reg_n_0_[3] ,\snapshot_rd_index_reg_n_0_[2] ,\snapshot_rd_index_reg_n_0_[1] ,\snapshot_rd_index_reg_n_0_[0] }),
        .p_3_in(p_3_in),
        .\post_remaining_reg[1]_0 (virtual_evt_trigger_reg_n_0),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr({s_axi_araddr[15:2],s_axi_araddr[0]}),
        .\s_axi_araddr[0] (capture_buffer_n_71),
        .\s_axi_araddr[5] ({capture_buffer_n_39,capture_buffer_n_40,capture_buffer_n_41,capture_buffer_n_42,capture_buffer_n_43,capture_buffer_n_44,capture_buffer_n_45,capture_buffer_n_46,capture_buffer_n_47,capture_buffer_n_48,capture_buffer_n_49,capture_buffer_n_50,capture_buffer_n_51,capture_buffer_n_52,capture_buffer_n_53,capture_buffer_n_54,capture_buffer_n_55,capture_buffer_n_56,capture_buffer_n_57,capture_buffer_n_58,capture_buffer_n_59,capture_buffer_n_60,capture_buffer_n_61,capture_buffer_n_62,capture_buffer_n_63,capture_buffer_n_64,capture_buffer_n_65,capture_buffer_n_66,capture_buffer_n_67,capture_buffer_n_68,capture_buffer_n_69,capture_buffer_n_70}),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_aresetn_0(capture_buffer_n_4),
        .s_axi_aresetn_1(capture_buffer_n_72),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_arvalid_0(capture_buffer_n_82),
        .\s_axi_rdata_reg[0] (snapshot_read_pending_reg_n_0),
        .\s_axi_rdata_reg[0]_0 (event_arbiter_n_157),
        .\s_axi_rdata_reg[0]_1 (snapshot_word_select),
        .\s_axi_rdata_reg[10] (event_arbiter_n_173),
        .\s_axi_rdata_reg[10]_0 (\s_axi_rdata[10]_i_5_n_0 ),
        .\s_axi_rdata_reg[11] (event_arbiter_n_172),
        .\s_axi_rdata_reg[11]_0 (\s_axi_rdata[11]_i_5_n_0 ),
        .\s_axi_rdata_reg[12] (event_arbiter_n_153),
        .\s_axi_rdata_reg[13] (event_arbiter_n_171),
        .\s_axi_rdata_reg[13]_0 (\s_axi_rdata[13]_i_5_n_0 ),
        .\s_axi_rdata_reg[14] (event_arbiter_n_170),
        .\s_axi_rdata_reg[14]_0 (\s_axi_rdata[14]_i_5_n_0 ),
        .\s_axi_rdata_reg[15] (event_arbiter_n_169),
        .\s_axi_rdata_reg[15]_0 (\s_axi_rdata[15]_i_5_n_0 ),
        .\s_axi_rdata_reg[16] (event_arbiter_n_0),
        .\s_axi_rdata_reg[17] (event_arbiter_n_168),
        .\s_axi_rdata_reg[17]_0 (\s_axi_rdata[17]_i_5_n_0 ),
        .\s_axi_rdata_reg[18] (event_arbiter_n_167),
        .\s_axi_rdata_reg[18]_0 (\s_axi_rdata[18]_i_5_n_0 ),
        .\s_axi_rdata_reg[19] (event_arbiter_n_166),
        .\s_axi_rdata_reg[19]_0 (\s_axi_rdata[19]_i_5_n_0 ),
        .\s_axi_rdata_reg[1] (event_arbiter_n_156),
        .\s_axi_rdata_reg[20] (event_arbiter_n_152),
        .\s_axi_rdata_reg[21] (event_arbiter_n_165),
        .\s_axi_rdata_reg[21]_0 (\s_axi_rdata[21]_i_5_n_0 ),
        .\s_axi_rdata_reg[22] (event_arbiter_n_151),
        .\s_axi_rdata_reg[23] (event_arbiter_n_164),
        .\s_axi_rdata_reg[23]_0 (\s_axi_rdata[23]_i_5_n_0 ),
        .\s_axi_rdata_reg[24] (event_arbiter_n_163),
        .\s_axi_rdata_reg[24]_0 (\s_axi_rdata[24]_i_5_n_0 ),
        .\s_axi_rdata_reg[25] (event_arbiter_n_162),
        .\s_axi_rdata_reg[25]_0 (\s_axi_rdata[25]_i_5_n_0 ),
        .\s_axi_rdata_reg[26] (event_arbiter_n_150),
        .\s_axi_rdata_reg[27] (event_arbiter_n_149),
        .\s_axi_rdata_reg[27]_0 (\s_axi_rdata[27]_i_7_n_0 ),
        .\s_axi_rdata_reg[28] (event_arbiter_n_161),
        .\s_axi_rdata_reg[28]_0 (\s_axi_rdata[28]_i_5_n_0 ),
        .\s_axi_rdata_reg[29] (event_arbiter_n_160),
        .\s_axi_rdata_reg[29]_0 (\s_axi_rdata[29]_i_5_n_0 ),
        .\s_axi_rdata_reg[2] (event_arbiter_n_155),
        .\s_axi_rdata_reg[30] (event_arbiter_n_159),
        .\s_axi_rdata_reg[30]_0 (\s_axi_rdata[30]_i_5_n_0 ),
        .\s_axi_rdata_reg[31] (\s_axi_rdata[31]_i_4_n_0 ),
        .\s_axi_rdata_reg[31]_0 (\s_axi_rdata[31]_i_5_n_0 ),
        .\s_axi_rdata_reg[31]_1 (dropped_count_reg),
        .\s_axi_rdata_reg[31]_2 (event_arbiter_n_158),
        .\s_axi_rdata_reg[31]_3 (\s_axi_rdata[31]_i_10_n_0 ),
        .\s_axi_rdata_reg[3] (\s_axi_rdata[3]_i_6_n_0 ),
        .\s_axi_rdata_reg[3]_0 (\s_axi_rdata[3]_i_7_n_0 ),
        .\s_axi_rdata_reg[3]_1 (event_arbiter_n_179),
        .\s_axi_rdata_reg[3]_2 (\s_axi_rdata[3]_i_10_n_0 ),
        .\s_axi_rdata_reg[3]_3 (\s_axi_rdata[3]_i_11_n_0 ),
        .\s_axi_rdata_reg[3]_4 (\s_axi_rdata[3]_i_12_n_0 ),
        .\s_axi_rdata_reg[3]_5 (\s_axi_rdata[3]_i_13_n_0 ),
        .\s_axi_rdata_reg[4] (event_arbiter_n_178),
        .\s_axi_rdata_reg[4]_0 (\s_axi_rdata[4]_i_5_n_0 ),
        .\s_axi_rdata_reg[4]_1 (\s_axi_rdata[7]_i_7_n_0 ),
        .\s_axi_rdata_reg[4]_2 (\s_axi_rdata[7]_i_8_n_0 ),
        .\s_axi_rdata_reg[5] (event_arbiter_n_177),
        .\s_axi_rdata_reg[5]_0 (\s_axi_rdata[5]_i_5_n_0 ),
        .\s_axi_rdata_reg[6] (event_arbiter_n_154),
        .\s_axi_rdata_reg[7] (event_arbiter_n_176),
        .\s_axi_rdata_reg[7]_0 (\s_axi_rdata[7]_i_5_n_0 ),
        .\s_axi_rdata_reg[8] (event_arbiter_n_175),
        .\s_axi_rdata_reg[8]_0 (\s_axi_rdata[8]_i_5_n_0 ),
        .\s_axi_rdata_reg[8]_1 (\s_axi_rdata[31]_i_13_n_0 ),
        .\s_axi_rdata_reg[9] (\s_axi_rdata[31]_i_12_n_0 ),
        .\s_axi_rdata_reg[9]_0 (event_arbiter_n_174),
        .\s_axi_rdata_reg[9]_1 (\s_axi_rdata[9]_i_5_n_0 ),
        .\s_axi_rdata_reg[9]_2 (\s_axi_rdata[31]_i_11_n_0 ),
        .s_axi_rready(s_axi_rready),
        .s_axi_rvalid(s_axi_rvalid),
        .\snapshot_count_reg[8]_0 (capture_buffer_n_81),
        .snapshot_rd_en(snapshot_rd_en),
        .\snapshot_rd_index_reg[0] (s_axi_arready),
        .snapshot_ready_reg_0(snapshot_rd_index),
        .snapshot_ready_reg_1(capture_ack_pulse_reg_n_0),
        .\timestamp_shadow_reg[32] (\timestamp_shadow[63]_i_2_n_0 ),
        .\timestamp_shadow_reg[32]_0 (\timestamp_shadow[63]_i_5_n_0 ));
  CARRY4 dropped_count_reg0_carry
       (.CI(1'b0),
        .CO({dropped_count_reg0_carry_n_0,dropped_count_reg0_carry_n_1,dropped_count_reg0_carry_n_2,dropped_count_reg0_carry_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,dropped_count_reg[1],1'b0}),
        .O(dropped_count_reg0[3:0]),
        .S({dropped_count_reg[3:2],dropped_count_reg0_carry_i_1_n_0,dropped_count_reg[0]}));
  CARRY4 dropped_count_reg0_carry__0
       (.CI(dropped_count_reg0_carry_n_0),
        .CO({dropped_count_reg0_carry__0_n_0,dropped_count_reg0_carry__0_n_1,dropped_count_reg0_carry__0_n_2,dropped_count_reg0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg0[7:4]),
        .S(dropped_count_reg[7:4]));
  CARRY4 dropped_count_reg0_carry__1
       (.CI(dropped_count_reg0_carry__0_n_0),
        .CO({dropped_count_reg0_carry__1_n_0,dropped_count_reg0_carry__1_n_1,dropped_count_reg0_carry__1_n_2,dropped_count_reg0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg0[11:8]),
        .S(dropped_count_reg[11:8]));
  CARRY4 dropped_count_reg0_carry__2
       (.CI(dropped_count_reg0_carry__1_n_0),
        .CO({dropped_count_reg0_carry__2_n_0,dropped_count_reg0_carry__2_n_1,dropped_count_reg0_carry__2_n_2,dropped_count_reg0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg0[15:12]),
        .S(dropped_count_reg[15:12]));
  CARRY4 dropped_count_reg0_carry__3
       (.CI(dropped_count_reg0_carry__2_n_0),
        .CO({dropped_count_reg0_carry__3_n_0,dropped_count_reg0_carry__3_n_1,dropped_count_reg0_carry__3_n_2,dropped_count_reg0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg0[19:16]),
        .S(dropped_count_reg[19:16]));
  CARRY4 dropped_count_reg0_carry__4
       (.CI(dropped_count_reg0_carry__3_n_0),
        .CO({dropped_count_reg0_carry__4_n_0,dropped_count_reg0_carry__4_n_1,dropped_count_reg0_carry__4_n_2,dropped_count_reg0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg0[23:20]),
        .S(dropped_count_reg[23:20]));
  CARRY4 dropped_count_reg0_carry__5
       (.CI(dropped_count_reg0_carry__4_n_0),
        .CO({dropped_count_reg0_carry__5_n_0,dropped_count_reg0_carry__5_n_1,dropped_count_reg0_carry__5_n_2,dropped_count_reg0_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg0[27:24]),
        .S(dropped_count_reg[27:24]));
  CARRY4 dropped_count_reg0_carry__6
       (.CI(dropped_count_reg0_carry__5_n_0),
        .CO({NLW_dropped_count_reg0_carry__6_CO_UNCONNECTED[3],dropped_count_reg0_carry__6_n_1,dropped_count_reg0_carry__6_n_2,dropped_count_reg0_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg0[31:28]),
        .S(dropped_count_reg[31:28]));
  LUT1 #(
    .INIT(2'h1)) 
    dropped_count_reg0_carry_i_1
       (.I0(dropped_count_reg[1]),
        .O(dropped_count_reg0_carry_i_1_n_0));
  CARRY4 \dropped_count_reg0_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\dropped_count_reg0_inferred__0/i__carry_n_0 ,\dropped_count_reg0_inferred__0/i__carry_n_1 ,\dropped_count_reg0_inferred__0/i__carry_n_2 ,\dropped_count_reg0_inferred__0/i__carry_n_3 }),
        .CYINIT(dropped_count_reg[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg00_in[4:1]),
        .S(dropped_count_reg[4:1]));
  CARRY4 \dropped_count_reg0_inferred__0/i__carry__0 
       (.CI(\dropped_count_reg0_inferred__0/i__carry_n_0 ),
        .CO({\dropped_count_reg0_inferred__0/i__carry__0_n_0 ,\dropped_count_reg0_inferred__0/i__carry__0_n_1 ,\dropped_count_reg0_inferred__0/i__carry__0_n_2 ,\dropped_count_reg0_inferred__0/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg00_in[8:5]),
        .S(dropped_count_reg[8:5]));
  CARRY4 \dropped_count_reg0_inferred__0/i__carry__1 
       (.CI(\dropped_count_reg0_inferred__0/i__carry__0_n_0 ),
        .CO({\dropped_count_reg0_inferred__0/i__carry__1_n_0 ,\dropped_count_reg0_inferred__0/i__carry__1_n_1 ,\dropped_count_reg0_inferred__0/i__carry__1_n_2 ,\dropped_count_reg0_inferred__0/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg00_in[12:9]),
        .S(dropped_count_reg[12:9]));
  CARRY4 \dropped_count_reg0_inferred__0/i__carry__2 
       (.CI(\dropped_count_reg0_inferred__0/i__carry__1_n_0 ),
        .CO({\dropped_count_reg0_inferred__0/i__carry__2_n_0 ,\dropped_count_reg0_inferred__0/i__carry__2_n_1 ,\dropped_count_reg0_inferred__0/i__carry__2_n_2 ,\dropped_count_reg0_inferred__0/i__carry__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg00_in[16:13]),
        .S(dropped_count_reg[16:13]));
  CARRY4 \dropped_count_reg0_inferred__0/i__carry__3 
       (.CI(\dropped_count_reg0_inferred__0/i__carry__2_n_0 ),
        .CO({\dropped_count_reg0_inferred__0/i__carry__3_n_0 ,\dropped_count_reg0_inferred__0/i__carry__3_n_1 ,\dropped_count_reg0_inferred__0/i__carry__3_n_2 ,\dropped_count_reg0_inferred__0/i__carry__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg00_in[20:17]),
        .S(dropped_count_reg[20:17]));
  CARRY4 \dropped_count_reg0_inferred__0/i__carry__4 
       (.CI(\dropped_count_reg0_inferred__0/i__carry__3_n_0 ),
        .CO({\dropped_count_reg0_inferred__0/i__carry__4_n_0 ,\dropped_count_reg0_inferred__0/i__carry__4_n_1 ,\dropped_count_reg0_inferred__0/i__carry__4_n_2 ,\dropped_count_reg0_inferred__0/i__carry__4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg00_in[24:21]),
        .S(dropped_count_reg[24:21]));
  CARRY4 \dropped_count_reg0_inferred__0/i__carry__5 
       (.CI(\dropped_count_reg0_inferred__0/i__carry__4_n_0 ),
        .CO({\dropped_count_reg0_inferred__0/i__carry__5_n_0 ,\dropped_count_reg0_inferred__0/i__carry__5_n_1 ,\dropped_count_reg0_inferred__0/i__carry__5_n_2 ,\dropped_count_reg0_inferred__0/i__carry__5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(dropped_count_reg00_in[28:25]),
        .S(dropped_count_reg[28:25]));
  CARRY4 \dropped_count_reg0_inferred__0/i__carry__6 
       (.CI(\dropped_count_reg0_inferred__0/i__carry__5_n_0 ),
        .CO({\NLW_dropped_count_reg0_inferred__0/i__carry__6_CO_UNCONNECTED [3:2],\dropped_count_reg0_inferred__0/i__carry__6_n_2 ,\dropped_count_reg0_inferred__0/i__carry__6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_dropped_count_reg0_inferred__0/i__carry__6_O_UNCONNECTED [3],dropped_count_reg00_in[31:29]}),
        .S({1'b0,dropped_count_reg[31:29]}));
  LUT5 #(
    .INIT(32'h8A80FFFF)) 
    \dropped_count_reg[31]_i_1 
       (.I0(\dropped_count_reg[31]_i_4_n_0 ),
        .I1(wdata_reg[0]),
        .I2(w_pending_reg_n_0),
        .I3(s_axi_wdata[0]),
        .I4(s_axi_aresetn),
        .O(\dropped_count_reg[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFF5D)) 
    \dropped_count_reg[31]_i_10 
       (.I0(event_arbiter_n_17),
        .I1(\dropped_count_reg[31]_i_11_n_0 ),
        .I2(event_arbiter_n_16),
        .I3(write_addr),
        .I4(event_arbiter_n_14),
        .I5(capture_arm_pulse_i_5_n_0),
        .O(\dropped_count_reg[31]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \dropped_count_reg[31]_i_11 
       (.I0(s_axi_awaddr[15]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[14]),
        .I3(s_axi_awaddr[13]),
        .O(\dropped_count_reg[31]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \dropped_count_reg[31]_i_4 
       (.I0(capture_arm_pulse_i_4_n_0),
        .I1(capture_arm_pulse_i_2_n_0),
        .I2(\dropped_count_reg[31]_i_8_n_0 ),
        .I3(event_arbiter_n_12),
        .I4(event_arbiter_n_10),
        .I5(event_arbiter_n_11),
        .O(\dropped_count_reg[31]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFDFF00FFFFFFFF)) 
    \dropped_count_reg[31]_i_5 
       (.I0(p_0_in13_in),
        .I1(event_arbiter_n_7),
        .I2(event_arbiter_n_11),
        .I3(event_arbiter_n_10),
        .I4(\dropped_count_reg[31]_i_9_n_0 ),
        .I5(event_arbiter_n_8),
        .O(\dropped_count_reg[31]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'hCCAFFFAF)) 
    \dropped_count_reg[31]_i_8 
       (.I0(s_axi_awaddr[1]),
        .I1(awaddr_reg[1]),
        .I2(s_axi_awaddr[12]),
        .I3(aw_pending),
        .I4(awaddr_reg[12]),
        .O(\dropped_count_reg[31]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hEFEEEFFFFFFFFFFF)) 
    \dropped_count_reg[31]_i_9 
       (.I0(\dropped_count_reg[31]_i_8_n_0 ),
        .I1(capture_arm_pulse_i_5_n_0),
        .I2(awaddr_reg[3]),
        .I3(aw_pending),
        .I4(s_axi_awaddr[3]),
        .I5(write_addr),
        .O(\dropped_count_reg[31]_i_9_n_0 ));
  FDRE \dropped_count_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[0]),
        .Q(dropped_count_reg[0]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[10]),
        .Q(dropped_count_reg[10]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[11]),
        .Q(dropped_count_reg[11]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[12]),
        .Q(dropped_count_reg[12]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[13]),
        .Q(dropped_count_reg[13]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[14]),
        .Q(dropped_count_reg[14]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[15]),
        .Q(dropped_count_reg[15]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[16]),
        .Q(dropped_count_reg[16]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[17]),
        .Q(dropped_count_reg[17]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[18]),
        .Q(dropped_count_reg[18]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[19]),
        .Q(dropped_count_reg[19]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[1]),
        .Q(dropped_count_reg[1]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[20]),
        .Q(dropped_count_reg[20]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[21]),
        .Q(dropped_count_reg[21]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[22]),
        .Q(dropped_count_reg[22]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[23]),
        .Q(dropped_count_reg[23]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[24]),
        .Q(dropped_count_reg[24]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[25]),
        .Q(dropped_count_reg[25]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[26]),
        .Q(dropped_count_reg[26]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[27]),
        .Q(dropped_count_reg[27]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[28]),
        .Q(dropped_count_reg[28]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[29]),
        .Q(dropped_count_reg[29]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[2]),
        .Q(dropped_count_reg[2]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[30]),
        .Q(dropped_count_reg[30]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[31]),
        .Q(dropped_count_reg[31]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[3]),
        .Q(dropped_count_reg[3]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[4]),
        .Q(dropped_count_reg[4]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[5]),
        .Q(dropped_count_reg[5]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[6]),
        .Q(dropped_count_reg[6]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[7]),
        .Q(dropped_count_reg[7]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[8]),
        .Q(dropped_count_reg[8]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  FDRE \dropped_count_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_38),
        .D(p_2_in__0[9]),
        .Q(dropped_count_reg[9]),
        .R(\dropped_count_reg[31]_i_1_n_0 ));
  multi_protocol_bd_multi_protocol_core_0_0_event_arbiter_2 event_arbiter
       (.E(virtual_evt_valid7_out),
        .Q(awaddr_reg),
        .aw_hs(aw_hs),
        .aw_pending(aw_pending),
        .aw_pending_reg(event_arbiter_n_8),
        .\awaddr_reg_reg[12] (event_arbiter_n_7),
        .\awaddr_reg_reg[15] (event_arbiter_n_16),
        .\awaddr_reg_reg[2] (event_arbiter_n_11),
        .\awaddr_reg_reg[3] (event_arbiter_n_14),
        .\awaddr_reg_reg[5] (event_arbiter_n_13),
        .\awaddr_reg_reg[8] (event_arbiter_n_18),
        .capture_arm_pulse_reg(event_arbiter_n_9),
        .clear(clear),
        .\dropped_count_reg[31]_i_4 (wstrb_reg[0]),
        .\dropped_count_reg[31]_i_6 (capture_arm_pulse_reg_n_0),
        .ext_evt_data(ext_evt_data),
        .ext_evt_dropped_count(ext_evt_dropped_count),
        .ext_evt_dropped_count_3_sp_1(event_arbiter_n_179),
        .ext_evt_ready(ext_evt_ready),
        .ext_evt_ready_INST_0_i_4_0(s_axi_bvalid_reg_0),
        .ext_evt_valid(ext_evt_valid),
        .ext_evt_valid_0(event_arbiter_n_3),
        .in_event(capture_event_data),
        .memory_reg_1({\virtual_evt_data_reg_n_0_[127] ,\virtual_evt_data_reg_n_0_[126] ,\virtual_evt_data_reg_n_0_[125] ,\virtual_evt_data_reg_n_0_[124] ,\virtual_evt_data_reg_n_0_[123] ,\virtual_evt_data_reg_n_0_[122] ,\virtual_evt_data_reg_n_0_[121] ,\virtual_evt_data_reg_n_0_[120] ,\virtual_evt_data_reg_n_0_[119] ,\virtual_evt_data_reg_n_0_[118] ,\virtual_evt_data_reg_n_0_[117] ,\virtual_evt_data_reg_n_0_[116] ,\virtual_evt_data_reg_n_0_[115] ,\virtual_evt_data_reg_n_0_[114] ,\virtual_evt_data_reg_n_0_[113] ,\virtual_evt_data_reg_n_0_[112] ,\virtual_evt_data_reg_n_0_[111] ,\virtual_evt_data_reg_n_0_[110] ,\virtual_evt_data_reg_n_0_[109] ,\virtual_evt_data_reg_n_0_[108] ,\virtual_evt_data_reg_n_0_[107] ,\virtual_evt_data_reg_n_0_[106] ,\virtual_evt_data_reg_n_0_[105] ,\virtual_evt_data_reg_n_0_[104] ,\virtual_evt_data_reg_n_0_[103] ,\virtual_evt_data_reg_n_0_[102] ,\virtual_evt_data_reg_n_0_[101] ,\virtual_evt_data_reg_n_0_[100] ,\virtual_evt_data_reg_n_0_[99] ,\virtual_evt_data_reg_n_0_[98] ,\virtual_evt_data_reg_n_0_[97] ,\virtual_evt_data_reg_n_0_[96] ,\virtual_evt_data_reg_n_0_[95] ,\virtual_evt_data_reg_n_0_[94] ,\virtual_evt_data_reg_n_0_[93] ,\virtual_evt_data_reg_n_0_[92] ,\virtual_evt_data_reg_n_0_[91] ,\virtual_evt_data_reg_n_0_[90] ,\virtual_evt_data_reg_n_0_[89] ,\virtual_evt_data_reg_n_0_[88] ,\virtual_evt_data_reg_n_0_[87] ,\virtual_evt_data_reg_n_0_[86] ,\virtual_evt_data_reg_n_0_[85] ,\virtual_evt_data_reg_n_0_[84] ,\virtual_evt_data_reg_n_0_[83] ,\virtual_evt_data_reg_n_0_[82] ,\virtual_evt_data_reg_n_0_[81] ,\virtual_evt_data_reg_n_0_[80] ,\virtual_evt_data_reg_n_0_[79] ,\virtual_evt_data_reg_n_0_[78] ,\virtual_evt_data_reg_n_0_[77] ,\virtual_evt_data_reg_n_0_[76] ,\virtual_evt_data_reg_n_0_[75] ,\virtual_evt_data_reg_n_0_[74] ,\virtual_evt_data_reg_n_0_[73] ,\virtual_evt_data_reg_n_0_[72] ,\virtual_evt_data_reg_n_0_[71] ,\virtual_evt_data_reg_n_0_[70] ,\virtual_evt_data_reg_n_0_[69] ,\virtual_evt_data_reg_n_0_[68] ,\virtual_evt_data_reg_n_0_[67] ,\virtual_evt_data_reg_n_0_[66] ,\virtual_evt_data_reg_n_0_[65] ,\virtual_evt_data_reg_n_0_[64] ,\virtual_evt_data_reg_n_0_[55] ,\virtual_evt_data_reg_n_0_[49] ,\virtual_evt_data_reg_n_0_[48] ,\virtual_evt_data_reg_n_0_[32] ,\virtual_evt_data_reg_n_0_[23] ,\virtual_evt_data_reg_n_0_[22] ,\virtual_evt_data_reg_n_0_[21] ,\virtual_evt_data_reg_n_0_[20] ,\virtual_evt_data_reg_n_0_[19] ,\virtual_evt_data_reg_n_0_[18] ,\virtual_evt_data_reg_n_0_[17] ,\virtual_evt_data_reg_n_0_[16] ,\virtual_evt_data_reg_n_0_[15] ,\virtual_evt_data_reg_n_0_[14] ,\virtual_evt_data_reg_n_0_[13] ,\virtual_evt_data_reg_n_0_[12] ,\virtual_evt_data_reg_n_0_[11] ,\virtual_evt_data_reg_n_0_[10] ,\virtual_evt_data_reg_n_0_[9] ,\virtual_evt_data_reg_n_0_[8] ,\virtual_evt_data_reg_n_0_[7] ,\virtual_evt_data_reg_n_0_[6] ,\virtual_evt_data_reg_n_0_[5] ,\virtual_evt_data_reg_n_0_[4] ,\virtual_evt_data_reg_n_0_[3] ,\virtual_evt_data_reg_n_0_[2] ,\virtual_evt_data_reg_n_0_[1] ,\virtual_evt_data_reg_n_0_[0] }),
        .p_3_in(p_3_in),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr[5:2]),
        .\s_axi_araddr[4] (event_arbiter_n_0),
        .\s_axi_araddr[4]_0 (event_arbiter_n_158),
        .\s_axi_araddr[4]_1 (event_arbiter_n_159),
        .\s_axi_araddr[4]_10 (event_arbiter_n_168),
        .\s_axi_araddr[4]_11 (event_arbiter_n_169),
        .\s_axi_araddr[4]_12 (event_arbiter_n_170),
        .\s_axi_araddr[4]_13 (event_arbiter_n_171),
        .\s_axi_araddr[4]_14 (event_arbiter_n_172),
        .\s_axi_araddr[4]_15 (event_arbiter_n_173),
        .\s_axi_araddr[4]_16 (event_arbiter_n_174),
        .\s_axi_araddr[4]_17 (event_arbiter_n_175),
        .\s_axi_araddr[4]_18 (event_arbiter_n_176),
        .\s_axi_araddr[4]_19 (event_arbiter_n_177),
        .\s_axi_araddr[4]_2 (event_arbiter_n_160),
        .\s_axi_araddr[4]_20 (event_arbiter_n_178),
        .\s_axi_araddr[4]_3 (event_arbiter_n_161),
        .\s_axi_araddr[4]_4 (event_arbiter_n_162),
        .\s_axi_araddr[4]_5 (event_arbiter_n_163),
        .\s_axi_araddr[4]_6 (event_arbiter_n_164),
        .\s_axi_araddr[4]_7 (event_arbiter_n_165),
        .\s_axi_araddr[4]_8 (event_arbiter_n_166),
        .\s_axi_araddr[4]_9 (event_arbiter_n_167),
        .\s_axi_araddr[5] (event_arbiter_n_149),
        .\s_axi_araddr[5]_0 (event_arbiter_n_150),
        .\s_axi_araddr[5]_1 (event_arbiter_n_151),
        .\s_axi_araddr[5]_2 (event_arbiter_n_152),
        .\s_axi_araddr[5]_3 (event_arbiter_n_153),
        .\s_axi_araddr[5]_4 (event_arbiter_n_154),
        .\s_axi_araddr[5]_5 (event_arbiter_n_155),
        .\s_axi_araddr[5]_6 (event_arbiter_n_156),
        .\s_axi_araddr[5]_7 (event_arbiter_n_157),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awaddr_15_sp_1(event_arbiter_n_10),
        .s_axi_awaddr_6_sp_1(event_arbiter_n_17),
        .s_axi_awaddr_9_sp_1(event_arbiter_n_19),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .\s_axi_rdata_reg[0] (\s_axi_rdata[0]_i_7_n_0 ),
        .\s_axi_rdata_reg[0]_0 (\s_axi_rdata[0]_i_8_n_0 ),
        .\s_axi_rdata_reg[10] (\s_axi_rdata[10]_i_6_n_0 ),
        .\s_axi_rdata_reg[11] (\s_axi_rdata[11]_i_6_n_0 ),
        .\s_axi_rdata_reg[12] (\s_axi_rdata[12]_i_6_n_0 ),
        .\s_axi_rdata_reg[12]_0 (\s_axi_rdata[12]_i_7_n_0 ),
        .\s_axi_rdata_reg[13] (\s_axi_rdata[13]_i_6_n_0 ),
        .\s_axi_rdata_reg[14] (\s_axi_rdata[14]_i_6_n_0 ),
        .\s_axi_rdata_reg[15] (\s_axi_rdata[15]_i_6_n_0 ),
        .\s_axi_rdata_reg[16] (\s_axi_rdata[31]_i_12_n_0 ),
        .\s_axi_rdata_reg[16]_0 (\s_axi_rdata[16]_i_5_n_0 ),
        .\s_axi_rdata_reg[16]_1 (\s_axi_rdata[16]_i_7_n_0 ),
        .\s_axi_rdata_reg[17] (\s_axi_rdata[17]_i_6_n_0 ),
        .\s_axi_rdata_reg[18] (\s_axi_rdata[18]_i_6_n_0 ),
        .\s_axi_rdata_reg[19] (\s_axi_rdata[19]_i_6_n_0 ),
        .\s_axi_rdata_reg[1] (\s_axi_rdata[1]_i_7_n_0 ),
        .\s_axi_rdata_reg[1]_0 (\s_axi_rdata[1]_i_8_n_0 ),
        .\s_axi_rdata_reg[20] (\s_axi_rdata[20]_i_6_n_0 ),
        .\s_axi_rdata_reg[20]_0 (\s_axi_rdata[20]_i_7_n_0 ),
        .\s_axi_rdata_reg[21] (\s_axi_rdata[21]_i_6_n_0 ),
        .\s_axi_rdata_reg[22] (\s_axi_rdata[22]_i_6_n_0 ),
        .\s_axi_rdata_reg[22]_0 (\s_axi_rdata[22]_i_7_n_0 ),
        .\s_axi_rdata_reg[23] (\s_axi_rdata[23]_i_6_n_0 ),
        .\s_axi_rdata_reg[24] (\s_axi_rdata[24]_i_6_n_0 ),
        .\s_axi_rdata_reg[25] (\s_axi_rdata[25]_i_6_n_0 ),
        .\s_axi_rdata_reg[26] (\s_axi_rdata[26]_i_6_n_0 ),
        .\s_axi_rdata_reg[26]_0 (\s_axi_rdata[26]_i_7_n_0 ),
        .\s_axi_rdata_reg[27] (\s_axi_rdata[27]_i_9_n_0 ),
        .\s_axi_rdata_reg[27]_0 (\s_axi_rdata[27]_i_10_n_0 ),
        .\s_axi_rdata_reg[28] (\s_axi_rdata[28]_i_6_n_0 ),
        .\s_axi_rdata_reg[29] (\s_axi_rdata[29]_i_6_n_0 ),
        .\s_axi_rdata_reg[2] (\s_axi_rdata[2]_i_7_n_0 ),
        .\s_axi_rdata_reg[2]_0 (\s_axi_rdata[2]_i_8_n_0 ),
        .\s_axi_rdata_reg[30] (\s_axi_rdata[30]_i_6_n_0 ),
        .\s_axi_rdata_reg[31] (\s_axi_rdata[31]_i_14_n_0 ),
        .\s_axi_rdata_reg[31]_i_9_0 ({led_ctrl_reg,led_ps_active}),
        .\s_axi_rdata_reg[4] (\s_axi_rdata[4]_i_7_n_0 ),
        .\s_axi_rdata_reg[5] (\s_axi_rdata[5]_i_7_n_0 ),
        .\s_axi_rdata_reg[6] (\s_axi_rdata[6]_i_7_n_0 ),
        .\s_axi_rdata_reg[6]_0 (\s_axi_rdata[6]_i_8_n_0 ),
        .\s_axi_rdata_reg[7] (\s_axi_rdata[7]_i_9_n_0 ),
        .\s_axi_rdata_reg[8] (\s_axi_rdata[8]_i_7_n_0 ),
        .\s_axi_rdata_reg[9] (\s_axi_rdata[9]_i_6_n_0 ),
        .s_axi_wdata(s_axi_wdata[0]),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb[0]),
        .s_axi_wvalid(s_axi_wvalid),
        .\scratch_reg_reg[0] (w_pending_reg_n_0),
        .\scratch_reg_reg[0]_0 (wdata_reg[0]),
        .virtual_evt_trigger_reg(virtual_evt_valid_reg_n_0),
        .virtual_evt_trigger_reg_0(\virtual_evt_data[127]_i_2_n_0 ),
        .virtual_evt_trigger_reg_1(\dropped_count_reg[31]_i_10_n_0 ),
        .virtual_evt_trigger_reg_2(virtual_evt_trigger_i_2_n_0),
        .virtual_evt_trigger_reg_3(virtual_evt_trigger_i_3_n_0),
        .virtual_evt_trigger_reg_4(virtual_evt_trigger_reg_n_0),
        .virtual_evt_valid_reg(event_arbiter_n_180),
        .virtual_evt_valid_reg_0(event_arbiter_n_181),
        .virtual_evt_valid_reg_1(virtual_evt_valid_i_2_n_0),
        .virtual_evt_valid_reg_2(virtual_evt_valid_i_3_n_0),
        .\wdata_reg_reg[0] (event_arbiter_n_5),
        .\wdata_reg_reg[0]_0 (event_arbiter_n_6),
        .write_addr(write_addr),
        .\wstrb_reg_reg[0] (event_arbiter_n_12));
  CARRY4 heartbeat_counter0_carry
       (.CI(1'b0),
        .CO({heartbeat_counter0_carry_n_0,heartbeat_counter0_carry_n_1,heartbeat_counter0_carry_n_2,heartbeat_counter0_carry_n_3}),
        .CYINIT(\heartbeat_counter_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S({\heartbeat_counter_reg_n_0_[4] ,\heartbeat_counter_reg_n_0_[3] ,\heartbeat_counter_reg_n_0_[2] ,\heartbeat_counter_reg_n_0_[1] }));
  CARRY4 heartbeat_counter0_carry__0
       (.CI(heartbeat_counter0_carry_n_0),
        .CO({heartbeat_counter0_carry__0_n_0,heartbeat_counter0_carry__0_n_1,heartbeat_counter0_carry__0_n_2,heartbeat_counter0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S({\heartbeat_counter_reg_n_0_[8] ,\heartbeat_counter_reg_n_0_[7] ,\heartbeat_counter_reg_n_0_[6] ,\heartbeat_counter_reg_n_0_[5] }));
  CARRY4 heartbeat_counter0_carry__1
       (.CI(heartbeat_counter0_carry__0_n_0),
        .CO({heartbeat_counter0_carry__1_n_0,heartbeat_counter0_carry__1_n_1,heartbeat_counter0_carry__1_n_2,heartbeat_counter0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S({\heartbeat_counter_reg_n_0_[12] ,\heartbeat_counter_reg_n_0_[11] ,\heartbeat_counter_reg_n_0_[10] ,\heartbeat_counter_reg_n_0_[9] }));
  CARRY4 heartbeat_counter0_carry__2
       (.CI(heartbeat_counter0_carry__1_n_0),
        .CO({heartbeat_counter0_carry__2_n_0,heartbeat_counter0_carry__2_n_1,heartbeat_counter0_carry__2_n_2,heartbeat_counter0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:13]),
        .S({\heartbeat_counter_reg_n_0_[16] ,\heartbeat_counter_reg_n_0_[15] ,\heartbeat_counter_reg_n_0_[14] ,\heartbeat_counter_reg_n_0_[13] }));
  CARRY4 heartbeat_counter0_carry__3
       (.CI(heartbeat_counter0_carry__2_n_0),
        .CO({heartbeat_counter0_carry__3_n_0,heartbeat_counter0_carry__3_n_1,heartbeat_counter0_carry__3_n_2,heartbeat_counter0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[20:17]),
        .S({\heartbeat_counter_reg_n_0_[20] ,\heartbeat_counter_reg_n_0_[19] ,\heartbeat_counter_reg_n_0_[18] ,\heartbeat_counter_reg_n_0_[17] }));
  CARRY4 heartbeat_counter0_carry__4
       (.CI(heartbeat_counter0_carry__3_n_0),
        .CO({heartbeat_counter0_carry__4_n_0,heartbeat_counter0_carry__4_n_1,heartbeat_counter0_carry__4_n_2,heartbeat_counter0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[24:21]),
        .S({\heartbeat_counter_reg_n_0_[24] ,\heartbeat_counter_reg_n_0_[23] ,\heartbeat_counter_reg_n_0_[22] ,\heartbeat_counter_reg_n_0_[21] }));
  CARRY4 heartbeat_counter0_carry__5
       (.CI(heartbeat_counter0_carry__4_n_0),
        .CO(NLW_heartbeat_counter0_carry__5_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_heartbeat_counter0_carry__5_O_UNCONNECTED[3:1],data0[25]}),
        .S({1'b0,1'b0,1'b0,\heartbeat_counter_reg_n_0_[25] }));
  LUT1 #(
    .INIT(2'h1)) 
    \heartbeat_counter[0]_i_1 
       (.I0(\heartbeat_counter_reg_n_0_[0] ),
        .O(heartbeat_counter[0]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[10]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[10]),
        .O(heartbeat_counter[10]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[11]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[11]),
        .O(heartbeat_counter[11]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[12]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[12]),
        .O(heartbeat_counter[12]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[13]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[13]),
        .O(heartbeat_counter[13]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[14]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[14]),
        .O(heartbeat_counter[14]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[15]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[15]),
        .O(heartbeat_counter[15]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[16]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[16]),
        .O(heartbeat_counter[16]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[17]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[17]),
        .O(heartbeat_counter[17]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[18]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[18]),
        .O(heartbeat_counter[18]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[19]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[19]),
        .O(heartbeat_counter[19]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[1]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[1]),
        .O(heartbeat_counter[1]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[20]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[20]),
        .O(heartbeat_counter[20]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[21]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[21]),
        .O(heartbeat_counter[21]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[22]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[22]),
        .O(heartbeat_counter[22]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[23]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[23]),
        .O(heartbeat_counter[23]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[24]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[24]),
        .O(heartbeat_counter[24]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[25]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[25]),
        .O(heartbeat_counter[25]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[2]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[2]),
        .O(heartbeat_counter[2]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[3]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[3]),
        .O(heartbeat_counter[3]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[4]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[4]),
        .O(heartbeat_counter[4]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[5]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[5]),
        .O(heartbeat_counter[5]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[6]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[6]),
        .O(heartbeat_counter[6]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[7]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[7]),
        .O(heartbeat_counter[7]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[8]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[8]),
        .O(heartbeat_counter[8]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \heartbeat_counter[9]_i_1 
       (.I0(heartbeat_state_i_2_n_0),
        .I1(data0[9]),
        .O(heartbeat_counter[9]));
  FDRE \heartbeat_counter_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[0]),
        .Q(\heartbeat_counter_reg_n_0_[0] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[10] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[10]),
        .Q(\heartbeat_counter_reg_n_0_[10] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[11] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[11]),
        .Q(\heartbeat_counter_reg_n_0_[11] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[12] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[12]),
        .Q(\heartbeat_counter_reg_n_0_[12] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[13] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[13]),
        .Q(\heartbeat_counter_reg_n_0_[13] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[14] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[14]),
        .Q(\heartbeat_counter_reg_n_0_[14] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[15] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[15]),
        .Q(\heartbeat_counter_reg_n_0_[15] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[16] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[16]),
        .Q(\heartbeat_counter_reg_n_0_[16] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[17] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[17]),
        .Q(\heartbeat_counter_reg_n_0_[17] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[18] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[18]),
        .Q(\heartbeat_counter_reg_n_0_[18] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[19] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[19]),
        .Q(\heartbeat_counter_reg_n_0_[19] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[1]),
        .Q(\heartbeat_counter_reg_n_0_[1] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[20] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[20]),
        .Q(\heartbeat_counter_reg_n_0_[20] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[21] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[21]),
        .Q(\heartbeat_counter_reg_n_0_[21] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[22] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[22]),
        .Q(\heartbeat_counter_reg_n_0_[22] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[23] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[23]),
        .Q(\heartbeat_counter_reg_n_0_[23] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[24] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[24]),
        .Q(\heartbeat_counter_reg_n_0_[24] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[25] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[25]),
        .Q(\heartbeat_counter_reg_n_0_[25] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[2]),
        .Q(\heartbeat_counter_reg_n_0_[2] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[3]),
        .Q(\heartbeat_counter_reg_n_0_[3] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[4]),
        .Q(\heartbeat_counter_reg_n_0_[4] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[5]),
        .Q(\heartbeat_counter_reg_n_0_[5] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[6]),
        .Q(\heartbeat_counter_reg_n_0_[6] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[7]),
        .Q(\heartbeat_counter_reg_n_0_[7] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[8] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[8]),
        .Q(\heartbeat_counter_reg_n_0_[8] ),
        .R(clear));
  FDRE \heartbeat_counter_reg[9] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_counter[9]),
        .Q(\heartbeat_counter_reg_n_0_[9] ),
        .R(clear));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'h9)) 
    heartbeat_state_i_1
       (.I0(heartbeat_state_i_2_n_0),
        .I1(led_heartbeat),
        .O(heartbeat_state_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    heartbeat_state_i_2
       (.I0(heartbeat_state_i_3_n_0),
        .I1(heartbeat_state_i_4_n_0),
        .I2(heartbeat_state_i_5_n_0),
        .I3(heartbeat_state_i_6_n_0),
        .I4(heartbeat_state_i_7_n_0),
        .I5(heartbeat_state_i_8_n_0),
        .O(heartbeat_state_i_2_n_0));
  LUT4 #(
    .INIT(16'hFF7F)) 
    heartbeat_state_i_3
       (.I0(\heartbeat_counter_reg_n_0_[15] ),
        .I1(\heartbeat_counter_reg_n_0_[14] ),
        .I2(\heartbeat_counter_reg_n_0_[17] ),
        .I3(\heartbeat_counter_reg_n_0_[16] ),
        .O(heartbeat_state_i_3_n_0));
  LUT4 #(
    .INIT(16'hDFFF)) 
    heartbeat_state_i_4
       (.I0(\heartbeat_counter_reg_n_0_[19] ),
        .I1(\heartbeat_counter_reg_n_0_[18] ),
        .I2(\heartbeat_counter_reg_n_0_[21] ),
        .I3(\heartbeat_counter_reg_n_0_[20] ),
        .O(heartbeat_state_i_4_n_0));
  LUT4 #(
    .INIT(16'hFFFD)) 
    heartbeat_state_i_5
       (.I0(\heartbeat_counter_reg_n_0_[6] ),
        .I1(\heartbeat_counter_reg_n_0_[7] ),
        .I2(\heartbeat_counter_reg_n_0_[9] ),
        .I3(\heartbeat_counter_reg_n_0_[8] ),
        .O(heartbeat_state_i_5_n_0));
  LUT4 #(
    .INIT(16'hEFFF)) 
    heartbeat_state_i_6
       (.I0(\heartbeat_counter_reg_n_0_[11] ),
        .I1(\heartbeat_counter_reg_n_0_[10] ),
        .I2(\heartbeat_counter_reg_n_0_[13] ),
        .I3(\heartbeat_counter_reg_n_0_[12] ),
        .O(heartbeat_state_i_6_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    heartbeat_state_i_7
       (.I0(\heartbeat_counter_reg_n_0_[3] ),
        .I1(\heartbeat_counter_reg_n_0_[2] ),
        .I2(\heartbeat_counter_reg_n_0_[5] ),
        .I3(\heartbeat_counter_reg_n_0_[4] ),
        .O(heartbeat_state_i_7_n_0));
  LUT6 #(
    .INIT(64'hBFFFFFFFFFFFFFFF)) 
    heartbeat_state_i_8
       (.I0(\heartbeat_counter_reg_n_0_[24] ),
        .I1(\heartbeat_counter_reg_n_0_[25] ),
        .I2(\heartbeat_counter_reg_n_0_[22] ),
        .I3(\heartbeat_counter_reg_n_0_[23] ),
        .I4(\heartbeat_counter_reg_n_0_[1] ),
        .I5(\heartbeat_counter_reg_n_0_[0] ),
        .O(heartbeat_state_i_8_n_0));
  FDRE heartbeat_state_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(heartbeat_state_i_1_n_0),
        .Q(led_heartbeat),
        .R(clear));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \io_mode_reg[15]_i_1 
       (.I0(\sys_ctrl_reg[31]_i_2_n_0 ),
        .I1(\led_ctrl_reg[15]_i_3_n_0 ),
        .I2(\led_ctrl_reg[0]_i_3_n_0 ),
        .I3(\led_ctrl_reg[0]_i_6_n_0 ),
        .I4(\led_ctrl_reg[0]_i_5_n_0 ),
        .I5(\sys_ctrl_reg[31]_i_3_n_0 ),
        .O(\io_mode_reg[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \io_mode_reg[23]_i_1 
       (.I0(\sys_ctrl_reg[31]_i_2_n_0 ),
        .I1(\led_ctrl_reg[23]_i_3_n_0 ),
        .I2(\led_ctrl_reg[0]_i_3_n_0 ),
        .I3(\led_ctrl_reg[0]_i_6_n_0 ),
        .I4(\led_ctrl_reg[0]_i_5_n_0 ),
        .I5(\sys_ctrl_reg[31]_i_3_n_0 ),
        .O(\io_mode_reg[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \io_mode_reg[31]_i_1 
       (.I0(\sys_ctrl_reg[31]_i_2_n_0 ),
        .I1(\led_ctrl_reg[31]_i_3_n_0 ),
        .I2(\led_ctrl_reg[0]_i_3_n_0 ),
        .I3(\led_ctrl_reg[0]_i_6_n_0 ),
        .I4(\led_ctrl_reg[0]_i_5_n_0 ),
        .I5(\sys_ctrl_reg[31]_i_3_n_0 ),
        .O(\io_mode_reg[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \io_mode_reg[7]_i_1 
       (.I0(\sys_ctrl_reg[31]_i_2_n_0 ),
        .I1(\led_ctrl_reg[0]_i_7_n_0 ),
        .I2(\led_ctrl_reg[0]_i_3_n_0 ),
        .I3(\led_ctrl_reg[0]_i_6_n_0 ),
        .I4(\led_ctrl_reg[0]_i_5_n_0 ),
        .I5(\sys_ctrl_reg[31]_i_3_n_0 ),
        .O(\io_mode_reg[7]_i_1_n_0 ));
  FDRE \io_mode_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[7]_i_1_n_0 ),
        .D(event_arbiter_n_6),
        .Q(io_mode_reg[0]),
        .R(clear));
  FDRE \io_mode_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[10]_i_1_n_0 ),
        .Q(io_mode_reg[10]),
        .R(clear));
  FDRE \io_mode_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[11]_i_1_n_0 ),
        .Q(io_mode_reg[11]),
        .R(clear));
  FDRE \io_mode_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[12]_i_1_n_0 ),
        .Q(io_mode_reg[12]),
        .R(clear));
  FDRE \io_mode_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[13]_i_1_n_0 ),
        .Q(io_mode_reg[13]),
        .R(clear));
  FDRE \io_mode_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[14]_i_1_n_0 ),
        .Q(io_mode_reg[14]),
        .R(clear));
  FDRE \io_mode_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[15]_i_2_n_0 ),
        .Q(io_mode_reg[15]),
        .R(clear));
  FDRE \io_mode_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[16]_i_1_n_0 ),
        .Q(io_mode_reg[16]),
        .R(clear));
  FDRE \io_mode_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[17]_i_1_n_0 ),
        .Q(io_mode_reg[17]),
        .R(clear));
  FDRE \io_mode_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[18]_i_1_n_0 ),
        .Q(io_mode_reg[18]),
        .R(clear));
  FDRE \io_mode_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[19]_i_1_n_0 ),
        .Q(io_mode_reg[19]),
        .R(clear));
  FDRE \io_mode_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[7]_i_1_n_0 ),
        .D(p_0_in15_in),
        .Q(io_mode_reg[1]),
        .R(clear));
  FDRE \io_mode_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[20]_i_1_n_0 ),
        .Q(io_mode_reg[20]),
        .R(clear));
  FDRE \io_mode_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[21]_i_1_n_0 ),
        .Q(io_mode_reg[21]),
        .R(clear));
  FDRE \io_mode_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[22]_i_1_n_0 ),
        .Q(io_mode_reg[22]),
        .R(clear));
  FDRE \io_mode_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[23]_i_2_n_0 ),
        .Q(io_mode_reg[23]),
        .R(clear));
  FDRE \io_mode_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[24]_i_1_n_0 ),
        .Q(io_mode_reg[24]),
        .R(clear));
  FDRE \io_mode_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[25]_i_1_n_0 ),
        .Q(io_mode_reg[25]),
        .R(clear));
  FDRE \io_mode_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[26]_i_1_n_0 ),
        .Q(io_mode_reg[26]),
        .R(clear));
  FDRE \io_mode_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[27]_i_1_n_0 ),
        .Q(io_mode_reg[27]),
        .R(clear));
  FDRE \io_mode_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[28]_i_1_n_0 ),
        .Q(io_mode_reg[28]),
        .R(clear));
  FDRE \io_mode_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[29]_i_1_n_0 ),
        .Q(io_mode_reg[29]),
        .R(clear));
  FDRE \io_mode_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[7]_i_1_n_0 ),
        .D(p_0_in13_in),
        .Q(io_mode_reg[2]),
        .R(clear));
  FDRE \io_mode_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[30]_i_1_n_0 ),
        .Q(io_mode_reg[30]),
        .R(clear));
  FDRE \io_mode_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[31]_i_1_n_0 ),
        .D(p_0_in10_in),
        .Q(io_mode_reg[31]),
        .R(clear));
  FDRE \io_mode_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[3]_i_1_n_0 ),
        .Q(io_mode_reg[3]),
        .R(clear));
  FDRE \io_mode_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[4]_i_1_n_0 ),
        .Q(io_mode_reg[4]),
        .R(clear));
  FDRE \io_mode_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[5]_i_1_n_0 ),
        .Q(io_mode_reg[5]),
        .R(clear));
  FDRE \io_mode_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[6]_i_1_n_0 ),
        .Q(io_mode_reg[6]),
        .R(clear));
  FDRE \io_mode_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[7]_i_1_n_0 ),
        .Q(io_mode_reg[7]),
        .R(clear));
  FDRE \io_mode_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[8]_i_1_n_0 ),
        .Q(io_mode_reg[8]),
        .R(clear));
  FDRE \io_mode_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(\io_mode_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[9]_i_1_n_0 ),
        .Q(io_mode_reg[9]),
        .R(clear));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \irq_enable_reg[15]_i_1 
       (.I0(\irq_enable_reg[31]_i_3_n_0 ),
        .I1(\led_ctrl_reg[0]_i_3_n_0 ),
        .I2(\led_ctrl_reg[0]_i_6_n_0 ),
        .I3(\led_ctrl_reg[0]_i_5_n_0 ),
        .I4(\irq_enable_reg[31]_i_2_n_0 ),
        .I5(\led_ctrl_reg[15]_i_3_n_0 ),
        .O(\irq_enable_reg[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \irq_enable_reg[23]_i_1 
       (.I0(\irq_enable_reg[31]_i_3_n_0 ),
        .I1(\led_ctrl_reg[0]_i_3_n_0 ),
        .I2(\led_ctrl_reg[0]_i_6_n_0 ),
        .I3(\led_ctrl_reg[0]_i_5_n_0 ),
        .I4(\irq_enable_reg[31]_i_2_n_0 ),
        .I5(\led_ctrl_reg[23]_i_3_n_0 ),
        .O(\irq_enable_reg[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \irq_enable_reg[31]_i_1 
       (.I0(\irq_enable_reg[31]_i_2_n_0 ),
        .I1(\led_ctrl_reg[31]_i_3_n_0 ),
        .I2(\irq_enable_reg[31]_i_3_n_0 ),
        .I3(\led_ctrl_reg[0]_i_3_n_0 ),
        .I4(\led_ctrl_reg[0]_i_6_n_0 ),
        .I5(\led_ctrl_reg[0]_i_5_n_0 ),
        .O(\irq_enable_reg[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCFAACFFFFFFFFFFF)) 
    \irq_enable_reg[31]_i_2 
       (.I0(s_axi_awaddr[4]),
        .I1(awaddr_reg[4]),
        .I2(awaddr_reg[5]),
        .I3(aw_pending),
        .I4(s_axi_awaddr[5]),
        .I5(event_arbiter_n_17),
        .O(\irq_enable_reg[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h33553355F3FFF355)) 
    \irq_enable_reg[31]_i_3 
       (.I0(s_axi_awaddr[5]),
        .I1(awaddr_reg[5]),
        .I2(awaddr_reg[3]),
        .I3(aw_pending),
        .I4(s_axi_awaddr[3]),
        .I5(write_addr),
        .O(\irq_enable_reg[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \irq_enable_reg[7]_i_1 
       (.I0(\irq_enable_reg[31]_i_3_n_0 ),
        .I1(\led_ctrl_reg[0]_i_3_n_0 ),
        .I2(\led_ctrl_reg[0]_i_6_n_0 ),
        .I3(\led_ctrl_reg[0]_i_5_n_0 ),
        .I4(\irq_enable_reg[31]_i_2_n_0 ),
        .I5(\led_ctrl_reg[0]_i_7_n_0 ),
        .O(\irq_enable_reg[7]_i_1_n_0 ));
  FDRE \irq_enable_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[7]_i_1_n_0 ),
        .D(event_arbiter_n_6),
        .Q(irq_enable_reg[0]),
        .R(clear));
  FDRE \irq_enable_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[10]_i_1_n_0 ),
        .Q(irq_enable_reg[10]),
        .R(clear));
  FDRE \irq_enable_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[11]_i_1_n_0 ),
        .Q(irq_enable_reg[11]),
        .R(clear));
  FDRE \irq_enable_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[12]_i_1_n_0 ),
        .Q(irq_enable_reg[12]),
        .R(clear));
  FDRE \irq_enable_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[13]_i_1_n_0 ),
        .Q(irq_enable_reg[13]),
        .R(clear));
  FDRE \irq_enable_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[14]_i_1_n_0 ),
        .Q(irq_enable_reg[14]),
        .R(clear));
  FDRE \irq_enable_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[15]_i_2_n_0 ),
        .Q(irq_enable_reg[15]),
        .R(clear));
  FDRE \irq_enable_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[16]_i_1_n_0 ),
        .Q(irq_enable_reg[16]),
        .R(clear));
  FDRE \irq_enable_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[17]_i_1_n_0 ),
        .Q(irq_enable_reg[17]),
        .R(clear));
  FDRE \irq_enable_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[18]_i_1_n_0 ),
        .Q(irq_enable_reg[18]),
        .R(clear));
  FDRE \irq_enable_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[19]_i_1_n_0 ),
        .Q(irq_enable_reg[19]),
        .R(clear));
  FDRE \irq_enable_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[7]_i_1_n_0 ),
        .D(p_0_in15_in),
        .Q(irq_enable_reg[1]),
        .R(clear));
  FDRE \irq_enable_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[20]_i_1_n_0 ),
        .Q(irq_enable_reg[20]),
        .R(clear));
  FDRE \irq_enable_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[21]_i_1_n_0 ),
        .Q(irq_enable_reg[21]),
        .R(clear));
  FDRE \irq_enable_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[22]_i_1_n_0 ),
        .Q(irq_enable_reg[22]),
        .R(clear));
  FDRE \irq_enable_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[23]_i_2_n_0 ),
        .Q(irq_enable_reg[23]),
        .R(clear));
  FDRE \irq_enable_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[24]_i_1_n_0 ),
        .Q(irq_enable_reg[24]),
        .R(clear));
  FDRE \irq_enable_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[25]_i_1_n_0 ),
        .Q(irq_enable_reg[25]),
        .R(clear));
  FDRE \irq_enable_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[26]_i_1_n_0 ),
        .Q(irq_enable_reg[26]),
        .R(clear));
  FDRE \irq_enable_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[27]_i_1_n_0 ),
        .Q(irq_enable_reg[27]),
        .R(clear));
  FDRE \irq_enable_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[28]_i_1_n_0 ),
        .Q(irq_enable_reg[28]),
        .R(clear));
  FDRE \irq_enable_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[29]_i_1_n_0 ),
        .Q(irq_enable_reg[29]),
        .R(clear));
  FDRE \irq_enable_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[7]_i_1_n_0 ),
        .D(p_0_in13_in),
        .Q(irq_enable_reg[2]),
        .R(clear));
  FDRE \irq_enable_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[30]_i_1_n_0 ),
        .Q(irq_enable_reg[30]),
        .R(clear));
  FDRE \irq_enable_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[31]_i_1_n_0 ),
        .D(p_0_in10_in),
        .Q(irq_enable_reg[31]),
        .R(clear));
  FDRE \irq_enable_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[3]_i_1_n_0 ),
        .Q(irq_enable_reg[3]),
        .R(clear));
  FDRE \irq_enable_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[4]_i_1_n_0 ),
        .Q(irq_enable_reg[4]),
        .R(clear));
  FDRE \irq_enable_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[5]_i_1_n_0 ),
        .Q(irq_enable_reg[5]),
        .R(clear));
  FDRE \irq_enable_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[6]_i_1_n_0 ),
        .Q(irq_enable_reg[6]),
        .R(clear));
  FDRE \irq_enable_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[7]_i_1_n_0 ),
        .Q(irq_enable_reg[7]),
        .R(clear));
  FDRE \irq_enable_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[8]_i_1_n_0 ),
        .Q(irq_enable_reg[8]),
        .R(clear));
  FDRE \irq_enable_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(\irq_enable_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[9]_i_1_n_0 ),
        .Q(irq_enable_reg[9]),
        .R(clear));
  LUT5 #(
    .INIT(32'h00000001)) 
    \led_ctrl_reg[0]_i_1 
       (.I0(\led_ctrl_reg[0]_i_3_n_0 ),
        .I1(\led_ctrl_reg[0]_i_4_n_0 ),
        .I2(\led_ctrl_reg[0]_i_5_n_0 ),
        .I3(\led_ctrl_reg[0]_i_6_n_0 ),
        .I4(\led_ctrl_reg[0]_i_7_n_0 ),
        .O(\led_ctrl_reg[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[0]_i_10 
       (.I0(awaddr_reg[0]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[0]),
        .O(\led_ctrl_reg[0]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'h0000FFFE)) 
    \led_ctrl_reg[0]_i_11 
       (.I0(s_axi_awaddr[13]),
        .I1(s_axi_awaddr[14]),
        .I2(aw_pending),
        .I3(s_axi_awaddr[15]),
        .I4(event_arbiter_n_16),
        .O(\led_ctrl_reg[0]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h00053305)) 
    \led_ctrl_reg[0]_i_12 
       (.I0(s_axi_awaddr[0]),
        .I1(awaddr_reg[0]),
        .I2(s_axi_awaddr[12]),
        .I3(aw_pending),
        .I4(awaddr_reg[12]),
        .O(\led_ctrl_reg[0]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[0]_i_13 
       (.I0(awaddr_reg[6]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[6]),
        .O(\led_ctrl_reg[0]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFAAAAFEAE)) 
    \led_ctrl_reg[0]_i_3 
       (.I0(\led_ctrl_reg[0]_i_8_n_0 ),
        .I1(s_axi_awaddr[2]),
        .I2(aw_pending),
        .I3(awaddr_reg[2]),
        .I4(\led_ctrl_reg[0]_i_9_n_0 ),
        .I5(\led_ctrl_reg[0]_i_10_n_0 ),
        .O(\led_ctrl_reg[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF47FFFFFF)) 
    \led_ctrl_reg[0]_i_4 
       (.I0(awaddr_reg[5]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[5]),
        .I3(event_arbiter_n_17),
        .I4(write_addr),
        .I5(event_arbiter_n_14),
        .O(\led_ctrl_reg[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEFEFFFFAEFEA)) 
    \led_ctrl_reg[0]_i_5 
       (.I0(event_arbiter_n_18),
        .I1(awaddr_reg[10]),
        .I2(aw_pending),
        .I3(s_axi_awaddr[10]),
        .I4(awaddr_reg[9]),
        .I5(s_axi_awaddr[9]),
        .O(\led_ctrl_reg[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'hFEFFFEEE)) 
    \led_ctrl_reg[0]_i_6 
       (.I0(capture_arm_pulse_i_4_n_0),
        .I1(\led_ctrl_reg[0]_i_11_n_0 ),
        .I2(awaddr_reg[11]),
        .I3(aw_pending),
        .I4(s_axi_awaddr[11]),
        .O(\led_ctrl_reg[0]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h1DFF)) 
    \led_ctrl_reg[0]_i_7 
       (.I0(s_axi_wstrb[0]),
        .I1(w_pending_reg_n_0),
        .I2(wstrb_reg[0]),
        .I3(\led_ctrl_reg[0]_i_12_n_0 ),
        .O(\led_ctrl_reg[0]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCFCCAFAFCFCCAAAA)) 
    \led_ctrl_reg[0]_i_8 
       (.I0(s_axi_awaddr[7]),
        .I1(awaddr_reg[7]),
        .I2(\led_ctrl_reg[0]_i_13_n_0 ),
        .I3(awaddr_reg[1]),
        .I4(aw_pending),
        .I5(s_axi_awaddr[1]),
        .O(\led_ctrl_reg[0]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[0]_i_9 
       (.I0(awaddr_reg[12]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[12]),
        .O(\led_ctrl_reg[0]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[10]_i_1 
       (.I0(wdata_reg[10]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[10]),
        .O(\led_ctrl_reg[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[11]_i_1 
       (.I0(wdata_reg[11]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[11]),
        .O(\led_ctrl_reg[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[12]_i_1 
       (.I0(wdata_reg[12]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[12]),
        .O(\led_ctrl_reg[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[13]_i_1 
       (.I0(wdata_reg[13]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[13]),
        .O(\led_ctrl_reg[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[14]_i_1 
       (.I0(wdata_reg[14]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[14]),
        .O(\led_ctrl_reg[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \led_ctrl_reg[15]_i_1 
       (.I0(\led_ctrl_reg[0]_i_3_n_0 ),
        .I1(\led_ctrl_reg[0]_i_4_n_0 ),
        .I2(\led_ctrl_reg[0]_i_5_n_0 ),
        .I3(\led_ctrl_reg[0]_i_6_n_0 ),
        .I4(\led_ctrl_reg[15]_i_3_n_0 ),
        .O(\led_ctrl_reg[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[15]_i_2 
       (.I0(wdata_reg[15]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[15]),
        .O(\led_ctrl_reg[15]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h57F7)) 
    \led_ctrl_reg[15]_i_3 
       (.I0(\led_ctrl_reg[0]_i_12_n_0 ),
        .I1(s_axi_wstrb[1]),
        .I2(w_pending_reg_n_0),
        .I3(wstrb_reg[1]),
        .O(\led_ctrl_reg[15]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[16]_i_1 
       (.I0(wdata_reg[16]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[16]),
        .O(\led_ctrl_reg[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[17]_i_1 
       (.I0(wdata_reg[17]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[17]),
        .O(\led_ctrl_reg[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[18]_i_1 
       (.I0(wdata_reg[18]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[18]),
        .O(\led_ctrl_reg[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[19]_i_1 
       (.I0(wdata_reg[19]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[19]),
        .O(\led_ctrl_reg[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[1]_i_1 
       (.I0(wdata_reg[1]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[1]),
        .O(p_0_in15_in));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[20]_i_1 
       (.I0(wdata_reg[20]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[20]),
        .O(\led_ctrl_reg[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[21]_i_1 
       (.I0(wdata_reg[21]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[21]),
        .O(\led_ctrl_reg[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[22]_i_1 
       (.I0(wdata_reg[22]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[22]),
        .O(\led_ctrl_reg[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \led_ctrl_reg[23]_i_1 
       (.I0(\led_ctrl_reg[0]_i_3_n_0 ),
        .I1(\led_ctrl_reg[0]_i_4_n_0 ),
        .I2(\led_ctrl_reg[0]_i_5_n_0 ),
        .I3(\led_ctrl_reg[0]_i_6_n_0 ),
        .I4(\led_ctrl_reg[23]_i_3_n_0 ),
        .O(\led_ctrl_reg[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[23]_i_2 
       (.I0(wdata_reg[23]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[23]),
        .O(\led_ctrl_reg[23]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'h57F7)) 
    \led_ctrl_reg[23]_i_3 
       (.I0(\led_ctrl_reg[0]_i_12_n_0 ),
        .I1(s_axi_wstrb[2]),
        .I2(w_pending_reg_n_0),
        .I3(wstrb_reg[2]),
        .O(\led_ctrl_reg[23]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[24]_i_1 
       (.I0(wdata_reg[24]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[24]),
        .O(\led_ctrl_reg[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[25]_i_1 
       (.I0(wdata_reg[25]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[25]),
        .O(\led_ctrl_reg[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[26]_i_1 
       (.I0(wdata_reg[26]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[26]),
        .O(\led_ctrl_reg[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[27]_i_1 
       (.I0(wdata_reg[27]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[27]),
        .O(\led_ctrl_reg[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[28]_i_1 
       (.I0(wdata_reg[28]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[28]),
        .O(\led_ctrl_reg[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[29]_i_1 
       (.I0(wdata_reg[29]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[29]),
        .O(\led_ctrl_reg[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[2]_i_1 
       (.I0(wdata_reg[2]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[2]),
        .O(p_0_in13_in));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[30]_i_1 
       (.I0(wdata_reg[30]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[30]),
        .O(\led_ctrl_reg[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \led_ctrl_reg[31]_i_1 
       (.I0(\led_ctrl_reg[31]_i_3_n_0 ),
        .I1(\led_ctrl_reg[0]_i_3_n_0 ),
        .I2(\led_ctrl_reg[0]_i_4_n_0 ),
        .I3(\led_ctrl_reg[0]_i_5_n_0 ),
        .I4(\led_ctrl_reg[0]_i_6_n_0 ),
        .O(\led_ctrl_reg[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[31]_i_2 
       (.I0(wdata_reg[31]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[31]),
        .O(p_0_in10_in));
  LUT4 #(
    .INIT(16'hE200)) 
    \led_ctrl_reg[31]_i_3 
       (.I0(s_axi_wstrb[3]),
        .I1(w_pending_reg_n_0),
        .I2(wstrb_reg[3]),
        .I3(\led_ctrl_reg[0]_i_12_n_0 ),
        .O(\led_ctrl_reg[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[3]_i_1 
       (.I0(wdata_reg[3]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[3]),
        .O(\led_ctrl_reg[3]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[4]_i_1 
       (.I0(wdata_reg[4]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[4]),
        .O(\led_ctrl_reg[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[5]_i_1 
       (.I0(wdata_reg[5]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[5]),
        .O(\led_ctrl_reg[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[6]_i_1 
       (.I0(wdata_reg[6]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[6]),
        .O(\led_ctrl_reg[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[7]_i_1 
       (.I0(wdata_reg[7]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[7]),
        .O(\led_ctrl_reg[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[8]_i_1 
       (.I0(wdata_reg[8]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[8]),
        .O(\led_ctrl_reg[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \led_ctrl_reg[9]_i_1 
       (.I0(wdata_reg[9]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wdata[9]),
        .O(\led_ctrl_reg[9]_i_1_n_0 ));
  FDRE \led_ctrl_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[0]_i_1_n_0 ),
        .D(event_arbiter_n_6),
        .Q(led_ps_active),
        .R(clear));
  FDRE \led_ctrl_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[10]_i_1_n_0 ),
        .Q(led_ctrl_reg[10]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[11]_i_1_n_0 ),
        .Q(led_ctrl_reg[11]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[12]_i_1_n_0 ),
        .Q(led_ctrl_reg[12]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[13]_i_1_n_0 ),
        .Q(led_ctrl_reg[13]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[14]_i_1_n_0 ),
        .Q(led_ctrl_reg[14]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[15]_i_2_n_0 ),
        .Q(led_ctrl_reg[15]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[16]_i_1_n_0 ),
        .Q(led_ctrl_reg[16]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[17]_i_1_n_0 ),
        .Q(led_ctrl_reg[17]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[18]_i_1_n_0 ),
        .Q(led_ctrl_reg[18]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[19]_i_1_n_0 ),
        .Q(led_ctrl_reg[19]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[0]_i_1_n_0 ),
        .D(p_0_in15_in),
        .Q(led_ctrl_reg[1]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[20]_i_1_n_0 ),
        .Q(led_ctrl_reg[20]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[21]_i_1_n_0 ),
        .Q(led_ctrl_reg[21]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[22]_i_1_n_0 ),
        .Q(led_ctrl_reg[22]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[23]_i_2_n_0 ),
        .Q(led_ctrl_reg[23]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[24]_i_1_n_0 ),
        .Q(led_ctrl_reg[24]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[25]_i_1_n_0 ),
        .Q(led_ctrl_reg[25]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[26]_i_1_n_0 ),
        .Q(led_ctrl_reg[26]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[27]_i_1_n_0 ),
        .Q(led_ctrl_reg[27]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[28]_i_1_n_0 ),
        .Q(led_ctrl_reg[28]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[29]_i_1_n_0 ),
        .Q(led_ctrl_reg[29]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[0]_i_1_n_0 ),
        .D(p_0_in13_in),
        .Q(led_ctrl_reg[2]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[30]_i_1_n_0 ),
        .Q(led_ctrl_reg[30]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[31]_i_1_n_0 ),
        .D(p_0_in10_in),
        .Q(led_ctrl_reg[31]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[0]_i_1_n_0 ),
        .D(\led_ctrl_reg[3]_i_1_n_0 ),
        .Q(led_ctrl_reg[3]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[0]_i_1_n_0 ),
        .D(\led_ctrl_reg[4]_i_1_n_0 ),
        .Q(led_ctrl_reg[4]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[0]_i_1_n_0 ),
        .D(\led_ctrl_reg[5]_i_1_n_0 ),
        .Q(led_ctrl_reg[5]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[0]_i_1_n_0 ),
        .D(\led_ctrl_reg[6]_i_1_n_0 ),
        .Q(led_ctrl_reg[6]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[0]_i_1_n_0 ),
        .D(\led_ctrl_reg[7]_i_1_n_0 ),
        .Q(led_ctrl_reg[7]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[8]_i_1_n_0 ),
        .Q(led_ctrl_reg[8]),
        .R(clear));
  FDRE \led_ctrl_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(\led_ctrl_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[9]_i_1_n_0 ),
        .Q(led_ctrl_reg[9]),
        .R(clear));
  LUT2 #(
    .INIT(4'h1)) 
    s_axi_arready_i_1
       (.I0(snapshot_read_pending_reg_n_0),
        .I1(s_axi_rvalid),
        .O(s_axi_arready0));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) 
  FDRE s_axi_arready_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_arready0),
        .Q(s_axi_arready),
        .R(clear));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h1)) 
    s_axi_awready_i_2
       (.I0(s_axi_bvalid_reg_0),
        .I1(aw_pending),
        .O(s_axi_awready0));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) 
  FDRE s_axi_awready_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_awready0),
        .Q(s_axi_awready),
        .R(clear));
  LUT6 #(
    .INIT(64'h0000EEE0FFFFEEE0)) 
    s_axi_bvalid_i_1
       (.I0(aw_pending),
        .I1(aw_hs),
        .I2(w_hs),
        .I3(w_pending_reg_n_0),
        .I4(s_axi_bvalid_reg_0),
        .I5(s_axi_bready),
        .O(s_axi_bvalid_i_1_n_0));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) 
  FDRE s_axi_bvalid_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_bvalid_i_1_n_0),
        .Q(s_axi_bvalid_reg_0),
        .R(clear));
  CARRY4 s_axi_rdata2_carry
       (.CI(1'b0),
        .CO({s_axi_rdata2_carry_n_0,s_axi_rdata2_carry_n_1,s_axi_rdata2_carry_n_2,s_axi_rdata2_carry_n_3}),
        .CYINIT(1'b0),
        .DI({capture_buffer_n_77,capture_buffer_n_78,capture_buffer_n_79,capture_buffer_n_80}),
        .O(NLW_s_axi_rdata2_carry_O_UNCONNECTED[3:0]),
        .S({capture_buffer_n_73,capture_buffer_n_74,capture_buffer_n_75,capture_buffer_n_76}));
  CARRY4 s_axi_rdata2_carry__0
       (.CI(s_axi_rdata2_carry_n_0),
        .CO({NLW_s_axi_rdata2_carry__0_CO_UNCONNECTED[3:1],s_axi_rdata2}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,snapshot_count}),
        .O(NLW_s_axi_rdata2_carry__0_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,1'b0,capture_buffer_n_81}));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[0]_i_7 
       (.I0(scratch_reg[0]),
        .I1(data5[0]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[0]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[0]),
        .O(\s_axi_rdata[0]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h1414544414141404)) 
    \s_axi_rdata[0]_i_8 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[3]),
        .I2(s_axi_araddr[4]),
        .I3(sys_ctrl_reg[0]),
        .I4(s_axi_araddr[2]),
        .I5(io_mode_reg[0]),
        .O(\s_axi_rdata[0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \s_axi_rdata[10]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[10]),
        .I2(sys_ctrl_reg[10]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(s_axi_araddr[12]),
        .I5(s_axi_araddr[0]),
        .O(\s_axi_rdata[10]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[10]_i_6 
       (.I0(scratch_reg[10]),
        .I1(data5[10]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[10]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[10]),
        .O(\s_axi_rdata[10]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF44F4)) 
    \s_axi_rdata[11]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[11]),
        .I2(sys_ctrl_reg[11]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(\s_axi_rdata[29]_i_9_n_0 ),
        .O(\s_axi_rdata[11]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[11]_i_6 
       (.I0(scratch_reg[11]),
        .I1(data5[11]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[11]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[11]),
        .O(\s_axi_rdata[11]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[12]_i_6 
       (.I0(scratch_reg[12]),
        .I1(data5[12]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[12]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[12]),
        .O(\s_axi_rdata[12]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000445100000051)) 
    \s_axi_rdata[12]_i_7 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[4]),
        .I2(sys_ctrl_reg[12]),
        .I3(s_axi_araddr[3]),
        .I4(s_axi_araddr[2]),
        .I5(io_mode_reg[12]),
        .O(\s_axi_rdata[12]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \s_axi_rdata[13]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[13]),
        .I2(sys_ctrl_reg[13]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(s_axi_araddr[12]),
        .I5(s_axi_araddr[0]),
        .O(\s_axi_rdata[13]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[13]_i_6 
       (.I0(scratch_reg[13]),
        .I1(data5[13]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[13]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[13]),
        .O(\s_axi_rdata[13]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF444F4F4)) 
    \s_axi_rdata[14]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[14]),
        .I2(\s_axi_rdata[30]_i_9_n_0 ),
        .I3(sys_ctrl_reg[14]),
        .I4(s_axi_araddr[4]),
        .I5(\s_axi_rdata[31]_i_12_n_0 ),
        .O(\s_axi_rdata[14]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[14]_i_6 
       (.I0(scratch_reg[14]),
        .I1(data5[14]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[14]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[14]),
        .O(\s_axi_rdata[14]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \s_axi_rdata[15]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[15]),
        .I2(sys_ctrl_reg[15]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(s_axi_araddr[12]),
        .I5(s_axi_araddr[0]),
        .O(\s_axi_rdata[15]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[15]_i_6 
       (.I0(scratch_reg[15]),
        .I1(data5[15]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[15]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[15]),
        .O(\s_axi_rdata[15]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[16]_i_5 
       (.I0(scratch_reg[16]),
        .I1(data5[16]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[16]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[16]),
        .O(\s_axi_rdata[16]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFAEFFEEFFBEFFFEF)) 
    \s_axi_rdata[16]_i_7 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[3]),
        .I2(s_axi_araddr[2]),
        .I3(s_axi_araddr[4]),
        .I4(io_mode_reg[16]),
        .I5(sys_ctrl_reg[16]),
        .O(\s_axi_rdata[16]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF44F4)) 
    \s_axi_rdata[17]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[17]),
        .I2(sys_ctrl_reg[17]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(\s_axi_rdata[29]_i_9_n_0 ),
        .O(\s_axi_rdata[17]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[17]_i_6 
       (.I0(scratch_reg[17]),
        .I1(data5[17]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[17]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[17]),
        .O(\s_axi_rdata[17]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF44F4)) 
    \s_axi_rdata[18]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[18]),
        .I2(sys_ctrl_reg[18]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(\s_axi_rdata[29]_i_9_n_0 ),
        .O(\s_axi_rdata[18]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[18]_i_6 
       (.I0(scratch_reg[18]),
        .I1(data5[18]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[18]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[18]),
        .O(\s_axi_rdata[18]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \s_axi_rdata[19]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[19]),
        .I2(sys_ctrl_reg[19]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(s_axi_araddr[12]),
        .I5(s_axi_araddr[0]),
        .O(\s_axi_rdata[19]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[19]_i_6 
       (.I0(scratch_reg[19]),
        .I1(data5[19]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[19]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[19]),
        .O(\s_axi_rdata[19]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[1]_i_7 
       (.I0(scratch_reg[1]),
        .I1(data5[1]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[1]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[1]),
        .O(\s_axi_rdata[1]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0505050545455000)) 
    \s_axi_rdata[1]_i_8 
       (.I0(s_axi_araddr[5]),
        .I1(io_mode_reg[1]),
        .I2(s_axi_araddr[4]),
        .I3(sys_ctrl_reg[1]),
        .I4(s_axi_araddr[3]),
        .I5(s_axi_araddr[2]),
        .O(\s_axi_rdata[1]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[20]_i_6 
       (.I0(scratch_reg[20]),
        .I1(data5[20]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[20]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[20]),
        .O(\s_axi_rdata[20]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000445100000051)) 
    \s_axi_rdata[20]_i_7 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[4]),
        .I2(sys_ctrl_reg[20]),
        .I3(s_axi_araddr[3]),
        .I4(s_axi_araddr[2]),
        .I5(io_mode_reg[20]),
        .O(\s_axi_rdata[20]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF44F4)) 
    \s_axi_rdata[21]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[21]),
        .I2(sys_ctrl_reg[21]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(\s_axi_rdata[29]_i_9_n_0 ),
        .O(\s_axi_rdata[21]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[21]_i_6 
       (.I0(scratch_reg[21]),
        .I1(data5[21]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[21]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[21]),
        .O(\s_axi_rdata[21]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[22]_i_6 
       (.I0(scratch_reg[22]),
        .I1(data5[22]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[22]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[22]),
        .O(\s_axi_rdata[22]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000445100000051)) 
    \s_axi_rdata[22]_i_7 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[4]),
        .I2(sys_ctrl_reg[22]),
        .I3(s_axi_araddr[3]),
        .I4(s_axi_araddr[2]),
        .I5(io_mode_reg[22]),
        .O(\s_axi_rdata[22]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \s_axi_rdata[23]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[23]),
        .I2(sys_ctrl_reg[23]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(s_axi_araddr[12]),
        .I5(s_axi_araddr[0]),
        .O(\s_axi_rdata[23]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[23]_i_6 
       (.I0(scratch_reg[23]),
        .I1(data5[23]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[23]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[23]),
        .O(\s_axi_rdata[23]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF444F4F4)) 
    \s_axi_rdata[24]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[24]),
        .I2(\s_axi_rdata[30]_i_9_n_0 ),
        .I3(sys_ctrl_reg[24]),
        .I4(s_axi_araddr[4]),
        .I5(\s_axi_rdata[31]_i_12_n_0 ),
        .O(\s_axi_rdata[24]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[24]_i_6 
       (.I0(scratch_reg[24]),
        .I1(data5[24]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[24]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[24]),
        .O(\s_axi_rdata[24]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \s_axi_rdata[25]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[25]),
        .I2(sys_ctrl_reg[25]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(s_axi_araddr[12]),
        .I5(s_axi_araddr[0]),
        .O(\s_axi_rdata[25]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[25]_i_6 
       (.I0(scratch_reg[25]),
        .I1(data5[25]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[25]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[25]),
        .O(\s_axi_rdata[25]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[26]_i_6 
       (.I0(scratch_reg[26]),
        .I1(data5[26]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[26]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[26]),
        .O(\s_axi_rdata[26]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000445100000051)) 
    \s_axi_rdata[26]_i_7 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[4]),
        .I2(sys_ctrl_reg[26]),
        .I3(s_axi_araddr[3]),
        .I4(s_axi_araddr[2]),
        .I5(io_mode_reg[26]),
        .O(\s_axi_rdata[26]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000445100000051)) 
    \s_axi_rdata[27]_i_10 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[4]),
        .I2(sys_ctrl_reg[27]),
        .I3(s_axi_araddr[3]),
        .I4(s_axi_araddr[2]),
        .I5(io_mode_reg[27]),
        .O(\s_axi_rdata[27]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFEFEFE)) 
    \s_axi_rdata[27]_i_7 
       (.I0(s_axi_araddr[6]),
        .I1(s_axi_araddr[1]),
        .I2(s_axi_araddr[8]),
        .I3(s_axi_araddr[5]),
        .I4(s_axi_araddr[12]),
        .I5(s_axi_araddr[15]),
        .O(\s_axi_rdata[27]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[27]_i_9 
       (.I0(scratch_reg[27]),
        .I1(data5[27]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[27]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[27]),
        .O(\s_axi_rdata[27]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \s_axi_rdata[28]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[28]),
        .I2(sys_ctrl_reg[28]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(s_axi_araddr[12]),
        .I5(s_axi_araddr[0]),
        .O(\s_axi_rdata[28]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[28]_i_6 
       (.I0(scratch_reg[28]),
        .I1(data5[28]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[28]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[28]),
        .O(\s_axi_rdata[28]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF44F4)) 
    \s_axi_rdata[29]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[29]),
        .I2(sys_ctrl_reg[29]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(\s_axi_rdata[29]_i_9_n_0 ),
        .O(\s_axi_rdata[29]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[29]_i_6 
       (.I0(scratch_reg[29]),
        .I1(data5[29]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[29]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[29]),
        .O(\s_axi_rdata[29]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'hFEFF)) 
    \s_axi_rdata[29]_i_8 
       (.I0(s_axi_araddr[3]),
        .I1(s_axi_araddr[2]),
        .I2(s_axi_araddr[5]),
        .I3(s_axi_araddr[4]),
        .O(\s_axi_rdata[29]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h4444444444444F44)) 
    \s_axi_rdata[29]_i_9 
       (.I0(s_axi_araddr[0]),
        .I1(s_axi_araddr[12]),
        .I2(s_axi_araddr[4]),
        .I3(s_axi_araddr[3]),
        .I4(s_axi_araddr[2]),
        .I5(s_axi_araddr[5]),
        .O(\s_axi_rdata[29]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[2]_i_7 
       (.I0(scratch_reg[2]),
        .I1(data5[2]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[2]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[2]),
        .O(\s_axi_rdata[2]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000445100000051)) 
    \s_axi_rdata[2]_i_8 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[4]),
        .I2(sys_ctrl_reg[2]),
        .I3(s_axi_araddr[3]),
        .I4(s_axi_araddr[2]),
        .I5(io_mode_reg[2]),
        .O(\s_axi_rdata[2]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF444F4F4)) 
    \s_axi_rdata[30]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[30]),
        .I2(\s_axi_rdata[30]_i_9_n_0 ),
        .I3(sys_ctrl_reg[30]),
        .I4(s_axi_araddr[4]),
        .I5(\s_axi_rdata[31]_i_12_n_0 ),
        .O(\s_axi_rdata[30]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[30]_i_6 
       (.I0(scratch_reg[30]),
        .I1(data5[30]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[30]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[30]),
        .O(\s_axi_rdata[30]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'hFBFF)) 
    \s_axi_rdata[30]_i_8 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[4]),
        .I2(s_axi_araddr[2]),
        .I3(s_axi_araddr[3]),
        .O(\s_axi_rdata[30]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \s_axi_rdata[30]_i_9 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[3]),
        .I2(s_axi_araddr[2]),
        .O(\s_axi_rdata[30]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hAFAEAAAEAAAAAAAA)) 
    \s_axi_rdata[31]_i_10 
       (.I0(\s_axi_rdata[31]_i_12_n_0 ),
        .I1(sys_ctrl_reg[31]),
        .I2(s_axi_araddr[2]),
        .I3(s_axi_araddr[3]),
        .I4(io_mode_reg[31]),
        .I5(\s_axi_rdata[31]_i_16_n_0 ),
        .O(\s_axi_rdata[31]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \s_axi_rdata[31]_i_11 
       (.I0(s_axi_araddr[4]),
        .I1(s_axi_araddr[3]),
        .I2(s_axi_araddr[2]),
        .O(\s_axi_rdata[31]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \s_axi_rdata[31]_i_12 
       (.I0(s_axi_araddr[12]),
        .I1(s_axi_araddr[0]),
        .O(\s_axi_rdata[31]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \s_axi_rdata[31]_i_13 
       (.I0(s_axi_araddr[2]),
        .I1(s_axi_araddr[3]),
        .I2(s_axi_araddr[4]),
        .O(\s_axi_rdata[31]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[31]_i_14 
       (.I0(scratch_reg[31]),
        .I1(data5[31]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[31]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[31]),
        .O(\s_axi_rdata[31]_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \s_axi_rdata[31]_i_16 
       (.I0(s_axi_araddr[4]),
        .I1(s_axi_araddr[5]),
        .O(\s_axi_rdata[31]_i_16_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'hEFFF)) 
    \s_axi_rdata[31]_i_4 
       (.I0(s_axi_araddr[12]),
        .I1(s_axi_araddr[15]),
        .I2(s_axi_araddr[14]),
        .I3(s_axi_araddr[13]),
        .O(\s_axi_rdata[31]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \s_axi_rdata[31]_i_5 
       (.I0(s_axi_arready),
        .I1(s_axi_arvalid),
        .O(\s_axi_rdata[31]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_10 
       (.I0(\s_axi_rdata[3]_i_14_n_0 ),
        .I1(\s_axi_rdata[3]_i_15_n_0 ),
        .I2(\s_axi_rdata[3]_i_16_n_0 ),
        .I3(\s_axi_rdata[3]_i_17_n_0 ),
        .O(\s_axi_rdata[3]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \s_axi_rdata[3]_i_11 
       (.I0(\s_axi_rdata[3]_i_18_n_0 ),
        .I1(\s_axi_rdata[3]_i_19_n_0 ),
        .I2(\s_axi_rdata[3]_i_20_n_0 ),
        .I3(\s_axi_rdata[3]_i_21_n_0 ),
        .O(\s_axi_rdata[3]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_12 
       (.I0(\s_axi_rdata[3]_i_22_n_0 ),
        .I1(\s_axi_rdata[3]_i_23_n_0 ),
        .I2(\s_axi_rdata[3]_i_24_n_0 ),
        .I3(\s_axi_rdata[3]_i_25_n_0 ),
        .O(\s_axi_rdata[3]_i_12_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_13 
       (.I0(\s_axi_rdata[3]_i_26_n_0 ),
        .I1(\s_axi_rdata[3]_i_27_n_0 ),
        .I2(\s_axi_rdata[3]_i_28_n_0 ),
        .I3(\s_axi_rdata[3]_i_29_n_0 ),
        .O(\s_axi_rdata[3]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_14 
       (.I0(ext_evt_dropped_count[21]),
        .I1(ext_evt_dropped_count[20]),
        .I2(ext_evt_dropped_count[23]),
        .I3(ext_evt_dropped_count[22]),
        .O(\s_axi_rdata[3]_i_14_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_15 
       (.I0(ext_evt_dropped_count[18]),
        .I1(ext_evt_dropped_count[17]),
        .I2(ext_evt_dropped_count[19]),
        .I3(ext_evt_dropped_count[16]),
        .O(\s_axi_rdata[3]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_16 
       (.I0(ext_evt_dropped_count[29]),
        .I1(ext_evt_dropped_count[28]),
        .I2(ext_evt_dropped_count[30]),
        .I3(ext_evt_dropped_count[31]),
        .O(\s_axi_rdata[3]_i_16_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_17 
       (.I0(ext_evt_dropped_count[27]),
        .I1(ext_evt_dropped_count[26]),
        .I2(ext_evt_dropped_count[25]),
        .I3(ext_evt_dropped_count[24]),
        .O(\s_axi_rdata[3]_i_17_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_18 
       (.I0(ext_evt_dropped_count[5]),
        .I1(ext_evt_dropped_count[4]),
        .I2(ext_evt_dropped_count[7]),
        .I3(ext_evt_dropped_count[6]),
        .O(\s_axi_rdata[3]_i_18_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \s_axi_rdata[3]_i_19 
       (.I0(ext_evt_dropped_count[2]),
        .I1(ext_evt_dropped_count[1]),
        .I2(ext_evt_dropped_count[3]),
        .I3(ext_evt_dropped_count[0]),
        .O(\s_axi_rdata[3]_i_19_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_20 
       (.I0(ext_evt_dropped_count[14]),
        .I1(ext_evt_dropped_count[13]),
        .I2(ext_evt_dropped_count[15]),
        .I3(ext_evt_dropped_count[12]),
        .O(\s_axi_rdata[3]_i_20_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_21 
       (.I0(ext_evt_dropped_count[9]),
        .I1(ext_evt_dropped_count[8]),
        .I2(ext_evt_dropped_count[11]),
        .I3(ext_evt_dropped_count[10]),
        .O(\s_axi_rdata[3]_i_21_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_22 
       (.I0(dropped_count_reg[14]),
        .I1(dropped_count_reg[13]),
        .I2(dropped_count_reg[15]),
        .I3(dropped_count_reg[12]),
        .O(\s_axi_rdata[3]_i_22_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_23 
       (.I0(dropped_count_reg[10]),
        .I1(dropped_count_reg[9]),
        .I2(dropped_count_reg[11]),
        .I3(dropped_count_reg[8]),
        .O(\s_axi_rdata[3]_i_23_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_24 
       (.I0(dropped_count_reg[5]),
        .I1(dropped_count_reg[4]),
        .I2(dropped_count_reg[7]),
        .I3(dropped_count_reg[6]),
        .O(\s_axi_rdata[3]_i_24_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_25 
       (.I0(dropped_count_reg[2]),
        .I1(dropped_count_reg[0]),
        .I2(dropped_count_reg[3]),
        .I3(dropped_count_reg[1]),
        .O(\s_axi_rdata[3]_i_25_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_26 
       (.I0(dropped_count_reg[21]),
        .I1(dropped_count_reg[20]),
        .I2(dropped_count_reg[23]),
        .I3(dropped_count_reg[22]),
        .O(\s_axi_rdata[3]_i_26_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_27 
       (.I0(dropped_count_reg[18]),
        .I1(dropped_count_reg[17]),
        .I2(dropped_count_reg[19]),
        .I3(dropped_count_reg[16]),
        .O(\s_axi_rdata[3]_i_27_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_28 
       (.I0(dropped_count_reg[29]),
        .I1(dropped_count_reg[28]),
        .I2(dropped_count_reg[30]),
        .I3(dropped_count_reg[31]),
        .O(\s_axi_rdata[3]_i_28_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \s_axi_rdata[3]_i_29 
       (.I0(dropped_count_reg[27]),
        .I1(dropped_count_reg[26]),
        .I2(dropped_count_reg[25]),
        .I3(dropped_count_reg[24]),
        .O(\s_axi_rdata[3]_i_29_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \s_axi_rdata[3]_i_6 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[3]),
        .I2(sys_ctrl_reg[3]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(s_axi_araddr[12]),
        .I5(s_axi_araddr[0]),
        .O(\s_axi_rdata[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[3]_i_7 
       (.I0(scratch_reg[3]),
        .I1(data5[3]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[3]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[3]),
        .O(\s_axi_rdata[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF444F4F4)) 
    \s_axi_rdata[4]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[4]),
        .I2(\s_axi_rdata[30]_i_9_n_0 ),
        .I3(sys_ctrl_reg[4]),
        .I4(s_axi_araddr[4]),
        .I5(\s_axi_rdata[31]_i_12_n_0 ),
        .O(\s_axi_rdata[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[4]_i_7 
       (.I0(scratch_reg[4]),
        .I1(data5[4]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[4]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[4]),
        .O(\s_axi_rdata[4]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hAEAEFFAE)) 
    \s_axi_rdata[5]_i_5 
       (.I0(\s_axi_rdata[29]_i_9_n_0 ),
        .I1(io_mode_reg[5]),
        .I2(\s_axi_rdata[30]_i_8_n_0 ),
        .I3(sys_ctrl_reg[5]),
        .I4(\s_axi_rdata[29]_i_8_n_0 ),
        .O(\s_axi_rdata[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[5]_i_7 
       (.I0(scratch_reg[5]),
        .I1(data5[5]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[5]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[5]),
        .O(\s_axi_rdata[5]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[6]_i_7 
       (.I0(scratch_reg[6]),
        .I1(data5[6]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[6]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[6]),
        .O(\s_axi_rdata[6]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000445100000051)) 
    \s_axi_rdata[6]_i_8 
       (.I0(s_axi_araddr[5]),
        .I1(s_axi_araddr[4]),
        .I2(sys_ctrl_reg[6]),
        .I3(s_axi_araddr[3]),
        .I4(s_axi_araddr[2]),
        .I5(io_mode_reg[6]),
        .O(\s_axi_rdata[6]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \s_axi_rdata[7]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[7]),
        .I2(sys_ctrl_reg[7]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(s_axi_araddr[12]),
        .I5(s_axi_araddr[0]),
        .O(\s_axi_rdata[7]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \s_axi_rdata[7]_i_7 
       (.I0(s_axi_araddr[4]),
        .I1(s_axi_araddr[3]),
        .O(\s_axi_rdata[7]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h5D)) 
    \s_axi_rdata[7]_i_8 
       (.I0(s_axi_araddr[4]),
        .I1(s_axi_araddr[2]),
        .I2(s_axi_araddr[3]),
        .O(\s_axi_rdata[7]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[7]_i_9 
       (.I0(scratch_reg[7]),
        .I1(data5[7]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[7]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[7]),
        .O(\s_axi_rdata[7]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF44F4)) 
    \s_axi_rdata[8]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[8]),
        .I2(sys_ctrl_reg[8]),
        .I3(\s_axi_rdata[29]_i_8_n_0 ),
        .I4(\s_axi_rdata[29]_i_9_n_0 ),
        .O(\s_axi_rdata[8]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[8]_i_7 
       (.I0(scratch_reg[8]),
        .I1(data5[8]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[8]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[8]),
        .O(\s_axi_rdata[8]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF444F4F4)) 
    \s_axi_rdata[9]_i_5 
       (.I0(\s_axi_rdata[30]_i_8_n_0 ),
        .I1(io_mode_reg[9]),
        .I2(\s_axi_rdata[30]_i_9_n_0 ),
        .I3(sys_ctrl_reg[9]),
        .I4(s_axi_araddr[4]),
        .I5(\s_axi_rdata[31]_i_12_n_0 ),
        .O(\s_axi_rdata[9]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[9]_i_6 
       (.I0(scratch_reg[9]),
        .I1(data5[9]),
        .I2(s_axi_araddr[3]),
        .I3(timestamp_counter_reg[9]),
        .I4(s_axi_araddr[2]),
        .I5(irq_enable_reg[9]),
        .O(\s_axi_rdata[9]_i_6_n_0 ));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[0] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_70),
        .Q(s_axi_rdata[0]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[10] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_60),
        .Q(s_axi_rdata[10]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[11] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_59),
        .Q(s_axi_rdata[11]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[12] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_58),
        .Q(s_axi_rdata[12]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[13] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_57),
        .Q(s_axi_rdata[13]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[14] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_56),
        .Q(s_axi_rdata[14]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[15] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_55),
        .Q(s_axi_rdata[15]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[16] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_54),
        .Q(s_axi_rdata[16]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[17] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_53),
        .Q(s_axi_rdata[17]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[18] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_52),
        .Q(s_axi_rdata[18]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[19] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_51),
        .Q(s_axi_rdata[19]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[1] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_69),
        .Q(s_axi_rdata[1]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[20] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_50),
        .Q(s_axi_rdata[20]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[21] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_49),
        .Q(s_axi_rdata[21]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[22] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_48),
        .Q(s_axi_rdata[22]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[23] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_47),
        .Q(s_axi_rdata[23]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[24] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_46),
        .Q(s_axi_rdata[24]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[25] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_45),
        .Q(s_axi_rdata[25]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[26] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_44),
        .Q(s_axi_rdata[26]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[27] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_43),
        .Q(s_axi_rdata[27]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[28] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_42),
        .Q(s_axi_rdata[28]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[29] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_41),
        .Q(s_axi_rdata[29]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[2] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_68),
        .Q(s_axi_rdata[2]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[30] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_40),
        .Q(s_axi_rdata[30]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[31] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_39),
        .Q(s_axi_rdata[31]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[3] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_67),
        .Q(s_axi_rdata[3]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[4] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_66),
        .Q(s_axi_rdata[4]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[5] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_65),
        .Q(s_axi_rdata[5]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[6] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_64),
        .Q(s_axi_rdata[6]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[7] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_63),
        .Q(s_axi_rdata[7]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[8] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_62),
        .Q(s_axi_rdata[8]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) 
  FDRE \s_axi_rdata_reg[9] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_3),
        .D(capture_buffer_n_61),
        .Q(s_axi_rdata[9]),
        .R(capture_buffer_n_2));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) 
  FDRE s_axi_rvalid_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(capture_buffer_n_82),
        .Q(s_axi_rvalid),
        .R(clear));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h1)) 
    s_axi_wready_i_1
       (.I0(s_axi_bvalid_reg_0),
        .I1(w_pending_reg_n_0),
        .O(s_axi_wready0));
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) 
  FDRE s_axi_wready_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wready0),
        .Q(s_axi_wready),
        .R(clear));
  LUT4 #(
    .INIT(16'h0002)) 
    \scratch_reg[15]_i_1 
       (.I0(\scratch_reg[31]_i_2_n_0 ),
        .I1(\scratch_reg[31]_i_3_n_0 ),
        .I2(\led_ctrl_reg[15]_i_3_n_0 ),
        .I3(\irq_enable_reg[31]_i_2_n_0 ),
        .O(\scratch_reg[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0002)) 
    \scratch_reg[23]_i_1 
       (.I0(\scratch_reg[31]_i_2_n_0 ),
        .I1(\scratch_reg[31]_i_3_n_0 ),
        .I2(\led_ctrl_reg[23]_i_3_n_0 ),
        .I3(\irq_enable_reg[31]_i_2_n_0 ),
        .O(\scratch_reg[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0008)) 
    \scratch_reg[31]_i_1 
       (.I0(\scratch_reg[31]_i_2_n_0 ),
        .I1(\led_ctrl_reg[31]_i_3_n_0 ),
        .I2(\irq_enable_reg[31]_i_2_n_0 ),
        .I3(\scratch_reg[31]_i_3_n_0 ),
        .O(\scratch_reg[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00000000000002A2)) 
    \scratch_reg[31]_i_2 
       (.I0(\scratch_reg[31]_i_4_n_0 ),
        .I1(s_axi_awaddr[10]),
        .I2(aw_pending),
        .I3(awaddr_reg[10]),
        .I4(\scratch_reg[31]_i_5_n_0 ),
        .I5(capture_arm_pulse_i_4_n_0),
        .O(\scratch_reg[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEFEEEFE)) 
    \scratch_reg[31]_i_3 
       (.I0(\scratch_reg[31]_i_6_n_0 ),
        .I1(event_arbiter_n_19),
        .I2(event_arbiter_n_13),
        .I3(event_arbiter_n_14),
        .I4(write_addr),
        .I5(\led_ctrl_reg[0]_i_8_n_0 ),
        .O(\scratch_reg[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hBABFAAAFBABAAAAA)) 
    \scratch_reg[31]_i_4 
       (.I0(\led_ctrl_reg[0]_i_10_n_0 ),
        .I1(awaddr_reg[12]),
        .I2(aw_pending),
        .I3(s_axi_awaddr[12]),
        .I4(awaddr_reg[2]),
        .I5(s_axi_awaddr[2]),
        .O(\scratch_reg[31]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h000ACC0A)) 
    \scratch_reg[31]_i_5 
       (.I0(s_axi_awaddr[8]),
        .I1(awaddr_reg[8]),
        .I2(s_axi_awaddr[9]),
        .I3(aw_pending),
        .I4(awaddr_reg[9]),
        .O(\scratch_reg[31]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hBBBBBBBBBBBBBBBA)) 
    \scratch_reg[31]_i_6 
       (.I0(\scratch_reg[31]_i_7_n_0 ),
        .I1(event_arbiter_n_16),
        .I2(s_axi_awaddr[15]),
        .I3(aw_pending),
        .I4(s_axi_awaddr[14]),
        .I5(s_axi_awaddr[13]),
        .O(\scratch_reg[31]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \scratch_reg[31]_i_7 
       (.I0(awaddr_reg[11]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[11]),
        .O(\scratch_reg[31]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h0002)) 
    \scratch_reg[7]_i_1 
       (.I0(\scratch_reg[31]_i_2_n_0 ),
        .I1(\scratch_reg[31]_i_3_n_0 ),
        .I2(\led_ctrl_reg[0]_i_7_n_0 ),
        .I3(\irq_enable_reg[31]_i_2_n_0 ),
        .O(\scratch_reg[7]_i_1_n_0 ));
  FDRE \scratch_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[7]_i_1_n_0 ),
        .D(event_arbiter_n_6),
        .Q(scratch_reg[0]),
        .R(clear));
  FDRE \scratch_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[10]_i_1_n_0 ),
        .Q(scratch_reg[10]),
        .R(clear));
  FDRE \scratch_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[11]_i_1_n_0 ),
        .Q(scratch_reg[11]),
        .R(clear));
  FDRE \scratch_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[12]_i_1_n_0 ),
        .Q(scratch_reg[12]),
        .R(clear));
  FDRE \scratch_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[13]_i_1_n_0 ),
        .Q(scratch_reg[13]),
        .R(clear));
  FDRE \scratch_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[14]_i_1_n_0 ),
        .Q(scratch_reg[14]),
        .R(clear));
  FDRE \scratch_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[15]_i_2_n_0 ),
        .Q(scratch_reg[15]),
        .R(clear));
  FDRE \scratch_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[16]_i_1_n_0 ),
        .Q(scratch_reg[16]),
        .R(clear));
  FDRE \scratch_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[17]_i_1_n_0 ),
        .Q(scratch_reg[17]),
        .R(clear));
  FDRE \scratch_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[18]_i_1_n_0 ),
        .Q(scratch_reg[18]),
        .R(clear));
  FDRE \scratch_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[19]_i_1_n_0 ),
        .Q(scratch_reg[19]),
        .R(clear));
  FDRE \scratch_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[7]_i_1_n_0 ),
        .D(p_0_in15_in),
        .Q(scratch_reg[1]),
        .R(clear));
  FDRE \scratch_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[20]_i_1_n_0 ),
        .Q(scratch_reg[20]),
        .R(clear));
  FDRE \scratch_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[21]_i_1_n_0 ),
        .Q(scratch_reg[21]),
        .R(clear));
  FDRE \scratch_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[22]_i_1_n_0 ),
        .Q(scratch_reg[22]),
        .R(clear));
  FDRE \scratch_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[23]_i_1_n_0 ),
        .D(\led_ctrl_reg[23]_i_2_n_0 ),
        .Q(scratch_reg[23]),
        .R(clear));
  FDRE \scratch_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[24]_i_1_n_0 ),
        .Q(scratch_reg[24]),
        .R(clear));
  FDRE \scratch_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[25]_i_1_n_0 ),
        .Q(scratch_reg[25]),
        .R(clear));
  FDRE \scratch_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[26]_i_1_n_0 ),
        .Q(scratch_reg[26]),
        .R(clear));
  FDRE \scratch_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[27]_i_1_n_0 ),
        .Q(scratch_reg[27]),
        .R(clear));
  FDRE \scratch_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[28]_i_1_n_0 ),
        .Q(scratch_reg[28]),
        .R(clear));
  FDRE \scratch_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[29]_i_1_n_0 ),
        .Q(scratch_reg[29]),
        .R(clear));
  FDRE \scratch_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[7]_i_1_n_0 ),
        .D(p_0_in13_in),
        .Q(scratch_reg[2]),
        .R(clear));
  FDRE \scratch_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[31]_i_1_n_0 ),
        .D(\led_ctrl_reg[30]_i_1_n_0 ),
        .Q(scratch_reg[30]),
        .R(clear));
  FDRE \scratch_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[31]_i_1_n_0 ),
        .D(p_0_in10_in),
        .Q(scratch_reg[31]),
        .R(clear));
  FDRE \scratch_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[3]_i_1_n_0 ),
        .Q(scratch_reg[3]),
        .R(clear));
  FDRE \scratch_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[4]_i_1_n_0 ),
        .Q(scratch_reg[4]),
        .R(clear));
  FDRE \scratch_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[5]_i_1_n_0 ),
        .Q(scratch_reg[5]),
        .R(clear));
  FDRE \scratch_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[6]_i_1_n_0 ),
        .Q(scratch_reg[6]),
        .R(clear));
  FDRE \scratch_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[7]_i_1_n_0 ),
        .D(\led_ctrl_reg[7]_i_1_n_0 ),
        .Q(scratch_reg[7]),
        .R(clear));
  FDRE \scratch_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[8]_i_1_n_0 ),
        .Q(scratch_reg[8]),
        .R(clear));
  FDRE \scratch_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(\scratch_reg[15]_i_1_n_0 ),
        .D(\led_ctrl_reg[9]_i_1_n_0 ),
        .Q(scratch_reg[9]),
        .R(clear));
  FDRE snapshot_rd_en_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(capture_buffer_n_4),
        .Q(snapshot_rd_en),
        .R(1'b0));
  FDRE \snapshot_rd_index_reg[0] 
       (.C(s_axi_aclk),
        .CE(snapshot_rd_index),
        .D(s_axi_araddr[4]),
        .Q(\snapshot_rd_index_reg_n_0_[0] ),
        .R(clear));
  FDRE \snapshot_rd_index_reg[1] 
       (.C(s_axi_aclk),
        .CE(snapshot_rd_index),
        .D(s_axi_araddr[5]),
        .Q(\snapshot_rd_index_reg_n_0_[1] ),
        .R(clear));
  FDRE \snapshot_rd_index_reg[2] 
       (.C(s_axi_aclk),
        .CE(snapshot_rd_index),
        .D(s_axi_araddr[6]),
        .Q(\snapshot_rd_index_reg_n_0_[2] ),
        .R(clear));
  FDRE \snapshot_rd_index_reg[3] 
       (.C(s_axi_aclk),
        .CE(snapshot_rd_index),
        .D(s_axi_araddr[7]),
        .Q(\snapshot_rd_index_reg_n_0_[3] ),
        .R(clear));
  FDRE \snapshot_rd_index_reg[4] 
       (.C(s_axi_aclk),
        .CE(snapshot_rd_index),
        .D(s_axi_araddr[8]),
        .Q(\snapshot_rd_index_reg_n_0_[4] ),
        .R(clear));
  FDRE \snapshot_rd_index_reg[5] 
       (.C(s_axi_aclk),
        .CE(snapshot_rd_index),
        .D(s_axi_araddr[9]),
        .Q(\snapshot_rd_index_reg_n_0_[5] ),
        .R(clear));
  FDRE \snapshot_rd_index_reg[6] 
       (.C(s_axi_aclk),
        .CE(snapshot_rd_index),
        .D(s_axi_araddr[10]),
        .Q(\snapshot_rd_index_reg_n_0_[6] ),
        .R(clear));
  FDRE \snapshot_rd_index_reg[7] 
       (.C(s_axi_aclk),
        .CE(snapshot_rd_index),
        .D(s_axi_araddr[11]),
        .Q(\snapshot_rd_index_reg_n_0_[7] ),
        .R(clear));
  FDRE snapshot_read_pending_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(capture_buffer_n_72),
        .Q(snapshot_read_pending_reg_n_0),
        .R(1'b0));
  FDRE \snapshot_word_select_reg[0] 
       (.C(s_axi_aclk),
        .CE(snapshot_rd_index),
        .D(s_axi_araddr[2]),
        .Q(snapshot_word_select[0]),
        .R(clear));
  FDRE \snapshot_word_select_reg[1] 
       (.C(s_axi_aclk),
        .CE(snapshot_rd_index),
        .D(s_axi_araddr[3]),
        .Q(snapshot_word_select[1]),
        .R(clear));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \sys_ctrl_reg[15]_i_1 
       (.I0(\led_ctrl_reg[0]_i_3_n_0 ),
        .I1(\led_ctrl_reg[0]_i_6_n_0 ),
        .I2(\led_ctrl_reg[0]_i_5_n_0 ),
        .I3(\sys_ctrl_reg[31]_i_3_n_0 ),
        .I4(\sys_ctrl_reg[31]_i_2_n_0 ),
        .I5(\led_ctrl_reg[15]_i_3_n_0 ),
        .O(p_1_in__0[15]));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \sys_ctrl_reg[23]_i_1 
       (.I0(\led_ctrl_reg[0]_i_3_n_0 ),
        .I1(\led_ctrl_reg[0]_i_6_n_0 ),
        .I2(\led_ctrl_reg[0]_i_5_n_0 ),
        .I3(\sys_ctrl_reg[31]_i_3_n_0 ),
        .I4(\sys_ctrl_reg[31]_i_2_n_0 ),
        .I5(\led_ctrl_reg[23]_i_3_n_0 ),
        .O(p_1_in__0[23]));
  LUT6 #(
    .INIT(64'h0000000400000000)) 
    \sys_ctrl_reg[31]_i_1 
       (.I0(\sys_ctrl_reg[31]_i_2_n_0 ),
        .I1(\led_ctrl_reg[31]_i_3_n_0 ),
        .I2(\led_ctrl_reg[0]_i_3_n_0 ),
        .I3(\led_ctrl_reg[0]_i_6_n_0 ),
        .I4(\led_ctrl_reg[0]_i_5_n_0 ),
        .I5(\sys_ctrl_reg[31]_i_3_n_0 ),
        .O(p_1_in__0[31]));
  LUT6 #(
    .INIT(64'hDFD5FFF5DFDFFFFF)) 
    \sys_ctrl_reg[31]_i_2 
       (.I0(event_arbiter_n_17),
        .I1(awaddr_reg[5]),
        .I2(aw_pending),
        .I3(s_axi_awaddr[5]),
        .I4(awaddr_reg[4]),
        .I5(s_axi_awaddr[4]),
        .O(\sys_ctrl_reg[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0300035533553355)) 
    \sys_ctrl_reg[31]_i_3 
       (.I0(s_axi_awaddr[5]),
        .I1(awaddr_reg[5]),
        .I2(awaddr_reg[3]),
        .I3(aw_pending),
        .I4(s_axi_awaddr[3]),
        .I5(write_addr),
        .O(\sys_ctrl_reg[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    \sys_ctrl_reg[7]_i_1 
       (.I0(\led_ctrl_reg[0]_i_3_n_0 ),
        .I1(\led_ctrl_reg[0]_i_6_n_0 ),
        .I2(\led_ctrl_reg[0]_i_5_n_0 ),
        .I3(\sys_ctrl_reg[31]_i_3_n_0 ),
        .I4(\sys_ctrl_reg[31]_i_2_n_0 ),
        .I5(\led_ctrl_reg[0]_i_7_n_0 ),
        .O(p_1_in__0[7]));
  FDRE \sys_ctrl_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[7]),
        .D(event_arbiter_n_6),
        .Q(sys_ctrl_reg[0]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[15]),
        .D(\led_ctrl_reg[10]_i_1_n_0 ),
        .Q(sys_ctrl_reg[10]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[15]),
        .D(\led_ctrl_reg[11]_i_1_n_0 ),
        .Q(sys_ctrl_reg[11]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[15]),
        .D(\led_ctrl_reg[12]_i_1_n_0 ),
        .Q(sys_ctrl_reg[12]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[15]),
        .D(\led_ctrl_reg[13]_i_1_n_0 ),
        .Q(sys_ctrl_reg[13]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[15]),
        .D(\led_ctrl_reg[14]_i_1_n_0 ),
        .Q(sys_ctrl_reg[14]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[15]),
        .D(\led_ctrl_reg[15]_i_2_n_0 ),
        .Q(sys_ctrl_reg[15]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[23]),
        .D(\led_ctrl_reg[16]_i_1_n_0 ),
        .Q(sys_ctrl_reg[16]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[23]),
        .D(\led_ctrl_reg[17]_i_1_n_0 ),
        .Q(sys_ctrl_reg[17]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[23]),
        .D(\led_ctrl_reg[18]_i_1_n_0 ),
        .Q(sys_ctrl_reg[18]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[23]),
        .D(\led_ctrl_reg[19]_i_1_n_0 ),
        .Q(sys_ctrl_reg[19]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[7]),
        .D(p_0_in15_in),
        .Q(sys_ctrl_reg[1]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[23]),
        .D(\led_ctrl_reg[20]_i_1_n_0 ),
        .Q(sys_ctrl_reg[20]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[23]),
        .D(\led_ctrl_reg[21]_i_1_n_0 ),
        .Q(sys_ctrl_reg[21]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[23]),
        .D(\led_ctrl_reg[22]_i_1_n_0 ),
        .Q(sys_ctrl_reg[22]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[23]),
        .D(\led_ctrl_reg[23]_i_2_n_0 ),
        .Q(sys_ctrl_reg[23]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[31]),
        .D(\led_ctrl_reg[24]_i_1_n_0 ),
        .Q(sys_ctrl_reg[24]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[31]),
        .D(\led_ctrl_reg[25]_i_1_n_0 ),
        .Q(sys_ctrl_reg[25]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[31]),
        .D(\led_ctrl_reg[26]_i_1_n_0 ),
        .Q(sys_ctrl_reg[26]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[31]),
        .D(\led_ctrl_reg[27]_i_1_n_0 ),
        .Q(sys_ctrl_reg[27]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[31]),
        .D(\led_ctrl_reg[28]_i_1_n_0 ),
        .Q(sys_ctrl_reg[28]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[31]),
        .D(\led_ctrl_reg[29]_i_1_n_0 ),
        .Q(sys_ctrl_reg[29]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[7]),
        .D(p_0_in13_in),
        .Q(sys_ctrl_reg[2]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[31]),
        .D(\led_ctrl_reg[30]_i_1_n_0 ),
        .Q(sys_ctrl_reg[30]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[31]),
        .D(p_0_in10_in),
        .Q(sys_ctrl_reg[31]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[7]),
        .D(\led_ctrl_reg[3]_i_1_n_0 ),
        .Q(sys_ctrl_reg[3]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[7]),
        .D(\led_ctrl_reg[4]_i_1_n_0 ),
        .Q(sys_ctrl_reg[4]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[7]),
        .D(\led_ctrl_reg[5]_i_1_n_0 ),
        .Q(sys_ctrl_reg[5]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[7]),
        .D(\led_ctrl_reg[6]_i_1_n_0 ),
        .Q(sys_ctrl_reg[6]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[7]),
        .D(\led_ctrl_reg[7]_i_1_n_0 ),
        .Q(sys_ctrl_reg[7]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[15]),
        .D(\led_ctrl_reg[8]_i_1_n_0 ),
        .Q(sys_ctrl_reg[8]),
        .R(clear));
  FDRE \sys_ctrl_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(p_1_in__0[15]),
        .D(\led_ctrl_reg[9]_i_1_n_0 ),
        .Q(sys_ctrl_reg[9]),
        .R(clear));
  LUT1 #(
    .INIT(2'h1)) 
    \timestamp_counter[0]_i_2 
       (.I0(timestamp_counter_reg[0]),
        .O(\timestamp_counter[0]_i_2_n_0 ));
  FDRE \timestamp_counter_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[0]_i_1_n_7 ),
        .Q(timestamp_counter_reg[0]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\timestamp_counter_reg[0]_i_1_n_0 ,\timestamp_counter_reg[0]_i_1_n_1 ,\timestamp_counter_reg[0]_i_1_n_2 ,\timestamp_counter_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\timestamp_counter_reg[0]_i_1_n_4 ,\timestamp_counter_reg[0]_i_1_n_5 ,\timestamp_counter_reg[0]_i_1_n_6 ,\timestamp_counter_reg[0]_i_1_n_7 }),
        .S({timestamp_counter_reg[3:1],\timestamp_counter[0]_i_2_n_0 }));
  FDRE \timestamp_counter_reg[10] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[8]_i_1_n_5 ),
        .Q(timestamp_counter_reg[10]),
        .R(clear));
  FDRE \timestamp_counter_reg[11] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[8]_i_1_n_4 ),
        .Q(timestamp_counter_reg[11]),
        .R(clear));
  FDRE \timestamp_counter_reg[12] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[12]_i_1_n_7 ),
        .Q(timestamp_counter_reg[12]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[12]_i_1 
       (.CI(\timestamp_counter_reg[8]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[12]_i_1_n_0 ,\timestamp_counter_reg[12]_i_1_n_1 ,\timestamp_counter_reg[12]_i_1_n_2 ,\timestamp_counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[12]_i_1_n_4 ,\timestamp_counter_reg[12]_i_1_n_5 ,\timestamp_counter_reg[12]_i_1_n_6 ,\timestamp_counter_reg[12]_i_1_n_7 }),
        .S(timestamp_counter_reg[15:12]));
  FDRE \timestamp_counter_reg[13] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[12]_i_1_n_6 ),
        .Q(timestamp_counter_reg[13]),
        .R(clear));
  FDRE \timestamp_counter_reg[14] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[12]_i_1_n_5 ),
        .Q(timestamp_counter_reg[14]),
        .R(clear));
  FDRE \timestamp_counter_reg[15] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[12]_i_1_n_4 ),
        .Q(timestamp_counter_reg[15]),
        .R(clear));
  FDRE \timestamp_counter_reg[16] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[16]_i_1_n_7 ),
        .Q(timestamp_counter_reg[16]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[16]_i_1 
       (.CI(\timestamp_counter_reg[12]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[16]_i_1_n_0 ,\timestamp_counter_reg[16]_i_1_n_1 ,\timestamp_counter_reg[16]_i_1_n_2 ,\timestamp_counter_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[16]_i_1_n_4 ,\timestamp_counter_reg[16]_i_1_n_5 ,\timestamp_counter_reg[16]_i_1_n_6 ,\timestamp_counter_reg[16]_i_1_n_7 }),
        .S(timestamp_counter_reg[19:16]));
  FDRE \timestamp_counter_reg[17] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[16]_i_1_n_6 ),
        .Q(timestamp_counter_reg[17]),
        .R(clear));
  FDRE \timestamp_counter_reg[18] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[16]_i_1_n_5 ),
        .Q(timestamp_counter_reg[18]),
        .R(clear));
  FDRE \timestamp_counter_reg[19] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[16]_i_1_n_4 ),
        .Q(timestamp_counter_reg[19]),
        .R(clear));
  FDRE \timestamp_counter_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[0]_i_1_n_6 ),
        .Q(timestamp_counter_reg[1]),
        .R(clear));
  FDRE \timestamp_counter_reg[20] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[20]_i_1_n_7 ),
        .Q(timestamp_counter_reg[20]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[20]_i_1 
       (.CI(\timestamp_counter_reg[16]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[20]_i_1_n_0 ,\timestamp_counter_reg[20]_i_1_n_1 ,\timestamp_counter_reg[20]_i_1_n_2 ,\timestamp_counter_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[20]_i_1_n_4 ,\timestamp_counter_reg[20]_i_1_n_5 ,\timestamp_counter_reg[20]_i_1_n_6 ,\timestamp_counter_reg[20]_i_1_n_7 }),
        .S(timestamp_counter_reg[23:20]));
  FDRE \timestamp_counter_reg[21] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[20]_i_1_n_6 ),
        .Q(timestamp_counter_reg[21]),
        .R(clear));
  FDRE \timestamp_counter_reg[22] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[20]_i_1_n_5 ),
        .Q(timestamp_counter_reg[22]),
        .R(clear));
  FDRE \timestamp_counter_reg[23] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[20]_i_1_n_4 ),
        .Q(timestamp_counter_reg[23]),
        .R(clear));
  FDRE \timestamp_counter_reg[24] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[24]_i_1_n_7 ),
        .Q(timestamp_counter_reg[24]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[24]_i_1 
       (.CI(\timestamp_counter_reg[20]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[24]_i_1_n_0 ,\timestamp_counter_reg[24]_i_1_n_1 ,\timestamp_counter_reg[24]_i_1_n_2 ,\timestamp_counter_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[24]_i_1_n_4 ,\timestamp_counter_reg[24]_i_1_n_5 ,\timestamp_counter_reg[24]_i_1_n_6 ,\timestamp_counter_reg[24]_i_1_n_7 }),
        .S(timestamp_counter_reg[27:24]));
  FDRE \timestamp_counter_reg[25] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[24]_i_1_n_6 ),
        .Q(timestamp_counter_reg[25]),
        .R(clear));
  FDRE \timestamp_counter_reg[26] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[24]_i_1_n_5 ),
        .Q(timestamp_counter_reg[26]),
        .R(clear));
  FDRE \timestamp_counter_reg[27] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[24]_i_1_n_4 ),
        .Q(timestamp_counter_reg[27]),
        .R(clear));
  FDRE \timestamp_counter_reg[28] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[28]_i_1_n_7 ),
        .Q(timestamp_counter_reg[28]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[28]_i_1 
       (.CI(\timestamp_counter_reg[24]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[28]_i_1_n_0 ,\timestamp_counter_reg[28]_i_1_n_1 ,\timestamp_counter_reg[28]_i_1_n_2 ,\timestamp_counter_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[28]_i_1_n_4 ,\timestamp_counter_reg[28]_i_1_n_5 ,\timestamp_counter_reg[28]_i_1_n_6 ,\timestamp_counter_reg[28]_i_1_n_7 }),
        .S(timestamp_counter_reg[31:28]));
  FDRE \timestamp_counter_reg[29] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[28]_i_1_n_6 ),
        .Q(timestamp_counter_reg[29]),
        .R(clear));
  FDRE \timestamp_counter_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[0]_i_1_n_5 ),
        .Q(timestamp_counter_reg[2]),
        .R(clear));
  FDRE \timestamp_counter_reg[30] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[28]_i_1_n_5 ),
        .Q(timestamp_counter_reg[30]),
        .R(clear));
  FDRE \timestamp_counter_reg[31] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[28]_i_1_n_4 ),
        .Q(timestamp_counter_reg[31]),
        .R(clear));
  FDRE \timestamp_counter_reg[32] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[32]_i_1_n_7 ),
        .Q(timestamp_counter_reg[32]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[32]_i_1 
       (.CI(\timestamp_counter_reg[28]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[32]_i_1_n_0 ,\timestamp_counter_reg[32]_i_1_n_1 ,\timestamp_counter_reg[32]_i_1_n_2 ,\timestamp_counter_reg[32]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[32]_i_1_n_4 ,\timestamp_counter_reg[32]_i_1_n_5 ,\timestamp_counter_reg[32]_i_1_n_6 ,\timestamp_counter_reg[32]_i_1_n_7 }),
        .S(timestamp_counter_reg[35:32]));
  FDRE \timestamp_counter_reg[33] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[32]_i_1_n_6 ),
        .Q(timestamp_counter_reg[33]),
        .R(clear));
  FDRE \timestamp_counter_reg[34] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[32]_i_1_n_5 ),
        .Q(timestamp_counter_reg[34]),
        .R(clear));
  FDRE \timestamp_counter_reg[35] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[32]_i_1_n_4 ),
        .Q(timestamp_counter_reg[35]),
        .R(clear));
  FDRE \timestamp_counter_reg[36] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[36]_i_1_n_7 ),
        .Q(timestamp_counter_reg[36]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[36]_i_1 
       (.CI(\timestamp_counter_reg[32]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[36]_i_1_n_0 ,\timestamp_counter_reg[36]_i_1_n_1 ,\timestamp_counter_reg[36]_i_1_n_2 ,\timestamp_counter_reg[36]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[36]_i_1_n_4 ,\timestamp_counter_reg[36]_i_1_n_5 ,\timestamp_counter_reg[36]_i_1_n_6 ,\timestamp_counter_reg[36]_i_1_n_7 }),
        .S(timestamp_counter_reg[39:36]));
  FDRE \timestamp_counter_reg[37] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[36]_i_1_n_6 ),
        .Q(timestamp_counter_reg[37]),
        .R(clear));
  FDRE \timestamp_counter_reg[38] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[36]_i_1_n_5 ),
        .Q(timestamp_counter_reg[38]),
        .R(clear));
  FDRE \timestamp_counter_reg[39] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[36]_i_1_n_4 ),
        .Q(timestamp_counter_reg[39]),
        .R(clear));
  FDRE \timestamp_counter_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[0]_i_1_n_4 ),
        .Q(timestamp_counter_reg[3]),
        .R(clear));
  FDRE \timestamp_counter_reg[40] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[40]_i_1_n_7 ),
        .Q(timestamp_counter_reg[40]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[40]_i_1 
       (.CI(\timestamp_counter_reg[36]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[40]_i_1_n_0 ,\timestamp_counter_reg[40]_i_1_n_1 ,\timestamp_counter_reg[40]_i_1_n_2 ,\timestamp_counter_reg[40]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[40]_i_1_n_4 ,\timestamp_counter_reg[40]_i_1_n_5 ,\timestamp_counter_reg[40]_i_1_n_6 ,\timestamp_counter_reg[40]_i_1_n_7 }),
        .S(timestamp_counter_reg[43:40]));
  FDRE \timestamp_counter_reg[41] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[40]_i_1_n_6 ),
        .Q(timestamp_counter_reg[41]),
        .R(clear));
  FDRE \timestamp_counter_reg[42] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[40]_i_1_n_5 ),
        .Q(timestamp_counter_reg[42]),
        .R(clear));
  FDRE \timestamp_counter_reg[43] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[40]_i_1_n_4 ),
        .Q(timestamp_counter_reg[43]),
        .R(clear));
  FDRE \timestamp_counter_reg[44] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[44]_i_1_n_7 ),
        .Q(timestamp_counter_reg[44]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[44]_i_1 
       (.CI(\timestamp_counter_reg[40]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[44]_i_1_n_0 ,\timestamp_counter_reg[44]_i_1_n_1 ,\timestamp_counter_reg[44]_i_1_n_2 ,\timestamp_counter_reg[44]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[44]_i_1_n_4 ,\timestamp_counter_reg[44]_i_1_n_5 ,\timestamp_counter_reg[44]_i_1_n_6 ,\timestamp_counter_reg[44]_i_1_n_7 }),
        .S(timestamp_counter_reg[47:44]));
  FDRE \timestamp_counter_reg[45] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[44]_i_1_n_6 ),
        .Q(timestamp_counter_reg[45]),
        .R(clear));
  FDRE \timestamp_counter_reg[46] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[44]_i_1_n_5 ),
        .Q(timestamp_counter_reg[46]),
        .R(clear));
  FDRE \timestamp_counter_reg[47] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[44]_i_1_n_4 ),
        .Q(timestamp_counter_reg[47]),
        .R(clear));
  FDRE \timestamp_counter_reg[48] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[48]_i_1_n_7 ),
        .Q(timestamp_counter_reg[48]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[48]_i_1 
       (.CI(\timestamp_counter_reg[44]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[48]_i_1_n_0 ,\timestamp_counter_reg[48]_i_1_n_1 ,\timestamp_counter_reg[48]_i_1_n_2 ,\timestamp_counter_reg[48]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[48]_i_1_n_4 ,\timestamp_counter_reg[48]_i_1_n_5 ,\timestamp_counter_reg[48]_i_1_n_6 ,\timestamp_counter_reg[48]_i_1_n_7 }),
        .S(timestamp_counter_reg[51:48]));
  FDRE \timestamp_counter_reg[49] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[48]_i_1_n_6 ),
        .Q(timestamp_counter_reg[49]),
        .R(clear));
  FDRE \timestamp_counter_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[4]_i_1_n_7 ),
        .Q(timestamp_counter_reg[4]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[4]_i_1 
       (.CI(\timestamp_counter_reg[0]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[4]_i_1_n_0 ,\timestamp_counter_reg[4]_i_1_n_1 ,\timestamp_counter_reg[4]_i_1_n_2 ,\timestamp_counter_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[4]_i_1_n_4 ,\timestamp_counter_reg[4]_i_1_n_5 ,\timestamp_counter_reg[4]_i_1_n_6 ,\timestamp_counter_reg[4]_i_1_n_7 }),
        .S(timestamp_counter_reg[7:4]));
  FDRE \timestamp_counter_reg[50] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[48]_i_1_n_5 ),
        .Q(timestamp_counter_reg[50]),
        .R(clear));
  FDRE \timestamp_counter_reg[51] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[48]_i_1_n_4 ),
        .Q(timestamp_counter_reg[51]),
        .R(clear));
  FDRE \timestamp_counter_reg[52] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[52]_i_1_n_7 ),
        .Q(timestamp_counter_reg[52]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[52]_i_1 
       (.CI(\timestamp_counter_reg[48]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[52]_i_1_n_0 ,\timestamp_counter_reg[52]_i_1_n_1 ,\timestamp_counter_reg[52]_i_1_n_2 ,\timestamp_counter_reg[52]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[52]_i_1_n_4 ,\timestamp_counter_reg[52]_i_1_n_5 ,\timestamp_counter_reg[52]_i_1_n_6 ,\timestamp_counter_reg[52]_i_1_n_7 }),
        .S(timestamp_counter_reg[55:52]));
  FDRE \timestamp_counter_reg[53] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[52]_i_1_n_6 ),
        .Q(timestamp_counter_reg[53]),
        .R(clear));
  FDRE \timestamp_counter_reg[54] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[52]_i_1_n_5 ),
        .Q(timestamp_counter_reg[54]),
        .R(clear));
  FDRE \timestamp_counter_reg[55] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[52]_i_1_n_4 ),
        .Q(timestamp_counter_reg[55]),
        .R(clear));
  FDRE \timestamp_counter_reg[56] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[56]_i_1_n_7 ),
        .Q(timestamp_counter_reg[56]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[56]_i_1 
       (.CI(\timestamp_counter_reg[52]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[56]_i_1_n_0 ,\timestamp_counter_reg[56]_i_1_n_1 ,\timestamp_counter_reg[56]_i_1_n_2 ,\timestamp_counter_reg[56]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[56]_i_1_n_4 ,\timestamp_counter_reg[56]_i_1_n_5 ,\timestamp_counter_reg[56]_i_1_n_6 ,\timestamp_counter_reg[56]_i_1_n_7 }),
        .S(timestamp_counter_reg[59:56]));
  FDRE \timestamp_counter_reg[57] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[56]_i_1_n_6 ),
        .Q(timestamp_counter_reg[57]),
        .R(clear));
  FDRE \timestamp_counter_reg[58] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[56]_i_1_n_5 ),
        .Q(timestamp_counter_reg[58]),
        .R(clear));
  FDRE \timestamp_counter_reg[59] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[56]_i_1_n_4 ),
        .Q(timestamp_counter_reg[59]),
        .R(clear));
  FDRE \timestamp_counter_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[4]_i_1_n_6 ),
        .Q(timestamp_counter_reg[5]),
        .R(clear));
  FDRE \timestamp_counter_reg[60] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[60]_i_1_n_7 ),
        .Q(timestamp_counter_reg[60]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[60]_i_1 
       (.CI(\timestamp_counter_reg[56]_i_1_n_0 ),
        .CO({\NLW_timestamp_counter_reg[60]_i_1_CO_UNCONNECTED [3],\timestamp_counter_reg[60]_i_1_n_1 ,\timestamp_counter_reg[60]_i_1_n_2 ,\timestamp_counter_reg[60]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[60]_i_1_n_4 ,\timestamp_counter_reg[60]_i_1_n_5 ,\timestamp_counter_reg[60]_i_1_n_6 ,\timestamp_counter_reg[60]_i_1_n_7 }),
        .S(timestamp_counter_reg[63:60]));
  FDRE \timestamp_counter_reg[61] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[60]_i_1_n_6 ),
        .Q(timestamp_counter_reg[61]),
        .R(clear));
  FDRE \timestamp_counter_reg[62] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[60]_i_1_n_5 ),
        .Q(timestamp_counter_reg[62]),
        .R(clear));
  FDRE \timestamp_counter_reg[63] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[60]_i_1_n_4 ),
        .Q(timestamp_counter_reg[63]),
        .R(clear));
  FDRE \timestamp_counter_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[4]_i_1_n_5 ),
        .Q(timestamp_counter_reg[6]),
        .R(clear));
  FDRE \timestamp_counter_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[4]_i_1_n_4 ),
        .Q(timestamp_counter_reg[7]),
        .R(clear));
  FDRE \timestamp_counter_reg[8] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[8]_i_1_n_7 ),
        .Q(timestamp_counter_reg[8]),
        .R(clear));
  CARRY4 \timestamp_counter_reg[8]_i_1 
       (.CI(\timestamp_counter_reg[4]_i_1_n_0 ),
        .CO({\timestamp_counter_reg[8]_i_1_n_0 ,\timestamp_counter_reg[8]_i_1_n_1 ,\timestamp_counter_reg[8]_i_1_n_2 ,\timestamp_counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timestamp_counter_reg[8]_i_1_n_4 ,\timestamp_counter_reg[8]_i_1_n_5 ,\timestamp_counter_reg[8]_i_1_n_6 ,\timestamp_counter_reg[8]_i_1_n_7 }),
        .S(timestamp_counter_reg[11:8]));
  FDRE \timestamp_counter_reg[9] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\timestamp_counter_reg[8]_i_1_n_6 ),
        .Q(timestamp_counter_reg[9]),
        .R(clear));
  LUT2 #(
    .INIT(4'hB)) 
    \timestamp_shadow[63]_i_2 
       (.I0(s_axi_araddr[3]),
        .I1(s_axi_araddr[2]),
        .O(\timestamp_shadow[63]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \timestamp_shadow[63]_i_5 
       (.I0(s_axi_araddr[9]),
        .I1(s_axi_araddr[10]),
        .I2(s_axi_araddr[7]),
        .I3(s_axi_araddr[6]),
        .I4(s_axi_araddr[1]),
        .I5(s_axi_araddr[8]),
        .O(\timestamp_shadow[63]_i_5_n_0 ));
  FDRE \timestamp_shadow_reg[32] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[32]),
        .Q(data5[0]),
        .R(clear));
  FDRE \timestamp_shadow_reg[33] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[33]),
        .Q(data5[1]),
        .R(clear));
  FDRE \timestamp_shadow_reg[34] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[34]),
        .Q(data5[2]),
        .R(clear));
  FDRE \timestamp_shadow_reg[35] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[35]),
        .Q(data5[3]),
        .R(clear));
  FDRE \timestamp_shadow_reg[36] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[36]),
        .Q(data5[4]),
        .R(clear));
  FDRE \timestamp_shadow_reg[37] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[37]),
        .Q(data5[5]),
        .R(clear));
  FDRE \timestamp_shadow_reg[38] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[38]),
        .Q(data5[6]),
        .R(clear));
  FDRE \timestamp_shadow_reg[39] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[39]),
        .Q(data5[7]),
        .R(clear));
  FDRE \timestamp_shadow_reg[40] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[40]),
        .Q(data5[8]),
        .R(clear));
  FDRE \timestamp_shadow_reg[41] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[41]),
        .Q(data5[9]),
        .R(clear));
  FDRE \timestamp_shadow_reg[42] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[42]),
        .Q(data5[10]),
        .R(clear));
  FDRE \timestamp_shadow_reg[43] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[43]),
        .Q(data5[11]),
        .R(clear));
  FDRE \timestamp_shadow_reg[44] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[44]),
        .Q(data5[12]),
        .R(clear));
  FDRE \timestamp_shadow_reg[45] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[45]),
        .Q(data5[13]),
        .R(clear));
  FDRE \timestamp_shadow_reg[46] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[46]),
        .Q(data5[14]),
        .R(clear));
  FDRE \timestamp_shadow_reg[47] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[47]),
        .Q(data5[15]),
        .R(clear));
  FDRE \timestamp_shadow_reg[48] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[48]),
        .Q(data5[16]),
        .R(clear));
  FDRE \timestamp_shadow_reg[49] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[49]),
        .Q(data5[17]),
        .R(clear));
  FDRE \timestamp_shadow_reg[50] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[50]),
        .Q(data5[18]),
        .R(clear));
  FDRE \timestamp_shadow_reg[51] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[51]),
        .Q(data5[19]),
        .R(clear));
  FDRE \timestamp_shadow_reg[52] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[52]),
        .Q(data5[20]),
        .R(clear));
  FDRE \timestamp_shadow_reg[53] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[53]),
        .Q(data5[21]),
        .R(clear));
  FDRE \timestamp_shadow_reg[54] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[54]),
        .Q(data5[22]),
        .R(clear));
  FDRE \timestamp_shadow_reg[55] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[55]),
        .Q(data5[23]),
        .R(clear));
  FDRE \timestamp_shadow_reg[56] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[56]),
        .Q(data5[24]),
        .R(clear));
  FDRE \timestamp_shadow_reg[57] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[57]),
        .Q(data5[25]),
        .R(clear));
  FDRE \timestamp_shadow_reg[58] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[58]),
        .Q(data5[26]),
        .R(clear));
  FDRE \timestamp_shadow_reg[59] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[59]),
        .Q(data5[27]),
        .R(clear));
  FDRE \timestamp_shadow_reg[60] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[60]),
        .Q(data5[28]),
        .R(clear));
  FDRE \timestamp_shadow_reg[61] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[61]),
        .Q(data5[29]),
        .R(clear));
  FDRE \timestamp_shadow_reg[62] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[62]),
        .Q(data5[30]),
        .R(clear));
  FDRE \timestamp_shadow_reg[63] 
       (.C(s_axi_aclk),
        .CE(capture_buffer_n_71),
        .D(timestamp_counter_reg[63]),
        .Q(data5[31]),
        .R(clear));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[0]_i_1 
       (.I0(s_axi_wdata[0]),
        .I1(w_pending_reg_n_0),
        .I2(wdata_reg[0]),
        .I3(s_axi_awaddr[4]),
        .I4(aw_pending),
        .I5(awaddr_reg[4]),
        .O(\virtual_evt_data[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[10]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[10]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[10]),
        .O(\virtual_evt_data[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[11]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[11]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[11]),
        .O(\virtual_evt_data[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0001000100010000)) 
    \virtual_evt_data[127]_i_2 
       (.I0(\virtual_evt_data[127]_i_3_n_0 ),
        .I1(\virtual_evt_data[127]_i_4_n_0 ),
        .I2(capture_arm_pulse_i_4_n_0),
        .I3(\scratch_reg[31]_i_6_n_0 ),
        .I4(\virtual_evt_data[127]_i_5_n_0 ),
        .I5(\virtual_evt_data[127]_i_6_n_0 ),
        .O(\virtual_evt_data[127]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBBFCB8)) 
    \virtual_evt_data[127]_i_3 
       (.I0(awaddr_reg[2]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[2]),
        .I3(awaddr_reg[5]),
        .I4(s_axi_awaddr[5]),
        .I5(\dropped_count_reg[31]_i_8_n_0 ),
        .O(\virtual_evt_data[127]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \virtual_evt_data[127]_i_4 
       (.I0(event_arbiter_n_19),
        .I1(\led_ctrl_reg[0]_i_10_n_0 ),
        .I2(\led_ctrl_reg[0]_i_13_n_0 ),
        .I3(\virtual_evt_data[127]_i_7_n_0 ),
        .I4(event_arbiter_n_18),
        .O(\virtual_evt_data[127]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'hCCA000A0)) 
    \virtual_evt_data[127]_i_5 
       (.I0(s_axi_awaddr[4]),
        .I1(awaddr_reg[4]),
        .I2(s_axi_awaddr[3]),
        .I3(aw_pending),
        .I4(awaddr_reg[3]),
        .O(\virtual_evt_data[127]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000020222000)) 
    \virtual_evt_data[127]_i_6 
       (.I0(p_0_in13_in),
        .I1(event_arbiter_n_14),
        .I2(wstrb_reg[0]),
        .I3(w_pending_reg_n_0),
        .I4(s_axi_wstrb[0]),
        .I5(write_addr),
        .O(\virtual_evt_data[127]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \virtual_evt_data[127]_i_7 
       (.I0(awaddr_reg[7]),
        .I1(aw_pending),
        .I2(s_axi_awaddr[7]),
        .O(\virtual_evt_data[127]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[12]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[12]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[12]),
        .O(\virtual_evt_data[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[13]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[13]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[13]),
        .O(\virtual_evt_data[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[14]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[14]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[14]),
        .O(\virtual_evt_data[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[15]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[15]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[15]),
        .O(\virtual_evt_data[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[16]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[16]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[16]),
        .O(\virtual_evt_data[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[17]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[17]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[17]),
        .O(\virtual_evt_data[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[18]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[18]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[18]),
        .O(\virtual_evt_data[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[19]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[19]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[19]),
        .O(\virtual_evt_data[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[1]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[1]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[1]),
        .O(\virtual_evt_data[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[20]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[20]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[20]),
        .O(\virtual_evt_data[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[21]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[21]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[21]),
        .O(\virtual_evt_data[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[22]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[22]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[22]),
        .O(\virtual_evt_data[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[23]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[23]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[23]),
        .O(\virtual_evt_data[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[2]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[2]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[2]),
        .O(\virtual_evt_data[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8308800FFFFFFFF)) 
    \virtual_evt_data[32]_i_1 
       (.I0(wstrb_reg[3]),
        .I1(w_pending_reg_n_0),
        .I2(s_axi_wstrb[3]),
        .I3(wdata_reg[31]),
        .I4(s_axi_wdata[31]),
        .I5(write_addr),
        .O(\virtual_evt_data[32]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[3]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[3]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[3]),
        .O(\virtual_evt_data[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h1D)) 
    \virtual_evt_data[49]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .O(\virtual_evt_data[49]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[4]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[4]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[4]),
        .O(\virtual_evt_data[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[5]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[5]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[5]),
        .O(\virtual_evt_data[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[6]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[6]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[6]),
        .O(\virtual_evt_data[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[7]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[7]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[7]),
        .O(\virtual_evt_data[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[8]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[8]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[8]),
        .O(\virtual_evt_data[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE2E2E2000000E200)) 
    \virtual_evt_data[9]_i_1 
       (.I0(s_axi_awaddr[4]),
        .I1(aw_pending),
        .I2(awaddr_reg[4]),
        .I3(s_axi_wdata[9]),
        .I4(w_pending_reg_n_0),
        .I5(wdata_reg[9]),
        .O(\virtual_evt_data[9]_i_1_n_0 ));
  FDRE \virtual_evt_data_reg[0] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[0]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[0] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[100] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[36]),
        .Q(\virtual_evt_data_reg_n_0_[100] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[101] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[37]),
        .Q(\virtual_evt_data_reg_n_0_[101] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[102] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[38]),
        .Q(\virtual_evt_data_reg_n_0_[102] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[103] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[39]),
        .Q(\virtual_evt_data_reg_n_0_[103] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[104] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[40]),
        .Q(\virtual_evt_data_reg_n_0_[104] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[105] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[41]),
        .Q(\virtual_evt_data_reg_n_0_[105] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[106] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[42]),
        .Q(\virtual_evt_data_reg_n_0_[106] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[107] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[43]),
        .Q(\virtual_evt_data_reg_n_0_[107] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[108] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[44]),
        .Q(\virtual_evt_data_reg_n_0_[108] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[109] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[45]),
        .Q(\virtual_evt_data_reg_n_0_[109] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[10] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[10]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[10] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[110] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[46]),
        .Q(\virtual_evt_data_reg_n_0_[110] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[111] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[47]),
        .Q(\virtual_evt_data_reg_n_0_[111] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[112] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[48]),
        .Q(\virtual_evt_data_reg_n_0_[112] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[113] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[49]),
        .Q(\virtual_evt_data_reg_n_0_[113] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[114] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[50]),
        .Q(\virtual_evt_data_reg_n_0_[114] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[115] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[51]),
        .Q(\virtual_evt_data_reg_n_0_[115] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[116] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[52]),
        .Q(\virtual_evt_data_reg_n_0_[116] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[117] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[53]),
        .Q(\virtual_evt_data_reg_n_0_[117] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[118] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[54]),
        .Q(\virtual_evt_data_reg_n_0_[118] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[119] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[55]),
        .Q(\virtual_evt_data_reg_n_0_[119] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[11] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[11]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[11] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[120] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[56]),
        .Q(\virtual_evt_data_reg_n_0_[120] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[121] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[57]),
        .Q(\virtual_evt_data_reg_n_0_[121] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[122] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[58]),
        .Q(\virtual_evt_data_reg_n_0_[122] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[123] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[59]),
        .Q(\virtual_evt_data_reg_n_0_[123] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[124] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[60]),
        .Q(\virtual_evt_data_reg_n_0_[124] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[125] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[61]),
        .Q(\virtual_evt_data_reg_n_0_[125] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[126] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[62]),
        .Q(\virtual_evt_data_reg_n_0_[126] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[127] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[63]),
        .Q(\virtual_evt_data_reg_n_0_[127] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[12] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[12]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[12] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[13] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[13]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[13] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[14] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[14]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[14] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[15] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[15]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[15] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[16] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[16]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[16] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[17] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[17]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[17] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[18] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[18]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[18] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[19] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[19]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[19] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[1] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[1]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[1] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[20] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[20]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[20] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[21] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[21]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[21] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[22] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[22]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[22] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[23] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[23]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[23] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[2] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[2]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[2] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[32] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[32]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[32] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[3] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[3]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[3] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[48] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(write_addr),
        .Q(\virtual_evt_data_reg_n_0_[48] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[49] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[49]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[49] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[4] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[4]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[4] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[55] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(1'b1),
        .Q(\virtual_evt_data_reg_n_0_[55] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[5] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[5]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[5] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[64] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[0]),
        .Q(\virtual_evt_data_reg_n_0_[64] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[65] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[1]),
        .Q(\virtual_evt_data_reg_n_0_[65] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[66] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[2]),
        .Q(\virtual_evt_data_reg_n_0_[66] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[67] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[3]),
        .Q(\virtual_evt_data_reg_n_0_[67] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[68] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[4]),
        .Q(\virtual_evt_data_reg_n_0_[68] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[69] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[5]),
        .Q(\virtual_evt_data_reg_n_0_[69] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[6] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[6]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[6] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[70] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[6]),
        .Q(\virtual_evt_data_reg_n_0_[70] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[71] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[7]),
        .Q(\virtual_evt_data_reg_n_0_[71] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[72] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[8]),
        .Q(\virtual_evt_data_reg_n_0_[72] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[73] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[9]),
        .Q(\virtual_evt_data_reg_n_0_[73] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[74] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[10]),
        .Q(\virtual_evt_data_reg_n_0_[74] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[75] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[11]),
        .Q(\virtual_evt_data_reg_n_0_[75] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[76] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[12]),
        .Q(\virtual_evt_data_reg_n_0_[76] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[77] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[13]),
        .Q(\virtual_evt_data_reg_n_0_[77] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[78] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[14]),
        .Q(\virtual_evt_data_reg_n_0_[78] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[79] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[15]),
        .Q(\virtual_evt_data_reg_n_0_[79] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[7] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[7]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[7] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[80] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[16]),
        .Q(\virtual_evt_data_reg_n_0_[80] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[81] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[17]),
        .Q(\virtual_evt_data_reg_n_0_[81] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[82] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[18]),
        .Q(\virtual_evt_data_reg_n_0_[82] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[83] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[19]),
        .Q(\virtual_evt_data_reg_n_0_[83] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[84] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[20]),
        .Q(\virtual_evt_data_reg_n_0_[84] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[85] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[21]),
        .Q(\virtual_evt_data_reg_n_0_[85] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[86] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[22]),
        .Q(\virtual_evt_data_reg_n_0_[86] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[87] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[23]),
        .Q(\virtual_evt_data_reg_n_0_[87] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[88] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[24]),
        .Q(\virtual_evt_data_reg_n_0_[88] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[89] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[25]),
        .Q(\virtual_evt_data_reg_n_0_[89] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[8] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[8]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[8] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[90] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[26]),
        .Q(\virtual_evt_data_reg_n_0_[90] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[91] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[27]),
        .Q(\virtual_evt_data_reg_n_0_[91] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[92] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[28]),
        .Q(\virtual_evt_data_reg_n_0_[92] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[93] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[29]),
        .Q(\virtual_evt_data_reg_n_0_[93] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[94] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[30]),
        .Q(\virtual_evt_data_reg_n_0_[94] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[95] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[31]),
        .Q(\virtual_evt_data_reg_n_0_[95] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[96] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[32]),
        .Q(\virtual_evt_data_reg_n_0_[96] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[97] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[33]),
        .Q(\virtual_evt_data_reg_n_0_[97] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[98] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[34]),
        .Q(\virtual_evt_data_reg_n_0_[98] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[99] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(timestamp_counter_reg[35]),
        .Q(\virtual_evt_data_reg_n_0_[99] ),
        .R(clear));
  FDRE \virtual_evt_data_reg[9] 
       (.C(s_axi_aclk),
        .CE(virtual_evt_valid7_out),
        .D(\virtual_evt_data[9]_i_1_n_0 ),
        .Q(\virtual_evt_data_reg_n_0_[9] ),
        .R(clear));
  LUT6 #(
    .INIT(64'h1015505515155555)) 
    virtual_evt_trigger_i_2
       (.I0(\virtual_evt_data[127]_i_6_n_0 ),
        .I1(wstrb_reg[3]),
        .I2(w_pending_reg_n_0),
        .I3(s_axi_wstrb[3]),
        .I4(wdata_reg[31]),
        .I5(s_axi_wdata[31]),
        .O(virtual_evt_trigger_i_2_n_0));
  LUT6 #(
    .INIT(64'h8C8C8C8C8C8C8CCC)) 
    virtual_evt_trigger_i_3
       (.I0(write_addr),
        .I1(virtual_evt_valid_reg_n_0),
        .I2(virtual_evt_valid_i_2_n_0),
        .I3(\scratch_reg[31]_i_6_n_0 ),
        .I4(capture_arm_pulse_i_4_n_0),
        .I5(virtual_evt_trigger_i_4_n_0),
        .O(virtual_evt_trigger_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    virtual_evt_trigger_i_4
       (.I0(\dropped_count_reg[31]_i_8_n_0 ),
        .I1(capture_arm_pulse_i_5_n_0),
        .I2(event_arbiter_n_18),
        .I3(\virtual_evt_data[127]_i_7_n_0 ),
        .I4(virtual_evt_trigger_i_5_n_0),
        .I5(event_arbiter_n_19),
        .O(virtual_evt_trigger_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    virtual_evt_trigger_i_5
       (.I0(s_axi_awaddr[0]),
        .I1(awaddr_reg[0]),
        .I2(s_axi_awaddr[6]),
        .I3(aw_pending),
        .I4(awaddr_reg[6]),
        .O(virtual_evt_trigger_i_5_n_0));
  FDRE virtual_evt_trigger_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(event_arbiter_n_180),
        .Q(virtual_evt_trigger_reg_n_0),
        .R(clear));
  LUT6 #(
    .INIT(64'h0C000A0A0C000000)) 
    virtual_evt_valid_i_2
       (.I0(s_axi_wstrb[0]),
        .I1(wstrb_reg[0]),
        .I2(event_arbiter_n_14),
        .I3(wdata_reg[2]),
        .I4(w_pending_reg_n_0),
        .I5(s_axi_wdata[2]),
        .O(virtual_evt_valid_i_2_n_0));
  LUT5 #(
    .INIT(32'h00000001)) 
    virtual_evt_valid_i_3
       (.I0(\scratch_reg[31]_i_6_n_0 ),
        .I1(capture_arm_pulse_i_4_n_0),
        .I2(\led_ctrl_reg[0]_i_5_n_0 ),
        .I3(virtual_evt_valid_i_5_n_0),
        .I4(\virtual_evt_data[127]_i_3_n_0 ),
        .O(virtual_evt_valid_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF4540)) 
    virtual_evt_valid_i_5
       (.I0(event_arbiter_n_18),
        .I1(awaddr_reg[7]),
        .I2(aw_pending),
        .I3(s_axi_awaddr[7]),
        .I4(\led_ctrl_reg[0]_i_13_n_0 ),
        .I5(\led_ctrl_reg[0]_i_10_n_0 ),
        .O(virtual_evt_valid_i_5_n_0));
  FDRE virtual_evt_valid_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(event_arbiter_n_181),
        .Q(virtual_evt_valid_reg_n_0),
        .R(clear));
  LUT6 #(
    .INIT(64'hE0E0E0EE00000000)) 
    w_pending_i_1
       (.I0(w_pending_reg_n_0),
        .I1(w_hs),
        .I2(s_axi_bvalid_reg_0),
        .I3(aw_hs),
        .I4(aw_pending),
        .I5(s_axi_aresetn),
        .O(w_pending_i_1_n_0));
  FDRE w_pending_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(w_pending_i_1_n_0),
        .Q(w_pending_reg_n_0),
        .R(1'b0));
  FDRE \wdata_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[0]),
        .Q(wdata_reg[0]),
        .R(clear));
  FDRE \wdata_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[10]),
        .Q(wdata_reg[10]),
        .R(clear));
  FDRE \wdata_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[11]),
        .Q(wdata_reg[11]),
        .R(clear));
  FDRE \wdata_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[12]),
        .Q(wdata_reg[12]),
        .R(clear));
  FDRE \wdata_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[13]),
        .Q(wdata_reg[13]),
        .R(clear));
  FDRE \wdata_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[14]),
        .Q(wdata_reg[14]),
        .R(clear));
  FDRE \wdata_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[15]),
        .Q(wdata_reg[15]),
        .R(clear));
  FDRE \wdata_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[16]),
        .Q(wdata_reg[16]),
        .R(clear));
  FDRE \wdata_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[17]),
        .Q(wdata_reg[17]),
        .R(clear));
  FDRE \wdata_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[18]),
        .Q(wdata_reg[18]),
        .R(clear));
  FDRE \wdata_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[19]),
        .Q(wdata_reg[19]),
        .R(clear));
  FDRE \wdata_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[1]),
        .Q(wdata_reg[1]),
        .R(clear));
  FDRE \wdata_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[20]),
        .Q(wdata_reg[20]),
        .R(clear));
  FDRE \wdata_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[21]),
        .Q(wdata_reg[21]),
        .R(clear));
  FDRE \wdata_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[22]),
        .Q(wdata_reg[22]),
        .R(clear));
  FDRE \wdata_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[23]),
        .Q(wdata_reg[23]),
        .R(clear));
  FDRE \wdata_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[24]),
        .Q(wdata_reg[24]),
        .R(clear));
  FDRE \wdata_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[25]),
        .Q(wdata_reg[25]),
        .R(clear));
  FDRE \wdata_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[26]),
        .Q(wdata_reg[26]),
        .R(clear));
  FDRE \wdata_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[27]),
        .Q(wdata_reg[27]),
        .R(clear));
  FDRE \wdata_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[28]),
        .Q(wdata_reg[28]),
        .R(clear));
  FDRE \wdata_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[29]),
        .Q(wdata_reg[29]),
        .R(clear));
  FDRE \wdata_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[2]),
        .Q(wdata_reg[2]),
        .R(clear));
  FDRE \wdata_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[30]),
        .Q(wdata_reg[30]),
        .R(clear));
  FDRE \wdata_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[31]),
        .Q(wdata_reg[31]),
        .R(clear));
  FDRE \wdata_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[3]),
        .Q(wdata_reg[3]),
        .R(clear));
  FDRE \wdata_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[4]),
        .Q(wdata_reg[4]),
        .R(clear));
  FDRE \wdata_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[5]),
        .Q(wdata_reg[5]),
        .R(clear));
  FDRE \wdata_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[6]),
        .Q(wdata_reg[6]),
        .R(clear));
  FDRE \wdata_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[7]),
        .Q(wdata_reg[7]),
        .R(clear));
  FDRE \wdata_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[8]),
        .Q(wdata_reg[8]),
        .R(clear));
  FDRE \wdata_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wdata[9]),
        .Q(wdata_reg[9]),
        .R(clear));
  LUT2 #(
    .INIT(4'h8)) 
    \wstrb_reg[3]_i_1 
       (.I0(s_axi_wready),
        .I1(s_axi_wvalid),
        .O(w_hs));
  FDRE \wstrb_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wstrb[0]),
        .Q(wstrb_reg[0]),
        .R(clear));
  FDRE \wstrb_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wstrb[1]),
        .Q(wstrb_reg[1]),
        .R(clear));
  FDRE \wstrb_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wstrb[2]),
        .Q(wstrb_reg[2]),
        .R(clear));
  FDRE \wstrb_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(w_hs),
        .D(s_axi_wstrb[3]),
        .Q(wstrb_reg[3]),
        .R(clear));
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
