-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Thu Sep 24 16:19:35 2026
-- Host        : LAPTOP-MK9F4NL5 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/Vivado/Project/Multi_protocol/Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/ip/multi_protocol_bd_multi_protocol_core_0_0/multi_protocol_bd_multi_protocol_core_0_0_sim_netlist.vhdl
-- Design      : multi_protocol_bd_multi_protocol_core_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity multi_protocol_bd_multi_protocol_core_0_0_event_arbiter_2 is
  port (
    \s_axi_araddr[4]\ : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    p_3_in : out STD_LOGIC;
    ext_evt_valid_0 : out STD_LOGIC;
    ext_evt_ready : out STD_LOGIC;
    \wdata_reg_reg[0]\ : out STD_LOGIC;
    \wdata_reg_reg[0]_0\ : out STD_LOGIC;
    \awaddr_reg_reg[12]\ : out STD_LOGIC;
    aw_pending_reg : out STD_LOGIC;
    capture_arm_pulse_reg : out STD_LOGIC;
    s_axi_awaddr_15_sp_1 : out STD_LOGIC;
    \awaddr_reg_reg[2]\ : out STD_LOGIC;
    \wstrb_reg_reg[0]\ : out STD_LOGIC;
    \awaddr_reg_reg[5]\ : out STD_LOGIC;
    \awaddr_reg_reg[3]\ : out STD_LOGIC;
    write_addr : out STD_LOGIC_VECTOR ( 0 to 0 );
    \awaddr_reg_reg[15]\ : out STD_LOGIC;
    s_axi_awaddr_6_sp_1 : out STD_LOGIC;
    \awaddr_reg_reg[8]\ : out STD_LOGIC;
    s_axi_awaddr_9_sp_1 : out STD_LOGIC;
    aw_hs : out STD_LOGIC;
    in_event : out STD_LOGIC_VECTOR ( 127 downto 0 );
    \s_axi_araddr[5]\ : out STD_LOGIC;
    \s_axi_araddr[5]_0\ : out STD_LOGIC;
    \s_axi_araddr[5]_1\ : out STD_LOGIC;
    \s_axi_araddr[5]_2\ : out STD_LOGIC;
    \s_axi_araddr[5]_3\ : out STD_LOGIC;
    \s_axi_araddr[5]_4\ : out STD_LOGIC;
    \s_axi_araddr[5]_5\ : out STD_LOGIC;
    \s_axi_araddr[5]_6\ : out STD_LOGIC;
    \s_axi_araddr[5]_7\ : out STD_LOGIC;
    \s_axi_araddr[4]_0\ : out STD_LOGIC;
    \s_axi_araddr[4]_1\ : out STD_LOGIC;
    \s_axi_araddr[4]_2\ : out STD_LOGIC;
    \s_axi_araddr[4]_3\ : out STD_LOGIC;
    \s_axi_araddr[4]_4\ : out STD_LOGIC;
    \s_axi_araddr[4]_5\ : out STD_LOGIC;
    \s_axi_araddr[4]_6\ : out STD_LOGIC;
    \s_axi_araddr[4]_7\ : out STD_LOGIC;
    \s_axi_araddr[4]_8\ : out STD_LOGIC;
    \s_axi_araddr[4]_9\ : out STD_LOGIC;
    \s_axi_araddr[4]_10\ : out STD_LOGIC;
    \s_axi_araddr[4]_11\ : out STD_LOGIC;
    \s_axi_araddr[4]_12\ : out STD_LOGIC;
    \s_axi_araddr[4]_13\ : out STD_LOGIC;
    \s_axi_araddr[4]_14\ : out STD_LOGIC;
    \s_axi_araddr[4]_15\ : out STD_LOGIC;
    \s_axi_araddr[4]_16\ : out STD_LOGIC;
    \s_axi_araddr[4]_17\ : out STD_LOGIC;
    \s_axi_araddr[4]_18\ : out STD_LOGIC;
    \s_axi_araddr[4]_19\ : out STD_LOGIC;
    \s_axi_araddr[4]_20\ : out STD_LOGIC;
    ext_evt_dropped_count_3_sp_1 : out STD_LOGIC;
    virtual_evt_valid_reg : out STD_LOGIC;
    virtual_evt_valid_reg_0 : out STD_LOGIC;
    clear : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    \s_axi_rdata_reg[16]\ : in STD_LOGIC;
    \s_axi_rdata_reg[16]_0\ : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \s_axi_rdata_reg[16]_1\ : in STD_LOGIC;
    virtual_evt_trigger_reg : in STD_LOGIC;
    virtual_evt_trigger_reg_0 : in STD_LOGIC;
    virtual_evt_trigger_reg_1 : in STD_LOGIC;
    ext_evt_valid : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    aw_pending : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 15 downto 0 );
    \dropped_count_reg[31]_i_4\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \scratch_reg_reg[0]\ : in STD_LOGIC;
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    ext_evt_ready_INST_0_i_4_0 : in STD_LOGIC;
    s_axi_wready : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    \scratch_reg_reg[0]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 0 to 0 );
    \dropped_count_reg[31]_i_6\ : in STD_LOGIC;
    ext_evt_data : in STD_LOGIC_VECTOR ( 127 downto 0 );
    memory_reg_1 : in STD_LOGIC_VECTOR ( 91 downto 0 );
    \s_axi_rdata_reg[27]\ : in STD_LOGIC;
    \s_axi_rdata_reg[27]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[26]\ : in STD_LOGIC;
    \s_axi_rdata_reg[26]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[22]\ : in STD_LOGIC;
    \s_axi_rdata_reg[22]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[20]\ : in STD_LOGIC;
    \s_axi_rdata_reg[20]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[12]\ : in STD_LOGIC;
    \s_axi_rdata_reg[12]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[6]\ : in STD_LOGIC;
    \s_axi_rdata_reg[6]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[2]\ : in STD_LOGIC;
    \s_axi_rdata_reg[2]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[1]\ : in STD_LOGIC;
    \s_axi_rdata_reg[1]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[0]\ : in STD_LOGIC;
    \s_axi_rdata_reg[0]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[31]\ : in STD_LOGIC;
    ext_evt_dropped_count : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \s_axi_rdata_reg[31]_i_9_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \s_axi_rdata_reg[30]\ : in STD_LOGIC;
    \s_axi_rdata_reg[29]\ : in STD_LOGIC;
    \s_axi_rdata_reg[28]\ : in STD_LOGIC;
    \s_axi_rdata_reg[25]\ : in STD_LOGIC;
    \s_axi_rdata_reg[24]\ : in STD_LOGIC;
    \s_axi_rdata_reg[23]\ : in STD_LOGIC;
    \s_axi_rdata_reg[21]\ : in STD_LOGIC;
    \s_axi_rdata_reg[19]\ : in STD_LOGIC;
    \s_axi_rdata_reg[18]\ : in STD_LOGIC;
    \s_axi_rdata_reg[17]\ : in STD_LOGIC;
    \s_axi_rdata_reg[15]\ : in STD_LOGIC;
    \s_axi_rdata_reg[14]\ : in STD_LOGIC;
    \s_axi_rdata_reg[13]\ : in STD_LOGIC;
    \s_axi_rdata_reg[11]\ : in STD_LOGIC;
    \s_axi_rdata_reg[10]\ : in STD_LOGIC;
    \s_axi_rdata_reg[9]\ : in STD_LOGIC;
    \s_axi_rdata_reg[8]\ : in STD_LOGIC;
    \s_axi_rdata_reg[7]\ : in STD_LOGIC;
    \s_axi_rdata_reg[5]\ : in STD_LOGIC;
    \s_axi_rdata_reg[4]\ : in STD_LOGIC;
    virtual_evt_trigger_reg_2 : in STD_LOGIC;
    virtual_evt_trigger_reg_3 : in STD_LOGIC;
    virtual_evt_trigger_reg_4 : in STD_LOGIC;
    virtual_evt_valid_reg_1 : in STD_LOGIC;
    virtual_evt_valid_reg_2 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of multi_protocol_bd_multi_protocol_core_0_0_event_arbiter_2 : entity is "event_arbiter_2";
end multi_protocol_bd_multi_protocol_core_0_0_event_arbiter_2;

architecture STRUCTURE of multi_protocol_bd_multi_protocol_core_0_0_event_arbiter_2 is
  signal \^aw_hs\ : STD_LOGIC;
  signal \^aw_pending_reg\ : STD_LOGIC;
  signal \^awaddr_reg_reg[12]\ : STD_LOGIC;
  signal \^awaddr_reg_reg[15]\ : STD_LOGIC;
  signal \^awaddr_reg_reg[2]\ : STD_LOGIC;
  signal \^awaddr_reg_reg[3]\ : STD_LOGIC;
  signal \^awaddr_reg_reg[5]\ : STD_LOGIC;
  signal \^awaddr_reg_reg[8]\ : STD_LOGIC;
  signal \^capture_arm_pulse_reg\ : STD_LOGIC;
  signal \contention_count[0]_i_1_n_0\ : STD_LOGIC;
  signal \contention_count[0]_i_3_n_0\ : STD_LOGIC;
  signal \contention_count_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \contention_count_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \contention_count_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \contention_count_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \contention_count_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \contention_count_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \contention_count_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \contention_count_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \contention_count_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \contention_count_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \contention_count_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \contention_count_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \contention_count_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \contention_count_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \contention_count_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \contention_count_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \contention_count_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \contention_count_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \contention_count_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \contention_count_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \contention_count_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \contention_count_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \contention_count_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \contention_count_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \contention_count_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \contention_count_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \contention_count_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \contention_count_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \contention_count_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \contention_count_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \contention_count_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \contention_count_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \contention_count_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \contention_count_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \contention_count_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \contention_count_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \contention_count_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \contention_count_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \contention_count_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \contention_count_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \contention_count_reg[28]_i_1_n_1\ : STD_LOGIC;
  signal \contention_count_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \contention_count_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \contention_count_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \contention_count_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \contention_count_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \contention_count_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \contention_count_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \contention_count_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \contention_count_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \contention_count_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \contention_count_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \contention_count_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \contention_count_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \contention_count_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \contention_count_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \contention_count_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \contention_count_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \contention_count_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \contention_count_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \contention_count_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \contention_count_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \contention_count_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal ext_evt_dropped_count_3_sn_1 : STD_LOGIC;
  signal ext_evt_ready_INST_0_i_11_n_0 : STD_LOGIC;
  signal ext_evt_ready_INST_0_i_8_n_0 : STD_LOGIC;
  signal \^ext_evt_valid_0\ : STD_LOGIC;
  signal last_grant : STD_LOGIC;
  signal last_grant_i_1_n_0 : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^p_3_in\ : STD_LOGIC;
  signal s_axi_awaddr_15_sn_1 : STD_LOGIC;
  signal s_axi_awaddr_6_sn_1 : STD_LOGIC;
  signal s_axi_awaddr_9_sn_1 : STD_LOGIC;
  signal \s_axi_rdata[0]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[10]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[11]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[12]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[13]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[14]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[15]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[16]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[17]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[18]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[19]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[1]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[20]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[21]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[22]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[23]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[24]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[25]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[26]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[27]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[28]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[29]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[2]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[30]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_15_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[4]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[5]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[6]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[7]_i_10_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[8]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[9]_i_7_n_0\ : STD_LOGIC;
  signal \^wdata_reg_reg[0]\ : STD_LOGIC;
  signal \^wdata_reg_reg[0]_0\ : STD_LOGIC;
  signal \^write_addr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^wstrb_reg_reg[0]\ : STD_LOGIC;
  signal \NLW_contention_count_reg[28]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of ext_evt_ready_INST_0 : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of ext_evt_ready_INST_0_i_12 : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of ext_evt_ready_INST_0_i_15 : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of ext_evt_ready_INST_0_i_9 : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \led_ctrl_reg[0]_i_2\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \virtual_evt_data[127]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \virtual_evt_data[48]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of virtual_evt_valid_i_4 : label is "soft_lutpair15";
begin
  aw_hs <= \^aw_hs\;
  aw_pending_reg <= \^aw_pending_reg\;
  \awaddr_reg_reg[12]\ <= \^awaddr_reg_reg[12]\;
  \awaddr_reg_reg[15]\ <= \^awaddr_reg_reg[15]\;
  \awaddr_reg_reg[2]\ <= \^awaddr_reg_reg[2]\;
  \awaddr_reg_reg[3]\ <= \^awaddr_reg_reg[3]\;
  \awaddr_reg_reg[5]\ <= \^awaddr_reg_reg[5]\;
  \awaddr_reg_reg[8]\ <= \^awaddr_reg_reg[8]\;
  capture_arm_pulse_reg <= \^capture_arm_pulse_reg\;
  ext_evt_dropped_count_3_sp_1 <= ext_evt_dropped_count_3_sn_1;
  ext_evt_valid_0 <= \^ext_evt_valid_0\;
  p_3_in <= \^p_3_in\;
  s_axi_awaddr_15_sp_1 <= s_axi_awaddr_15_sn_1;
  s_axi_awaddr_6_sp_1 <= s_axi_awaddr_6_sn_1;
  s_axi_awaddr_9_sp_1 <= s_axi_awaddr_9_sn_1;
  \wdata_reg_reg[0]\ <= \^wdata_reg_reg[0]\;
  \wdata_reg_reg[0]_0\ <= \^wdata_reg_reg[0]_0\;
  write_addr(0) <= \^write_addr\(0);
  \wstrb_reg_reg[0]\ <= \^wstrb_reg_reg[0]\;
\awaddr_reg[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => s_axi_awready,
      I1 => s_axi_awvalid,
      O => \^aw_hs\
    );
\contention_count[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \^p_3_in\,
      I1 => virtual_evt_trigger_reg,
      I2 => ext_evt_valid,
      O => \contention_count[0]_i_1_n_0\
    );
\contention_count[0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => p_1_in(0),
      O => \contention_count[0]_i_3_n_0\
    );
\contention_count_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[0]_i_2_n_7\,
      Q => p_1_in(0),
      R => clear
    );
\contention_count_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \contention_count_reg[0]_i_2_n_0\,
      CO(2) => \contention_count_reg[0]_i_2_n_1\,
      CO(1) => \contention_count_reg[0]_i_2_n_2\,
      CO(0) => \contention_count_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \contention_count_reg[0]_i_2_n_4\,
      O(2) => \contention_count_reg[0]_i_2_n_5\,
      O(1) => \contention_count_reg[0]_i_2_n_6\,
      O(0) => \contention_count_reg[0]_i_2_n_7\,
      S(3 downto 1) => p_1_in(3 downto 1),
      S(0) => \contention_count[0]_i_3_n_0\
    );
\contention_count_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[8]_i_1_n_5\,
      Q => p_1_in(10),
      R => clear
    );
\contention_count_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[8]_i_1_n_4\,
      Q => p_1_in(11),
      R => clear
    );
\contention_count_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[12]_i_1_n_7\,
      Q => p_1_in(12),
      R => clear
    );
\contention_count_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \contention_count_reg[8]_i_1_n_0\,
      CO(3) => \contention_count_reg[12]_i_1_n_0\,
      CO(2) => \contention_count_reg[12]_i_1_n_1\,
      CO(1) => \contention_count_reg[12]_i_1_n_2\,
      CO(0) => \contention_count_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \contention_count_reg[12]_i_1_n_4\,
      O(2) => \contention_count_reg[12]_i_1_n_5\,
      O(1) => \contention_count_reg[12]_i_1_n_6\,
      O(0) => \contention_count_reg[12]_i_1_n_7\,
      S(3 downto 0) => p_1_in(15 downto 12)
    );
\contention_count_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[12]_i_1_n_6\,
      Q => p_1_in(13),
      R => clear
    );
\contention_count_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[12]_i_1_n_5\,
      Q => p_1_in(14),
      R => clear
    );
\contention_count_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[12]_i_1_n_4\,
      Q => p_1_in(15),
      R => clear
    );
\contention_count_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[16]_i_1_n_7\,
      Q => p_1_in(16),
      R => clear
    );
\contention_count_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \contention_count_reg[12]_i_1_n_0\,
      CO(3) => \contention_count_reg[16]_i_1_n_0\,
      CO(2) => \contention_count_reg[16]_i_1_n_1\,
      CO(1) => \contention_count_reg[16]_i_1_n_2\,
      CO(0) => \contention_count_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \contention_count_reg[16]_i_1_n_4\,
      O(2) => \contention_count_reg[16]_i_1_n_5\,
      O(1) => \contention_count_reg[16]_i_1_n_6\,
      O(0) => \contention_count_reg[16]_i_1_n_7\,
      S(3 downto 0) => p_1_in(19 downto 16)
    );
\contention_count_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[16]_i_1_n_6\,
      Q => p_1_in(17),
      R => clear
    );
\contention_count_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[16]_i_1_n_5\,
      Q => p_1_in(18),
      R => clear
    );
\contention_count_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[16]_i_1_n_4\,
      Q => p_1_in(19),
      R => clear
    );
\contention_count_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[0]_i_2_n_6\,
      Q => p_1_in(1),
      R => clear
    );
\contention_count_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[20]_i_1_n_7\,
      Q => p_1_in(20),
      R => clear
    );
\contention_count_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \contention_count_reg[16]_i_1_n_0\,
      CO(3) => \contention_count_reg[20]_i_1_n_0\,
      CO(2) => \contention_count_reg[20]_i_1_n_1\,
      CO(1) => \contention_count_reg[20]_i_1_n_2\,
      CO(0) => \contention_count_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \contention_count_reg[20]_i_1_n_4\,
      O(2) => \contention_count_reg[20]_i_1_n_5\,
      O(1) => \contention_count_reg[20]_i_1_n_6\,
      O(0) => \contention_count_reg[20]_i_1_n_7\,
      S(3 downto 0) => p_1_in(23 downto 20)
    );
\contention_count_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[20]_i_1_n_6\,
      Q => p_1_in(21),
      R => clear
    );
\contention_count_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[20]_i_1_n_5\,
      Q => p_1_in(22),
      R => clear
    );
\contention_count_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[20]_i_1_n_4\,
      Q => p_1_in(23),
      R => clear
    );
\contention_count_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[24]_i_1_n_7\,
      Q => p_1_in(24),
      R => clear
    );
\contention_count_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \contention_count_reg[20]_i_1_n_0\,
      CO(3) => \contention_count_reg[24]_i_1_n_0\,
      CO(2) => \contention_count_reg[24]_i_1_n_1\,
      CO(1) => \contention_count_reg[24]_i_1_n_2\,
      CO(0) => \contention_count_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \contention_count_reg[24]_i_1_n_4\,
      O(2) => \contention_count_reg[24]_i_1_n_5\,
      O(1) => \contention_count_reg[24]_i_1_n_6\,
      O(0) => \contention_count_reg[24]_i_1_n_7\,
      S(3 downto 0) => p_1_in(27 downto 24)
    );
\contention_count_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[24]_i_1_n_6\,
      Q => p_1_in(25),
      R => clear
    );
\contention_count_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[24]_i_1_n_5\,
      Q => p_1_in(26),
      R => clear
    );
\contention_count_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[24]_i_1_n_4\,
      Q => p_1_in(27),
      R => clear
    );
\contention_count_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[28]_i_1_n_7\,
      Q => p_1_in(28),
      R => clear
    );
\contention_count_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \contention_count_reg[24]_i_1_n_0\,
      CO(3) => \NLW_contention_count_reg[28]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \contention_count_reg[28]_i_1_n_1\,
      CO(1) => \contention_count_reg[28]_i_1_n_2\,
      CO(0) => \contention_count_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \contention_count_reg[28]_i_1_n_4\,
      O(2) => \contention_count_reg[28]_i_1_n_5\,
      O(1) => \contention_count_reg[28]_i_1_n_6\,
      O(0) => \contention_count_reg[28]_i_1_n_7\,
      S(3 downto 0) => p_1_in(31 downto 28)
    );
\contention_count_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[28]_i_1_n_6\,
      Q => p_1_in(29),
      R => clear
    );
\contention_count_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[0]_i_2_n_5\,
      Q => p_1_in(2),
      R => clear
    );
\contention_count_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[28]_i_1_n_5\,
      Q => p_1_in(30),
      R => clear
    );
\contention_count_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[28]_i_1_n_4\,
      Q => p_1_in(31),
      R => clear
    );
\contention_count_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[0]_i_2_n_4\,
      Q => p_1_in(3),
      R => clear
    );
\contention_count_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[4]_i_1_n_7\,
      Q => p_1_in(4),
      R => clear
    );
\contention_count_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \contention_count_reg[0]_i_2_n_0\,
      CO(3) => \contention_count_reg[4]_i_1_n_0\,
      CO(2) => \contention_count_reg[4]_i_1_n_1\,
      CO(1) => \contention_count_reg[4]_i_1_n_2\,
      CO(0) => \contention_count_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \contention_count_reg[4]_i_1_n_4\,
      O(2) => \contention_count_reg[4]_i_1_n_5\,
      O(1) => \contention_count_reg[4]_i_1_n_6\,
      O(0) => \contention_count_reg[4]_i_1_n_7\,
      S(3 downto 0) => p_1_in(7 downto 4)
    );
\contention_count_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[4]_i_1_n_6\,
      Q => p_1_in(5),
      R => clear
    );
\contention_count_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[4]_i_1_n_5\,
      Q => p_1_in(6),
      R => clear
    );
\contention_count_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[4]_i_1_n_4\,
      Q => p_1_in(7),
      R => clear
    );
\contention_count_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[8]_i_1_n_7\,
      Q => p_1_in(8),
      R => clear
    );
\contention_count_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \contention_count_reg[4]_i_1_n_0\,
      CO(3) => \contention_count_reg[8]_i_1_n_0\,
      CO(2) => \contention_count_reg[8]_i_1_n_1\,
      CO(1) => \contention_count_reg[8]_i_1_n_2\,
      CO(0) => \contention_count_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \contention_count_reg[8]_i_1_n_4\,
      O(2) => \contention_count_reg[8]_i_1_n_5\,
      O(1) => \contention_count_reg[8]_i_1_n_6\,
      O(0) => \contention_count_reg[8]_i_1_n_7\,
      S(3 downto 0) => p_1_in(11 downto 8)
    );
\contention_count_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \contention_count[0]_i_1_n_0\,
      D => \contention_count_reg[8]_i_1_n_6\,
      Q => p_1_in(9),
      R => clear
    );
\dropped_count_reg[31]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FDFF0000"
    )
        port map (
      I0 => \^wdata_reg_reg[0]_0\,
      I1 => virtual_evt_trigger_reg_1,
      I2 => \^awaddr_reg_reg[12]\,
      I3 => \^aw_pending_reg\,
      I4 => \^capture_arm_pulse_reg\,
      I5 => \^ext_evt_valid_0\,
      O => \^wdata_reg_reg[0]\
    );
ext_evt_ready_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^p_3_in\,
      I1 => \^ext_evt_valid_0\,
      O => ext_evt_ready
    );
ext_evt_ready_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAA2AAAAAAAA"
    )
        port map (
      I0 => \^capture_arm_pulse_reg\,
      I1 => \^aw_pending_reg\,
      I2 => \^awaddr_reg_reg[12]\,
      I3 => s_axi_awaddr_15_sn_1,
      I4 => \^awaddr_reg_reg[2]\,
      I5 => \^wdata_reg_reg[0]_0\,
      O => \^p_3_in\
    );
ext_evt_ready_INST_0_i_10: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => s_axi_awaddr(9),
      I1 => Q(9),
      I2 => s_axi_awaddr(10),
      I3 => aw_pending,
      I4 => Q(10),
      O => s_axi_awaddr_9_sn_1
    );
ext_evt_ready_INST_0_i_11: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AABF"
    )
        port map (
      I0 => ext_evt_ready_INST_0_i_4_0,
      I1 => s_axi_wready,
      I2 => s_axi_wvalid,
      I3 => \scratch_reg_reg[0]\,
      O => ext_evt_ready_INST_0_i_11_n_0
    );
ext_evt_ready_INST_0_i_12: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \dropped_count_reg[31]_i_4\(0),
      I1 => \scratch_reg_reg[0]\,
      I2 => s_axi_wstrb(0),
      O => \^wstrb_reg_reg[0]\
    );
ext_evt_ready_INST_0_i_13: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => Q(15),
      I1 => aw_pending,
      I2 => Q(14),
      I3 => Q(13),
      O => \^awaddr_reg_reg[15]\
    );
ext_evt_ready_INST_0_i_14: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
        port map (
      I0 => s_axi_awaddr(6),
      I1 => Q(6),
      I2 => s_axi_awaddr(7),
      I3 => aw_pending,
      I4 => Q(7),
      O => s_axi_awaddr_6_sn_1
    );
ext_evt_ready_INST_0_i_15: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => Q(5),
      I1 => aw_pending,
      I2 => s_axi_awaddr(5),
      O => \^awaddr_reg_reg[5]\
    );
ext_evt_ready_INST_0_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"2A"
    )
        port map (
      I0 => ext_evt_valid,
      I1 => last_grant,
      I2 => virtual_evt_trigger_reg,
      O => \^ext_evt_valid_0\
    );
ext_evt_ready_INST_0_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"54"
    )
        port map (
      I0 => \dropped_count_reg[31]_i_6\,
      I1 => virtual_evt_trigger_reg,
      I2 => ext_evt_valid,
      O => \^capture_arm_pulse_reg\
    );
ext_evt_ready_INST_0_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000001010100"
    )
        port map (
      I0 => ext_evt_ready_INST_0_i_8_n_0,
      I1 => \^awaddr_reg_reg[8]\,
      I2 => s_axi_awaddr_9_sn_1,
      I3 => aw_pending,
      I4 => \^aw_hs\,
      I5 => ext_evt_ready_INST_0_i_11_n_0,
      O => \^aw_pending_reg\
    );
ext_evt_ready_INST_0_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF77CF47FFFFFFFF"
    )
        port map (
      I0 => Q(12),
      I1 => aw_pending,
      I2 => s_axi_awaddr(12),
      I3 => Q(1),
      I4 => s_axi_awaddr(1),
      I5 => \^wstrb_reg_reg[0]\,
      O => \^awaddr_reg_reg[12]\
    );
ext_evt_ready_INST_0_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55555554FFFFFFFF"
    )
        port map (
      I0 => \^awaddr_reg_reg[15]\,
      I1 => s_axi_awaddr(15),
      I2 => aw_pending,
      I3 => s_axi_awaddr(14),
      I4 => s_axi_awaddr(13),
      I5 => s_axi_awaddr_6_sn_1,
      O => s_axi_awaddr_15_sn_1
    );
ext_evt_ready_INST_0_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFB8"
    )
        port map (
      I0 => Q(2),
      I1 => aw_pending,
      I2 => s_axi_awaddr(2),
      I3 => \^awaddr_reg_reg[5]\,
      I4 => \^awaddr_reg_reg[3]\,
      I5 => \^write_addr\(0),
      O => \^awaddr_reg_reg[2]\
    );
ext_evt_ready_INST_0_i_8: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => s_axi_awaddr(0),
      I1 => Q(0),
      I2 => s_axi_awaddr(11),
      I3 => aw_pending,
      I4 => Q(11),
      O => ext_evt_ready_INST_0_i_8_n_0
    );
ext_evt_ready_INST_0_i_9: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => Q(8),
      I1 => aw_pending,
      I2 => s_axi_awaddr(8),
      O => \^awaddr_reg_reg[8]\
    );
last_grant_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^ext_evt_valid_0\,
      I1 => \^p_3_in\,
      I2 => last_grant,
      O => last_grant_i_1_n_0
    );
last_grant_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => last_grant_i_1_n_0,
      Q => last_grant,
      R => clear
    );
\led_ctrl_reg[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \scratch_reg_reg[0]_0\(0),
      I1 => \scratch_reg_reg[0]\,
      I2 => s_axi_wdata(0),
      O => \^wdata_reg_reg[0]_0\
    );
memory_reg_0_i_10: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(24),
      I1 => \^ext_evt_valid_0\,
      O => in_event(24)
    );
memory_reg_0_i_11: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(23),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(23),
      O => in_event(23)
    );
memory_reg_0_i_12: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(22),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(22),
      O => in_event(22)
    );
memory_reg_0_i_13: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(21),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(21),
      O => in_event(21)
    );
memory_reg_0_i_14: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(20),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(20),
      O => in_event(20)
    );
memory_reg_0_i_15: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(19),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(19),
      O => in_event(19)
    );
memory_reg_0_i_16: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(18),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(18),
      O => in_event(18)
    );
memory_reg_0_i_17: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(17),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(17),
      O => in_event(17)
    );
memory_reg_0_i_18: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(16),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(16),
      O => in_event(16)
    );
memory_reg_0_i_19: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(15),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(15),
      O => in_event(15)
    );
memory_reg_0_i_20: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(14),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(14),
      O => in_event(14)
    );
memory_reg_0_i_21: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(13),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(13),
      O => in_event(13)
    );
memory_reg_0_i_22: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(12),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(12),
      O => in_event(12)
    );
memory_reg_0_i_23: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(11),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(11),
      O => in_event(11)
    );
memory_reg_0_i_24: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(10),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(10),
      O => in_event(10)
    );
memory_reg_0_i_25: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(9),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(9),
      O => in_event(9)
    );
memory_reg_0_i_26: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(8),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(8),
      O => in_event(8)
    );
memory_reg_0_i_27: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(7),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(7),
      O => in_event(7)
    );
memory_reg_0_i_28: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(6),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(6),
      O => in_event(6)
    );
memory_reg_0_i_29: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(5),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(5),
      O => in_event(5)
    );
memory_reg_0_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(31),
      I1 => \^ext_evt_valid_0\,
      O => in_event(31)
    );
memory_reg_0_i_30: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(4),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(4),
      O => in_event(4)
    );
memory_reg_0_i_31: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(3),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(3),
      O => in_event(3)
    );
memory_reg_0_i_32: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(2),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(2),
      O => in_event(2)
    );
memory_reg_0_i_33: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(1),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(1),
      O => in_event(1)
    );
memory_reg_0_i_34: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(0),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(0),
      O => in_event(0)
    );
memory_reg_0_i_35: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(63),
      I1 => \^ext_evt_valid_0\,
      O => in_event(63)
    );
memory_reg_0_i_36: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(62),
      I1 => \^ext_evt_valid_0\,
      O => in_event(62)
    );
memory_reg_0_i_37: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(61),
      I1 => \^ext_evt_valid_0\,
      O => in_event(61)
    );
memory_reg_0_i_38: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(60),
      I1 => \^ext_evt_valid_0\,
      O => in_event(60)
    );
memory_reg_0_i_39: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(59),
      I1 => \^ext_evt_valid_0\,
      O => in_event(59)
    );
memory_reg_0_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(30),
      I1 => \^ext_evt_valid_0\,
      O => in_event(30)
    );
memory_reg_0_i_40: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(58),
      I1 => \^ext_evt_valid_0\,
      O => in_event(58)
    );
memory_reg_0_i_41: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(57),
      I1 => \^ext_evt_valid_0\,
      O => in_event(57)
    );
memory_reg_0_i_42: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(56),
      I1 => \^ext_evt_valid_0\,
      O => in_event(56)
    );
memory_reg_0_i_43: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(55),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(27),
      O => in_event(55)
    );
memory_reg_0_i_44: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(54),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(27),
      O => in_event(54)
    );
memory_reg_0_i_45: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(53),
      I1 => \^ext_evt_valid_0\,
      O => in_event(53)
    );
memory_reg_0_i_46: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(52),
      I1 => \^ext_evt_valid_0\,
      O => in_event(52)
    );
memory_reg_0_i_47: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(51),
      I1 => \^ext_evt_valid_0\,
      O => in_event(51)
    );
memory_reg_0_i_48: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(50),
      I1 => \^ext_evt_valid_0\,
      O => in_event(50)
    );
memory_reg_0_i_49: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(49),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(26),
      O => in_event(49)
    );
memory_reg_0_i_5: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(29),
      I1 => \^ext_evt_valid_0\,
      O => in_event(29)
    );
memory_reg_0_i_50: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(48),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(25),
      O => in_event(48)
    );
memory_reg_0_i_51: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(47),
      I1 => \^ext_evt_valid_0\,
      O => in_event(47)
    );
memory_reg_0_i_52: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(46),
      I1 => \^ext_evt_valid_0\,
      O => in_event(46)
    );
memory_reg_0_i_53: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(45),
      I1 => \^ext_evt_valid_0\,
      O => in_event(45)
    );
memory_reg_0_i_54: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(44),
      I1 => \^ext_evt_valid_0\,
      O => in_event(44)
    );
memory_reg_0_i_55: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(43),
      I1 => \^ext_evt_valid_0\,
      O => in_event(43)
    );
memory_reg_0_i_56: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(42),
      I1 => \^ext_evt_valid_0\,
      O => in_event(42)
    );
memory_reg_0_i_57: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(41),
      I1 => \^ext_evt_valid_0\,
      O => in_event(41)
    );
memory_reg_0_i_58: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(40),
      I1 => \^ext_evt_valid_0\,
      O => in_event(40)
    );
memory_reg_0_i_59: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(39),
      I1 => \^ext_evt_valid_0\,
      O => in_event(39)
    );
memory_reg_0_i_6: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(28),
      I1 => \^ext_evt_valid_0\,
      O => in_event(28)
    );
memory_reg_0_i_60: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(38),
      I1 => \^ext_evt_valid_0\,
      O => in_event(38)
    );
memory_reg_0_i_61: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(37),
      I1 => \^ext_evt_valid_0\,
      O => in_event(37)
    );
memory_reg_0_i_62: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(36),
      I1 => \^ext_evt_valid_0\,
      O => in_event(36)
    );
memory_reg_0_i_63: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(35),
      I1 => \^ext_evt_valid_0\,
      O => in_event(35)
    );
memory_reg_0_i_64: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(34),
      I1 => \^ext_evt_valid_0\,
      O => in_event(34)
    );
memory_reg_0_i_65: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(33),
      I1 => \^ext_evt_valid_0\,
      O => in_event(33)
    );
memory_reg_0_i_66: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(32),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(24),
      O => in_event(32)
    );
memory_reg_0_i_67: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(67),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(31),
      O => in_event(67)
    );
memory_reg_0_i_68: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(66),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(30),
      O => in_event(66)
    );
memory_reg_0_i_69: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(65),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(29),
      O => in_event(65)
    );
memory_reg_0_i_7: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(27),
      I1 => \^ext_evt_valid_0\,
      O => in_event(27)
    );
memory_reg_0_i_70: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(64),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(28),
      O => in_event(64)
    );
memory_reg_0_i_71: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(71),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(35),
      O => in_event(71)
    );
memory_reg_0_i_72: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(70),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(34),
      O => in_event(70)
    );
memory_reg_0_i_73: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(69),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(33),
      O => in_event(69)
    );
memory_reg_0_i_74: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(68),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(32),
      O => in_event(68)
    );
memory_reg_0_i_8: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(26),
      I1 => \^ext_evt_valid_0\,
      O => in_event(26)
    );
memory_reg_0_i_9: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ext_evt_data(25),
      I1 => \^ext_evt_valid_0\,
      O => in_event(25)
    );
memory_reg_1_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(103),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(67),
      O => in_event(103)
    );
memory_reg_1_i_10: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(94),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(58),
      O => in_event(94)
    );
memory_reg_1_i_11: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(93),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(57),
      O => in_event(93)
    );
memory_reg_1_i_12: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(92),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(56),
      O => in_event(92)
    );
memory_reg_1_i_13: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(91),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(55),
      O => in_event(91)
    );
memory_reg_1_i_14: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(90),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(54),
      O => in_event(90)
    );
memory_reg_1_i_15: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(89),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(53),
      O => in_event(89)
    );
memory_reg_1_i_16: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(88),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(52),
      O => in_event(88)
    );
memory_reg_1_i_17: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(87),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(51),
      O => in_event(87)
    );
memory_reg_1_i_18: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(86),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(50),
      O => in_event(86)
    );
memory_reg_1_i_19: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(85),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(49),
      O => in_event(85)
    );
memory_reg_1_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(102),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(66),
      O => in_event(102)
    );
memory_reg_1_i_20: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(84),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(48),
      O => in_event(84)
    );
memory_reg_1_i_21: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(83),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(47),
      O => in_event(83)
    );
memory_reg_1_i_22: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(82),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(46),
      O => in_event(82)
    );
memory_reg_1_i_23: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(81),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(45),
      O => in_event(81)
    );
memory_reg_1_i_24: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(80),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(44),
      O => in_event(80)
    );
memory_reg_1_i_25: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(79),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(43),
      O => in_event(79)
    );
memory_reg_1_i_26: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(78),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(42),
      O => in_event(78)
    );
memory_reg_1_i_27: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(77),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(41),
      O => in_event(77)
    );
memory_reg_1_i_28: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(76),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(40),
      O => in_event(76)
    );
memory_reg_1_i_29: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(75),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(39),
      O => in_event(75)
    );
memory_reg_1_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(101),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(65),
      O => in_event(101)
    );
memory_reg_1_i_30: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(74),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(38),
      O => in_event(74)
    );
memory_reg_1_i_31: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(73),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(37),
      O => in_event(73)
    );
memory_reg_1_i_32: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(72),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(36),
      O => in_event(72)
    );
memory_reg_1_i_33: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(127),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(91),
      O => in_event(127)
    );
memory_reg_1_i_34: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(126),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(90),
      O => in_event(126)
    );
memory_reg_1_i_35: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(125),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(89),
      O => in_event(125)
    );
memory_reg_1_i_36: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(124),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(88),
      O => in_event(124)
    );
memory_reg_1_i_37: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(123),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(87),
      O => in_event(123)
    );
memory_reg_1_i_38: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(122),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(86),
      O => in_event(122)
    );
memory_reg_1_i_39: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(121),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(85),
      O => in_event(121)
    );
memory_reg_1_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(100),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(64),
      O => in_event(100)
    );
memory_reg_1_i_40: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(120),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(84),
      O => in_event(120)
    );
memory_reg_1_i_41: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(119),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(83),
      O => in_event(119)
    );
memory_reg_1_i_42: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(118),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(82),
      O => in_event(118)
    );
memory_reg_1_i_43: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(117),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(81),
      O => in_event(117)
    );
memory_reg_1_i_44: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(116),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(80),
      O => in_event(116)
    );
memory_reg_1_i_45: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(115),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(79),
      O => in_event(115)
    );
memory_reg_1_i_46: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(114),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(78),
      O => in_event(114)
    );
memory_reg_1_i_47: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(113),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(77),
      O => in_event(113)
    );
memory_reg_1_i_48: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(112),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(76),
      O => in_event(112)
    );
memory_reg_1_i_49: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(111),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(75),
      O => in_event(111)
    );
memory_reg_1_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(99),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(63),
      O => in_event(99)
    );
memory_reg_1_i_50: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(110),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(74),
      O => in_event(110)
    );
memory_reg_1_i_51: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(109),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(73),
      O => in_event(109)
    );
memory_reg_1_i_52: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(108),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(72),
      O => in_event(108)
    );
memory_reg_1_i_53: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(107),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(71),
      O => in_event(107)
    );
memory_reg_1_i_54: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(106),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(70),
      O => in_event(106)
    );
memory_reg_1_i_55: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(105),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(69),
      O => in_event(105)
    );
memory_reg_1_i_56: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(104),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(68),
      O => in_event(104)
    );
memory_reg_1_i_6: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(98),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(62),
      O => in_event(98)
    );
memory_reg_1_i_7: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(97),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(61),
      O => in_event(97)
    );
memory_reg_1_i_8: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(96),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(60),
      O => in_event(96)
    );
memory_reg_1_i_9: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ext_evt_data(95),
      I1 => \^ext_evt_valid_0\,
      I2 => memory_reg_1(59),
      O => in_event(95)
    );
\s_axi_rdata[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8A80"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => \s_axi_rdata[0]_i_6_n_0\,
      I2 => s_axi_araddr(2),
      I3 => \s_axi_rdata_reg[0]\,
      I4 => \s_axi_rdata_reg[0]_0\,
      I5 => \s_axi_rdata_reg[16]\,
      O => \s_axi_araddr[5]_7\
    );
\s_axi_rdata[0]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(0),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(0),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(0),
      O => \s_axi_rdata[0]_i_6_n_0\
    );
\s_axi_rdata[10]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(10),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(10),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(10),
      O => \s_axi_rdata[10]_i_7_n_0\
    );
\s_axi_rdata[11]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(11),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(11),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(11),
      O => \s_axi_rdata[11]_i_7_n_0\
    );
\s_axi_rdata[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8A80"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => \s_axi_rdata[12]_i_5_n_0\,
      I2 => s_axi_araddr(2),
      I3 => \s_axi_rdata_reg[12]\,
      I4 => \s_axi_rdata_reg[12]_0\,
      I5 => \s_axi_rdata_reg[16]\,
      O => \s_axi_araddr[5]_3\
    );
\s_axi_rdata[12]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(12),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(12),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(12),
      O => \s_axi_rdata[12]_i_5_n_0\
    );
\s_axi_rdata[13]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(13),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(13),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(13),
      O => \s_axi_rdata[13]_i_7_n_0\
    );
\s_axi_rdata[14]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(14),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(14),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(14),
      O => \s_axi_rdata[14]_i_7_n_0\
    );
\s_axi_rdata[15]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(15),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(15),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(15),
      O => \s_axi_rdata[15]_i_7_n_0\
    );
\s_axi_rdata[16]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEAEAAAAFFFFFFFF"
    )
        port map (
      I0 => \s_axi_rdata_reg[16]\,
      I1 => \s_axi_rdata_reg[16]_0\,
      I2 => s_axi_araddr(2),
      I3 => \s_axi_rdata[16]_i_6_n_0\,
      I4 => s_axi_araddr(3),
      I5 => \s_axi_rdata_reg[16]_1\,
      O => \s_axi_araddr[4]\
    );
\s_axi_rdata[16]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(16),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(16),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(16),
      O => \s_axi_rdata[16]_i_6_n_0\
    );
\s_axi_rdata[17]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(17),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(17),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(17),
      O => \s_axi_rdata[17]_i_7_n_0\
    );
\s_axi_rdata[18]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(18),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(18),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(18),
      O => \s_axi_rdata[18]_i_7_n_0\
    );
\s_axi_rdata[19]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(19),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(19),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(19),
      O => \s_axi_rdata[19]_i_7_n_0\
    );
\s_axi_rdata[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8A80"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => \s_axi_rdata[1]_i_6_n_0\,
      I2 => s_axi_araddr(2),
      I3 => \s_axi_rdata_reg[1]\,
      I4 => \s_axi_rdata_reg[1]_0\,
      I5 => \s_axi_rdata_reg[16]\,
      O => \s_axi_araddr[5]_6\
    );
\s_axi_rdata[1]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(1),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(1),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(1),
      O => \s_axi_rdata[1]_i_6_n_0\
    );
\s_axi_rdata[20]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8A80"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => \s_axi_rdata[20]_i_5_n_0\,
      I2 => s_axi_araddr(2),
      I3 => \s_axi_rdata_reg[20]\,
      I4 => \s_axi_rdata_reg[20]_0\,
      I5 => \s_axi_rdata_reg[16]\,
      O => \s_axi_araddr[5]_2\
    );
\s_axi_rdata[20]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(20),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(20),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(20),
      O => \s_axi_rdata[20]_i_5_n_0\
    );
\s_axi_rdata[21]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(21),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(21),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(21),
      O => \s_axi_rdata[21]_i_7_n_0\
    );
\s_axi_rdata[22]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8A80"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => \s_axi_rdata[22]_i_5_n_0\,
      I2 => s_axi_araddr(2),
      I3 => \s_axi_rdata_reg[22]\,
      I4 => \s_axi_rdata_reg[22]_0\,
      I5 => \s_axi_rdata_reg[16]\,
      O => \s_axi_araddr[5]_1\
    );
\s_axi_rdata[22]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(22),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(22),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(22),
      O => \s_axi_rdata[22]_i_5_n_0\
    );
\s_axi_rdata[23]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(23),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(23),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(23),
      O => \s_axi_rdata[23]_i_7_n_0\
    );
\s_axi_rdata[24]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(24),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(24),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(24),
      O => \s_axi_rdata[24]_i_7_n_0\
    );
\s_axi_rdata[25]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(25),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(25),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(25),
      O => \s_axi_rdata[25]_i_7_n_0\
    );
\s_axi_rdata[26]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8A80"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => \s_axi_rdata[26]_i_5_n_0\,
      I2 => s_axi_araddr(2),
      I3 => \s_axi_rdata_reg[26]\,
      I4 => \s_axi_rdata_reg[26]_0\,
      I5 => \s_axi_rdata_reg[16]\,
      O => \s_axi_araddr[5]_0\
    );
\s_axi_rdata[26]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(26),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(26),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(26),
      O => \s_axi_rdata[26]_i_5_n_0\
    );
\s_axi_rdata[27]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8A80"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => \s_axi_rdata[27]_i_8_n_0\,
      I2 => s_axi_araddr(2),
      I3 => \s_axi_rdata_reg[27]\,
      I4 => \s_axi_rdata_reg[27]_0\,
      I5 => \s_axi_rdata_reg[16]\,
      O => \s_axi_araddr[5]\
    );
\s_axi_rdata[27]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(27),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(27),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(27),
      O => \s_axi_rdata[27]_i_8_n_0\
    );
\s_axi_rdata[28]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(28),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(28),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(28),
      O => \s_axi_rdata[28]_i_7_n_0\
    );
\s_axi_rdata[29]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(29),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(29),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(29),
      O => \s_axi_rdata[29]_i_7_n_0\
    );
\s_axi_rdata[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8A80"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => \s_axi_rdata[2]_i_6_n_0\,
      I2 => s_axi_araddr(2),
      I3 => \s_axi_rdata_reg[2]\,
      I4 => \s_axi_rdata_reg[2]_0\,
      I5 => \s_axi_rdata_reg[16]\,
      O => \s_axi_araddr[5]_5\
    );
\s_axi_rdata[2]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(2),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(2),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(2),
      O => \s_axi_rdata[2]_i_6_n_0\
    );
\s_axi_rdata[30]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(30),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(30),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(30),
      O => \s_axi_rdata[30]_i_7_n_0\
    );
\s_axi_rdata[31]_i_15\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(31),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(31),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(31),
      O => \s_axi_rdata[31]_i_15_n_0\
    );
\s_axi_rdata[3]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(3),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(3),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(3),
      O => ext_evt_dropped_count_3_sn_1
    );
\s_axi_rdata[4]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(4),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(4),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(4),
      O => \s_axi_rdata[4]_i_8_n_0\
    );
\s_axi_rdata[5]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(5),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(5),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(5),
      O => \s_axi_rdata[5]_i_8_n_0\
    );
\s_axi_rdata[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF8A80"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => \s_axi_rdata[6]_i_6_n_0\,
      I2 => s_axi_araddr(2),
      I3 => \s_axi_rdata_reg[6]\,
      I4 => \s_axi_rdata_reg[6]_0\,
      I5 => \s_axi_rdata_reg[16]\,
      O => \s_axi_araddr[5]_4\
    );
\s_axi_rdata[6]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(6),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(6),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(6),
      O => \s_axi_rdata[6]_i_6_n_0\
    );
\s_axi_rdata[7]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(7),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(7),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(7),
      O => \s_axi_rdata[7]_i_10_n_0\
    );
\s_axi_rdata[8]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(8),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(8),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(8),
      O => \s_axi_rdata[8]_i_8_n_0\
    );
\s_axi_rdata[9]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"30BB3088"
    )
        port map (
      I0 => ext_evt_dropped_count(9),
      I1 => s_axi_araddr(1),
      I2 => p_1_in(9),
      I3 => s_axi_araddr(0),
      I4 => \s_axi_rdata_reg[31]_i_9_0\(9),
      O => \s_axi_rdata[9]_i_7_n_0\
    );
\s_axi_rdata_reg[10]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[10]\,
      I1 => \s_axi_rdata[10]_i_7_n_0\,
      O => \s_axi_araddr[4]_15\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[11]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[11]\,
      I1 => \s_axi_rdata[11]_i_7_n_0\,
      O => \s_axi_araddr[4]_14\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[13]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[13]\,
      I1 => \s_axi_rdata[13]_i_7_n_0\,
      O => \s_axi_araddr[4]_13\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[14]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[14]\,
      I1 => \s_axi_rdata[14]_i_7_n_0\,
      O => \s_axi_araddr[4]_12\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[15]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[15]\,
      I1 => \s_axi_rdata[15]_i_7_n_0\,
      O => \s_axi_araddr[4]_11\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[17]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[17]\,
      I1 => \s_axi_rdata[17]_i_7_n_0\,
      O => \s_axi_araddr[4]_10\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[18]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[18]\,
      I1 => \s_axi_rdata[18]_i_7_n_0\,
      O => \s_axi_araddr[4]_9\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[19]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[19]\,
      I1 => \s_axi_rdata[19]_i_7_n_0\,
      O => \s_axi_araddr[4]_8\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[21]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[21]\,
      I1 => \s_axi_rdata[21]_i_7_n_0\,
      O => \s_axi_araddr[4]_7\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[23]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[23]\,
      I1 => \s_axi_rdata[23]_i_7_n_0\,
      O => \s_axi_araddr[4]_6\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[24]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[24]\,
      I1 => \s_axi_rdata[24]_i_7_n_0\,
      O => \s_axi_araddr[4]_5\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[25]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[25]\,
      I1 => \s_axi_rdata[25]_i_7_n_0\,
      O => \s_axi_araddr[4]_4\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[28]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[28]\,
      I1 => \s_axi_rdata[28]_i_7_n_0\,
      O => \s_axi_araddr[4]_3\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[29]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[29]\,
      I1 => \s_axi_rdata[29]_i_7_n_0\,
      O => \s_axi_araddr[4]_2\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[30]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[30]\,
      I1 => \s_axi_rdata[30]_i_7_n_0\,
      O => \s_axi_araddr[4]_1\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[31]_i_9\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[31]\,
      I1 => \s_axi_rdata[31]_i_15_n_0\,
      O => \s_axi_araddr[4]_0\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[4]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[4]\,
      I1 => \s_axi_rdata[4]_i_8_n_0\,
      O => \s_axi_araddr[4]_20\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[5]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[5]\,
      I1 => \s_axi_rdata[5]_i_8_n_0\,
      O => \s_axi_araddr[4]_19\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[7]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[7]\,
      I1 => \s_axi_rdata[7]_i_10_n_0\,
      O => \s_axi_araddr[4]_18\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[8]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[8]\,
      I1 => \s_axi_rdata[8]_i_8_n_0\,
      O => \s_axi_araddr[4]_17\,
      S => s_axi_araddr(2)
    );
\s_axi_rdata_reg[9]_i_4\: unisim.vcomponents.MUXF7
     port map (
      I0 => \s_axi_rdata_reg[9]\,
      I1 => \s_axi_rdata[9]_i_7_n_0\,
      O => \s_axi_araddr[4]_16\,
      S => s_axi_araddr(2)
    );
\virtual_evt_data[127]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5D00"
    )
        port map (
      I0 => virtual_evt_trigger_reg,
      I1 => \^p_3_in\,
      I2 => \^ext_evt_valid_0\,
      I3 => virtual_evt_trigger_reg_0,
      O => E(0)
    );
\virtual_evt_data[48]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => Q(4),
      I1 => aw_pending,
      I2 => s_axi_awaddr(4),
      O => \^write_addr\(0)
    );
virtual_evt_trigger_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3F310F0F30310000"
    )
        port map (
      I0 => virtual_evt_trigger_reg,
      I1 => virtual_evt_trigger_reg_2,
      I2 => \^wdata_reg_reg[0]\,
      I3 => virtual_evt_trigger_reg_3,
      I4 => virtual_evt_trigger_reg_0,
      I5 => virtual_evt_trigger_reg_4,
      O => virtual_evt_valid_reg
    );
virtual_evt_valid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFDC505073505050"
    )
        port map (
      I0 => \^wdata_reg_reg[0]\,
      I1 => \^write_addr\(0),
      I2 => virtual_evt_trigger_reg,
      I3 => virtual_evt_valid_reg_1,
      I4 => virtual_evt_valid_reg_2,
      I5 => \^awaddr_reg_reg[3]\,
      O => virtual_evt_valid_reg_0
    );
virtual_evt_valid_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => Q(3),
      I1 => aw_pending,
      I2 => s_axi_awaddr(3),
      O => \^awaddr_reg_reg[3]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity multi_protocol_bd_multi_protocol_core_0_0_event_snapshot_buffer is
  port (
    clear : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 0 to 0 );
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aresetn_0 : out STD_LOGIC;
    snapshot_ready_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    capture_active_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    \s_axi_araddr[5]\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    \s_axi_araddr[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aresetn_1 : out STD_LOGIC;
    S : out STD_LOGIC_VECTOR ( 3 downto 0 );
    DI : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \snapshot_count_reg[8]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arvalid_0 : out STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    \s_axi_rdata_reg[31]\ : in STD_LOGIC;
    CO : in STD_LOGIC_VECTOR ( 0 to 0 );
    \s_axi_rdata_reg[31]_0\ : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    \snapshot_rd_index_reg[0]\ : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    \s_axi_rdata_reg[0]\ : in STD_LOGIC;
    snapshot_rd_en : in STD_LOGIC;
    \s_axi_rdata_reg[31]_1\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 14 downto 0 );
    \s_axi_rdata_reg[9]\ : in STD_LOGIC;
    \dropped_count_reg_reg[0]\ : in STD_LOGIC;
    \dropped_count_reg_reg[0]_0\ : in STD_LOGIC;
    \dropped_count_reg_reg[0]_1\ : in STD_LOGIC;
    dropped_count_reg0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dropped_count_reg00_in : in STD_LOGIC_VECTOR ( 30 downto 0 );
    \dropped_count_reg_reg[0]_2\ : in STD_LOGIC;
    p_3_in : in STD_LOGIC;
    \dropped_count_reg_reg[31]\ : in STD_LOGIC;
    \dropped_count_reg_reg[31]_0\ : in STD_LOGIC;
    \dropped_count_reg_reg[31]_1\ : in STD_LOGIC;
    \dropped_count_reg_reg[31]_2\ : in STD_LOGIC;
    \dropped_count_reg_reg[31]_3\ : in STD_LOGIC;
    \post_remaining_reg[1]_0\ : in STD_LOGIC;
    ext_evt_trigger : in STD_LOGIC;
    capture_active_reg_1 : in STD_LOGIC;
    ext_evt_valid : in STD_LOGIC;
    memory_reg_0_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \s_axi_rdata_reg[0]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[1]\ : in STD_LOGIC;
    \s_axi_rdata_reg[2]\ : in STD_LOGIC;
    \s_axi_rdata_reg[4]\ : in STD_LOGIC;
    \s_axi_rdata_reg[4]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[5]\ : in STD_LOGIC;
    \s_axi_rdata_reg[5]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[6]\ : in STD_LOGIC;
    \s_axi_rdata_reg[7]\ : in STD_LOGIC;
    \s_axi_rdata_reg[7]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[8]\ : in STD_LOGIC;
    \s_axi_rdata_reg[8]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[9]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[9]_1\ : in STD_LOGIC;
    \s_axi_rdata_reg[10]\ : in STD_LOGIC;
    \s_axi_rdata_reg[10]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[11]\ : in STD_LOGIC;
    \s_axi_rdata_reg[11]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[12]\ : in STD_LOGIC;
    \s_axi_rdata_reg[13]\ : in STD_LOGIC;
    \s_axi_rdata_reg[13]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[14]\ : in STD_LOGIC;
    \s_axi_rdata_reg[14]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[15]\ : in STD_LOGIC;
    \s_axi_rdata_reg[15]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[16]\ : in STD_LOGIC;
    \s_axi_rdata_reg[17]\ : in STD_LOGIC;
    \s_axi_rdata_reg[17]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[18]\ : in STD_LOGIC;
    \s_axi_rdata_reg[18]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[19]\ : in STD_LOGIC;
    \s_axi_rdata_reg[19]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[20]\ : in STD_LOGIC;
    \s_axi_rdata_reg[21]\ : in STD_LOGIC;
    \s_axi_rdata_reg[21]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[22]\ : in STD_LOGIC;
    \s_axi_rdata_reg[23]\ : in STD_LOGIC;
    \s_axi_rdata_reg[23]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[24]\ : in STD_LOGIC;
    \s_axi_rdata_reg[24]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[25]\ : in STD_LOGIC;
    \s_axi_rdata_reg[25]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[26]\ : in STD_LOGIC;
    \s_axi_rdata_reg[27]\ : in STD_LOGIC;
    \s_axi_rdata_reg[28]\ : in STD_LOGIC;
    \s_axi_rdata_reg[28]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[29]\ : in STD_LOGIC;
    \s_axi_rdata_reg[29]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[30]\ : in STD_LOGIC;
    \s_axi_rdata_reg[30]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[31]_2\ : in STD_LOGIC;
    \s_axi_rdata_reg[31]_3\ : in STD_LOGIC;
    \s_axi_rdata_reg[3]\ : in STD_LOGIC;
    \s_axi_rdata_reg[3]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[3]_1\ : in STD_LOGIC;
    \s_axi_rdata_reg[4]_1\ : in STD_LOGIC;
    \s_axi_rdata_reg[4]_2\ : in STD_LOGIC;
    \s_axi_rdata_reg[8]_1\ : in STD_LOGIC;
    \s_axi_rdata_reg[9]_2\ : in STD_LOGIC;
    \s_axi_rdata_reg[27]_0\ : in STD_LOGIC;
    \timestamp_shadow_reg[32]\ : in STD_LOGIC;
    \timestamp_shadow_reg[32]_0\ : in STD_LOGIC;
    \s_axi_rdata_reg[3]_2\ : in STD_LOGIC;
    \s_axi_rdata_reg[3]_3\ : in STD_LOGIC;
    \s_axi_rdata_reg[3]_4\ : in STD_LOGIC;
    \s_axi_rdata_reg[3]_5\ : in STD_LOGIC;
    \s_axi_rdata_reg[0]_1\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    snapshot_ready_reg_1 : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_rvalid : in STD_LOGIC;
    in_event : in STD_LOGIC_VECTOR ( 127 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of multi_protocol_bd_multi_protocol_core_0_0_event_snapshot_buffer : entity is "event_snapshot_buffer";
end multi_protocol_bd_multi_protocol_core_0_0_event_snapshot_buffer;

architecture STRUCTURE of multi_protocol_bd_multi_protocol_core_0_0_event_snapshot_buffer is
  signal \^q\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal capture_active : STD_LOGIC;
  signal capture_active111_out : STD_LOGIC;
  signal capture_active_i_1_n_0 : STD_LOGIC;
  signal \capture_count_reg__0\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \^clear\ : STD_LOGIC;
  signal \dropped_count_reg[31]_i_6_n_0\ : STD_LOGIC;
  signal memory_reg_0_i_1_n_0 : STD_LOGIC;
  signal memory_reg_0_i_2_n_0 : STD_LOGIC;
  signal next_snapshot_start : STD_LOGIC_VECTOR ( 7 to 7 );
  signal next_write_pointer : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal overwritten_i_1_n_0 : STD_LOGIC;
  signal overwritten_i_2_n_0 : STD_LOGIC;
  signal overwritten_i_3_n_0 : STD_LOGIC;
  signal post_remaining : STD_LOGIC;
  signal \post_remaining[0]_i_1_n_0\ : STD_LOGIC;
  signal \post_remaining[1]_i_1_n_0\ : STD_LOGIC;
  signal \post_remaining[2]_i_1_n_0\ : STD_LOGIC;
  signal \post_remaining[3]_i_1_n_0\ : STD_LOGIC;
  signal \post_remaining[3]_i_3_n_0\ : STD_LOGIC;
  signal \post_remaining[4]_i_1_n_0\ : STD_LOGIC;
  signal \post_remaining[4]_i_2_n_0\ : STD_LOGIC;
  signal \post_remaining_reg_n_0_[0]\ : STD_LOGIC;
  signal \post_remaining_reg_n_0_[1]\ : STD_LOGIC;
  signal \post_remaining_reg_n_0_[2]\ : STD_LOGIC;
  signal \post_remaining_reg_n_0_[3]\ : STD_LOGIC;
  signal \post_remaining_reg_n_0_[4]\ : STD_LOGIC;
  signal rd_valid1 : STD_LOGIC;
  signal \rd_valid1_carry__0_i_1_n_0\ : STD_LOGIC;
  signal rd_valid1_carry_i_1_n_0 : STD_LOGIC;
  signal rd_valid1_carry_i_2_n_0 : STD_LOGIC;
  signal rd_valid1_carry_i_3_n_0 : STD_LOGIC;
  signal rd_valid1_carry_i_4_n_0 : STD_LOGIC;
  signal rd_valid1_carry_i_5_n_0 : STD_LOGIC;
  signal rd_valid1_carry_i_6_n_0 : STD_LOGIC;
  signal rd_valid1_carry_i_7_n_0 : STD_LOGIC;
  signal rd_valid1_carry_i_8_n_0 : STD_LOGIC;
  signal rd_valid1_carry_n_0 : STD_LOGIC;
  signal rd_valid1_carry_n_1 : STD_LOGIC;
  signal rd_valid1_carry_n_2 : STD_LOGIC;
  signal rd_valid1_carry_n_3 : STD_LOGIC;
  signal rd_valid_i_1_n_0 : STD_LOGIC;
  signal read_physical_index : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \read_physical_index_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \read_physical_index_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \read_physical_index_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \read_physical_index_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \read_physical_index_carry__0_n_1\ : STD_LOGIC;
  signal \read_physical_index_carry__0_n_2\ : STD_LOGIC;
  signal \read_physical_index_carry__0_n_3\ : STD_LOGIC;
  signal read_physical_index_carry_i_1_n_0 : STD_LOGIC;
  signal read_physical_index_carry_i_2_n_0 : STD_LOGIC;
  signal read_physical_index_carry_i_3_n_0 : STD_LOGIC;
  signal read_physical_index_carry_i_4_n_0 : STD_LOGIC;
  signal read_physical_index_carry_n_0 : STD_LOGIC;
  signal read_physical_index_carry_n_1 : STD_LOGIC;
  signal read_physical_index_carry_n_2 : STD_LOGIC;
  signal read_physical_index_carry_n_3 : STD_LOGIC;
  signal \s_axi_rdata[0]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[0]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[0]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[10]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[10]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[11]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[11]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[12]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[12]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[13]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[13]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[14]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[14]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[15]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[15]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[16]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[16]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[17]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[17]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[18]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[18]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[19]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[19]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[1]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[1]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[1]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[20]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[20]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[21]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[21]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[22]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[22]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[23]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[23]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[24]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[24]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[25]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[25]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[26]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[26]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[27]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[27]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[27]_i_4_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[27]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[28]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[28]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[29]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[29]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[2]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[2]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[2]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[30]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[30]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_4_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_9_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[4]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[4]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[4]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[5]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[5]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[5]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[6]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[6]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[6]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[7]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[7]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[7]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[8]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[8]_i_3_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[8]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[9]_i_2_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[9]_i_3_n_0\ : STD_LOGIC;
  signal sel0 : STD_LOGIC_VECTOR ( 8 downto 1 );
  signal snapshot_count : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \snapshot_count[0]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_count[5]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_count[6]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_count[7]_i_2_n_0\ : STD_LOGIC;
  signal \snapshot_count[8]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_count[8]_i_2_n_0\ : STD_LOGIC;
  signal \snapshot_count[8]_i_4_n_0\ : STD_LOGIC;
  signal snapshot_id : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \snapshot_id[0]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_id[0]_i_3_n_0\ : STD_LOGIC;
  signal \snapshot_id_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \snapshot_id_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \snapshot_id_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \snapshot_id_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \snapshot_id_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \snapshot_id_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \snapshot_id_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \snapshot_id_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \snapshot_id_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_id_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \snapshot_id_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \snapshot_id_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \snapshot_id_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \snapshot_id_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \snapshot_id_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \snapshot_id_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \snapshot_id_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_id_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \snapshot_id_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \snapshot_id_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \snapshot_id_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \snapshot_id_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \snapshot_id_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \snapshot_id_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \snapshot_id_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_id_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \snapshot_id_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \snapshot_id_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \snapshot_id_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \snapshot_id_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \snapshot_id_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \snapshot_id_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \snapshot_id_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_id_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \snapshot_id_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \snapshot_id_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \snapshot_id_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \snapshot_id_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \snapshot_id_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \snapshot_id_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \snapshot_id_reg[28]_i_1_n_1\ : STD_LOGIC;
  signal \snapshot_id_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \snapshot_id_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \snapshot_id_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \snapshot_id_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \snapshot_id_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \snapshot_id_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \snapshot_id_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_id_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \snapshot_id_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \snapshot_id_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \snapshot_id_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \snapshot_id_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \snapshot_id_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \snapshot_id_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \snapshot_id_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_id_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \snapshot_id_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \snapshot_id_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \snapshot_id_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \snapshot_id_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \snapshot_id_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \snapshot_id_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal snapshot_overwritten : STD_LOGIC;
  signal snapshot_rd_event : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal snapshot_rd_valid : STD_LOGIC;
  signal snapshot_read_pending_i_2_n_0 : STD_LOGIC;
  signal snapshot_ready : STD_LOGIC;
  signal snapshot_ready_i_1_n_0 : STD_LOGIC;
  signal \^snapshot_ready_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \snapshot_start[0]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_start[1]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_start[2]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_start[3]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_start[4]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_start[5]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_start[6]_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_start[7]_i_2_n_0\ : STD_LOGIC;
  signal \snapshot_start[7]_i_3_n_0\ : STD_LOGIC;
  signal \snapshot_start[7]_i_4_n_0\ : STD_LOGIC;
  signal \snapshot_start_reg_n_0_[0]\ : STD_LOGIC;
  signal \snapshot_start_reg_n_0_[1]\ : STD_LOGIC;
  signal \snapshot_start_reg_n_0_[2]\ : STD_LOGIC;
  signal \snapshot_start_reg_n_0_[3]\ : STD_LOGIC;
  signal \snapshot_start_reg_n_0_[4]\ : STD_LOGIC;
  signal \snapshot_start_reg_n_0_[5]\ : STD_LOGIC;
  signal \snapshot_start_reg_n_0_[6]\ : STD_LOGIC;
  signal \snapshot_start_reg_n_0_[7]\ : STD_LOGIC;
  signal snapshot_trigger_index : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal snapshot_trigger_index00_out : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \snapshot_trigger_index0_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \snapshot_trigger_index0_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \snapshot_trigger_index0_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \snapshot_trigger_index0_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \snapshot_trigger_index0_carry__0_n_1\ : STD_LOGIC;
  signal \snapshot_trigger_index0_carry__0_n_2\ : STD_LOGIC;
  signal \snapshot_trigger_index0_carry__0_n_3\ : STD_LOGIC;
  signal snapshot_trigger_index0_carry_i_1_n_0 : STD_LOGIC;
  signal snapshot_trigger_index0_carry_i_2_n_0 : STD_LOGIC;
  signal snapshot_trigger_index0_carry_i_3_n_0 : STD_LOGIC;
  signal snapshot_trigger_index0_carry_i_4_n_0 : STD_LOGIC;
  signal snapshot_trigger_index0_carry_n_0 : STD_LOGIC;
  signal snapshot_trigger_index0_carry_n_1 : STD_LOGIC;
  signal snapshot_trigger_index0_carry_n_2 : STD_LOGIC;
  signal snapshot_trigger_index0_carry_n_3 : STD_LOGIC;
  signal \timestamp_shadow[63]_i_3_n_0\ : STD_LOGIC;
  signal \timestamp_shadow[63]_i_4_n_0\ : STD_LOGIC;
  signal \trigger_physical_index_reg_n_0_[0]\ : STD_LOGIC;
  signal \trigger_physical_index_reg_n_0_[1]\ : STD_LOGIC;
  signal \trigger_physical_index_reg_n_0_[2]\ : STD_LOGIC;
  signal \trigger_physical_index_reg_n_0_[3]\ : STD_LOGIC;
  signal \trigger_physical_index_reg_n_0_[4]\ : STD_LOGIC;
  signal \trigger_physical_index_reg_n_0_[5]\ : STD_LOGIC;
  signal \trigger_physical_index_reg_n_0_[6]\ : STD_LOGIC;
  signal \trigger_physical_index_reg_n_0_[7]\ : STD_LOGIC;
  signal trigger_seen8_out : STD_LOGIC;
  signal trigger_seen_i_1_n_0 : STD_LOGIC;
  signal trigger_seen_reg_n_0 : STD_LOGIC;
  signal \write_pointer_reg__0\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_memory_reg_0_CASCADEOUTA_UNCONNECTED : STD_LOGIC;
  signal NLW_memory_reg_0_CASCADEOUTB_UNCONNECTED : STD_LOGIC;
  signal NLW_memory_reg_0_DBITERR_UNCONNECTED : STD_LOGIC;
  signal NLW_memory_reg_0_SBITERR_UNCONNECTED : STD_LOGIC;
  signal NLW_memory_reg_0_ECCPARITY_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_memory_reg_0_RDADDRECC_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal NLW_memory_reg_1_CASCADEOUTA_UNCONNECTED : STD_LOGIC;
  signal NLW_memory_reg_1_CASCADEOUTB_UNCONNECTED : STD_LOGIC;
  signal NLW_memory_reg_1_DBITERR_UNCONNECTED : STD_LOGIC;
  signal NLW_memory_reg_1_SBITERR_UNCONNECTED : STD_LOGIC;
  signal NLW_memory_reg_1_DOBDO_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 24 );
  signal NLW_memory_reg_1_DOPADOP_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_memory_reg_1_DOPBDOP_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_memory_reg_1_ECCPARITY_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_memory_reg_1_RDADDRECC_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal NLW_rd_valid1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_rd_valid1_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_rd_valid1_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_read_physical_index_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_snapshot_id_reg[28]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_snapshot_trigger_index0_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of memory_reg_0 : label is "p8_d64";
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of memory_reg_0 : label is "p8_d64";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of memory_reg_0 : label is "{SYNTH-6 {cell *THIS*}}";
  attribute RTL_RAM_BITS : integer;
  attribute RTL_RAM_BITS of memory_reg_0 : label is 32768;
  attribute RTL_RAM_NAME : string;
  attribute RTL_RAM_NAME of memory_reg_0 : label is "memory";
  attribute bram_addr_begin : integer;
  attribute bram_addr_begin of memory_reg_0 : label is 0;
  attribute bram_addr_end : integer;
  attribute bram_addr_end of memory_reg_0 : label is 511;
  attribute bram_slice_begin : integer;
  attribute bram_slice_begin of memory_reg_0 : label is 0;
  attribute bram_slice_end : integer;
  attribute bram_slice_end of memory_reg_0 : label is 71;
  attribute ram_addr_begin : integer;
  attribute ram_addr_begin of memory_reg_0 : label is 0;
  attribute ram_addr_end : integer;
  attribute ram_addr_end of memory_reg_0 : label is 511;
  attribute ram_slice_begin : integer;
  attribute ram_slice_begin of memory_reg_0 : label is 0;
  attribute ram_slice_end : integer;
  attribute ram_slice_end of memory_reg_0 : label is 71;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of memory_reg_1 : label is "p0_d56";
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of memory_reg_1 : label is "p0_d56";
  attribute METHODOLOGY_DRC_VIOS of memory_reg_1 : label is "{SYNTH-6 {cell *THIS*}}";
  attribute RTL_RAM_BITS of memory_reg_1 : label is 32768;
  attribute RTL_RAM_NAME of memory_reg_1 : label is "memory";
  attribute bram_addr_begin of memory_reg_1 : label is 0;
  attribute bram_addr_end of memory_reg_1 : label is 511;
  attribute bram_slice_begin of memory_reg_1 : label is 72;
  attribute bram_slice_end of memory_reg_1 : label is 127;
  attribute ram_addr_begin of memory_reg_1 : label is 0;
  attribute ram_addr_end of memory_reg_1 : label is 511;
  attribute ram_slice_begin of memory_reg_1 : label is 72;
  attribute ram_slice_end of memory_reg_1 : label is 127;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \post_remaining[1]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \post_remaining[2]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \post_remaining[3]_i_3\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \post_remaining[4]_i_2\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \s_axi_rdata[31]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \s_axi_rdata[31]_i_6\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \snapshot_count[0]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \snapshot_count[1]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \snapshot_count[2]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \snapshot_count[3]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \snapshot_count[6]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \snapshot_count[7]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \snapshot_count[7]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \snapshot_count[8]_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of snapshot_read_pending_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \snapshot_start[0]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \snapshot_start[1]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \snapshot_start[2]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \snapshot_start[3]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \snapshot_start[6]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \snapshot_start[7]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \timestamp_shadow[63]_i_4\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \write_pointer[1]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \write_pointer[2]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \write_pointer[3]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \write_pointer[4]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \write_pointer[6]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \write_pointer[7]_i_1\ : label is "soft_lutpair11";
begin
  Q(0) <= \^q\(0);
  clear <= \^clear\;
  snapshot_ready_reg_0(0) <= \^snapshot_ready_reg_0\(0);
capture_active_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => capture_active_reg_1,
      I1 => \snapshot_count[8]_i_2_n_0\,
      I2 => capture_active,
      O => capture_active_i_1_n_0
    );
capture_active_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => capture_active_i_1_n_0,
      Q => capture_active,
      R => \^clear\
    );
\capture_count[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
        port map (
      I0 => capture_active,
      I1 => \dropped_count_reg_reg[0]_1\,
      I2 => ext_evt_valid,
      O => capture_active111_out
    );
\capture_count_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => \snapshot_count[0]_i_1_n_0\,
      Q => \capture_count_reg__0\(0),
      R => \snapshot_count[8]_i_1_n_0\
    );
\capture_count_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => sel0(1),
      Q => \capture_count_reg__0\(1),
      R => \snapshot_count[8]_i_1_n_0\
    );
\capture_count_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => sel0(2),
      Q => \capture_count_reg__0\(2),
      R => \snapshot_count[8]_i_1_n_0\
    );
\capture_count_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => sel0(3),
      Q => \capture_count_reg__0\(3),
      R => \snapshot_count[8]_i_1_n_0\
    );
\capture_count_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => sel0(4),
      Q => \capture_count_reg__0\(4),
      R => \snapshot_count[8]_i_1_n_0\
    );
\capture_count_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => \snapshot_count[5]_i_1_n_0\,
      Q => \capture_count_reg__0\(5),
      R => \snapshot_count[8]_i_1_n_0\
    );
\capture_count_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => \snapshot_count[6]_i_1_n_0\,
      Q => \capture_count_reg__0\(6),
      R => \snapshot_count[8]_i_1_n_0\
    );
\capture_count_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => sel0(7),
      Q => \capture_count_reg__0\(7),
      R => \snapshot_count[8]_i_1_n_0\
    );
\capture_count_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => sel0(8),
      Q => \capture_count_reg__0\(8),
      R => \snapshot_count[8]_i_1_n_0\
    );
\dropped_count_reg[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5557555555545555"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(0),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(0),
      O => D(0)
    );
\dropped_count_reg[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(9),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(10),
      O => D(10)
    );
\dropped_count_reg[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(10),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(11),
      O => D(11)
    );
\dropped_count_reg[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(11),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(12),
      O => D(12)
    );
\dropped_count_reg[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(12),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(13),
      O => D(13)
    );
\dropped_count_reg[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(13),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(14),
      O => D(14)
    );
\dropped_count_reg[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(14),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(15),
      O => D(15)
    );
\dropped_count_reg[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(15),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(16),
      O => D(16)
    );
\dropped_count_reg[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(16),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(17),
      O => D(17)
    );
\dropped_count_reg[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(17),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(18),
      O => D(18)
    );
\dropped_count_reg[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(18),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(19),
      O => D(19)
    );
\dropped_count_reg[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(0),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(1),
      O => D(1)
    );
\dropped_count_reg[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(19),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(20),
      O => D(20)
    );
\dropped_count_reg[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(20),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(21),
      O => D(21)
    );
\dropped_count_reg[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(21),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(22),
      O => D(22)
    );
\dropped_count_reg[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(22),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(23),
      O => D(23)
    );
\dropped_count_reg[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(23),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(24),
      O => D(24)
    );
\dropped_count_reg[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(24),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(25),
      O => D(25)
    );
\dropped_count_reg[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(25),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(26),
      O => D(26)
    );
\dropped_count_reg[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(26),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(27),
      O => D(27)
    );
\dropped_count_reg[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(27),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(28),
      O => D(28)
    );
\dropped_count_reg[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(28),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(29),
      O => D(29)
    );
\dropped_count_reg[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(1),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(2),
      O => D(2)
    );
\dropped_count_reg[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(29),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(30),
      O => D(30)
    );
\dropped_count_reg[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"75335500"
    )
        port map (
      I0 => capture_active,
      I1 => \dropped_count_reg_reg[0]\,
      I2 => \dropped_count_reg_reg[0]_2\,
      I3 => p_3_in,
      I4 => \dropped_count_reg_reg[0]_1\,
      O => capture_active_reg_0(0)
    );
\dropped_count_reg[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(30),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(31),
      O => D(31)
    );
\dropped_count_reg[31]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAEAAAAFFFFFFFF"
    )
        port map (
      I0 => capture_active,
      I1 => \dropped_count_reg_reg[31]\,
      I2 => \dropped_count_reg_reg[31]_0\,
      I3 => \dropped_count_reg_reg[31]_1\,
      I4 => \dropped_count_reg_reg[31]_2\,
      I5 => \dropped_count_reg_reg[31]_3\,
      O => \dropped_count_reg[31]_i_6_n_0\
    );
\dropped_count_reg[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(2),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(3),
      O => D(3)
    );
\dropped_count_reg[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(3),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(4),
      O => D(4)
    );
\dropped_count_reg[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(4),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(5),
      O => D(5)
    );
\dropped_count_reg[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(5),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(6),
      O => D(6)
    );
\dropped_count_reg[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(6),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(7),
      O => D(7)
    );
\dropped_count_reg[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(7),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(8),
      O => D(8)
    );
\dropped_count_reg[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAABAAAAAAA8AAAA"
    )
        port map (
      I0 => dropped_count_reg00_in(8),
      I1 => \dropped_count_reg[31]_i_6_n_0\,
      I2 => \dropped_count_reg_reg[0]\,
      I3 => \dropped_count_reg_reg[0]_0\,
      I4 => \dropped_count_reg_reg[0]_1\,
      I5 => dropped_count_reg0(9),
      O => D(9)
    );
memory_reg_0: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "SDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 72,
      READ_WIDTH_B => 0,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 0,
      WRITE_WIDTH_B => 72
    )
        port map (
      ADDRARDADDR(15 downto 14) => B"11",
      ADDRARDADDR(13 downto 6) => read_physical_index(7 downto 0),
      ADDRARDADDR(5 downto 0) => B"111111",
      ADDRBWRADDR(15 downto 14) => B"11",
      ADDRBWRADDR(13 downto 6) => \write_pointer_reg__0\(7 downto 0),
      ADDRBWRADDR(5 downto 0) => B"111111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => NLW_memory_reg_0_CASCADEOUTA_UNCONNECTED,
      CASCADEOUTB => NLW_memory_reg_0_CASCADEOUTB_UNCONNECTED,
      CLKARDCLK => s_axi_aclk,
      CLKBWRCLK => s_axi_aclk,
      DBITERR => NLW_memory_reg_0_DBITERR_UNCONNECTED,
      DIADI(31 downto 0) => in_event(31 downto 0),
      DIBDI(31 downto 0) => in_event(63 downto 32),
      DIPADIP(3 downto 0) => in_event(67 downto 64),
      DIPBDIP(3 downto 0) => in_event(71 downto 68),
      DOADO(31 downto 0) => snapshot_rd_event(31 downto 0),
      DOBDO(31 downto 0) => snapshot_rd_event(63 downto 32),
      DOPADOP(3 downto 0) => snapshot_rd_event(67 downto 64),
      DOPBDOP(3 downto 0) => snapshot_rd_event(71 downto 68),
      ECCPARITY(7 downto 0) => NLW_memory_reg_0_ECCPARITY_UNCONNECTED(7 downto 0),
      ENARDEN => memory_reg_0_i_1_n_0,
      ENBWREN => memory_reg_0_i_2_n_0,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => NLW_memory_reg_0_RDADDRECC_UNCONNECTED(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => \^clear\,
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => NLW_memory_reg_0_SBITERR_UNCONNECTED,
      WEA(3 downto 0) => B"0000",
      WEBWE(7) => s_axi_aresetn,
      WEBWE(6) => s_axi_aresetn,
      WEBWE(5) => s_axi_aresetn,
      WEBWE(4) => s_axi_aresetn,
      WEBWE(3) => s_axi_aresetn,
      WEBWE(2) => s_axi_aresetn,
      WEBWE(1) => s_axi_aresetn,
      WEBWE(0) => s_axi_aresetn
    );
memory_reg_0_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"80FF"
    )
        port map (
      I0 => snapshot_ready,
      I1 => rd_valid1,
      I2 => snapshot_rd_en,
      I3 => s_axi_aresetn,
      O => memory_reg_0_i_1_n_0
    );
memory_reg_0_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00A8"
    )
        port map (
      I0 => capture_active,
      I1 => ext_evt_valid,
      I2 => \dropped_count_reg_reg[0]_1\,
      I3 => capture_active_reg_1,
      O => memory_reg_0_i_2_n_0
    );
memory_reg_1: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "SDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 72,
      READ_WIDTH_B => 0,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 0,
      WRITE_WIDTH_B => 72
    )
        port map (
      ADDRARDADDR(15 downto 14) => B"11",
      ADDRARDADDR(13 downto 6) => read_physical_index(7 downto 0),
      ADDRARDADDR(5 downto 0) => B"111111",
      ADDRBWRADDR(15 downto 14) => B"11",
      ADDRBWRADDR(13 downto 6) => \write_pointer_reg__0\(7 downto 0),
      ADDRBWRADDR(5 downto 0) => B"111111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => NLW_memory_reg_1_CASCADEOUTA_UNCONNECTED,
      CASCADEOUTB => NLW_memory_reg_1_CASCADEOUTB_UNCONNECTED,
      CLKARDCLK => s_axi_aclk,
      CLKBWRCLK => s_axi_aclk,
      DBITERR => NLW_memory_reg_1_DBITERR_UNCONNECTED,
      DIADI(31 downto 0) => in_event(103 downto 72),
      DIBDI(31 downto 24) => B"11111111",
      DIBDI(23 downto 0) => in_event(127 downto 104),
      DIPADIP(3 downto 0) => B"1111",
      DIPBDIP(3 downto 0) => B"1111",
      DOADO(31 downto 0) => snapshot_rd_event(103 downto 72),
      DOBDO(31 downto 24) => NLW_memory_reg_1_DOBDO_UNCONNECTED(31 downto 24),
      DOBDO(23 downto 0) => snapshot_rd_event(127 downto 104),
      DOPADOP(3 downto 0) => NLW_memory_reg_1_DOPADOP_UNCONNECTED(3 downto 0),
      DOPBDOP(3 downto 0) => NLW_memory_reg_1_DOPBDOP_UNCONNECTED(3 downto 0),
      ECCPARITY(7 downto 0) => NLW_memory_reg_1_ECCPARITY_UNCONNECTED(7 downto 0),
      ENARDEN => memory_reg_0_i_1_n_0,
      ENBWREN => memory_reg_0_i_2_n_0,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => NLW_memory_reg_1_RDADDRECC_UNCONNECTED(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => \^clear\,
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => NLW_memory_reg_1_SBITERR_UNCONNECTED,
      WEA(3 downto 0) => B"0000",
      WEBWE(7) => s_axi_aresetn,
      WEBWE(6) => s_axi_aresetn,
      WEBWE(5) => s_axi_aresetn,
      WEBWE(4) => s_axi_aresetn,
      WEBWE(3) => s_axi_aresetn,
      WEBWE(2) => s_axi_aresetn,
      WEBWE(1) => s_axi_aresetn,
      WEBWE(0) => s_axi_aresetn
    );
overwritten_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AE00"
    )
        port map (
      I0 => snapshot_overwritten,
      I1 => overwritten_i_2_n_0,
      I2 => overwritten_i_3_n_0,
      I3 => s_axi_aresetn,
      I4 => capture_active_reg_1,
      O => overwritten_i_1_n_0
    );
overwritten_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
        port map (
      I0 => \capture_count_reg__0\(0),
      I1 => \capture_count_reg__0\(8),
      I2 => \capture_count_reg__0\(3),
      I3 => \capture_count_reg__0\(7),
      I4 => \capture_count_reg__0\(4),
      I5 => \capture_count_reg__0\(6),
      O => overwritten_i_2_n_0
    );
overwritten_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFF1F"
    )
        port map (
      I0 => ext_evt_valid,
      I1 => \dropped_count_reg_reg[0]_1\,
      I2 => capture_active,
      I3 => \capture_count_reg__0\(1),
      I4 => \capture_count_reg__0\(2),
      I5 => \capture_count_reg__0\(5),
      O => overwritten_i_3_n_0
    );
overwritten_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => overwritten_i_1_n_0,
      Q => snapshot_overwritten,
      R => '0'
    );
\post_remaining[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \post_remaining_reg_n_0_[0]\,
      O => \post_remaining[0]_i_1_n_0\
    );
\post_remaining[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \post_remaining_reg_n_0_[1]\,
      I1 => \post_remaining_reg_n_0_[0]\,
      O => \post_remaining[1]_i_1_n_0\
    );
\post_remaining[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A9"
    )
        port map (
      I0 => \post_remaining_reg_n_0_[2]\,
      I1 => \post_remaining_reg_n_0_[0]\,
      I2 => \post_remaining_reg_n_0_[1]\,
      O => \post_remaining[2]_i_1_n_0\
    );
\post_remaining[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF54040000"
    )
        port map (
      I0 => trigger_seen_reg_n_0,
      I1 => \post_remaining_reg[1]_0\,
      I2 => \dropped_count_reg_reg[0]_2\,
      I3 => ext_evt_trigger,
      I4 => capture_active111_out,
      I5 => \snapshot_count[8]_i_1_n_0\,
      O => \post_remaining[3]_i_1_n_0\
    );
\post_remaining[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A800"
    )
        port map (
      I0 => trigger_seen_reg_n_0,
      I1 => ext_evt_valid,
      I2 => \dropped_count_reg_reg[0]_1\,
      I3 => capture_active,
      O => post_remaining
    );
\post_remaining[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA9"
    )
        port map (
      I0 => \post_remaining_reg_n_0_[3]\,
      I1 => \post_remaining_reg_n_0_[2]\,
      I2 => \post_remaining_reg_n_0_[1]\,
      I3 => \post_remaining_reg_n_0_[0]\,
      O => \post_remaining[3]_i_3_n_0\
    );
\post_remaining[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EEDEEEEE"
    )
        port map (
      I0 => \post_remaining_reg_n_0_[4]\,
      I1 => trigger_seen8_out,
      I2 => post_remaining,
      I3 => \post_remaining_reg_n_0_[3]\,
      I4 => \post_remaining[4]_i_2_n_0\,
      I5 => \snapshot_count[8]_i_1_n_0\,
      O => \post_remaining[4]_i_1_n_0\
    );
\post_remaining[4]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \post_remaining_reg_n_0_[0]\,
      I1 => \post_remaining_reg_n_0_[1]\,
      I2 => \post_remaining_reg_n_0_[2]\,
      O => \post_remaining[4]_i_2_n_0\
    );
\post_remaining_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => post_remaining,
      D => \post_remaining[0]_i_1_n_0\,
      Q => \post_remaining_reg_n_0_[0]\,
      R => \post_remaining[3]_i_1_n_0\
    );
\post_remaining_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => post_remaining,
      D => \post_remaining[1]_i_1_n_0\,
      Q => \post_remaining_reg_n_0_[1]\,
      R => \post_remaining[3]_i_1_n_0\
    );
\post_remaining_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => post_remaining,
      D => \post_remaining[2]_i_1_n_0\,
      Q => \post_remaining_reg_n_0_[2]\,
      R => \post_remaining[3]_i_1_n_0\
    );
\post_remaining_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => post_remaining,
      D => \post_remaining[3]_i_3_n_0\,
      Q => \post_remaining_reg_n_0_[3]\,
      R => \post_remaining[3]_i_1_n_0\
    );
\post_remaining_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \post_remaining[4]_i_1_n_0\,
      Q => \post_remaining_reg_n_0_[4]\,
      R => '0'
    );
rd_valid1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => rd_valid1_carry_n_0,
      CO(2) => rd_valid1_carry_n_1,
      CO(1) => rd_valid1_carry_n_2,
      CO(0) => rd_valid1_carry_n_3,
      CYINIT => '0',
      DI(3) => rd_valid1_carry_i_1_n_0,
      DI(2) => rd_valid1_carry_i_2_n_0,
      DI(1) => rd_valid1_carry_i_3_n_0,
      DI(0) => rd_valid1_carry_i_4_n_0,
      O(3 downto 0) => NLW_rd_valid1_carry_O_UNCONNECTED(3 downto 0),
      S(3) => rd_valid1_carry_i_5_n_0,
      S(2) => rd_valid1_carry_i_6_n_0,
      S(1) => rd_valid1_carry_i_7_n_0,
      S(0) => rd_valid1_carry_i_8_n_0
    );
\rd_valid1_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => rd_valid1_carry_n_0,
      CO(3 downto 1) => \NLW_rd_valid1_carry__0_CO_UNCONNECTED\(3 downto 1),
      CO(0) => rd_valid1,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => \^q\(0),
      O(3 downto 0) => \NLW_rd_valid1_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3 downto 1) => B"000",
      S(0) => \rd_valid1_carry__0_i_1_n_0\
    );
\rd_valid1_carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => \rd_valid1_carry__0_i_1_n_0\
    );
rd_valid1_carry_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => snapshot_count(7),
      I1 => memory_reg_0_0(7),
      I2 => snapshot_count(6),
      I3 => memory_reg_0_0(6),
      O => rd_valid1_carry_i_1_n_0
    );
rd_valid1_carry_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => snapshot_count(5),
      I1 => memory_reg_0_0(5),
      I2 => snapshot_count(4),
      I3 => memory_reg_0_0(4),
      O => rd_valid1_carry_i_2_n_0
    );
rd_valid1_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => snapshot_count(3),
      I1 => memory_reg_0_0(3),
      I2 => snapshot_count(2),
      I3 => memory_reg_0_0(2),
      O => rd_valid1_carry_i_3_n_0
    );
rd_valid1_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => snapshot_count(1),
      I1 => memory_reg_0_0(1),
      I2 => snapshot_count(0),
      I3 => memory_reg_0_0(0),
      O => rd_valid1_carry_i_4_n_0
    );
rd_valid1_carry_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => memory_reg_0_0(7),
      I1 => snapshot_count(7),
      I2 => memory_reg_0_0(6),
      I3 => snapshot_count(6),
      O => rd_valid1_carry_i_5_n_0
    );
rd_valid1_carry_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => memory_reg_0_0(5),
      I1 => snapshot_count(5),
      I2 => memory_reg_0_0(4),
      I3 => snapshot_count(4),
      O => rd_valid1_carry_i_6_n_0
    );
rd_valid1_carry_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => memory_reg_0_0(3),
      I1 => snapshot_count(3),
      I2 => memory_reg_0_0(2),
      I3 => snapshot_count(2),
      O => rd_valid1_carry_i_7_n_0
    );
rd_valid1_carry_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => memory_reg_0_0(1),
      I1 => snapshot_count(1),
      I2 => memory_reg_0_0(0),
      I3 => snapshot_count(0),
      O => rd_valid1_carry_i_8_n_0
    );
rd_valid_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => snapshot_rd_en,
      I1 => rd_valid1,
      I2 => snapshot_ready,
      O => rd_valid_i_1_n_0
    );
rd_valid_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => rd_valid_i_1_n_0,
      Q => snapshot_rd_valid,
      R => \^clear\
    );
read_physical_index_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => read_physical_index_carry_n_0,
      CO(2) => read_physical_index_carry_n_1,
      CO(1) => read_physical_index_carry_n_2,
      CO(0) => read_physical_index_carry_n_3,
      CYINIT => '0',
      DI(3) => \snapshot_start_reg_n_0_[3]\,
      DI(2) => \snapshot_start_reg_n_0_[2]\,
      DI(1) => \snapshot_start_reg_n_0_[1]\,
      DI(0) => \snapshot_start_reg_n_0_[0]\,
      O(3 downto 0) => read_physical_index(3 downto 0),
      S(3) => read_physical_index_carry_i_1_n_0,
      S(2) => read_physical_index_carry_i_2_n_0,
      S(1) => read_physical_index_carry_i_3_n_0,
      S(0) => read_physical_index_carry_i_4_n_0
    );
\read_physical_index_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => read_physical_index_carry_n_0,
      CO(3) => \NLW_read_physical_index_carry__0_CO_UNCONNECTED\(3),
      CO(2) => \read_physical_index_carry__0_n_1\,
      CO(1) => \read_physical_index_carry__0_n_2\,
      CO(0) => \read_physical_index_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => \snapshot_start_reg_n_0_[6]\,
      DI(1) => \snapshot_start_reg_n_0_[5]\,
      DI(0) => \snapshot_start_reg_n_0_[4]\,
      O(3 downto 0) => read_physical_index(7 downto 4),
      S(3) => \read_physical_index_carry__0_i_1_n_0\,
      S(2) => \read_physical_index_carry__0_i_2_n_0\,
      S(1) => \read_physical_index_carry__0_i_3_n_0\,
      S(0) => \read_physical_index_carry__0_i_4_n_0\
    );
\read_physical_index_carry__0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => memory_reg_0_0(7),
      I1 => \snapshot_start_reg_n_0_[7]\,
      O => \read_physical_index_carry__0_i_1_n_0\
    );
\read_physical_index_carry__0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \snapshot_start_reg_n_0_[6]\,
      I1 => memory_reg_0_0(6),
      O => \read_physical_index_carry__0_i_2_n_0\
    );
\read_physical_index_carry__0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \snapshot_start_reg_n_0_[5]\,
      I1 => memory_reg_0_0(5),
      O => \read_physical_index_carry__0_i_3_n_0\
    );
\read_physical_index_carry__0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \snapshot_start_reg_n_0_[4]\,
      I1 => memory_reg_0_0(4),
      O => \read_physical_index_carry__0_i_4_n_0\
    );
read_physical_index_carry_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \snapshot_start_reg_n_0_[3]\,
      I1 => memory_reg_0_0(3),
      O => read_physical_index_carry_i_1_n_0
    );
read_physical_index_carry_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \snapshot_start_reg_n_0_[2]\,
      I1 => memory_reg_0_0(2),
      O => read_physical_index_carry_i_2_n_0
    );
read_physical_index_carry_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \snapshot_start_reg_n_0_[1]\,
      I1 => memory_reg_0_0(1),
      O => read_physical_index_carry_i_3_n_0
    );
read_physical_index_carry_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \snapshot_start_reg_n_0_[0]\,
      I1 => memory_reg_0_0(0),
      O => read_physical_index_carry_i_4_n_0
    );
s_axi_awready_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s_axi_aresetn,
      O => \^clear\
    );
\s_axi_rdata2_carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => \snapshot_count_reg[8]_0\(0)
    );
s_axi_rdata2_carry_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => snapshot_count(7),
      I1 => s_axi_araddr(10),
      I2 => snapshot_count(6),
      I3 => s_axi_araddr(9),
      O => DI(3)
    );
s_axi_rdata2_carry_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => snapshot_count(5),
      I1 => s_axi_araddr(8),
      I2 => snapshot_count(4),
      I3 => s_axi_araddr(7),
      O => DI(2)
    );
s_axi_rdata2_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => snapshot_count(3),
      I1 => s_axi_araddr(6),
      I2 => snapshot_count(2),
      I3 => s_axi_araddr(5),
      O => DI(1)
    );
s_axi_rdata2_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => snapshot_count(1),
      I1 => s_axi_araddr(4),
      I2 => snapshot_count(0),
      I3 => s_axi_araddr(3),
      O => DI(0)
    );
s_axi_rdata2_carry_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => s_axi_araddr(10),
      I1 => snapshot_count(7),
      I2 => s_axi_araddr(9),
      I3 => snapshot_count(6),
      O => S(3)
    );
s_axi_rdata2_carry_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => s_axi_araddr(8),
      I1 => snapshot_count(5),
      I2 => s_axi_araddr(7),
      I3 => snapshot_count(4),
      O => S(2)
    );
s_axi_rdata2_carry_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => s_axi_araddr(6),
      I1 => snapshot_count(3),
      I2 => s_axi_araddr(5),
      I3 => snapshot_count(2),
      O => S(1)
    );
s_axi_rdata2_carry_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => s_axi_araddr(4),
      I1 => snapshot_count(1),
      I2 => s_axi_araddr(3),
      I3 => snapshot_count(0),
      O => S(0)
    );
\s_axi_rdata[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404040"
    )
        port map (
      I0 => \s_axi_rdata[0]_i_2_n_0\,
      I1 => snapshot_rd_valid,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => \s_axi_rdata[27]_i_3_n_0\,
      I4 => \s_axi_rdata[0]_i_3_n_0\,
      I5 => \s_axi_rdata_reg[0]_0\,
      O => \s_axi_araddr[5]\(0)
    );
\s_axi_rdata[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(32),
      I1 => snapshot_rd_event(0),
      I2 => snapshot_rd_event(64),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(96),
      O => \s_axi_rdata[0]_i_2_n_0\
    );
\s_axi_rdata[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"47FF000000000000"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(0),
      I1 => \s_axi_rdata_reg[4]_2\,
      I2 => snapshot_trigger_index(0),
      I3 => \s_axi_rdata_reg[4]_1\,
      I4 => \s_axi_rdata[0]_i_5_n_0\,
      I5 => \s_axi_rdata_reg[9]\,
      O => \s_axi_rdata[0]_i_3_n_0\
    );
\s_axi_rdata[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AABFBBBFEEBFFFBF"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => s_axi_araddr(1),
      I2 => capture_active,
      I3 => s_axi_araddr(2),
      I4 => snapshot_id(0),
      I5 => snapshot_count(0),
      O => \s_axi_rdata[0]_i_5_n_0\
    );
\s_axi_rdata[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[10]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[10]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[10]\,
      I5 => \s_axi_rdata_reg[10]_0\,
      O => \s_axi_araddr[5]\(10)
    );
\s_axi_rdata[10]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3355000F3355FF0F"
    )
        port map (
      I0 => snapshot_rd_event(74),
      I1 => snapshot_rd_event(106),
      I2 => snapshot_rd_event(10),
      I3 => \s_axi_rdata_reg[0]_1\(0),
      I4 => \s_axi_rdata_reg[0]_1\(1),
      I5 => snapshot_rd_event(42),
      O => \s_axi_rdata[10]_i_2_n_0\
    );
\s_axi_rdata[10]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(10),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(10),
      O => \s_axi_rdata[10]_i_3_n_0\
    );
\s_axi_rdata[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[11]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[11]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[11]\,
      I5 => \s_axi_rdata_reg[11]_0\,
      O => \s_axi_araddr[5]\(11)
    );
\s_axi_rdata[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(43),
      I1 => snapshot_rd_event(11),
      I2 => snapshot_rd_event(75),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(107),
      O => \s_axi_rdata[11]_i_2_n_0\
    );
\s_axi_rdata[11]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(11),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(11),
      O => \s_axi_rdata[11]_i_3_n_0\
    );
\s_axi_rdata[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404040"
    )
        port map (
      I0 => \s_axi_rdata[12]_i_2_n_0\,
      I1 => snapshot_rd_valid,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => \s_axi_rdata[27]_i_3_n_0\,
      I4 => \s_axi_rdata[12]_i_3_n_0\,
      I5 => \s_axi_rdata_reg[12]\,
      O => \s_axi_araddr[5]\(12)
    );
\s_axi_rdata[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(44),
      I1 => snapshot_rd_event(12),
      I2 => snapshot_rd_event(76),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(108),
      O => \s_axi_rdata[12]_i_2_n_0\
    );
\s_axi_rdata[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCCC44CCCC0CCCCC"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(12),
      I1 => \s_axi_rdata_reg[9]\,
      I2 => snapshot_id(12),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(2),
      I5 => s_axi_araddr(3),
      O => \s_axi_rdata[12]_i_3_n_0\
    );
\s_axi_rdata[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[13]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[13]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[13]\,
      I5 => \s_axi_rdata_reg[13]_0\,
      O => \s_axi_araddr[5]\(13)
    );
\s_axi_rdata[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(45),
      I1 => snapshot_rd_event(13),
      I2 => snapshot_rd_event(77),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(109),
      O => \s_axi_rdata[13]_i_2_n_0\
    );
\s_axi_rdata[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(13),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(13),
      O => \s_axi_rdata[13]_i_3_n_0\
    );
\s_axi_rdata[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[14]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[14]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[14]\,
      I5 => \s_axi_rdata_reg[14]_0\,
      O => \s_axi_araddr[5]\(14)
    );
\s_axi_rdata[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(46),
      I1 => snapshot_rd_event(14),
      I2 => snapshot_rd_event(78),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(110),
      O => \s_axi_rdata[14]_i_2_n_0\
    );
\s_axi_rdata[14]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(14),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(14),
      O => \s_axi_rdata[14]_i_3_n_0\
    );
\s_axi_rdata[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[15]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[15]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[15]\,
      I5 => \s_axi_rdata_reg[15]_0\,
      O => \s_axi_araddr[5]\(15)
    );
\s_axi_rdata[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F55FF330F55"
    )
        port map (
      I0 => snapshot_rd_event(15),
      I1 => snapshot_rd_event(47),
      I2 => snapshot_rd_event(79),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(111),
      O => \s_axi_rdata[15]_i_2_n_0\
    );
\s_axi_rdata[15]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(15),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(15),
      O => \s_axi_rdata[15]_i_3_n_0\
    );
\s_axi_rdata[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404040"
    )
        port map (
      I0 => \s_axi_rdata[16]_i_2_n_0\,
      I1 => snapshot_rd_valid,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => \s_axi_rdata[27]_i_3_n_0\,
      I4 => \s_axi_rdata[16]_i_3_n_0\,
      I5 => \s_axi_rdata_reg[16]\,
      O => \s_axi_araddr[5]\(16)
    );
\s_axi_rdata[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(48),
      I1 => snapshot_rd_event(16),
      I2 => snapshot_rd_event(80),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(112),
      O => \s_axi_rdata[16]_i_2_n_0\
    );
\s_axi_rdata[16]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCCC44CCCC0CCCCC"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(16),
      I1 => \s_axi_rdata_reg[9]\,
      I2 => snapshot_id(16),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(2),
      I5 => s_axi_araddr(3),
      O => \s_axi_rdata[16]_i_3_n_0\
    );
\s_axi_rdata[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[17]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[17]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[17]\,
      I5 => \s_axi_rdata_reg[17]_0\,
      O => \s_axi_araddr[5]\(17)
    );
\s_axi_rdata[17]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"33550F0033550FFF"
    )
        port map (
      I0 => snapshot_rd_event(81),
      I1 => snapshot_rd_event(113),
      I2 => snapshot_rd_event(49),
      I3 => \s_axi_rdata_reg[0]_1\(0),
      I4 => \s_axi_rdata_reg[0]_1\(1),
      I5 => snapshot_rd_event(17),
      O => \s_axi_rdata[17]_i_2_n_0\
    );
\s_axi_rdata[17]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(17),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(17),
      O => \s_axi_rdata[17]_i_3_n_0\
    );
\s_axi_rdata[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[18]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[18]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[18]\,
      I5 => \s_axi_rdata_reg[18]_0\,
      O => \s_axi_araddr[5]\(18)
    );
\s_axi_rdata[18]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"33550F0033550FFF"
    )
        port map (
      I0 => snapshot_rd_event(82),
      I1 => snapshot_rd_event(114),
      I2 => snapshot_rd_event(50),
      I3 => \s_axi_rdata_reg[0]_1\(0),
      I4 => \s_axi_rdata_reg[0]_1\(1),
      I5 => snapshot_rd_event(18),
      O => \s_axi_rdata[18]_i_2_n_0\
    );
\s_axi_rdata[18]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(18),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(18),
      O => \s_axi_rdata[18]_i_3_n_0\
    );
\s_axi_rdata[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[19]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[19]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[19]\,
      I5 => \s_axi_rdata_reg[19]_0\,
      O => \s_axi_araddr[5]\(19)
    );
\s_axi_rdata[19]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(51),
      I1 => snapshot_rd_event(19),
      I2 => snapshot_rd_event(83),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(115),
      O => \s_axi_rdata[19]_i_2_n_0\
    );
\s_axi_rdata[19]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(19),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(19),
      O => \s_axi_rdata[19]_i_3_n_0\
    );
\s_axi_rdata[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404040"
    )
        port map (
      I0 => \s_axi_rdata[1]_i_2_n_0\,
      I1 => snapshot_rd_valid,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => \s_axi_rdata[27]_i_3_n_0\,
      I4 => \s_axi_rdata[1]_i_3_n_0\,
      I5 => \s_axi_rdata_reg[1]\,
      O => \s_axi_araddr[5]\(1)
    );
\s_axi_rdata[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(33),
      I1 => snapshot_rd_event(1),
      I2 => snapshot_rd_event(65),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(97),
      O => \s_axi_rdata[1]_i_2_n_0\
    );
\s_axi_rdata[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"47FF000000000000"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(1),
      I1 => \s_axi_rdata_reg[4]_2\,
      I2 => snapshot_trigger_index(1),
      I3 => \s_axi_rdata_reg[4]_1\,
      I4 => \s_axi_rdata[1]_i_5_n_0\,
      I5 => \s_axi_rdata_reg[9]\,
      O => \s_axi_rdata[1]_i_3_n_0\
    );
\s_axi_rdata[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AABFBBBFEEBFFFBF"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => s_axi_araddr(1),
      I2 => snapshot_ready,
      I3 => s_axi_araddr(2),
      I4 => snapshot_id(1),
      I5 => snapshot_count(1),
      O => \s_axi_rdata[1]_i_5_n_0\
    );
\s_axi_rdata[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404040"
    )
        port map (
      I0 => \s_axi_rdata[20]_i_2_n_0\,
      I1 => snapshot_rd_valid,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => \s_axi_rdata[27]_i_3_n_0\,
      I4 => \s_axi_rdata[20]_i_3_n_0\,
      I5 => \s_axi_rdata_reg[20]\,
      O => \s_axi_araddr[5]\(20)
    );
\s_axi_rdata[20]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3355000F3355FF0F"
    )
        port map (
      I0 => snapshot_rd_event(84),
      I1 => snapshot_rd_event(116),
      I2 => snapshot_rd_event(20),
      I3 => \s_axi_rdata_reg[0]_1\(0),
      I4 => \s_axi_rdata_reg[0]_1\(1),
      I5 => snapshot_rd_event(52),
      O => \s_axi_rdata[20]_i_2_n_0\
    );
\s_axi_rdata[20]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCCC44CCCC0CCCCC"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(20),
      I1 => \s_axi_rdata_reg[9]\,
      I2 => snapshot_id(20),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(2),
      I5 => s_axi_araddr(3),
      O => \s_axi_rdata[20]_i_3_n_0\
    );
\s_axi_rdata[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[21]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[21]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[21]\,
      I5 => \s_axi_rdata_reg[21]_0\,
      O => \s_axi_araddr[5]\(21)
    );
\s_axi_rdata[21]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3355000F3355FF0F"
    )
        port map (
      I0 => snapshot_rd_event(85),
      I1 => snapshot_rd_event(117),
      I2 => snapshot_rd_event(21),
      I3 => \s_axi_rdata_reg[0]_1\(0),
      I4 => \s_axi_rdata_reg[0]_1\(1),
      I5 => snapshot_rd_event(53),
      O => \s_axi_rdata[21]_i_2_n_0\
    );
\s_axi_rdata[21]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(21),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(21),
      O => \s_axi_rdata[21]_i_3_n_0\
    );
\s_axi_rdata[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404040"
    )
        port map (
      I0 => \s_axi_rdata[22]_i_2_n_0\,
      I1 => snapshot_rd_valid,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => \s_axi_rdata[27]_i_3_n_0\,
      I4 => \s_axi_rdata[22]_i_3_n_0\,
      I5 => \s_axi_rdata_reg[22]\,
      O => \s_axi_araddr[5]\(22)
    );
\s_axi_rdata[22]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(54),
      I1 => snapshot_rd_event(22),
      I2 => snapshot_rd_event(86),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(118),
      O => \s_axi_rdata[22]_i_2_n_0\
    );
\s_axi_rdata[22]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCCC44CCCC0CCCCC"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(22),
      I1 => \s_axi_rdata_reg[9]\,
      I2 => snapshot_id(22),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(2),
      I5 => s_axi_araddr(3),
      O => \s_axi_rdata[22]_i_3_n_0\
    );
\s_axi_rdata[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[23]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[23]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[23]\,
      I5 => \s_axi_rdata_reg[23]_0\,
      O => \s_axi_araddr[5]\(23)
    );
\s_axi_rdata[23]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(55),
      I1 => snapshot_rd_event(23),
      I2 => snapshot_rd_event(87),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(119),
      O => \s_axi_rdata[23]_i_2_n_0\
    );
\s_axi_rdata[23]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(23),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(23),
      O => \s_axi_rdata[23]_i_3_n_0\
    );
\s_axi_rdata[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[24]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[24]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[24]\,
      I5 => \s_axi_rdata_reg[24]_0\,
      O => \s_axi_araddr[5]\(24)
    );
\s_axi_rdata[24]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F55FF330F55"
    )
        port map (
      I0 => snapshot_rd_event(24),
      I1 => snapshot_rd_event(56),
      I2 => snapshot_rd_event(88),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(120),
      O => \s_axi_rdata[24]_i_2_n_0\
    );
\s_axi_rdata[24]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(24),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(24),
      O => \s_axi_rdata[24]_i_3_n_0\
    );
\s_axi_rdata[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[25]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[25]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[25]\,
      I5 => \s_axi_rdata_reg[25]_0\,
      O => \s_axi_araddr[5]\(25)
    );
\s_axi_rdata[25]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F55FF330F55"
    )
        port map (
      I0 => snapshot_rd_event(25),
      I1 => snapshot_rd_event(57),
      I2 => snapshot_rd_event(89),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(121),
      O => \s_axi_rdata[25]_i_2_n_0\
    );
\s_axi_rdata[25]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(25),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(25),
      O => \s_axi_rdata[25]_i_3_n_0\
    );
\s_axi_rdata[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404040"
    )
        port map (
      I0 => \s_axi_rdata[26]_i_2_n_0\,
      I1 => snapshot_rd_valid,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => \s_axi_rdata[27]_i_3_n_0\,
      I4 => \s_axi_rdata[26]_i_3_n_0\,
      I5 => \s_axi_rdata_reg[26]\,
      O => \s_axi_araddr[5]\(26)
    );
\s_axi_rdata[26]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"33550F0033550FFF"
    )
        port map (
      I0 => snapshot_rd_event(90),
      I1 => snapshot_rd_event(122),
      I2 => snapshot_rd_event(58),
      I3 => \s_axi_rdata_reg[0]_1\(0),
      I4 => \s_axi_rdata_reg[0]_1\(1),
      I5 => snapshot_rd_event(26),
      O => \s_axi_rdata[26]_i_2_n_0\
    );
\s_axi_rdata[26]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCCC44CCCC0CCCCC"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(26),
      I1 => \s_axi_rdata_reg[9]\,
      I2 => snapshot_id(26),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(2),
      I5 => s_axi_araddr(3),
      O => \s_axi_rdata[26]_i_3_n_0\
    );
\s_axi_rdata[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404040"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_2_n_0\,
      I1 => snapshot_rd_valid,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => \s_axi_rdata[27]_i_3_n_0\,
      I4 => \s_axi_rdata[27]_i_4_n_0\,
      I5 => \s_axi_rdata_reg[27]\,
      O => \s_axi_araddr[5]\(27)
    );
\s_axi_rdata[27]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(59),
      I1 => snapshot_rd_event(27),
      I2 => snapshot_rd_event(91),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(123),
      O => \s_axi_rdata[27]_i_2_n_0\
    );
\s_axi_rdata[27]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_6_n_0\,
      I1 => \s_axi_rdata_reg[27]_0\,
      I2 => s_axi_araddr(6),
      I3 => s_axi_araddr(9),
      I4 => s_axi_araddr(8),
      O => \s_axi_rdata[27]_i_3_n_0\
    );
\s_axi_rdata[27]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCCC44CCCC0CCCCC"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(27),
      I1 => \s_axi_rdata_reg[9]\,
      I2 => snapshot_id(27),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(2),
      I5 => s_axi_araddr(3),
      O => \s_axi_rdata[27]_i_4_n_0\
    );
\s_axi_rdata[27]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFF8"
    )
        port map (
      I0 => \s_axi_rdata_reg[0]\,
      I1 => snapshot_rd_valid,
      I2 => s_axi_araddr(12),
      I3 => s_axi_araddr(13),
      I4 => s_axi_araddr(10),
      I5 => s_axi_araddr(0),
      O => \s_axi_rdata[27]_i_6_n_0\
    );
\s_axi_rdata[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[28]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[28]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[28]\,
      I5 => \s_axi_rdata_reg[28]_0\,
      O => \s_axi_araddr[5]\(28)
    );
\s_axi_rdata[28]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(60),
      I1 => snapshot_rd_event(28),
      I2 => snapshot_rd_event(92),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(124),
      O => \s_axi_rdata[28]_i_2_n_0\
    );
\s_axi_rdata[28]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(28),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(28),
      O => \s_axi_rdata[28]_i_3_n_0\
    );
\s_axi_rdata[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[29]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[29]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[29]\,
      I5 => \s_axi_rdata_reg[29]_0\,
      O => \s_axi_araddr[5]\(29)
    );
\s_axi_rdata[29]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(61),
      I1 => snapshot_rd_event(29),
      I2 => snapshot_rd_event(93),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(125),
      O => \s_axi_rdata[29]_i_2_n_0\
    );
\s_axi_rdata[29]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(29),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(29),
      O => \s_axi_rdata[29]_i_3_n_0\
    );
\s_axi_rdata[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404040"
    )
        port map (
      I0 => \s_axi_rdata[2]_i_2_n_0\,
      I1 => snapshot_rd_valid,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => \s_axi_rdata[27]_i_3_n_0\,
      I4 => \s_axi_rdata[2]_i_3_n_0\,
      I5 => \s_axi_rdata_reg[2]\,
      O => \s_axi_araddr[5]\(2)
    );
\s_axi_rdata[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F55FF330F55"
    )
        port map (
      I0 => snapshot_rd_event(2),
      I1 => snapshot_rd_event(34),
      I2 => snapshot_rd_event(66),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(98),
      O => \s_axi_rdata[2]_i_2_n_0\
    );
\s_axi_rdata[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"47FF000000000000"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(2),
      I1 => \s_axi_rdata_reg[4]_2\,
      I2 => snapshot_trigger_index(2),
      I3 => \s_axi_rdata_reg[4]_1\,
      I4 => \s_axi_rdata[2]_i_5_n_0\,
      I5 => \s_axi_rdata_reg[9]\,
      O => \s_axi_rdata[2]_i_3_n_0\
    );
\s_axi_rdata[2]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AABFAFBFFABFFFBF"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => snapshot_overwritten,
      I2 => s_axi_araddr(1),
      I3 => s_axi_araddr(2),
      I4 => snapshot_id(2),
      I5 => snapshot_count(2),
      O => \s_axi_rdata[2]_i_5_n_0\
    );
\s_axi_rdata[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[30]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[30]\,
      I5 => \s_axi_rdata_reg[30]_0\,
      O => \s_axi_araddr[5]\(30)
    );
\s_axi_rdata[30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(62),
      I1 => snapshot_rd_event(30),
      I2 => snapshot_rd_event(94),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(126),
      O => \s_axi_rdata[30]_i_2_n_0\
    );
\s_axi_rdata[30]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(30),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(30),
      O => \s_axi_rdata[30]_i_3_n_0\
    );
\s_axi_rdata[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00001500FFFFFFFF"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]\,
      I1 => snapshot_ready,
      I2 => CO(0),
      I3 => \s_axi_rdata_reg[31]_0\,
      I4 => \s_axi_rdata[31]_i_6_n_0\,
      I5 => s_axi_aresetn,
      O => SR(0)
    );
\s_axi_rdata[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF808080"
    )
        port map (
      I0 => \snapshot_rd_index_reg[0]\,
      I1 => s_axi_arvalid,
      I2 => \s_axi_rdata_reg[31]\,
      I3 => snapshot_rd_valid,
      I4 => \s_axi_rdata_reg[0]\,
      O => E(0)
    );
\s_axi_rdata[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[31]_i_7_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[31]_i_8_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[31]_2\,
      I5 => \s_axi_rdata_reg[31]_3\,
      O => \s_axi_araddr[5]\(31)
    );
\s_axi_rdata[31]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => snapshot_rd_valid,
      I1 => \s_axi_rdata_reg[0]\,
      O => \s_axi_rdata[31]_i_6_n_0\
    );
\s_axi_rdata[31]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3355000F3355FF0F"
    )
        port map (
      I0 => snapshot_rd_event(95),
      I1 => snapshot_rd_event(127),
      I2 => snapshot_rd_event(31),
      I3 => \s_axi_rdata_reg[0]_1\(0),
      I4 => \s_axi_rdata_reg[0]_1\(1),
      I5 => snapshot_rd_event(63),
      O => \s_axi_rdata[31]_i_7_n_0\
    );
\s_axi_rdata[31]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(31),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(31),
      O => \s_axi_rdata[31]_i_8_n_0\
    );
\s_axi_rdata[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4444444F"
    )
        port map (
      I0 => \s_axi_rdata[3]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[3]_i_3_n_0\,
      I3 => \s_axi_rdata[3]_i_4_n_0\,
      I4 => s_axi_araddr(3),
      I5 => \s_axi_rdata[3]_i_5_n_0\,
      O => \s_axi_araddr[5]\(3)
    );
\s_axi_rdata[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(35),
      I1 => snapshot_rd_event(3),
      I2 => snapshot_rd_event(67),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(99),
      O => \s_axi_rdata[3]_i_2_n_0\
    );
\s_axi_rdata[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABABABBBBBBBABBB"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[3]\,
      I2 => s_axi_araddr(4),
      I3 => \s_axi_rdata_reg[3]_0\,
      I4 => s_axi_araddr(3),
      I5 => \s_axi_rdata_reg[3]_1\,
      O => \s_axi_rdata[3]_i_3_n_0\
    );
\s_axi_rdata[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAA00000020"
    )
        port map (
      I0 => \s_axi_rdata[3]_i_9_n_0\,
      I1 => \s_axi_rdata_reg[3]_2\,
      I2 => \s_axi_rdata_reg[3]_3\,
      I3 => \s_axi_rdata_reg[3]_4\,
      I4 => \s_axi_rdata_reg[3]_5\,
      I5 => \timestamp_shadow_reg[32]\,
      O => \s_axi_rdata[3]_i_4_n_0\
    );
\s_axi_rdata[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008C0080FFFFFFFF"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(3),
      I1 => s_axi_araddr(3),
      I2 => s_axi_araddr(1),
      I3 => s_axi_araddr(2),
      I4 => snapshot_trigger_index(3),
      I5 => \s_axi_rdata_reg[9]\,
      O => \s_axi_rdata[3]_i_5_n_0\
    );
\s_axi_rdata[3]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"57F7"
    )
        port map (
      I0 => s_axi_araddr(2),
      I1 => snapshot_id(3),
      I2 => s_axi_araddr(1),
      I3 => snapshot_count(3),
      O => \s_axi_rdata[3]_i_9_n_0\
    );
\s_axi_rdata[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[4]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[4]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[4]\,
      I5 => \s_axi_rdata_reg[4]_0\,
      O => \s_axi_araddr[5]\(4)
    );
\s_axi_rdata[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F55FF330F55"
    )
        port map (
      I0 => snapshot_rd_event(4),
      I1 => snapshot_rd_event(36),
      I2 => snapshot_rd_event(68),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(100),
      O => \s_axi_rdata[4]_i_2_n_0\
    );
\s_axi_rdata[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABABABBBBBBBABBB"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata[4]_i_6_n_0\,
      I2 => \s_axi_rdata_reg[4]_1\,
      I3 => snapshot_trigger_index(4),
      I4 => \s_axi_rdata_reg[4]_2\,
      I5 => \s_axi_rdata_reg[31]_1\(4),
      O => \s_axi_rdata[4]_i_3_n_0\
    );
\s_axi_rdata[4]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"22200020FFFFFFFF"
    )
        port map (
      I0 => s_axi_araddr(2),
      I1 => s_axi_araddr(3),
      I2 => snapshot_id(4),
      I3 => s_axi_araddr(1),
      I4 => snapshot_count(4),
      I5 => \s_axi_rdata_reg[9]\,
      O => \s_axi_rdata[4]_i_6_n_0\
    );
\s_axi_rdata[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[5]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[5]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[5]\,
      I5 => \s_axi_rdata_reg[5]_0\,
      O => \s_axi_araddr[5]\(5)
    );
\s_axi_rdata[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00330F55FF330F55"
    )
        port map (
      I0 => snapshot_rd_event(5),
      I1 => snapshot_rd_event(37),
      I2 => snapshot_rd_event(69),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(101),
      O => \s_axi_rdata[5]_i_2_n_0\
    );
\s_axi_rdata[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABABABBBBBBBABBB"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata[5]_i_6_n_0\,
      I2 => \s_axi_rdata_reg[4]_1\,
      I3 => snapshot_trigger_index(5),
      I4 => \s_axi_rdata_reg[4]_2\,
      I5 => \s_axi_rdata_reg[31]_1\(5),
      O => \s_axi_rdata[5]_i_3_n_0\
    );
\s_axi_rdata[5]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"22200020FFFFFFFF"
    )
        port map (
      I0 => s_axi_araddr(2),
      I1 => s_axi_araddr(3),
      I2 => snapshot_id(5),
      I3 => s_axi_araddr(1),
      I4 => snapshot_count(5),
      I5 => \s_axi_rdata_reg[9]\,
      O => \s_axi_rdata[5]_i_6_n_0\
    );
\s_axi_rdata[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"404040FF40404040"
    )
        port map (
      I0 => \s_axi_rdata[6]_i_2_n_0\,
      I1 => snapshot_rd_valid,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => \s_axi_rdata[27]_i_3_n_0\,
      I4 => \s_axi_rdata[6]_i_3_n_0\,
      I5 => \s_axi_rdata_reg[6]\,
      O => \s_axi_araddr[5]\(6)
    );
\s_axi_rdata[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(38),
      I1 => snapshot_rd_event(6),
      I2 => snapshot_rd_event(70),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(102),
      O => \s_axi_rdata[6]_i_2_n_0\
    );
\s_axi_rdata[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FF73FF7F"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]_1\(6),
      I1 => s_axi_araddr(3),
      I2 => s_axi_araddr(1),
      I3 => s_axi_araddr(2),
      I4 => snapshot_trigger_index(6),
      I5 => \s_axi_rdata[6]_i_5_n_0\,
      O => \s_axi_rdata[6]_i_3_n_0\
    );
\s_axi_rdata[6]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"22200020FFFFFFFF"
    )
        port map (
      I0 => s_axi_araddr(2),
      I1 => s_axi_araddr(3),
      I2 => snapshot_id(6),
      I3 => s_axi_araddr(1),
      I4 => snapshot_count(6),
      I5 => \s_axi_rdata_reg[9]\,
      O => \s_axi_rdata[6]_i_5_n_0\
    );
\s_axi_rdata[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[7]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[7]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[7]\,
      I5 => \s_axi_rdata_reg[7]_0\,
      O => \s_axi_araddr[5]\(7)
    );
\s_axi_rdata[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(39),
      I1 => snapshot_rd_event(7),
      I2 => snapshot_rd_event(71),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(103),
      O => \s_axi_rdata[7]_i_2_n_0\
    );
\s_axi_rdata[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABABABBBBBBBABBB"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata[7]_i_6_n_0\,
      I2 => \s_axi_rdata_reg[4]_1\,
      I3 => snapshot_trigger_index(7),
      I4 => \s_axi_rdata_reg[4]_2\,
      I5 => \s_axi_rdata_reg[31]_1\(7),
      O => \s_axi_rdata[7]_i_3_n_0\
    );
\s_axi_rdata[7]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"22200020FFFFFFFF"
    )
        port map (
      I0 => s_axi_araddr(2),
      I1 => s_axi_araddr(3),
      I2 => snapshot_id(7),
      I3 => s_axi_araddr(1),
      I4 => snapshot_count(7),
      I5 => \s_axi_rdata_reg[9]\,
      O => \s_axi_rdata[7]_i_6_n_0\
    );
\s_axi_rdata[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[8]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[8]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[8]\,
      I5 => \s_axi_rdata_reg[8]_0\,
      O => \s_axi_araddr[5]\(8)
    );
\s_axi_rdata[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(40),
      I1 => snapshot_rd_event(8),
      I2 => snapshot_rd_event(72),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(104),
      O => \s_axi_rdata[8]_i_2_n_0\
    );
\s_axi_rdata[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAEFAAAAAAAAAAAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[8]_1\,
      I2 => \s_axi_rdata_reg[31]_1\(8),
      I3 => s_axi_araddr(0),
      I4 => s_axi_araddr(11),
      I5 => \s_axi_rdata[8]_i_6_n_0\,
      O => \s_axi_rdata[8]_i_3_n_0\
    );
\s_axi_rdata[8]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF1DFFFF"
    )
        port map (
      I0 => snapshot_id(8),
      I1 => s_axi_araddr(1),
      I2 => \^q\(0),
      I3 => s_axi_araddr(3),
      I4 => s_axi_araddr(2),
      O => \s_axi_rdata[8]_i_6_n_0\
    );
\s_axi_rdata[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F4F4F444444"
    )
        port map (
      I0 => \s_axi_rdata[9]_i_2_n_0\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => \s_axi_rdata[9]_i_3_n_0\,
      I3 => s_axi_araddr(4),
      I4 => \s_axi_rdata_reg[9]_0\,
      I5 => \s_axi_rdata_reg[9]_1\,
      O => \s_axi_araddr[5]\(9)
    );
\s_axi_rdata[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00550F33FF550F33"
    )
        port map (
      I0 => snapshot_rd_event(41),
      I1 => snapshot_rd_event(9),
      I2 => snapshot_rd_event(73),
      I3 => \s_axi_rdata_reg[0]_1\(1),
      I4 => \s_axi_rdata_reg[0]_1\(0),
      I5 => snapshot_rd_event(105),
      O => \s_axi_rdata[9]_i_2_n_0\
    );
\s_axi_rdata[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFAAAAAAEFAAEFAA"
    )
        port map (
      I0 => \s_axi_rdata[27]_i_3_n_0\,
      I1 => \s_axi_rdata_reg[9]_2\,
      I2 => snapshot_id(9),
      I3 => \s_axi_rdata_reg[9]\,
      I4 => \s_axi_rdata_reg[8]_1\,
      I5 => \s_axi_rdata_reg[31]_1\(9),
      O => \s_axi_rdata[9]_i_3_n_0\
    );
s_axi_rvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000F8FFF8F8"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => \snapshot_rd_index_reg[0]\,
      I2 => \s_axi_rdata[31]_i_6_n_0\,
      I3 => s_axi_rready,
      I4 => s_axi_rvalid,
      I5 => \^snapshot_ready_reg_0\(0),
      O => s_axi_arvalid_0
    );
\snapshot_count[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \capture_count_reg__0\(0),
      I1 => \capture_count_reg__0\(8),
      O => \snapshot_count[0]_i_1_n_0\
    );
\snapshot_count[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"9A"
    )
        port map (
      I0 => \capture_count_reg__0\(1),
      I1 => \capture_count_reg__0\(8),
      I2 => \capture_count_reg__0\(0),
      O => sel0(1)
    );
\snapshot_count[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A6AA"
    )
        port map (
      I0 => \capture_count_reg__0\(2),
      I1 => \capture_count_reg__0\(0),
      I2 => \capture_count_reg__0\(8),
      I3 => \capture_count_reg__0\(1),
      O => sel0(2)
    );
\snapshot_count[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF4000"
    )
        port map (
      I0 => \capture_count_reg__0\(8),
      I1 => \capture_count_reg__0\(1),
      I2 => \capture_count_reg__0\(2),
      I3 => \capture_count_reg__0\(0),
      I4 => \capture_count_reg__0\(3),
      O => sel0(3)
    );
\snapshot_count[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => \capture_count_reg__0\(4),
      I1 => \capture_count_reg__0\(8),
      I2 => \capture_count_reg__0\(1),
      I3 => \capture_count_reg__0\(2),
      I4 => \capture_count_reg__0\(0),
      I5 => \capture_count_reg__0\(3),
      O => sel0(4)
    );
\snapshot_count[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \capture_count_reg__0\(5),
      I1 => \snapshot_count[7]_i_2_n_0\,
      I2 => \capture_count_reg__0\(4),
      O => \snapshot_count[5]_i_1_n_0\
    );
\snapshot_count[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \capture_count_reg__0\(6),
      I1 => \capture_count_reg__0\(5),
      I2 => \capture_count_reg__0\(4),
      I3 => \snapshot_count[7]_i_2_n_0\,
      O => \snapshot_count[6]_i_1_n_0\
    );
\snapshot_count[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \capture_count_reg__0\(7),
      I1 => \snapshot_count[7]_i_2_n_0\,
      I2 => \capture_count_reg__0\(4),
      I3 => \capture_count_reg__0\(5),
      I4 => \capture_count_reg__0\(6),
      O => sel0(7)
    );
\snapshot_count[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00008000"
    )
        port map (
      I0 => \capture_count_reg__0\(3),
      I1 => \capture_count_reg__0\(0),
      I2 => \capture_count_reg__0\(2),
      I3 => \capture_count_reg__0\(1),
      I4 => \capture_count_reg__0\(8),
      O => \snapshot_count[7]_i_2_n_0\
    );
\snapshot_count[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => capture_active_reg_1,
      I1 => s_axi_aresetn,
      O => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_count[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000200000000"
    )
        port map (
      I0 => post_remaining,
      I1 => \post_remaining_reg_n_0_[3]\,
      I2 => \post_remaining_reg_n_0_[2]\,
      I3 => \post_remaining_reg_n_0_[4]\,
      I4 => \post_remaining_reg_n_0_[1]\,
      I5 => \post_remaining_reg_n_0_[0]\,
      O => \snapshot_count[8]_i_2_n_0\
    );
\snapshot_count[8]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0080"
    )
        port map (
      I0 => \capture_count_reg__0\(1),
      I1 => \capture_count_reg__0\(2),
      I2 => \capture_count_reg__0\(0),
      I3 => \snapshot_count[8]_i_4_n_0\,
      I4 => \capture_count_reg__0\(8),
      O => sel0(8)
    );
\snapshot_count[8]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
        port map (
      I0 => \capture_count_reg__0\(7),
      I1 => \capture_count_reg__0\(4),
      I2 => \capture_count_reg__0\(6),
      I3 => \capture_count_reg__0\(3),
      I4 => \capture_count_reg__0\(5),
      O => \snapshot_count[8]_i_4_n_0\
    );
\snapshot_count_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => \snapshot_count[0]_i_1_n_0\,
      Q => snapshot_count(0),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_count_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => sel0(1),
      Q => snapshot_count(1),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_count_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => sel0(2),
      Q => snapshot_count(2),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_count_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => sel0(3),
      Q => snapshot_count(3),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_count_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => sel0(4),
      Q => snapshot_count(4),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_count_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => \snapshot_count[5]_i_1_n_0\,
      Q => snapshot_count(5),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_count_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => \snapshot_count[6]_i_1_n_0\,
      Q => snapshot_count(6),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_count_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => sel0(7),
      Q => snapshot_count(7),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_count_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => sel0(8),
      Q => \^q\(0),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_id[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \snapshot_count[8]_i_2_n_0\,
      I1 => capture_active_reg_1,
      O => \snapshot_id[0]_i_1_n_0\
    );
\snapshot_id[0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => snapshot_id(0),
      O => \snapshot_id[0]_i_3_n_0\
    );
\snapshot_id_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[0]_i_2_n_7\,
      Q => snapshot_id(0),
      R => \^clear\
    );
\snapshot_id_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \snapshot_id_reg[0]_i_2_n_0\,
      CO(2) => \snapshot_id_reg[0]_i_2_n_1\,
      CO(1) => \snapshot_id_reg[0]_i_2_n_2\,
      CO(0) => \snapshot_id_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \snapshot_id_reg[0]_i_2_n_4\,
      O(2) => \snapshot_id_reg[0]_i_2_n_5\,
      O(1) => \snapshot_id_reg[0]_i_2_n_6\,
      O(0) => \snapshot_id_reg[0]_i_2_n_7\,
      S(3 downto 1) => snapshot_id(3 downto 1),
      S(0) => \snapshot_id[0]_i_3_n_0\
    );
\snapshot_id_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[8]_i_1_n_5\,
      Q => snapshot_id(10),
      R => \^clear\
    );
\snapshot_id_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[8]_i_1_n_4\,
      Q => snapshot_id(11),
      R => \^clear\
    );
\snapshot_id_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[12]_i_1_n_7\,
      Q => snapshot_id(12),
      R => \^clear\
    );
\snapshot_id_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \snapshot_id_reg[8]_i_1_n_0\,
      CO(3) => \snapshot_id_reg[12]_i_1_n_0\,
      CO(2) => \snapshot_id_reg[12]_i_1_n_1\,
      CO(1) => \snapshot_id_reg[12]_i_1_n_2\,
      CO(0) => \snapshot_id_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \snapshot_id_reg[12]_i_1_n_4\,
      O(2) => \snapshot_id_reg[12]_i_1_n_5\,
      O(1) => \snapshot_id_reg[12]_i_1_n_6\,
      O(0) => \snapshot_id_reg[12]_i_1_n_7\,
      S(3 downto 0) => snapshot_id(15 downto 12)
    );
\snapshot_id_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[12]_i_1_n_6\,
      Q => snapshot_id(13),
      R => \^clear\
    );
\snapshot_id_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[12]_i_1_n_5\,
      Q => snapshot_id(14),
      R => \^clear\
    );
\snapshot_id_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[12]_i_1_n_4\,
      Q => snapshot_id(15),
      R => \^clear\
    );
\snapshot_id_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[16]_i_1_n_7\,
      Q => snapshot_id(16),
      R => \^clear\
    );
\snapshot_id_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \snapshot_id_reg[12]_i_1_n_0\,
      CO(3) => \snapshot_id_reg[16]_i_1_n_0\,
      CO(2) => \snapshot_id_reg[16]_i_1_n_1\,
      CO(1) => \snapshot_id_reg[16]_i_1_n_2\,
      CO(0) => \snapshot_id_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \snapshot_id_reg[16]_i_1_n_4\,
      O(2) => \snapshot_id_reg[16]_i_1_n_5\,
      O(1) => \snapshot_id_reg[16]_i_1_n_6\,
      O(0) => \snapshot_id_reg[16]_i_1_n_7\,
      S(3 downto 0) => snapshot_id(19 downto 16)
    );
\snapshot_id_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[16]_i_1_n_6\,
      Q => snapshot_id(17),
      R => \^clear\
    );
\snapshot_id_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[16]_i_1_n_5\,
      Q => snapshot_id(18),
      R => \^clear\
    );
\snapshot_id_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[16]_i_1_n_4\,
      Q => snapshot_id(19),
      R => \^clear\
    );
\snapshot_id_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[0]_i_2_n_6\,
      Q => snapshot_id(1),
      R => \^clear\
    );
\snapshot_id_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[20]_i_1_n_7\,
      Q => snapshot_id(20),
      R => \^clear\
    );
\snapshot_id_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \snapshot_id_reg[16]_i_1_n_0\,
      CO(3) => \snapshot_id_reg[20]_i_1_n_0\,
      CO(2) => \snapshot_id_reg[20]_i_1_n_1\,
      CO(1) => \snapshot_id_reg[20]_i_1_n_2\,
      CO(0) => \snapshot_id_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \snapshot_id_reg[20]_i_1_n_4\,
      O(2) => \snapshot_id_reg[20]_i_1_n_5\,
      O(1) => \snapshot_id_reg[20]_i_1_n_6\,
      O(0) => \snapshot_id_reg[20]_i_1_n_7\,
      S(3 downto 0) => snapshot_id(23 downto 20)
    );
\snapshot_id_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[20]_i_1_n_6\,
      Q => snapshot_id(21),
      R => \^clear\
    );
\snapshot_id_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[20]_i_1_n_5\,
      Q => snapshot_id(22),
      R => \^clear\
    );
\snapshot_id_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[20]_i_1_n_4\,
      Q => snapshot_id(23),
      R => \^clear\
    );
\snapshot_id_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[24]_i_1_n_7\,
      Q => snapshot_id(24),
      R => \^clear\
    );
\snapshot_id_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \snapshot_id_reg[20]_i_1_n_0\,
      CO(3) => \snapshot_id_reg[24]_i_1_n_0\,
      CO(2) => \snapshot_id_reg[24]_i_1_n_1\,
      CO(1) => \snapshot_id_reg[24]_i_1_n_2\,
      CO(0) => \snapshot_id_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \snapshot_id_reg[24]_i_1_n_4\,
      O(2) => \snapshot_id_reg[24]_i_1_n_5\,
      O(1) => \snapshot_id_reg[24]_i_1_n_6\,
      O(0) => \snapshot_id_reg[24]_i_1_n_7\,
      S(3 downto 0) => snapshot_id(27 downto 24)
    );
\snapshot_id_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[24]_i_1_n_6\,
      Q => snapshot_id(25),
      R => \^clear\
    );
\snapshot_id_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[24]_i_1_n_5\,
      Q => snapshot_id(26),
      R => \^clear\
    );
\snapshot_id_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[24]_i_1_n_4\,
      Q => snapshot_id(27),
      R => \^clear\
    );
\snapshot_id_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[28]_i_1_n_7\,
      Q => snapshot_id(28),
      R => \^clear\
    );
\snapshot_id_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \snapshot_id_reg[24]_i_1_n_0\,
      CO(3) => \NLW_snapshot_id_reg[28]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \snapshot_id_reg[28]_i_1_n_1\,
      CO(1) => \snapshot_id_reg[28]_i_1_n_2\,
      CO(0) => \snapshot_id_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \snapshot_id_reg[28]_i_1_n_4\,
      O(2) => \snapshot_id_reg[28]_i_1_n_5\,
      O(1) => \snapshot_id_reg[28]_i_1_n_6\,
      O(0) => \snapshot_id_reg[28]_i_1_n_7\,
      S(3 downto 0) => snapshot_id(31 downto 28)
    );
\snapshot_id_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[28]_i_1_n_6\,
      Q => snapshot_id(29),
      R => \^clear\
    );
\snapshot_id_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[0]_i_2_n_5\,
      Q => snapshot_id(2),
      R => \^clear\
    );
\snapshot_id_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[28]_i_1_n_5\,
      Q => snapshot_id(30),
      R => \^clear\
    );
\snapshot_id_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[28]_i_1_n_4\,
      Q => snapshot_id(31),
      R => \^clear\
    );
\snapshot_id_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[0]_i_2_n_4\,
      Q => snapshot_id(3),
      R => \^clear\
    );
\snapshot_id_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[4]_i_1_n_7\,
      Q => snapshot_id(4),
      R => \^clear\
    );
\snapshot_id_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \snapshot_id_reg[0]_i_2_n_0\,
      CO(3) => \snapshot_id_reg[4]_i_1_n_0\,
      CO(2) => \snapshot_id_reg[4]_i_1_n_1\,
      CO(1) => \snapshot_id_reg[4]_i_1_n_2\,
      CO(0) => \snapshot_id_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \snapshot_id_reg[4]_i_1_n_4\,
      O(2) => \snapshot_id_reg[4]_i_1_n_5\,
      O(1) => \snapshot_id_reg[4]_i_1_n_6\,
      O(0) => \snapshot_id_reg[4]_i_1_n_7\,
      S(3 downto 0) => snapshot_id(7 downto 4)
    );
\snapshot_id_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[4]_i_1_n_6\,
      Q => snapshot_id(5),
      R => \^clear\
    );
\snapshot_id_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[4]_i_1_n_5\,
      Q => snapshot_id(6),
      R => \^clear\
    );
\snapshot_id_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[4]_i_1_n_4\,
      Q => snapshot_id(7),
      R => \^clear\
    );
\snapshot_id_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[8]_i_1_n_7\,
      Q => snapshot_id(8),
      R => \^clear\
    );
\snapshot_id_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \snapshot_id_reg[4]_i_1_n_0\,
      CO(3) => \snapshot_id_reg[8]_i_1_n_0\,
      CO(2) => \snapshot_id_reg[8]_i_1_n_1\,
      CO(1) => \snapshot_id_reg[8]_i_1_n_2\,
      CO(0) => \snapshot_id_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \snapshot_id_reg[8]_i_1_n_4\,
      O(2) => \snapshot_id_reg[8]_i_1_n_5\,
      O(1) => \snapshot_id_reg[8]_i_1_n_6\,
      O(0) => \snapshot_id_reg[8]_i_1_n_7\,
      S(3 downto 0) => snapshot_id(11 downto 8)
    );
\snapshot_id_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_id[0]_i_1_n_0\,
      D => \snapshot_id_reg[8]_i_1_n_6\,
      Q => snapshot_id(9),
      R => \^clear\
    );
snapshot_rd_en_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^snapshot_ready_reg_0\(0),
      I1 => s_axi_aresetn,
      O => s_axi_aresetn_0
    );
snapshot_read_pending_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0010F010"
    )
        port map (
      I0 => snapshot_read_pending_i_2_n_0,
      I1 => \s_axi_rdata_reg[31]\,
      I2 => s_axi_aresetn,
      I3 => \s_axi_rdata_reg[0]\,
      I4 => snapshot_rd_valid,
      O => s_axi_aresetn_1
    );
snapshot_read_pending_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => \snapshot_rd_index_reg[0]\,
      I2 => snapshot_ready,
      I3 => CO(0),
      O => snapshot_read_pending_i_2_n_0
    );
snapshot_ready_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20302020"
    )
        port map (
      I0 => \snapshot_count[8]_i_2_n_0\,
      I1 => capture_active_reg_1,
      I2 => s_axi_aresetn,
      I3 => snapshot_ready_reg_1,
      I4 => snapshot_ready,
      O => snapshot_ready_i_1_n_0
    );
snapshot_ready_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => snapshot_ready_i_1_n_0,
      Q => snapshot_ready,
      R => '0'
    );
\snapshot_start[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \write_pointer_reg__0\(0),
      I1 => \snapshot_start[7]_i_3_n_0\,
      O => \snapshot_start[0]_i_1_n_0\
    );
\snapshot_start[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => \write_pointer_reg__0\(1),
      I1 => \write_pointer_reg__0\(0),
      I2 => \snapshot_start[7]_i_3_n_0\,
      O => \snapshot_start[1]_i_1_n_0\
    );
\snapshot_start[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0078"
    )
        port map (
      I0 => \write_pointer_reg__0\(0),
      I1 => \write_pointer_reg__0\(1),
      I2 => \write_pointer_reg__0\(2),
      I3 => \snapshot_start[7]_i_3_n_0\,
      O => \snapshot_start[2]_i_1_n_0\
    );
\snapshot_start[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00007F80"
    )
        port map (
      I0 => \write_pointer_reg__0\(2),
      I1 => \write_pointer_reg__0\(1),
      I2 => \write_pointer_reg__0\(0),
      I3 => \write_pointer_reg__0\(3),
      I4 => \snapshot_start[7]_i_3_n_0\,
      O => \snapshot_start[3]_i_1_n_0\
    );
\snapshot_start[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000000007FFF8000"
    )
        port map (
      I0 => \write_pointer_reg__0\(3),
      I1 => \write_pointer_reg__0\(0),
      I2 => \write_pointer_reg__0\(1),
      I3 => \write_pointer_reg__0\(2),
      I4 => \write_pointer_reg__0\(4),
      I5 => \snapshot_start[7]_i_3_n_0\,
      O => \snapshot_start[4]_i_1_n_0\
    );
\snapshot_start[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => next_write_pointer(5),
      I1 => \snapshot_start[7]_i_3_n_0\,
      O => \snapshot_start[5]_i_1_n_0\
    );
\snapshot_start[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"06"
    )
        port map (
      I0 => \snapshot_start[7]_i_2_n_0\,
      I1 => \write_pointer_reg__0\(6),
      I2 => \snapshot_start[7]_i_3_n_0\,
      O => \snapshot_start[6]_i_1_n_0\
    );
\snapshot_start[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"006A"
    )
        port map (
      I0 => \write_pointer_reg__0\(7),
      I1 => \snapshot_start[7]_i_2_n_0\,
      I2 => \write_pointer_reg__0\(6),
      I3 => \snapshot_start[7]_i_3_n_0\,
      O => next_snapshot_start(7)
    );
\snapshot_start[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \write_pointer_reg__0\(5),
      I1 => \write_pointer_reg__0\(3),
      I2 => \write_pointer_reg__0\(0),
      I3 => \write_pointer_reg__0\(1),
      I4 => \write_pointer_reg__0\(2),
      I5 => \write_pointer_reg__0\(4),
      O => \snapshot_start[7]_i_2_n_0\
    );
\snapshot_start[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF7FFFFFFE"
    )
        port map (
      I0 => \capture_count_reg__0\(4),
      I1 => \snapshot_count[7]_i_2_n_0\,
      I2 => \capture_count_reg__0\(7),
      I3 => \capture_count_reg__0\(5),
      I4 => \capture_count_reg__0\(6),
      I5 => \snapshot_start[7]_i_4_n_0\,
      O => \snapshot_start[7]_i_3_n_0\
    );
\snapshot_start[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEFFFF7FFEFF"
    )
        port map (
      I0 => \capture_count_reg__0\(3),
      I1 => \capture_count_reg__0\(2),
      I2 => \capture_count_reg__0\(0),
      I3 => \capture_count_reg__0\(8),
      I4 => \capture_count_reg__0\(1),
      I5 => \snapshot_count[8]_i_4_n_0\,
      O => \snapshot_start[7]_i_4_n_0\
    );
\snapshot_start_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => \snapshot_start[0]_i_1_n_0\,
      Q => \snapshot_start_reg_n_0_[0]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_start_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => \snapshot_start[1]_i_1_n_0\,
      Q => \snapshot_start_reg_n_0_[1]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_start_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => \snapshot_start[2]_i_1_n_0\,
      Q => \snapshot_start_reg_n_0_[2]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_start_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => \snapshot_start[3]_i_1_n_0\,
      Q => \snapshot_start_reg_n_0_[3]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_start_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => \snapshot_start[4]_i_1_n_0\,
      Q => \snapshot_start_reg_n_0_[4]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_start_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => \snapshot_start[5]_i_1_n_0\,
      Q => \snapshot_start_reg_n_0_[5]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_start_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => \snapshot_start[6]_i_1_n_0\,
      Q => \snapshot_start_reg_n_0_[6]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_start_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => next_snapshot_start(7),
      Q => \snapshot_start_reg_n_0_[7]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
snapshot_trigger_index0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => snapshot_trigger_index0_carry_n_0,
      CO(2) => snapshot_trigger_index0_carry_n_1,
      CO(1) => snapshot_trigger_index0_carry_n_2,
      CO(0) => snapshot_trigger_index0_carry_n_3,
      CYINIT => '1',
      DI(3) => \trigger_physical_index_reg_n_0_[3]\,
      DI(2) => \trigger_physical_index_reg_n_0_[2]\,
      DI(1) => \trigger_physical_index_reg_n_0_[1]\,
      DI(0) => \trigger_physical_index_reg_n_0_[0]\,
      O(3 downto 0) => snapshot_trigger_index00_out(3 downto 0),
      S(3) => snapshot_trigger_index0_carry_i_1_n_0,
      S(2) => snapshot_trigger_index0_carry_i_2_n_0,
      S(1) => snapshot_trigger_index0_carry_i_3_n_0,
      S(0) => snapshot_trigger_index0_carry_i_4_n_0
    );
\snapshot_trigger_index0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => snapshot_trigger_index0_carry_n_0,
      CO(3) => \NLW_snapshot_trigger_index0_carry__0_CO_UNCONNECTED\(3),
      CO(2) => \snapshot_trigger_index0_carry__0_n_1\,
      CO(1) => \snapshot_trigger_index0_carry__0_n_2\,
      CO(0) => \snapshot_trigger_index0_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => \trigger_physical_index_reg_n_0_[6]\,
      DI(1) => \trigger_physical_index_reg_n_0_[5]\,
      DI(0) => \trigger_physical_index_reg_n_0_[4]\,
      O(3 downto 0) => snapshot_trigger_index00_out(7 downto 4),
      S(3) => \snapshot_trigger_index0_carry__0_i_1_n_0\,
      S(2) => \snapshot_trigger_index0_carry__0_i_2_n_0\,
      S(1) => \snapshot_trigger_index0_carry__0_i_3_n_0\,
      S(0) => \snapshot_trigger_index0_carry__0_i_4_n_0\
    );
\snapshot_trigger_index0_carry__0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55556999"
    )
        port map (
      I0 => \trigger_physical_index_reg_n_0_[7]\,
      I1 => \write_pointer_reg__0\(7),
      I2 => \snapshot_start[7]_i_2_n_0\,
      I3 => \write_pointer_reg__0\(6),
      I4 => \snapshot_start[7]_i_3_n_0\,
      O => \snapshot_trigger_index0_carry__0_i_1_n_0\
    );
\snapshot_trigger_index0_carry__0_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5665"
    )
        port map (
      I0 => \trigger_physical_index_reg_n_0_[6]\,
      I1 => \snapshot_start[7]_i_3_n_0\,
      I2 => \write_pointer_reg__0\(6),
      I3 => \snapshot_start[7]_i_2_n_0\,
      O => \snapshot_trigger_index0_carry__0_i_2_n_0\
    );
\snapshot_trigger_index0_carry__0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"65"
    )
        port map (
      I0 => \trigger_physical_index_reg_n_0_[5]\,
      I1 => \snapshot_start[7]_i_3_n_0\,
      I2 => next_write_pointer(5),
      O => \snapshot_trigger_index0_carry__0_i_3_n_0\
    );
\snapshot_trigger_index0_carry__0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"65"
    )
        port map (
      I0 => \trigger_physical_index_reg_n_0_[4]\,
      I1 => \snapshot_start[7]_i_3_n_0\,
      I2 => next_write_pointer(4),
      O => \snapshot_trigger_index0_carry__0_i_4_n_0\
    );
snapshot_trigger_index0_carry_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5665656565656565"
    )
        port map (
      I0 => \trigger_physical_index_reg_n_0_[3]\,
      I1 => \snapshot_start[7]_i_3_n_0\,
      I2 => \write_pointer_reg__0\(3),
      I3 => \write_pointer_reg__0\(0),
      I4 => \write_pointer_reg__0\(1),
      I5 => \write_pointer_reg__0\(2),
      O => snapshot_trigger_index0_carry_i_1_n_0
    );
snapshot_trigger_index0_carry_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"56656565"
    )
        port map (
      I0 => \trigger_physical_index_reg_n_0_[2]\,
      I1 => \snapshot_start[7]_i_3_n_0\,
      I2 => \write_pointer_reg__0\(2),
      I3 => \write_pointer_reg__0\(1),
      I4 => \write_pointer_reg__0\(0),
      O => snapshot_trigger_index0_carry_i_2_n_0
    );
snapshot_trigger_index0_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5665"
    )
        port map (
      I0 => \trigger_physical_index_reg_n_0_[1]\,
      I1 => \snapshot_start[7]_i_3_n_0\,
      I2 => \write_pointer_reg__0\(0),
      I3 => \write_pointer_reg__0\(1),
      O => snapshot_trigger_index0_carry_i_3_n_0
    );
snapshot_trigger_index0_carry_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"56"
    )
        port map (
      I0 => \trigger_physical_index_reg_n_0_[0]\,
      I1 => \snapshot_start[7]_i_3_n_0\,
      I2 => \write_pointer_reg__0\(0),
      O => snapshot_trigger_index0_carry_i_4_n_0
    );
\snapshot_trigger_index_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => snapshot_trigger_index00_out(0),
      Q => snapshot_trigger_index(0),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_trigger_index_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => snapshot_trigger_index00_out(1),
      Q => snapshot_trigger_index(1),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_trigger_index_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => snapshot_trigger_index00_out(2),
      Q => snapshot_trigger_index(2),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_trigger_index_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => snapshot_trigger_index00_out(3),
      Q => snapshot_trigger_index(3),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_trigger_index_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => snapshot_trigger_index00_out(4),
      Q => snapshot_trigger_index(4),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_trigger_index_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => snapshot_trigger_index00_out(5),
      Q => snapshot_trigger_index(5),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_trigger_index_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => snapshot_trigger_index00_out(6),
      Q => snapshot_trigger_index(6),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_trigger_index_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \snapshot_count[8]_i_2_n_0\,
      D => snapshot_trigger_index00_out(7),
      Q => snapshot_trigger_index(7),
      R => \snapshot_count[8]_i_1_n_0\
    );
\snapshot_word_select[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1000000000000000"
    )
        port map (
      I0 => \s_axi_rdata_reg[31]\,
      I1 => \s_axi_rdata[31]_i_6_n_0\,
      I2 => CO(0),
      I3 => snapshot_ready,
      I4 => \snapshot_rd_index_reg[0]\,
      I5 => s_axi_arvalid,
      O => \^snapshot_ready_reg_0\(0)
    );
\timestamp_shadow[63]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_araddr(10),
      I2 => \timestamp_shadow_reg[32]\,
      I3 => s_axi_araddr(12),
      I4 => s_axi_araddr(13),
      I5 => \timestamp_shadow[63]_i_3_n_0\,
      O => \s_axi_araddr[0]\(0)
    );
\timestamp_shadow[63]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFEFFFFF"
    )
        port map (
      I0 => s_axi_araddr(11),
      I1 => s_axi_araddr(14),
      I2 => s_axi_araddr(4),
      I3 => s_axi_araddr(3),
      I4 => \timestamp_shadow[63]_i_4_n_0\,
      I5 => \timestamp_shadow_reg[32]_0\,
      O => \timestamp_shadow[63]_i_3_n_0\
    );
\timestamp_shadow[63]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0888"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => \snapshot_rd_index_reg[0]\,
      I2 => \s_axi_rdata_reg[0]\,
      I3 => snapshot_rd_valid,
      O => \timestamp_shadow[63]_i_4_n_0\
    );
\trigger_physical_index[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00008A80"
    )
        port map (
      I0 => capture_active111_out,
      I1 => ext_evt_trigger,
      I2 => \dropped_count_reg_reg[0]_2\,
      I3 => \post_remaining_reg[1]_0\,
      I4 => trigger_seen_reg_n_0,
      O => trigger_seen8_out
    );
\trigger_physical_index_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => trigger_seen8_out,
      D => \write_pointer_reg__0\(0),
      Q => \trigger_physical_index_reg_n_0_[0]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\trigger_physical_index_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => trigger_seen8_out,
      D => \write_pointer_reg__0\(1),
      Q => \trigger_physical_index_reg_n_0_[1]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\trigger_physical_index_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => trigger_seen8_out,
      D => \write_pointer_reg__0\(2),
      Q => \trigger_physical_index_reg_n_0_[2]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\trigger_physical_index_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => trigger_seen8_out,
      D => \write_pointer_reg__0\(3),
      Q => \trigger_physical_index_reg_n_0_[3]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\trigger_physical_index_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => trigger_seen8_out,
      D => \write_pointer_reg__0\(4),
      Q => \trigger_physical_index_reg_n_0_[4]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\trigger_physical_index_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => trigger_seen8_out,
      D => \write_pointer_reg__0\(5),
      Q => \trigger_physical_index_reg_n_0_[5]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\trigger_physical_index_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => trigger_seen8_out,
      D => \write_pointer_reg__0\(6),
      Q => \trigger_physical_index_reg_n_0_[6]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
\trigger_physical_index_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => trigger_seen8_out,
      D => \write_pointer_reg__0\(7),
      Q => \trigger_physical_index_reg_n_0_[7]\,
      R => \snapshot_count[8]_i_1_n_0\
    );
trigger_seen_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EAEEEAAA"
    )
        port map (
      I0 => trigger_seen_reg_n_0,
      I1 => capture_active111_out,
      I2 => ext_evt_trigger,
      I3 => \dropped_count_reg_reg[0]_2\,
      I4 => \post_remaining_reg[1]_0\,
      I5 => \snapshot_count[8]_i_1_n_0\,
      O => trigger_seen_i_1_n_0
    );
trigger_seen_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => trigger_seen_i_1_n_0,
      Q => trigger_seen_reg_n_0,
      R => '0'
    );
\write_pointer[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \write_pointer_reg__0\(0),
      O => next_write_pointer(0)
    );
\write_pointer[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \write_pointer_reg__0\(0),
      I1 => \write_pointer_reg__0\(1),
      O => next_write_pointer(1)
    );
\write_pointer[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \write_pointer_reg__0\(2),
      I1 => \write_pointer_reg__0\(1),
      I2 => \write_pointer_reg__0\(0),
      O => next_write_pointer(2)
    );
\write_pointer[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \write_pointer_reg__0\(3),
      I1 => \write_pointer_reg__0\(0),
      I2 => \write_pointer_reg__0\(1),
      I3 => \write_pointer_reg__0\(2),
      O => next_write_pointer(3)
    );
\write_pointer[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \write_pointer_reg__0\(4),
      I1 => \write_pointer_reg__0\(2),
      I2 => \write_pointer_reg__0\(1),
      I3 => \write_pointer_reg__0\(0),
      I4 => \write_pointer_reg__0\(3),
      O => next_write_pointer(4)
    );
\write_pointer[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => \write_pointer_reg__0\(5),
      I1 => \write_pointer_reg__0\(3),
      I2 => \write_pointer_reg__0\(0),
      I3 => \write_pointer_reg__0\(1),
      I4 => \write_pointer_reg__0\(2),
      I5 => \write_pointer_reg__0\(4),
      O => next_write_pointer(5)
    );
\write_pointer[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \write_pointer_reg__0\(6),
      I1 => \snapshot_start[7]_i_2_n_0\,
      O => next_write_pointer(6)
    );
\write_pointer[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \write_pointer_reg__0\(7),
      I1 => \snapshot_start[7]_i_2_n_0\,
      I2 => \write_pointer_reg__0\(6),
      O => next_write_pointer(7)
    );
\write_pointer_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => next_write_pointer(0),
      Q => \write_pointer_reg__0\(0),
      R => \snapshot_count[8]_i_1_n_0\
    );
\write_pointer_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => next_write_pointer(1),
      Q => \write_pointer_reg__0\(1),
      R => \snapshot_count[8]_i_1_n_0\
    );
\write_pointer_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => next_write_pointer(2),
      Q => \write_pointer_reg__0\(2),
      R => \snapshot_count[8]_i_1_n_0\
    );
\write_pointer_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => next_write_pointer(3),
      Q => \write_pointer_reg__0\(3),
      R => \snapshot_count[8]_i_1_n_0\
    );
\write_pointer_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => next_write_pointer(4),
      Q => \write_pointer_reg__0\(4),
      R => \snapshot_count[8]_i_1_n_0\
    );
\write_pointer_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => next_write_pointer(5),
      Q => \write_pointer_reg__0\(5),
      R => \snapshot_count[8]_i_1_n_0\
    );
\write_pointer_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => next_write_pointer(6),
      Q => \write_pointer_reg__0\(6),
      R => \snapshot_count[8]_i_1_n_0\
    );
\write_pointer_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_active111_out,
      D => next_write_pointer(7),
      Q => \write_pointer_reg__0\(7),
      R => \snapshot_count[8]_i_1_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity multi_protocol_bd_multi_protocol_core_0_0_multi_protocol_core is
  port (
    s_axi_arready : out STD_LOGIC;
    led_heartbeat : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    led_ps_active : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ext_evt_ready : out STD_LOGIC;
    s_axi_bvalid_reg_0 : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aresetn : in STD_LOGIC;
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 15 downto 0 );
    ext_evt_valid : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    ext_evt_trigger : in STD_LOGIC;
    ext_evt_data : in STD_LOGIC_VECTOR ( 127 downto 0 );
    ext_evt_dropped_count : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_bready : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of multi_protocol_bd_multi_protocol_core_0_0_multi_protocol_core : entity is "multi_protocol_core";
end multi_protocol_bd_multi_protocol_core_0_0_multi_protocol_core;

architecture STRUCTURE of multi_protocol_bd_multi_protocol_core_0_0_multi_protocol_core is
  signal aw_hs : STD_LOGIC;
  signal aw_pending : STD_LOGIC;
  signal aw_pending_i_1_n_0 : STD_LOGIC;
  signal awaddr_reg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal capture_ack_pulse_i_1_n_0 : STD_LOGIC;
  signal capture_ack_pulse_reg_n_0 : STD_LOGIC;
  signal capture_arm_pulse_i_1_n_0 : STD_LOGIC;
  signal capture_arm_pulse_i_2_n_0 : STD_LOGIC;
  signal capture_arm_pulse_i_3_n_0 : STD_LOGIC;
  signal capture_arm_pulse_i_4_n_0 : STD_LOGIC;
  signal capture_arm_pulse_i_5_n_0 : STD_LOGIC;
  signal capture_arm_pulse_reg_n_0 : STD_LOGIC;
  signal capture_buffer_n_2 : STD_LOGIC;
  signal capture_buffer_n_3 : STD_LOGIC;
  signal capture_buffer_n_38 : STD_LOGIC;
  signal capture_buffer_n_39 : STD_LOGIC;
  signal capture_buffer_n_4 : STD_LOGIC;
  signal capture_buffer_n_40 : STD_LOGIC;
  signal capture_buffer_n_41 : STD_LOGIC;
  signal capture_buffer_n_42 : STD_LOGIC;
  signal capture_buffer_n_43 : STD_LOGIC;
  signal capture_buffer_n_44 : STD_LOGIC;
  signal capture_buffer_n_45 : STD_LOGIC;
  signal capture_buffer_n_46 : STD_LOGIC;
  signal capture_buffer_n_47 : STD_LOGIC;
  signal capture_buffer_n_48 : STD_LOGIC;
  signal capture_buffer_n_49 : STD_LOGIC;
  signal capture_buffer_n_50 : STD_LOGIC;
  signal capture_buffer_n_51 : STD_LOGIC;
  signal capture_buffer_n_52 : STD_LOGIC;
  signal capture_buffer_n_53 : STD_LOGIC;
  signal capture_buffer_n_54 : STD_LOGIC;
  signal capture_buffer_n_55 : STD_LOGIC;
  signal capture_buffer_n_56 : STD_LOGIC;
  signal capture_buffer_n_57 : STD_LOGIC;
  signal capture_buffer_n_58 : STD_LOGIC;
  signal capture_buffer_n_59 : STD_LOGIC;
  signal capture_buffer_n_60 : STD_LOGIC;
  signal capture_buffer_n_61 : STD_LOGIC;
  signal capture_buffer_n_62 : STD_LOGIC;
  signal capture_buffer_n_63 : STD_LOGIC;
  signal capture_buffer_n_64 : STD_LOGIC;
  signal capture_buffer_n_65 : STD_LOGIC;
  signal capture_buffer_n_66 : STD_LOGIC;
  signal capture_buffer_n_67 : STD_LOGIC;
  signal capture_buffer_n_68 : STD_LOGIC;
  signal capture_buffer_n_69 : STD_LOGIC;
  signal capture_buffer_n_70 : STD_LOGIC;
  signal capture_buffer_n_71 : STD_LOGIC;
  signal capture_buffer_n_72 : STD_LOGIC;
  signal capture_buffer_n_73 : STD_LOGIC;
  signal capture_buffer_n_74 : STD_LOGIC;
  signal capture_buffer_n_75 : STD_LOGIC;
  signal capture_buffer_n_76 : STD_LOGIC;
  signal capture_buffer_n_77 : STD_LOGIC;
  signal capture_buffer_n_78 : STD_LOGIC;
  signal capture_buffer_n_79 : STD_LOGIC;
  signal capture_buffer_n_80 : STD_LOGIC;
  signal capture_buffer_n_81 : STD_LOGIC;
  signal capture_buffer_n_82 : STD_LOGIC;
  signal capture_event_data : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal clear : STD_LOGIC;
  signal data0 : STD_LOGIC_VECTOR ( 25 downto 1 );
  signal data5 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal dropped_count_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal dropped_count_reg0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal dropped_count_reg00_in : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal \dropped_count_reg0_carry__0_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__0_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__0_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__0_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__1_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__1_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__1_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__1_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__2_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__2_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__2_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__2_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__3_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__3_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__3_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__3_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__4_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__4_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__4_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__4_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__5_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__5_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__5_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__5_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__6_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__6_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_carry__6_n_3\ : STD_LOGIC;
  signal dropped_count_reg0_carry_i_1_n_0 : STD_LOGIC;
  signal dropped_count_reg0_carry_n_0 : STD_LOGIC;
  signal dropped_count_reg0_carry_n_1 : STD_LOGIC;
  signal dropped_count_reg0_carry_n_2 : STD_LOGIC;
  signal dropped_count_reg0_carry_n_3 : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__0_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__0_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__0_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__0_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__1_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__1_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__1_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__1_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__2_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__2_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__2_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__2_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__3_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__3_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__3_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__3_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__4_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__4_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__4_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__4_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__5_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__5_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__5_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__5_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__6_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry__6_n_3\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry_n_0\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry_n_1\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry_n_2\ : STD_LOGIC;
  signal \dropped_count_reg0_inferred__0/i__carry_n_3\ : STD_LOGIC;
  signal \dropped_count_reg[31]_i_10_n_0\ : STD_LOGIC;
  signal \dropped_count_reg[31]_i_11_n_0\ : STD_LOGIC;
  signal \dropped_count_reg[31]_i_1_n_0\ : STD_LOGIC;
  signal \dropped_count_reg[31]_i_4_n_0\ : STD_LOGIC;
  signal \dropped_count_reg[31]_i_5_n_0\ : STD_LOGIC;
  signal \dropped_count_reg[31]_i_8_n_0\ : STD_LOGIC;
  signal \dropped_count_reg[31]_i_9_n_0\ : STD_LOGIC;
  signal event_arbiter_n_0 : STD_LOGIC;
  signal event_arbiter_n_10 : STD_LOGIC;
  signal event_arbiter_n_11 : STD_LOGIC;
  signal event_arbiter_n_12 : STD_LOGIC;
  signal event_arbiter_n_13 : STD_LOGIC;
  signal event_arbiter_n_14 : STD_LOGIC;
  signal event_arbiter_n_149 : STD_LOGIC;
  signal event_arbiter_n_150 : STD_LOGIC;
  signal event_arbiter_n_151 : STD_LOGIC;
  signal event_arbiter_n_152 : STD_LOGIC;
  signal event_arbiter_n_153 : STD_LOGIC;
  signal event_arbiter_n_154 : STD_LOGIC;
  signal event_arbiter_n_155 : STD_LOGIC;
  signal event_arbiter_n_156 : STD_LOGIC;
  signal event_arbiter_n_157 : STD_LOGIC;
  signal event_arbiter_n_158 : STD_LOGIC;
  signal event_arbiter_n_159 : STD_LOGIC;
  signal event_arbiter_n_16 : STD_LOGIC;
  signal event_arbiter_n_160 : STD_LOGIC;
  signal event_arbiter_n_161 : STD_LOGIC;
  signal event_arbiter_n_162 : STD_LOGIC;
  signal event_arbiter_n_163 : STD_LOGIC;
  signal event_arbiter_n_164 : STD_LOGIC;
  signal event_arbiter_n_165 : STD_LOGIC;
  signal event_arbiter_n_166 : STD_LOGIC;
  signal event_arbiter_n_167 : STD_LOGIC;
  signal event_arbiter_n_168 : STD_LOGIC;
  signal event_arbiter_n_169 : STD_LOGIC;
  signal event_arbiter_n_17 : STD_LOGIC;
  signal event_arbiter_n_170 : STD_LOGIC;
  signal event_arbiter_n_171 : STD_LOGIC;
  signal event_arbiter_n_172 : STD_LOGIC;
  signal event_arbiter_n_173 : STD_LOGIC;
  signal event_arbiter_n_174 : STD_LOGIC;
  signal event_arbiter_n_175 : STD_LOGIC;
  signal event_arbiter_n_176 : STD_LOGIC;
  signal event_arbiter_n_177 : STD_LOGIC;
  signal event_arbiter_n_178 : STD_LOGIC;
  signal event_arbiter_n_179 : STD_LOGIC;
  signal event_arbiter_n_18 : STD_LOGIC;
  signal event_arbiter_n_180 : STD_LOGIC;
  signal event_arbiter_n_181 : STD_LOGIC;
  signal event_arbiter_n_19 : STD_LOGIC;
  signal event_arbiter_n_3 : STD_LOGIC;
  signal event_arbiter_n_5 : STD_LOGIC;
  signal event_arbiter_n_6 : STD_LOGIC;
  signal event_arbiter_n_7 : STD_LOGIC;
  signal event_arbiter_n_8 : STD_LOGIC;
  signal event_arbiter_n_9 : STD_LOGIC;
  signal heartbeat_counter : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal \heartbeat_counter0_carry__0_n_0\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__0_n_1\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__0_n_2\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__0_n_3\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__1_n_0\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__1_n_1\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__1_n_2\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__1_n_3\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__2_n_0\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__2_n_1\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__2_n_2\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__2_n_3\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__3_n_0\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__3_n_1\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__3_n_2\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__3_n_3\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__4_n_0\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__4_n_1\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__4_n_2\ : STD_LOGIC;
  signal \heartbeat_counter0_carry__4_n_3\ : STD_LOGIC;
  signal heartbeat_counter0_carry_n_0 : STD_LOGIC;
  signal heartbeat_counter0_carry_n_1 : STD_LOGIC;
  signal heartbeat_counter0_carry_n_2 : STD_LOGIC;
  signal heartbeat_counter0_carry_n_3 : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[0]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[10]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[11]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[12]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[13]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[14]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[15]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[16]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[17]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[18]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[19]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[1]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[20]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[21]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[22]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[23]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[24]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[25]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[2]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[3]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[4]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[5]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[6]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[7]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[8]\ : STD_LOGIC;
  signal \heartbeat_counter_reg_n_0_[9]\ : STD_LOGIC;
  signal heartbeat_state_i_1_n_0 : STD_LOGIC;
  signal heartbeat_state_i_2_n_0 : STD_LOGIC;
  signal heartbeat_state_i_3_n_0 : STD_LOGIC;
  signal heartbeat_state_i_4_n_0 : STD_LOGIC;
  signal heartbeat_state_i_5_n_0 : STD_LOGIC;
  signal heartbeat_state_i_6_n_0 : STD_LOGIC;
  signal heartbeat_state_i_7_n_0 : STD_LOGIC;
  signal heartbeat_state_i_8_n_0 : STD_LOGIC;
  signal io_mode_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \io_mode_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal \io_mode_reg[23]_i_1_n_0\ : STD_LOGIC;
  signal \io_mode_reg[31]_i_1_n_0\ : STD_LOGIC;
  signal \io_mode_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal irq_enable_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \irq_enable_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal \irq_enable_reg[23]_i_1_n_0\ : STD_LOGIC;
  signal \irq_enable_reg[31]_i_1_n_0\ : STD_LOGIC;
  signal \irq_enable_reg[31]_i_2_n_0\ : STD_LOGIC;
  signal \irq_enable_reg[31]_i_3_n_0\ : STD_LOGIC;
  signal \irq_enable_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal led_ctrl_reg : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal \led_ctrl_reg[0]_i_10_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_11_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_12_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_13_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_3_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_4_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_5_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_6_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_7_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_8_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[0]_i_9_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[10]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[11]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[13]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[14]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[15]_i_2_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[15]_i_3_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[17]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[18]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[19]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[21]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[22]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[23]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[23]_i_2_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[23]_i_3_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[25]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[26]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[27]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[28]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[29]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[30]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[31]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[31]_i_3_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[5]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[6]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \led_ctrl_reg[9]_i_1_n_0\ : STD_LOGIC;
  signal \^led_heartbeat\ : STD_LOGIC;
  signal \^led_ps_active\ : STD_LOGIC;
  signal p_0_in10_in : STD_LOGIC;
  signal p_0_in13_in : STD_LOGIC;
  signal p_0_in15_in : STD_LOGIC;
  signal \p_1_in__0\ : STD_LOGIC_VECTOR ( 31 downto 7 );
  signal \p_2_in__0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal p_3_in : STD_LOGIC;
  signal \^s_axi_arready\ : STD_LOGIC;
  signal s_axi_arready0 : STD_LOGIC;
  signal \^s_axi_awready\ : STD_LOGIC;
  signal s_axi_awready0 : STD_LOGIC;
  signal s_axi_bvalid_i_1_n_0 : STD_LOGIC;
  signal \^s_axi_bvalid_reg_0\ : STD_LOGIC;
  signal s_axi_rdata2 : STD_LOGIC;
  signal s_axi_rdata2_carry_n_0 : STD_LOGIC;
  signal s_axi_rdata2_carry_n_1 : STD_LOGIC;
  signal s_axi_rdata2_carry_n_2 : STD_LOGIC;
  signal s_axi_rdata2_carry_n_3 : STD_LOGIC;
  signal \s_axi_rdata[0]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[0]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[10]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[10]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[11]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[11]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[12]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[12]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[13]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[13]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[14]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[14]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[15]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[15]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[16]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[16]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[17]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[17]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[18]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[18]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[19]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[19]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[1]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[1]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[20]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[20]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[21]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[21]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[22]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[22]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[23]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[23]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[24]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[24]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[25]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[25]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[26]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[26]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[27]_i_10_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[27]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[27]_i_9_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[28]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[28]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[29]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[29]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[29]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[29]_i_9_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[2]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[2]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[30]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[30]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[30]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[30]_i_9_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_10_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_11_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_12_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_13_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_14_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_16_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_4_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[31]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_10_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_11_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_12_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_13_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_14_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_15_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_16_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_17_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_18_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_19_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_20_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_21_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_22_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_23_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_24_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_25_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_26_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_27_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_28_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_29_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_6_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[3]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[4]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[4]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[5]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[5]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[6]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[6]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[7]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[7]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[7]_i_8_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[7]_i_9_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[8]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[8]_i_7_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[9]_i_5_n_0\ : STD_LOGIC;
  signal \s_axi_rdata[9]_i_6_n_0\ : STD_LOGIC;
  signal \^s_axi_rvalid\ : STD_LOGIC;
  signal \^s_axi_wready\ : STD_LOGIC;
  signal s_axi_wready0 : STD_LOGIC;
  signal scratch_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \scratch_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal \scratch_reg[23]_i_1_n_0\ : STD_LOGIC;
  signal \scratch_reg[31]_i_1_n_0\ : STD_LOGIC;
  signal \scratch_reg[31]_i_2_n_0\ : STD_LOGIC;
  signal \scratch_reg[31]_i_3_n_0\ : STD_LOGIC;
  signal \scratch_reg[31]_i_4_n_0\ : STD_LOGIC;
  signal \scratch_reg[31]_i_5_n_0\ : STD_LOGIC;
  signal \scratch_reg[31]_i_6_n_0\ : STD_LOGIC;
  signal \scratch_reg[31]_i_7_n_0\ : STD_LOGIC;
  signal \scratch_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal snapshot_count : STD_LOGIC_VECTOR ( 8 to 8 );
  signal snapshot_rd_en : STD_LOGIC;
  signal snapshot_rd_index : STD_LOGIC;
  signal \snapshot_rd_index_reg_n_0_[0]\ : STD_LOGIC;
  signal \snapshot_rd_index_reg_n_0_[1]\ : STD_LOGIC;
  signal \snapshot_rd_index_reg_n_0_[2]\ : STD_LOGIC;
  signal \snapshot_rd_index_reg_n_0_[3]\ : STD_LOGIC;
  signal \snapshot_rd_index_reg_n_0_[4]\ : STD_LOGIC;
  signal \snapshot_rd_index_reg_n_0_[5]\ : STD_LOGIC;
  signal \snapshot_rd_index_reg_n_0_[6]\ : STD_LOGIC;
  signal \snapshot_rd_index_reg_n_0_[7]\ : STD_LOGIC;
  signal snapshot_read_pending_reg_n_0 : STD_LOGIC;
  signal snapshot_word_select : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal sys_ctrl_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \sys_ctrl_reg[31]_i_2_n_0\ : STD_LOGIC;
  signal \sys_ctrl_reg[31]_i_3_n_0\ : STD_LOGIC;
  signal \timestamp_counter[0]_i_2_n_0\ : STD_LOGIC;
  signal timestamp_counter_reg : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal \timestamp_counter_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[28]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[28]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[32]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[32]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[32]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[32]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[32]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[32]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[32]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[32]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[36]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[36]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[36]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[36]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[36]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[36]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[36]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[36]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[40]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[40]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[40]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[40]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[40]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[40]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[40]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[40]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[44]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[44]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[44]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[44]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[44]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[44]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[44]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[44]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[48]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[48]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[48]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[48]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[48]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[48]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[48]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[48]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[52]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[52]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[52]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[52]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[52]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[52]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[52]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[52]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[56]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[56]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[56]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[56]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[56]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[56]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[56]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[56]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[60]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[60]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[60]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[60]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[60]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[60]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[60]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_counter_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \timestamp_counter_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \timestamp_counter_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \timestamp_counter_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \timestamp_counter_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \timestamp_counter_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \timestamp_counter_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \timestamp_counter_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \timestamp_shadow[63]_i_2_n_0\ : STD_LOGIC;
  signal \timestamp_shadow[63]_i_5_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[0]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[10]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[11]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[127]_i_2_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[127]_i_3_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[127]_i_4_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[127]_i_5_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[127]_i_6_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[127]_i_7_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[12]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[13]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[14]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[15]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[16]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[17]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[18]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[19]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[1]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[20]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[21]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[22]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[23]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[2]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[32]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[3]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[49]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[4]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[5]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[6]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[7]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[8]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data[9]_i_1_n_0\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[100]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[101]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[102]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[103]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[104]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[105]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[106]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[107]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[108]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[109]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[10]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[110]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[111]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[112]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[113]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[114]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[115]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[116]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[117]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[118]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[119]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[11]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[120]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[121]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[122]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[123]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[124]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[125]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[126]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[127]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[12]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[13]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[14]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[15]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[16]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[17]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[18]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[19]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[1]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[20]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[21]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[22]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[23]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[2]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[32]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[3]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[48]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[49]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[4]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[55]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[5]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[64]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[65]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[66]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[67]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[68]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[69]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[6]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[70]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[71]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[72]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[73]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[74]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[75]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[76]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[77]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[78]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[79]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[7]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[80]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[81]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[82]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[83]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[84]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[85]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[86]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[87]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[88]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[89]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[8]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[90]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[91]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[92]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[93]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[94]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[95]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[96]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[97]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[98]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[99]\ : STD_LOGIC;
  signal \virtual_evt_data_reg_n_0_[9]\ : STD_LOGIC;
  signal virtual_evt_trigger_i_2_n_0 : STD_LOGIC;
  signal virtual_evt_trigger_i_3_n_0 : STD_LOGIC;
  signal virtual_evt_trigger_i_4_n_0 : STD_LOGIC;
  signal virtual_evt_trigger_i_5_n_0 : STD_LOGIC;
  signal virtual_evt_trigger_reg_n_0 : STD_LOGIC;
  signal virtual_evt_valid7_out : STD_LOGIC;
  signal virtual_evt_valid_i_2_n_0 : STD_LOGIC;
  signal virtual_evt_valid_i_3_n_0 : STD_LOGIC;
  signal virtual_evt_valid_i_5_n_0 : STD_LOGIC;
  signal virtual_evt_valid_reg_n_0 : STD_LOGIC;
  signal w_hs : STD_LOGIC;
  signal w_pending_i_1_n_0 : STD_LOGIC;
  signal w_pending_reg_n_0 : STD_LOGIC;
  signal wdata_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal write_addr : STD_LOGIC_VECTOR ( 4 to 4 );
  signal wstrb_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_dropped_count_reg0_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_dropped_count_reg0_inferred__0/i__carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_dropped_count_reg0_inferred__0/i__carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_heartbeat_counter0_carry__5_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_heartbeat_counter0_carry__5_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_s_axi_rdata2_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_s_axi_rdata2_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_s_axi_rdata2_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_timestamp_counter_reg[60]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \dropped_count_reg[31]_i_11\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \dropped_count_reg[31]_i_8\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \heartbeat_counter[10]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \heartbeat_counter[11]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \heartbeat_counter[12]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \heartbeat_counter[13]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \heartbeat_counter[14]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \heartbeat_counter[15]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \heartbeat_counter[16]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \heartbeat_counter[17]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \heartbeat_counter[18]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \heartbeat_counter[19]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \heartbeat_counter[1]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \heartbeat_counter[20]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \heartbeat_counter[21]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \heartbeat_counter[22]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \heartbeat_counter[23]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \heartbeat_counter[24]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \heartbeat_counter[25]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \heartbeat_counter[2]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \heartbeat_counter[3]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \heartbeat_counter[4]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \heartbeat_counter[5]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \heartbeat_counter[6]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \heartbeat_counter[7]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \heartbeat_counter[8]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \heartbeat_counter[9]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of heartbeat_state_i_1 : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \led_ctrl_reg[0]_i_10\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \led_ctrl_reg[0]_i_11\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \led_ctrl_reg[0]_i_12\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \led_ctrl_reg[0]_i_13\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \led_ctrl_reg[0]_i_6\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \led_ctrl_reg[0]_i_9\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \led_ctrl_reg[10]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \led_ctrl_reg[11]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \led_ctrl_reg[12]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \led_ctrl_reg[13]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \led_ctrl_reg[14]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \led_ctrl_reg[15]_i_2\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \led_ctrl_reg[16]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \led_ctrl_reg[17]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \led_ctrl_reg[18]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \led_ctrl_reg[19]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \led_ctrl_reg[1]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \led_ctrl_reg[20]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \led_ctrl_reg[21]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \led_ctrl_reg[22]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \led_ctrl_reg[23]_i_2\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \led_ctrl_reg[23]_i_3\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \led_ctrl_reg[24]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \led_ctrl_reg[25]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \led_ctrl_reg[26]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \led_ctrl_reg[27]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \led_ctrl_reg[28]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \led_ctrl_reg[29]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \led_ctrl_reg[2]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \led_ctrl_reg[30]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \led_ctrl_reg[31]_i_2\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \led_ctrl_reg[3]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \led_ctrl_reg[5]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \led_ctrl_reg[6]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \led_ctrl_reg[7]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \led_ctrl_reg[8]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \led_ctrl_reg[9]_i_1\ : label is "soft_lutpair42";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of s_axi_arready_reg : label is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute SOFT_HLUTNM of s_axi_awready_i_2 : label is "soft_lutpair33";
  attribute X_INTERFACE_INFO of s_axi_awready_reg : label is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute X_INTERFACE_INFO of s_axi_bvalid_reg : label is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute SOFT_HLUTNM of \s_axi_rdata[29]_i_8\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \s_axi_rdata[30]_i_8\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \s_axi_rdata[30]_i_9\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \s_axi_rdata[31]_i_11\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \s_axi_rdata[31]_i_12\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \s_axi_rdata[31]_i_13\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \s_axi_rdata[31]_i_16\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \s_axi_rdata[31]_i_4\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \s_axi_rdata[7]_i_7\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \s_axi_rdata[7]_i_8\ : label is "soft_lutpair29";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[0]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[10]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[11]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[12]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[13]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[14]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[15]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[16]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[17]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[18]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[19]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[1]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[20]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[21]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[22]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[23]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[24]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[25]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[26]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[27]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[28]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[29]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[2]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[30]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[31]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[3]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[4]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[5]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[6]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[7]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[8]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of \s_axi_rdata_reg[9]\ : label is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of s_axi_rvalid_reg : label is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute SOFT_HLUTNM of s_axi_wready_i_1 : label is "soft_lutpair25";
  attribute X_INTERFACE_INFO of s_axi_wready_reg : label is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute SOFT_HLUTNM of \scratch_reg[31]_i_7\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \virtual_evt_data[127]_i_5\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \virtual_evt_data[127]_i_7\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \virtual_evt_data[49]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of virtual_evt_trigger_i_5 : label is "soft_lutpair23";
begin
  led_heartbeat <= \^led_heartbeat\;
  led_ps_active <= \^led_ps_active\;
  s_axi_arready <= \^s_axi_arready\;
  s_axi_awready <= \^s_axi_awready\;
  s_axi_bvalid_reg_0 <= \^s_axi_bvalid_reg_0\;
  s_axi_rvalid <= \^s_axi_rvalid\;
  s_axi_wready <= \^s_axi_wready\;
aw_pending_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F1F1F10000000000"
    )
        port map (
      I0 => w_pending_reg_n_0,
      I1 => w_hs,
      I2 => \^s_axi_bvalid_reg_0\,
      I3 => aw_hs,
      I4 => aw_pending,
      I5 => s_axi_aresetn,
      O => aw_pending_i_1_n_0
    );
aw_pending_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => aw_pending_i_1_n_0,
      Q => aw_pending,
      R => '0'
    );
\awaddr_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(0),
      Q => awaddr_reg(0),
      R => clear
    );
\awaddr_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(10),
      Q => awaddr_reg(10),
      R => clear
    );
\awaddr_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(11),
      Q => awaddr_reg(11),
      R => clear
    );
\awaddr_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(12),
      Q => awaddr_reg(12),
      R => clear
    );
\awaddr_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(13),
      Q => awaddr_reg(13),
      R => clear
    );
\awaddr_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(14),
      Q => awaddr_reg(14),
      R => clear
    );
\awaddr_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(15),
      Q => awaddr_reg(15),
      R => clear
    );
\awaddr_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(1),
      Q => awaddr_reg(1),
      R => clear
    );
\awaddr_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(2),
      Q => awaddr_reg(2),
      R => clear
    );
\awaddr_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(3),
      Q => awaddr_reg(3),
      R => clear
    );
\awaddr_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(4),
      Q => awaddr_reg(4),
      R => clear
    );
\awaddr_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(5),
      Q => awaddr_reg(5),
      R => clear
    );
\awaddr_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(6),
      Q => awaddr_reg(6),
      R => clear
    );
\awaddr_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(7),
      Q => awaddr_reg(7),
      R => clear
    );
\awaddr_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(8),
      Q => awaddr_reg(8),
      R => clear
    );
\awaddr_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => aw_hs,
      D => s_axi_awaddr(9),
      Q => awaddr_reg(9),
      R => clear
    );
capture_ack_pulse_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00001000"
    )
        port map (
      I0 => capture_arm_pulse_i_2_n_0,
      I1 => capture_arm_pulse_i_3_n_0,
      I2 => p_0_in15_in,
      I3 => s_axi_aresetn,
      I4 => capture_arm_pulse_i_4_n_0,
      O => capture_ack_pulse_i_1_n_0
    );
capture_ack_pulse_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => capture_ack_pulse_i_1_n_0,
      Q => capture_ack_pulse_reg_n_0,
      R => '0'
    );
capture_arm_pulse_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00001000"
    )
        port map (
      I0 => capture_arm_pulse_i_2_n_0,
      I1 => capture_arm_pulse_i_3_n_0,
      I2 => event_arbiter_n_6,
      I3 => s_axi_aresetn,
      I4 => capture_arm_pulse_i_4_n_0,
      O => capture_arm_pulse_i_1_n_0
    );
capture_arm_pulse_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFEFFFEEE"
    )
        port map (
      I0 => event_arbiter_n_19,
      I1 => event_arbiter_n_18,
      I2 => awaddr_reg(11),
      I3 => aw_pending,
      I4 => s_axi_awaddr(11),
      I5 => \led_ctrl_reg[0]_i_10_n_0\,
      O => capture_arm_pulse_i_2_n_0
    );
capture_arm_pulse_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFEFFFF"
    )
        port map (
      I0 => capture_arm_pulse_i_5_n_0,
      I1 => event_arbiter_n_14,
      I2 => write_addr(4),
      I3 => event_arbiter_n_10,
      I4 => event_arbiter_n_12,
      I5 => \dropped_count_reg[31]_i_8_n_0\,
      O => capture_arm_pulse_i_3_n_0
    );
capture_arm_pulse_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F1F1F1F1F1FFFFFF"
    )
        port map (
      I0 => w_pending_reg_n_0,
      I1 => w_hs,
      I2 => \^s_axi_bvalid_reg_0\,
      I3 => \^s_axi_awready\,
      I4 => s_axi_awvalid,
      I5 => aw_pending,
      O => capture_arm_pulse_i_4_n_0
    );
capture_arm_pulse_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => s_axi_awaddr(5),
      I1 => awaddr_reg(5),
      I2 => s_axi_awaddr(2),
      I3 => aw_pending,
      I4 => awaddr_reg(2),
      O => capture_arm_pulse_i_5_n_0
    );
capture_arm_pulse_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => capture_arm_pulse_i_1_n_0,
      Q => capture_arm_pulse_reg_n_0,
      R => '0'
    );
capture_buffer: entity work.multi_protocol_bd_multi_protocol_core_0_0_event_snapshot_buffer
     port map (
      CO(0) => s_axi_rdata2,
      D(31 downto 0) => \p_2_in__0\(31 downto 0),
      DI(3) => capture_buffer_n_77,
      DI(2) => capture_buffer_n_78,
      DI(1) => capture_buffer_n_79,
      DI(0) => capture_buffer_n_80,
      E(0) => capture_buffer_n_3,
      Q(0) => snapshot_count(8),
      S(3) => capture_buffer_n_73,
      S(2) => capture_buffer_n_74,
      S(1) => capture_buffer_n_75,
      S(0) => capture_buffer_n_76,
      SR(0) => capture_buffer_n_2,
      capture_active_reg_0(0) => capture_buffer_n_38,
      capture_active_reg_1 => capture_arm_pulse_reg_n_0,
      clear => clear,
      dropped_count_reg0(31 downto 0) => dropped_count_reg0(31 downto 0),
      dropped_count_reg00_in(30 downto 0) => dropped_count_reg00_in(31 downto 1),
      \dropped_count_reg_reg[0]\ => \dropped_count_reg[31]_i_5_n_0\,
      \dropped_count_reg_reg[0]_0\ => event_arbiter_n_5,
      \dropped_count_reg_reg[0]_1\ => virtual_evt_valid_reg_n_0,
      \dropped_count_reg_reg[0]_2\ => event_arbiter_n_3,
      \dropped_count_reg_reg[31]\ => event_arbiter_n_6,
      \dropped_count_reg_reg[31]_0\ => \dropped_count_reg[31]_i_10_n_0\,
      \dropped_count_reg_reg[31]_1\ => event_arbiter_n_7,
      \dropped_count_reg_reg[31]_2\ => event_arbiter_n_8,
      \dropped_count_reg_reg[31]_3\ => event_arbiter_n_9,
      ext_evt_trigger => ext_evt_trigger,
      ext_evt_valid => ext_evt_valid,
      in_event(127 downto 0) => capture_event_data(127 downto 0),
      memory_reg_0_0(7) => \snapshot_rd_index_reg_n_0_[7]\,
      memory_reg_0_0(6) => \snapshot_rd_index_reg_n_0_[6]\,
      memory_reg_0_0(5) => \snapshot_rd_index_reg_n_0_[5]\,
      memory_reg_0_0(4) => \snapshot_rd_index_reg_n_0_[4]\,
      memory_reg_0_0(3) => \snapshot_rd_index_reg_n_0_[3]\,
      memory_reg_0_0(2) => \snapshot_rd_index_reg_n_0_[2]\,
      memory_reg_0_0(1) => \snapshot_rd_index_reg_n_0_[1]\,
      memory_reg_0_0(0) => \snapshot_rd_index_reg_n_0_[0]\,
      p_3_in => p_3_in,
      \post_remaining_reg[1]_0\ => virtual_evt_trigger_reg_n_0,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(14 downto 1) => s_axi_araddr(15 downto 2),
      s_axi_araddr(0) => s_axi_araddr(0),
      \s_axi_araddr[0]\(0) => capture_buffer_n_71,
      \s_axi_araddr[5]\(31) => capture_buffer_n_39,
      \s_axi_araddr[5]\(30) => capture_buffer_n_40,
      \s_axi_araddr[5]\(29) => capture_buffer_n_41,
      \s_axi_araddr[5]\(28) => capture_buffer_n_42,
      \s_axi_araddr[5]\(27) => capture_buffer_n_43,
      \s_axi_araddr[5]\(26) => capture_buffer_n_44,
      \s_axi_araddr[5]\(25) => capture_buffer_n_45,
      \s_axi_araddr[5]\(24) => capture_buffer_n_46,
      \s_axi_araddr[5]\(23) => capture_buffer_n_47,
      \s_axi_araddr[5]\(22) => capture_buffer_n_48,
      \s_axi_araddr[5]\(21) => capture_buffer_n_49,
      \s_axi_araddr[5]\(20) => capture_buffer_n_50,
      \s_axi_araddr[5]\(19) => capture_buffer_n_51,
      \s_axi_araddr[5]\(18) => capture_buffer_n_52,
      \s_axi_araddr[5]\(17) => capture_buffer_n_53,
      \s_axi_araddr[5]\(16) => capture_buffer_n_54,
      \s_axi_araddr[5]\(15) => capture_buffer_n_55,
      \s_axi_araddr[5]\(14) => capture_buffer_n_56,
      \s_axi_araddr[5]\(13) => capture_buffer_n_57,
      \s_axi_araddr[5]\(12) => capture_buffer_n_58,
      \s_axi_araddr[5]\(11) => capture_buffer_n_59,
      \s_axi_araddr[5]\(10) => capture_buffer_n_60,
      \s_axi_araddr[5]\(9) => capture_buffer_n_61,
      \s_axi_araddr[5]\(8) => capture_buffer_n_62,
      \s_axi_araddr[5]\(7) => capture_buffer_n_63,
      \s_axi_araddr[5]\(6) => capture_buffer_n_64,
      \s_axi_araddr[5]\(5) => capture_buffer_n_65,
      \s_axi_araddr[5]\(4) => capture_buffer_n_66,
      \s_axi_araddr[5]\(3) => capture_buffer_n_67,
      \s_axi_araddr[5]\(2) => capture_buffer_n_68,
      \s_axi_araddr[5]\(1) => capture_buffer_n_69,
      \s_axi_araddr[5]\(0) => capture_buffer_n_70,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_aresetn_0 => capture_buffer_n_4,
      s_axi_aresetn_1 => capture_buffer_n_72,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_arvalid_0 => capture_buffer_n_82,
      \s_axi_rdata_reg[0]\ => snapshot_read_pending_reg_n_0,
      \s_axi_rdata_reg[0]_0\ => event_arbiter_n_157,
      \s_axi_rdata_reg[0]_1\(1 downto 0) => snapshot_word_select(1 downto 0),
      \s_axi_rdata_reg[10]\ => event_arbiter_n_173,
      \s_axi_rdata_reg[10]_0\ => \s_axi_rdata[10]_i_5_n_0\,
      \s_axi_rdata_reg[11]\ => event_arbiter_n_172,
      \s_axi_rdata_reg[11]_0\ => \s_axi_rdata[11]_i_5_n_0\,
      \s_axi_rdata_reg[12]\ => event_arbiter_n_153,
      \s_axi_rdata_reg[13]\ => event_arbiter_n_171,
      \s_axi_rdata_reg[13]_0\ => \s_axi_rdata[13]_i_5_n_0\,
      \s_axi_rdata_reg[14]\ => event_arbiter_n_170,
      \s_axi_rdata_reg[14]_0\ => \s_axi_rdata[14]_i_5_n_0\,
      \s_axi_rdata_reg[15]\ => event_arbiter_n_169,
      \s_axi_rdata_reg[15]_0\ => \s_axi_rdata[15]_i_5_n_0\,
      \s_axi_rdata_reg[16]\ => event_arbiter_n_0,
      \s_axi_rdata_reg[17]\ => event_arbiter_n_168,
      \s_axi_rdata_reg[17]_0\ => \s_axi_rdata[17]_i_5_n_0\,
      \s_axi_rdata_reg[18]\ => event_arbiter_n_167,
      \s_axi_rdata_reg[18]_0\ => \s_axi_rdata[18]_i_5_n_0\,
      \s_axi_rdata_reg[19]\ => event_arbiter_n_166,
      \s_axi_rdata_reg[19]_0\ => \s_axi_rdata[19]_i_5_n_0\,
      \s_axi_rdata_reg[1]\ => event_arbiter_n_156,
      \s_axi_rdata_reg[20]\ => event_arbiter_n_152,
      \s_axi_rdata_reg[21]\ => event_arbiter_n_165,
      \s_axi_rdata_reg[21]_0\ => \s_axi_rdata[21]_i_5_n_0\,
      \s_axi_rdata_reg[22]\ => event_arbiter_n_151,
      \s_axi_rdata_reg[23]\ => event_arbiter_n_164,
      \s_axi_rdata_reg[23]_0\ => \s_axi_rdata[23]_i_5_n_0\,
      \s_axi_rdata_reg[24]\ => event_arbiter_n_163,
      \s_axi_rdata_reg[24]_0\ => \s_axi_rdata[24]_i_5_n_0\,
      \s_axi_rdata_reg[25]\ => event_arbiter_n_162,
      \s_axi_rdata_reg[25]_0\ => \s_axi_rdata[25]_i_5_n_0\,
      \s_axi_rdata_reg[26]\ => event_arbiter_n_150,
      \s_axi_rdata_reg[27]\ => event_arbiter_n_149,
      \s_axi_rdata_reg[27]_0\ => \s_axi_rdata[27]_i_7_n_0\,
      \s_axi_rdata_reg[28]\ => event_arbiter_n_161,
      \s_axi_rdata_reg[28]_0\ => \s_axi_rdata[28]_i_5_n_0\,
      \s_axi_rdata_reg[29]\ => event_arbiter_n_160,
      \s_axi_rdata_reg[29]_0\ => \s_axi_rdata[29]_i_5_n_0\,
      \s_axi_rdata_reg[2]\ => event_arbiter_n_155,
      \s_axi_rdata_reg[30]\ => event_arbiter_n_159,
      \s_axi_rdata_reg[30]_0\ => \s_axi_rdata[30]_i_5_n_0\,
      \s_axi_rdata_reg[31]\ => \s_axi_rdata[31]_i_4_n_0\,
      \s_axi_rdata_reg[31]_0\ => \s_axi_rdata[31]_i_5_n_0\,
      \s_axi_rdata_reg[31]_1\(31 downto 0) => dropped_count_reg(31 downto 0),
      \s_axi_rdata_reg[31]_2\ => event_arbiter_n_158,
      \s_axi_rdata_reg[31]_3\ => \s_axi_rdata[31]_i_10_n_0\,
      \s_axi_rdata_reg[3]\ => \s_axi_rdata[3]_i_6_n_0\,
      \s_axi_rdata_reg[3]_0\ => \s_axi_rdata[3]_i_7_n_0\,
      \s_axi_rdata_reg[3]_1\ => event_arbiter_n_179,
      \s_axi_rdata_reg[3]_2\ => \s_axi_rdata[3]_i_10_n_0\,
      \s_axi_rdata_reg[3]_3\ => \s_axi_rdata[3]_i_11_n_0\,
      \s_axi_rdata_reg[3]_4\ => \s_axi_rdata[3]_i_12_n_0\,
      \s_axi_rdata_reg[3]_5\ => \s_axi_rdata[3]_i_13_n_0\,
      \s_axi_rdata_reg[4]\ => event_arbiter_n_178,
      \s_axi_rdata_reg[4]_0\ => \s_axi_rdata[4]_i_5_n_0\,
      \s_axi_rdata_reg[4]_1\ => \s_axi_rdata[7]_i_7_n_0\,
      \s_axi_rdata_reg[4]_2\ => \s_axi_rdata[7]_i_8_n_0\,
      \s_axi_rdata_reg[5]\ => event_arbiter_n_177,
      \s_axi_rdata_reg[5]_0\ => \s_axi_rdata[5]_i_5_n_0\,
      \s_axi_rdata_reg[6]\ => event_arbiter_n_154,
      \s_axi_rdata_reg[7]\ => event_arbiter_n_176,
      \s_axi_rdata_reg[7]_0\ => \s_axi_rdata[7]_i_5_n_0\,
      \s_axi_rdata_reg[8]\ => event_arbiter_n_175,
      \s_axi_rdata_reg[8]_0\ => \s_axi_rdata[8]_i_5_n_0\,
      \s_axi_rdata_reg[8]_1\ => \s_axi_rdata[31]_i_13_n_0\,
      \s_axi_rdata_reg[9]\ => \s_axi_rdata[31]_i_12_n_0\,
      \s_axi_rdata_reg[9]_0\ => event_arbiter_n_174,
      \s_axi_rdata_reg[9]_1\ => \s_axi_rdata[9]_i_5_n_0\,
      \s_axi_rdata_reg[9]_2\ => \s_axi_rdata[31]_i_11_n_0\,
      s_axi_rready => s_axi_rready,
      s_axi_rvalid => \^s_axi_rvalid\,
      \snapshot_count_reg[8]_0\(0) => capture_buffer_n_81,
      snapshot_rd_en => snapshot_rd_en,
      \snapshot_rd_index_reg[0]\ => \^s_axi_arready\,
      snapshot_ready_reg_0(0) => snapshot_rd_index,
      snapshot_ready_reg_1 => capture_ack_pulse_reg_n_0,
      \timestamp_shadow_reg[32]\ => \timestamp_shadow[63]_i_2_n_0\,
      \timestamp_shadow_reg[32]_0\ => \timestamp_shadow[63]_i_5_n_0\
    );
dropped_count_reg0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => dropped_count_reg0_carry_n_0,
      CO(2) => dropped_count_reg0_carry_n_1,
      CO(1) => dropped_count_reg0_carry_n_2,
      CO(0) => dropped_count_reg0_carry_n_3,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => dropped_count_reg(1),
      DI(0) => '0',
      O(3 downto 0) => dropped_count_reg0(3 downto 0),
      S(3 downto 2) => dropped_count_reg(3 downto 2),
      S(1) => dropped_count_reg0_carry_i_1_n_0,
      S(0) => dropped_count_reg(0)
    );
\dropped_count_reg0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => dropped_count_reg0_carry_n_0,
      CO(3) => \dropped_count_reg0_carry__0_n_0\,
      CO(2) => \dropped_count_reg0_carry__0_n_1\,
      CO(1) => \dropped_count_reg0_carry__0_n_2\,
      CO(0) => \dropped_count_reg0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg0(7 downto 4),
      S(3 downto 0) => dropped_count_reg(7 downto 4)
    );
\dropped_count_reg0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_carry__0_n_0\,
      CO(3) => \dropped_count_reg0_carry__1_n_0\,
      CO(2) => \dropped_count_reg0_carry__1_n_1\,
      CO(1) => \dropped_count_reg0_carry__1_n_2\,
      CO(0) => \dropped_count_reg0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg0(11 downto 8),
      S(3 downto 0) => dropped_count_reg(11 downto 8)
    );
\dropped_count_reg0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_carry__1_n_0\,
      CO(3) => \dropped_count_reg0_carry__2_n_0\,
      CO(2) => \dropped_count_reg0_carry__2_n_1\,
      CO(1) => \dropped_count_reg0_carry__2_n_2\,
      CO(0) => \dropped_count_reg0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg0(15 downto 12),
      S(3 downto 0) => dropped_count_reg(15 downto 12)
    );
\dropped_count_reg0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_carry__2_n_0\,
      CO(3) => \dropped_count_reg0_carry__3_n_0\,
      CO(2) => \dropped_count_reg0_carry__3_n_1\,
      CO(1) => \dropped_count_reg0_carry__3_n_2\,
      CO(0) => \dropped_count_reg0_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg0(19 downto 16),
      S(3 downto 0) => dropped_count_reg(19 downto 16)
    );
\dropped_count_reg0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_carry__3_n_0\,
      CO(3) => \dropped_count_reg0_carry__4_n_0\,
      CO(2) => \dropped_count_reg0_carry__4_n_1\,
      CO(1) => \dropped_count_reg0_carry__4_n_2\,
      CO(0) => \dropped_count_reg0_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg0(23 downto 20),
      S(3 downto 0) => dropped_count_reg(23 downto 20)
    );
\dropped_count_reg0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_carry__4_n_0\,
      CO(3) => \dropped_count_reg0_carry__5_n_0\,
      CO(2) => \dropped_count_reg0_carry__5_n_1\,
      CO(1) => \dropped_count_reg0_carry__5_n_2\,
      CO(0) => \dropped_count_reg0_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg0(27 downto 24),
      S(3 downto 0) => dropped_count_reg(27 downto 24)
    );
\dropped_count_reg0_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_carry__5_n_0\,
      CO(3) => \NLW_dropped_count_reg0_carry__6_CO_UNCONNECTED\(3),
      CO(2) => \dropped_count_reg0_carry__6_n_1\,
      CO(1) => \dropped_count_reg0_carry__6_n_2\,
      CO(0) => \dropped_count_reg0_carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg0(31 downto 28),
      S(3 downto 0) => dropped_count_reg(31 downto 28)
    );
dropped_count_reg0_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => dropped_count_reg(1),
      O => dropped_count_reg0_carry_i_1_n_0
    );
\dropped_count_reg0_inferred__0/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \dropped_count_reg0_inferred__0/i__carry_n_0\,
      CO(2) => \dropped_count_reg0_inferred__0/i__carry_n_1\,
      CO(1) => \dropped_count_reg0_inferred__0/i__carry_n_2\,
      CO(0) => \dropped_count_reg0_inferred__0/i__carry_n_3\,
      CYINIT => dropped_count_reg(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg00_in(4 downto 1),
      S(3 downto 0) => dropped_count_reg(4 downto 1)
    );
\dropped_count_reg0_inferred__0/i__carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_inferred__0/i__carry_n_0\,
      CO(3) => \dropped_count_reg0_inferred__0/i__carry__0_n_0\,
      CO(2) => \dropped_count_reg0_inferred__0/i__carry__0_n_1\,
      CO(1) => \dropped_count_reg0_inferred__0/i__carry__0_n_2\,
      CO(0) => \dropped_count_reg0_inferred__0/i__carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg00_in(8 downto 5),
      S(3 downto 0) => dropped_count_reg(8 downto 5)
    );
\dropped_count_reg0_inferred__0/i__carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_inferred__0/i__carry__0_n_0\,
      CO(3) => \dropped_count_reg0_inferred__0/i__carry__1_n_0\,
      CO(2) => \dropped_count_reg0_inferred__0/i__carry__1_n_1\,
      CO(1) => \dropped_count_reg0_inferred__0/i__carry__1_n_2\,
      CO(0) => \dropped_count_reg0_inferred__0/i__carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg00_in(12 downto 9),
      S(3 downto 0) => dropped_count_reg(12 downto 9)
    );
\dropped_count_reg0_inferred__0/i__carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_inferred__0/i__carry__1_n_0\,
      CO(3) => \dropped_count_reg0_inferred__0/i__carry__2_n_0\,
      CO(2) => \dropped_count_reg0_inferred__0/i__carry__2_n_1\,
      CO(1) => \dropped_count_reg0_inferred__0/i__carry__2_n_2\,
      CO(0) => \dropped_count_reg0_inferred__0/i__carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg00_in(16 downto 13),
      S(3 downto 0) => dropped_count_reg(16 downto 13)
    );
\dropped_count_reg0_inferred__0/i__carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_inferred__0/i__carry__2_n_0\,
      CO(3) => \dropped_count_reg0_inferred__0/i__carry__3_n_0\,
      CO(2) => \dropped_count_reg0_inferred__0/i__carry__3_n_1\,
      CO(1) => \dropped_count_reg0_inferred__0/i__carry__3_n_2\,
      CO(0) => \dropped_count_reg0_inferred__0/i__carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg00_in(20 downto 17),
      S(3 downto 0) => dropped_count_reg(20 downto 17)
    );
\dropped_count_reg0_inferred__0/i__carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_inferred__0/i__carry__3_n_0\,
      CO(3) => \dropped_count_reg0_inferred__0/i__carry__4_n_0\,
      CO(2) => \dropped_count_reg0_inferred__0/i__carry__4_n_1\,
      CO(1) => \dropped_count_reg0_inferred__0/i__carry__4_n_2\,
      CO(0) => \dropped_count_reg0_inferred__0/i__carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg00_in(24 downto 21),
      S(3 downto 0) => dropped_count_reg(24 downto 21)
    );
\dropped_count_reg0_inferred__0/i__carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_inferred__0/i__carry__4_n_0\,
      CO(3) => \dropped_count_reg0_inferred__0/i__carry__5_n_0\,
      CO(2) => \dropped_count_reg0_inferred__0/i__carry__5_n_1\,
      CO(1) => \dropped_count_reg0_inferred__0/i__carry__5_n_2\,
      CO(0) => \dropped_count_reg0_inferred__0/i__carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => dropped_count_reg00_in(28 downto 25),
      S(3 downto 0) => dropped_count_reg(28 downto 25)
    );
\dropped_count_reg0_inferred__0/i__carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_count_reg0_inferred__0/i__carry__5_n_0\,
      CO(3 downto 2) => \NLW_dropped_count_reg0_inferred__0/i__carry__6_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \dropped_count_reg0_inferred__0/i__carry__6_n_2\,
      CO(0) => \dropped_count_reg0_inferred__0/i__carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_dropped_count_reg0_inferred__0/i__carry__6_O_UNCONNECTED\(3),
      O(2 downto 0) => dropped_count_reg00_in(31 downto 29),
      S(3) => '0',
      S(2 downto 0) => dropped_count_reg(31 downto 29)
    );
\dropped_count_reg[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8A80FFFF"
    )
        port map (
      I0 => \dropped_count_reg[31]_i_4_n_0\,
      I1 => wdata_reg(0),
      I2 => w_pending_reg_n_0,
      I3 => s_axi_wdata(0),
      I4 => s_axi_aresetn,
      O => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg[31]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFF5D"
    )
        port map (
      I0 => event_arbiter_n_17,
      I1 => \dropped_count_reg[31]_i_11_n_0\,
      I2 => event_arbiter_n_16,
      I3 => write_addr(4),
      I4 => event_arbiter_n_14,
      I5 => capture_arm_pulse_i_5_n_0,
      O => \dropped_count_reg[31]_i_10_n_0\
    );
\dropped_count_reg[31]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => s_axi_awaddr(15),
      I1 => aw_pending,
      I2 => s_axi_awaddr(14),
      I3 => s_axi_awaddr(13),
      O => \dropped_count_reg[31]_i_11_n_0\
    );
\dropped_count_reg[31]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000100"
    )
        port map (
      I0 => capture_arm_pulse_i_4_n_0,
      I1 => capture_arm_pulse_i_2_n_0,
      I2 => \dropped_count_reg[31]_i_8_n_0\,
      I3 => event_arbiter_n_12,
      I4 => event_arbiter_n_10,
      I5 => event_arbiter_n_11,
      O => \dropped_count_reg[31]_i_4_n_0\
    );
\dropped_count_reg[31]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFDFF00FFFFFFFF"
    )
        port map (
      I0 => p_0_in13_in,
      I1 => event_arbiter_n_7,
      I2 => event_arbiter_n_11,
      I3 => event_arbiter_n_10,
      I4 => \dropped_count_reg[31]_i_9_n_0\,
      I5 => event_arbiter_n_8,
      O => \dropped_count_reg[31]_i_5_n_0\
    );
\dropped_count_reg[31]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCAFFFAF"
    )
        port map (
      I0 => s_axi_awaddr(1),
      I1 => awaddr_reg(1),
      I2 => s_axi_awaddr(12),
      I3 => aw_pending,
      I4 => awaddr_reg(12),
      O => \dropped_count_reg[31]_i_8_n_0\
    );
\dropped_count_reg[31]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFEEEFFFFFFFFFFF"
    )
        port map (
      I0 => \dropped_count_reg[31]_i_8_n_0\,
      I1 => capture_arm_pulse_i_5_n_0,
      I2 => awaddr_reg(3),
      I3 => aw_pending,
      I4 => s_axi_awaddr(3),
      I5 => write_addr(4),
      O => \dropped_count_reg[31]_i_9_n_0\
    );
\dropped_count_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(0),
      Q => dropped_count_reg(0),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(10),
      Q => dropped_count_reg(10),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(11),
      Q => dropped_count_reg(11),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(12),
      Q => dropped_count_reg(12),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(13),
      Q => dropped_count_reg(13),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(14),
      Q => dropped_count_reg(14),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(15),
      Q => dropped_count_reg(15),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(16),
      Q => dropped_count_reg(16),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(17),
      Q => dropped_count_reg(17),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(18),
      Q => dropped_count_reg(18),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(19),
      Q => dropped_count_reg(19),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(1),
      Q => dropped_count_reg(1),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(20),
      Q => dropped_count_reg(20),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(21),
      Q => dropped_count_reg(21),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(22),
      Q => dropped_count_reg(22),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(23),
      Q => dropped_count_reg(23),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(24),
      Q => dropped_count_reg(24),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(25),
      Q => dropped_count_reg(25),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(26),
      Q => dropped_count_reg(26),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(27),
      Q => dropped_count_reg(27),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(28),
      Q => dropped_count_reg(28),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(29),
      Q => dropped_count_reg(29),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(2),
      Q => dropped_count_reg(2),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(30),
      Q => dropped_count_reg(30),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(31),
      Q => dropped_count_reg(31),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(3),
      Q => dropped_count_reg(3),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(4),
      Q => dropped_count_reg(4),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(5),
      Q => dropped_count_reg(5),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(6),
      Q => dropped_count_reg(6),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(7),
      Q => dropped_count_reg(7),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(8),
      Q => dropped_count_reg(8),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
\dropped_count_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_38,
      D => \p_2_in__0\(9),
      Q => dropped_count_reg(9),
      R => \dropped_count_reg[31]_i_1_n_0\
    );
event_arbiter: entity work.multi_protocol_bd_multi_protocol_core_0_0_event_arbiter_2
     port map (
      E(0) => virtual_evt_valid7_out,
      Q(15 downto 0) => awaddr_reg(15 downto 0),
      aw_hs => aw_hs,
      aw_pending => aw_pending,
      aw_pending_reg => event_arbiter_n_8,
      \awaddr_reg_reg[12]\ => event_arbiter_n_7,
      \awaddr_reg_reg[15]\ => event_arbiter_n_16,
      \awaddr_reg_reg[2]\ => event_arbiter_n_11,
      \awaddr_reg_reg[3]\ => event_arbiter_n_14,
      \awaddr_reg_reg[5]\ => event_arbiter_n_13,
      \awaddr_reg_reg[8]\ => event_arbiter_n_18,
      capture_arm_pulse_reg => event_arbiter_n_9,
      clear => clear,
      \dropped_count_reg[31]_i_4\(0) => wstrb_reg(0),
      \dropped_count_reg[31]_i_6\ => capture_arm_pulse_reg_n_0,
      ext_evt_data(127 downto 0) => ext_evt_data(127 downto 0),
      ext_evt_dropped_count(31 downto 0) => ext_evt_dropped_count(31 downto 0),
      ext_evt_dropped_count_3_sp_1 => event_arbiter_n_179,
      ext_evt_ready => ext_evt_ready,
      ext_evt_ready_INST_0_i_4_0 => \^s_axi_bvalid_reg_0\,
      ext_evt_valid => ext_evt_valid,
      ext_evt_valid_0 => event_arbiter_n_3,
      in_event(127 downto 0) => capture_event_data(127 downto 0),
      memory_reg_1(91) => \virtual_evt_data_reg_n_0_[127]\,
      memory_reg_1(90) => \virtual_evt_data_reg_n_0_[126]\,
      memory_reg_1(89) => \virtual_evt_data_reg_n_0_[125]\,
      memory_reg_1(88) => \virtual_evt_data_reg_n_0_[124]\,
      memory_reg_1(87) => \virtual_evt_data_reg_n_0_[123]\,
      memory_reg_1(86) => \virtual_evt_data_reg_n_0_[122]\,
      memory_reg_1(85) => \virtual_evt_data_reg_n_0_[121]\,
      memory_reg_1(84) => \virtual_evt_data_reg_n_0_[120]\,
      memory_reg_1(83) => \virtual_evt_data_reg_n_0_[119]\,
      memory_reg_1(82) => \virtual_evt_data_reg_n_0_[118]\,
      memory_reg_1(81) => \virtual_evt_data_reg_n_0_[117]\,
      memory_reg_1(80) => \virtual_evt_data_reg_n_0_[116]\,
      memory_reg_1(79) => \virtual_evt_data_reg_n_0_[115]\,
      memory_reg_1(78) => \virtual_evt_data_reg_n_0_[114]\,
      memory_reg_1(77) => \virtual_evt_data_reg_n_0_[113]\,
      memory_reg_1(76) => \virtual_evt_data_reg_n_0_[112]\,
      memory_reg_1(75) => \virtual_evt_data_reg_n_0_[111]\,
      memory_reg_1(74) => \virtual_evt_data_reg_n_0_[110]\,
      memory_reg_1(73) => \virtual_evt_data_reg_n_0_[109]\,
      memory_reg_1(72) => \virtual_evt_data_reg_n_0_[108]\,
      memory_reg_1(71) => \virtual_evt_data_reg_n_0_[107]\,
      memory_reg_1(70) => \virtual_evt_data_reg_n_0_[106]\,
      memory_reg_1(69) => \virtual_evt_data_reg_n_0_[105]\,
      memory_reg_1(68) => \virtual_evt_data_reg_n_0_[104]\,
      memory_reg_1(67) => \virtual_evt_data_reg_n_0_[103]\,
      memory_reg_1(66) => \virtual_evt_data_reg_n_0_[102]\,
      memory_reg_1(65) => \virtual_evt_data_reg_n_0_[101]\,
      memory_reg_1(64) => \virtual_evt_data_reg_n_0_[100]\,
      memory_reg_1(63) => \virtual_evt_data_reg_n_0_[99]\,
      memory_reg_1(62) => \virtual_evt_data_reg_n_0_[98]\,
      memory_reg_1(61) => \virtual_evt_data_reg_n_0_[97]\,
      memory_reg_1(60) => \virtual_evt_data_reg_n_0_[96]\,
      memory_reg_1(59) => \virtual_evt_data_reg_n_0_[95]\,
      memory_reg_1(58) => \virtual_evt_data_reg_n_0_[94]\,
      memory_reg_1(57) => \virtual_evt_data_reg_n_0_[93]\,
      memory_reg_1(56) => \virtual_evt_data_reg_n_0_[92]\,
      memory_reg_1(55) => \virtual_evt_data_reg_n_0_[91]\,
      memory_reg_1(54) => \virtual_evt_data_reg_n_0_[90]\,
      memory_reg_1(53) => \virtual_evt_data_reg_n_0_[89]\,
      memory_reg_1(52) => \virtual_evt_data_reg_n_0_[88]\,
      memory_reg_1(51) => \virtual_evt_data_reg_n_0_[87]\,
      memory_reg_1(50) => \virtual_evt_data_reg_n_0_[86]\,
      memory_reg_1(49) => \virtual_evt_data_reg_n_0_[85]\,
      memory_reg_1(48) => \virtual_evt_data_reg_n_0_[84]\,
      memory_reg_1(47) => \virtual_evt_data_reg_n_0_[83]\,
      memory_reg_1(46) => \virtual_evt_data_reg_n_0_[82]\,
      memory_reg_1(45) => \virtual_evt_data_reg_n_0_[81]\,
      memory_reg_1(44) => \virtual_evt_data_reg_n_0_[80]\,
      memory_reg_1(43) => \virtual_evt_data_reg_n_0_[79]\,
      memory_reg_1(42) => \virtual_evt_data_reg_n_0_[78]\,
      memory_reg_1(41) => \virtual_evt_data_reg_n_0_[77]\,
      memory_reg_1(40) => \virtual_evt_data_reg_n_0_[76]\,
      memory_reg_1(39) => \virtual_evt_data_reg_n_0_[75]\,
      memory_reg_1(38) => \virtual_evt_data_reg_n_0_[74]\,
      memory_reg_1(37) => \virtual_evt_data_reg_n_0_[73]\,
      memory_reg_1(36) => \virtual_evt_data_reg_n_0_[72]\,
      memory_reg_1(35) => \virtual_evt_data_reg_n_0_[71]\,
      memory_reg_1(34) => \virtual_evt_data_reg_n_0_[70]\,
      memory_reg_1(33) => \virtual_evt_data_reg_n_0_[69]\,
      memory_reg_1(32) => \virtual_evt_data_reg_n_0_[68]\,
      memory_reg_1(31) => \virtual_evt_data_reg_n_0_[67]\,
      memory_reg_1(30) => \virtual_evt_data_reg_n_0_[66]\,
      memory_reg_1(29) => \virtual_evt_data_reg_n_0_[65]\,
      memory_reg_1(28) => \virtual_evt_data_reg_n_0_[64]\,
      memory_reg_1(27) => \virtual_evt_data_reg_n_0_[55]\,
      memory_reg_1(26) => \virtual_evt_data_reg_n_0_[49]\,
      memory_reg_1(25) => \virtual_evt_data_reg_n_0_[48]\,
      memory_reg_1(24) => \virtual_evt_data_reg_n_0_[32]\,
      memory_reg_1(23) => \virtual_evt_data_reg_n_0_[23]\,
      memory_reg_1(22) => \virtual_evt_data_reg_n_0_[22]\,
      memory_reg_1(21) => \virtual_evt_data_reg_n_0_[21]\,
      memory_reg_1(20) => \virtual_evt_data_reg_n_0_[20]\,
      memory_reg_1(19) => \virtual_evt_data_reg_n_0_[19]\,
      memory_reg_1(18) => \virtual_evt_data_reg_n_0_[18]\,
      memory_reg_1(17) => \virtual_evt_data_reg_n_0_[17]\,
      memory_reg_1(16) => \virtual_evt_data_reg_n_0_[16]\,
      memory_reg_1(15) => \virtual_evt_data_reg_n_0_[15]\,
      memory_reg_1(14) => \virtual_evt_data_reg_n_0_[14]\,
      memory_reg_1(13) => \virtual_evt_data_reg_n_0_[13]\,
      memory_reg_1(12) => \virtual_evt_data_reg_n_0_[12]\,
      memory_reg_1(11) => \virtual_evt_data_reg_n_0_[11]\,
      memory_reg_1(10) => \virtual_evt_data_reg_n_0_[10]\,
      memory_reg_1(9) => \virtual_evt_data_reg_n_0_[9]\,
      memory_reg_1(8) => \virtual_evt_data_reg_n_0_[8]\,
      memory_reg_1(7) => \virtual_evt_data_reg_n_0_[7]\,
      memory_reg_1(6) => \virtual_evt_data_reg_n_0_[6]\,
      memory_reg_1(5) => \virtual_evt_data_reg_n_0_[5]\,
      memory_reg_1(4) => \virtual_evt_data_reg_n_0_[4]\,
      memory_reg_1(3) => \virtual_evt_data_reg_n_0_[3]\,
      memory_reg_1(2) => \virtual_evt_data_reg_n_0_[2]\,
      memory_reg_1(1) => \virtual_evt_data_reg_n_0_[1]\,
      memory_reg_1(0) => \virtual_evt_data_reg_n_0_[0]\,
      p_3_in => p_3_in,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(3 downto 0) => s_axi_araddr(5 downto 2),
      \s_axi_araddr[4]\ => event_arbiter_n_0,
      \s_axi_araddr[4]_0\ => event_arbiter_n_158,
      \s_axi_araddr[4]_1\ => event_arbiter_n_159,
      \s_axi_araddr[4]_10\ => event_arbiter_n_168,
      \s_axi_araddr[4]_11\ => event_arbiter_n_169,
      \s_axi_araddr[4]_12\ => event_arbiter_n_170,
      \s_axi_araddr[4]_13\ => event_arbiter_n_171,
      \s_axi_araddr[4]_14\ => event_arbiter_n_172,
      \s_axi_araddr[4]_15\ => event_arbiter_n_173,
      \s_axi_araddr[4]_16\ => event_arbiter_n_174,
      \s_axi_araddr[4]_17\ => event_arbiter_n_175,
      \s_axi_araddr[4]_18\ => event_arbiter_n_176,
      \s_axi_araddr[4]_19\ => event_arbiter_n_177,
      \s_axi_araddr[4]_2\ => event_arbiter_n_160,
      \s_axi_araddr[4]_20\ => event_arbiter_n_178,
      \s_axi_araddr[4]_3\ => event_arbiter_n_161,
      \s_axi_araddr[4]_4\ => event_arbiter_n_162,
      \s_axi_araddr[4]_5\ => event_arbiter_n_163,
      \s_axi_araddr[4]_6\ => event_arbiter_n_164,
      \s_axi_araddr[4]_7\ => event_arbiter_n_165,
      \s_axi_araddr[4]_8\ => event_arbiter_n_166,
      \s_axi_araddr[4]_9\ => event_arbiter_n_167,
      \s_axi_araddr[5]\ => event_arbiter_n_149,
      \s_axi_araddr[5]_0\ => event_arbiter_n_150,
      \s_axi_araddr[5]_1\ => event_arbiter_n_151,
      \s_axi_araddr[5]_2\ => event_arbiter_n_152,
      \s_axi_araddr[5]_3\ => event_arbiter_n_153,
      \s_axi_araddr[5]_4\ => event_arbiter_n_154,
      \s_axi_araddr[5]_5\ => event_arbiter_n_155,
      \s_axi_araddr[5]_6\ => event_arbiter_n_156,
      \s_axi_araddr[5]_7\ => event_arbiter_n_157,
      s_axi_awaddr(15 downto 0) => s_axi_awaddr(15 downto 0),
      s_axi_awaddr_15_sp_1 => event_arbiter_n_10,
      s_axi_awaddr_6_sp_1 => event_arbiter_n_17,
      s_axi_awaddr_9_sp_1 => event_arbiter_n_19,
      s_axi_awready => \^s_axi_awready\,
      s_axi_awvalid => s_axi_awvalid,
      \s_axi_rdata_reg[0]\ => \s_axi_rdata[0]_i_7_n_0\,
      \s_axi_rdata_reg[0]_0\ => \s_axi_rdata[0]_i_8_n_0\,
      \s_axi_rdata_reg[10]\ => \s_axi_rdata[10]_i_6_n_0\,
      \s_axi_rdata_reg[11]\ => \s_axi_rdata[11]_i_6_n_0\,
      \s_axi_rdata_reg[12]\ => \s_axi_rdata[12]_i_6_n_0\,
      \s_axi_rdata_reg[12]_0\ => \s_axi_rdata[12]_i_7_n_0\,
      \s_axi_rdata_reg[13]\ => \s_axi_rdata[13]_i_6_n_0\,
      \s_axi_rdata_reg[14]\ => \s_axi_rdata[14]_i_6_n_0\,
      \s_axi_rdata_reg[15]\ => \s_axi_rdata[15]_i_6_n_0\,
      \s_axi_rdata_reg[16]\ => \s_axi_rdata[31]_i_12_n_0\,
      \s_axi_rdata_reg[16]_0\ => \s_axi_rdata[16]_i_5_n_0\,
      \s_axi_rdata_reg[16]_1\ => \s_axi_rdata[16]_i_7_n_0\,
      \s_axi_rdata_reg[17]\ => \s_axi_rdata[17]_i_6_n_0\,
      \s_axi_rdata_reg[18]\ => \s_axi_rdata[18]_i_6_n_0\,
      \s_axi_rdata_reg[19]\ => \s_axi_rdata[19]_i_6_n_0\,
      \s_axi_rdata_reg[1]\ => \s_axi_rdata[1]_i_7_n_0\,
      \s_axi_rdata_reg[1]_0\ => \s_axi_rdata[1]_i_8_n_0\,
      \s_axi_rdata_reg[20]\ => \s_axi_rdata[20]_i_6_n_0\,
      \s_axi_rdata_reg[20]_0\ => \s_axi_rdata[20]_i_7_n_0\,
      \s_axi_rdata_reg[21]\ => \s_axi_rdata[21]_i_6_n_0\,
      \s_axi_rdata_reg[22]\ => \s_axi_rdata[22]_i_6_n_0\,
      \s_axi_rdata_reg[22]_0\ => \s_axi_rdata[22]_i_7_n_0\,
      \s_axi_rdata_reg[23]\ => \s_axi_rdata[23]_i_6_n_0\,
      \s_axi_rdata_reg[24]\ => \s_axi_rdata[24]_i_6_n_0\,
      \s_axi_rdata_reg[25]\ => \s_axi_rdata[25]_i_6_n_0\,
      \s_axi_rdata_reg[26]\ => \s_axi_rdata[26]_i_6_n_0\,
      \s_axi_rdata_reg[26]_0\ => \s_axi_rdata[26]_i_7_n_0\,
      \s_axi_rdata_reg[27]\ => \s_axi_rdata[27]_i_9_n_0\,
      \s_axi_rdata_reg[27]_0\ => \s_axi_rdata[27]_i_10_n_0\,
      \s_axi_rdata_reg[28]\ => \s_axi_rdata[28]_i_6_n_0\,
      \s_axi_rdata_reg[29]\ => \s_axi_rdata[29]_i_6_n_0\,
      \s_axi_rdata_reg[2]\ => \s_axi_rdata[2]_i_7_n_0\,
      \s_axi_rdata_reg[2]_0\ => \s_axi_rdata[2]_i_8_n_0\,
      \s_axi_rdata_reg[30]\ => \s_axi_rdata[30]_i_6_n_0\,
      \s_axi_rdata_reg[31]\ => \s_axi_rdata[31]_i_14_n_0\,
      \s_axi_rdata_reg[31]_i_9_0\(31 downto 1) => led_ctrl_reg(31 downto 1),
      \s_axi_rdata_reg[31]_i_9_0\(0) => \^led_ps_active\,
      \s_axi_rdata_reg[4]\ => \s_axi_rdata[4]_i_7_n_0\,
      \s_axi_rdata_reg[5]\ => \s_axi_rdata[5]_i_7_n_0\,
      \s_axi_rdata_reg[6]\ => \s_axi_rdata[6]_i_7_n_0\,
      \s_axi_rdata_reg[6]_0\ => \s_axi_rdata[6]_i_8_n_0\,
      \s_axi_rdata_reg[7]\ => \s_axi_rdata[7]_i_9_n_0\,
      \s_axi_rdata_reg[8]\ => \s_axi_rdata[8]_i_7_n_0\,
      \s_axi_rdata_reg[9]\ => \s_axi_rdata[9]_i_6_n_0\,
      s_axi_wdata(0) => s_axi_wdata(0),
      s_axi_wready => \^s_axi_wready\,
      s_axi_wstrb(0) => s_axi_wstrb(0),
      s_axi_wvalid => s_axi_wvalid,
      \scratch_reg_reg[0]\ => w_pending_reg_n_0,
      \scratch_reg_reg[0]_0\(0) => wdata_reg(0),
      virtual_evt_trigger_reg => virtual_evt_valid_reg_n_0,
      virtual_evt_trigger_reg_0 => \virtual_evt_data[127]_i_2_n_0\,
      virtual_evt_trigger_reg_1 => \dropped_count_reg[31]_i_10_n_0\,
      virtual_evt_trigger_reg_2 => virtual_evt_trigger_i_2_n_0,
      virtual_evt_trigger_reg_3 => virtual_evt_trigger_i_3_n_0,
      virtual_evt_trigger_reg_4 => virtual_evt_trigger_reg_n_0,
      virtual_evt_valid_reg => event_arbiter_n_180,
      virtual_evt_valid_reg_0 => event_arbiter_n_181,
      virtual_evt_valid_reg_1 => virtual_evt_valid_i_2_n_0,
      virtual_evt_valid_reg_2 => virtual_evt_valid_i_3_n_0,
      \wdata_reg_reg[0]\ => event_arbiter_n_5,
      \wdata_reg_reg[0]_0\ => event_arbiter_n_6,
      write_addr(0) => write_addr(4),
      \wstrb_reg_reg[0]\ => event_arbiter_n_12
    );
heartbeat_counter0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => heartbeat_counter0_carry_n_0,
      CO(2) => heartbeat_counter0_carry_n_1,
      CO(1) => heartbeat_counter0_carry_n_2,
      CO(0) => heartbeat_counter0_carry_n_3,
      CYINIT => \heartbeat_counter_reg_n_0_[0]\,
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(4 downto 1),
      S(3) => \heartbeat_counter_reg_n_0_[4]\,
      S(2) => \heartbeat_counter_reg_n_0_[3]\,
      S(1) => \heartbeat_counter_reg_n_0_[2]\,
      S(0) => \heartbeat_counter_reg_n_0_[1]\
    );
\heartbeat_counter0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => heartbeat_counter0_carry_n_0,
      CO(3) => \heartbeat_counter0_carry__0_n_0\,
      CO(2) => \heartbeat_counter0_carry__0_n_1\,
      CO(1) => \heartbeat_counter0_carry__0_n_2\,
      CO(0) => \heartbeat_counter0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(8 downto 5),
      S(3) => \heartbeat_counter_reg_n_0_[8]\,
      S(2) => \heartbeat_counter_reg_n_0_[7]\,
      S(1) => \heartbeat_counter_reg_n_0_[6]\,
      S(0) => \heartbeat_counter_reg_n_0_[5]\
    );
\heartbeat_counter0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \heartbeat_counter0_carry__0_n_0\,
      CO(3) => \heartbeat_counter0_carry__1_n_0\,
      CO(2) => \heartbeat_counter0_carry__1_n_1\,
      CO(1) => \heartbeat_counter0_carry__1_n_2\,
      CO(0) => \heartbeat_counter0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(12 downto 9),
      S(3) => \heartbeat_counter_reg_n_0_[12]\,
      S(2) => \heartbeat_counter_reg_n_0_[11]\,
      S(1) => \heartbeat_counter_reg_n_0_[10]\,
      S(0) => \heartbeat_counter_reg_n_0_[9]\
    );
\heartbeat_counter0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \heartbeat_counter0_carry__1_n_0\,
      CO(3) => \heartbeat_counter0_carry__2_n_0\,
      CO(2) => \heartbeat_counter0_carry__2_n_1\,
      CO(1) => \heartbeat_counter0_carry__2_n_2\,
      CO(0) => \heartbeat_counter0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(16 downto 13),
      S(3) => \heartbeat_counter_reg_n_0_[16]\,
      S(2) => \heartbeat_counter_reg_n_0_[15]\,
      S(1) => \heartbeat_counter_reg_n_0_[14]\,
      S(0) => \heartbeat_counter_reg_n_0_[13]\
    );
\heartbeat_counter0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \heartbeat_counter0_carry__2_n_0\,
      CO(3) => \heartbeat_counter0_carry__3_n_0\,
      CO(2) => \heartbeat_counter0_carry__3_n_1\,
      CO(1) => \heartbeat_counter0_carry__3_n_2\,
      CO(0) => \heartbeat_counter0_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(20 downto 17),
      S(3) => \heartbeat_counter_reg_n_0_[20]\,
      S(2) => \heartbeat_counter_reg_n_0_[19]\,
      S(1) => \heartbeat_counter_reg_n_0_[18]\,
      S(0) => \heartbeat_counter_reg_n_0_[17]\
    );
\heartbeat_counter0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \heartbeat_counter0_carry__3_n_0\,
      CO(3) => \heartbeat_counter0_carry__4_n_0\,
      CO(2) => \heartbeat_counter0_carry__4_n_1\,
      CO(1) => \heartbeat_counter0_carry__4_n_2\,
      CO(0) => \heartbeat_counter0_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(24 downto 21),
      S(3) => \heartbeat_counter_reg_n_0_[24]\,
      S(2) => \heartbeat_counter_reg_n_0_[23]\,
      S(1) => \heartbeat_counter_reg_n_0_[22]\,
      S(0) => \heartbeat_counter_reg_n_0_[21]\
    );
\heartbeat_counter0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \heartbeat_counter0_carry__4_n_0\,
      CO(3 downto 0) => \NLW_heartbeat_counter0_carry__5_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_heartbeat_counter0_carry__5_O_UNCONNECTED\(3 downto 1),
      O(0) => data0(25),
      S(3 downto 1) => B"000",
      S(0) => \heartbeat_counter_reg_n_0_[25]\
    );
\heartbeat_counter[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \heartbeat_counter_reg_n_0_[0]\,
      O => heartbeat_counter(0)
    );
\heartbeat_counter[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(10),
      O => heartbeat_counter(10)
    );
\heartbeat_counter[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(11),
      O => heartbeat_counter(11)
    );
\heartbeat_counter[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(12),
      O => heartbeat_counter(12)
    );
\heartbeat_counter[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(13),
      O => heartbeat_counter(13)
    );
\heartbeat_counter[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(14),
      O => heartbeat_counter(14)
    );
\heartbeat_counter[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(15),
      O => heartbeat_counter(15)
    );
\heartbeat_counter[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(16),
      O => heartbeat_counter(16)
    );
\heartbeat_counter[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(17),
      O => heartbeat_counter(17)
    );
\heartbeat_counter[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(18),
      O => heartbeat_counter(18)
    );
\heartbeat_counter[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(19),
      O => heartbeat_counter(19)
    );
\heartbeat_counter[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(1),
      O => heartbeat_counter(1)
    );
\heartbeat_counter[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(20),
      O => heartbeat_counter(20)
    );
\heartbeat_counter[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(21),
      O => heartbeat_counter(21)
    );
\heartbeat_counter[22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(22),
      O => heartbeat_counter(22)
    );
\heartbeat_counter[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(23),
      O => heartbeat_counter(23)
    );
\heartbeat_counter[24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(24),
      O => heartbeat_counter(24)
    );
\heartbeat_counter[25]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(25),
      O => heartbeat_counter(25)
    );
\heartbeat_counter[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(2),
      O => heartbeat_counter(2)
    );
\heartbeat_counter[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(3),
      O => heartbeat_counter(3)
    );
\heartbeat_counter[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(4),
      O => heartbeat_counter(4)
    );
\heartbeat_counter[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(5),
      O => heartbeat_counter(5)
    );
\heartbeat_counter[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(6),
      O => heartbeat_counter(6)
    );
\heartbeat_counter[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(7),
      O => heartbeat_counter(7)
    );
\heartbeat_counter[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(8),
      O => heartbeat_counter(8)
    );
\heartbeat_counter[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => data0(9),
      O => heartbeat_counter(9)
    );
\heartbeat_counter_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(0),
      Q => \heartbeat_counter_reg_n_0_[0]\,
      R => clear
    );
\heartbeat_counter_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(10),
      Q => \heartbeat_counter_reg_n_0_[10]\,
      R => clear
    );
\heartbeat_counter_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(11),
      Q => \heartbeat_counter_reg_n_0_[11]\,
      R => clear
    );
\heartbeat_counter_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(12),
      Q => \heartbeat_counter_reg_n_0_[12]\,
      R => clear
    );
\heartbeat_counter_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(13),
      Q => \heartbeat_counter_reg_n_0_[13]\,
      R => clear
    );
\heartbeat_counter_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(14),
      Q => \heartbeat_counter_reg_n_0_[14]\,
      R => clear
    );
\heartbeat_counter_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(15),
      Q => \heartbeat_counter_reg_n_0_[15]\,
      R => clear
    );
\heartbeat_counter_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(16),
      Q => \heartbeat_counter_reg_n_0_[16]\,
      R => clear
    );
\heartbeat_counter_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(17),
      Q => \heartbeat_counter_reg_n_0_[17]\,
      R => clear
    );
\heartbeat_counter_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(18),
      Q => \heartbeat_counter_reg_n_0_[18]\,
      R => clear
    );
\heartbeat_counter_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(19),
      Q => \heartbeat_counter_reg_n_0_[19]\,
      R => clear
    );
\heartbeat_counter_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(1),
      Q => \heartbeat_counter_reg_n_0_[1]\,
      R => clear
    );
\heartbeat_counter_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(20),
      Q => \heartbeat_counter_reg_n_0_[20]\,
      R => clear
    );
\heartbeat_counter_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(21),
      Q => \heartbeat_counter_reg_n_0_[21]\,
      R => clear
    );
\heartbeat_counter_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(22),
      Q => \heartbeat_counter_reg_n_0_[22]\,
      R => clear
    );
\heartbeat_counter_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(23),
      Q => \heartbeat_counter_reg_n_0_[23]\,
      R => clear
    );
\heartbeat_counter_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(24),
      Q => \heartbeat_counter_reg_n_0_[24]\,
      R => clear
    );
\heartbeat_counter_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(25),
      Q => \heartbeat_counter_reg_n_0_[25]\,
      R => clear
    );
\heartbeat_counter_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(2),
      Q => \heartbeat_counter_reg_n_0_[2]\,
      R => clear
    );
\heartbeat_counter_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(3),
      Q => \heartbeat_counter_reg_n_0_[3]\,
      R => clear
    );
\heartbeat_counter_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(4),
      Q => \heartbeat_counter_reg_n_0_[4]\,
      R => clear
    );
\heartbeat_counter_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(5),
      Q => \heartbeat_counter_reg_n_0_[5]\,
      R => clear
    );
\heartbeat_counter_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(6),
      Q => \heartbeat_counter_reg_n_0_[6]\,
      R => clear
    );
\heartbeat_counter_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(7),
      Q => \heartbeat_counter_reg_n_0_[7]\,
      R => clear
    );
\heartbeat_counter_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(8),
      Q => \heartbeat_counter_reg_n_0_[8]\,
      R => clear
    );
\heartbeat_counter_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_counter(9),
      Q => \heartbeat_counter_reg_n_0_[9]\,
      R => clear
    );
heartbeat_state_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => heartbeat_state_i_2_n_0,
      I1 => \^led_heartbeat\,
      O => heartbeat_state_i_1_n_0
    );
heartbeat_state_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => heartbeat_state_i_3_n_0,
      I1 => heartbeat_state_i_4_n_0,
      I2 => heartbeat_state_i_5_n_0,
      I3 => heartbeat_state_i_6_n_0,
      I4 => heartbeat_state_i_7_n_0,
      I5 => heartbeat_state_i_8_n_0,
      O => heartbeat_state_i_2_n_0
    );
heartbeat_state_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF7F"
    )
        port map (
      I0 => \heartbeat_counter_reg_n_0_[15]\,
      I1 => \heartbeat_counter_reg_n_0_[14]\,
      I2 => \heartbeat_counter_reg_n_0_[17]\,
      I3 => \heartbeat_counter_reg_n_0_[16]\,
      O => heartbeat_state_i_3_n_0
    );
heartbeat_state_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DFFF"
    )
        port map (
      I0 => \heartbeat_counter_reg_n_0_[19]\,
      I1 => \heartbeat_counter_reg_n_0_[18]\,
      I2 => \heartbeat_counter_reg_n_0_[21]\,
      I3 => \heartbeat_counter_reg_n_0_[20]\,
      O => heartbeat_state_i_4_n_0
    );
heartbeat_state_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
        port map (
      I0 => \heartbeat_counter_reg_n_0_[6]\,
      I1 => \heartbeat_counter_reg_n_0_[7]\,
      I2 => \heartbeat_counter_reg_n_0_[9]\,
      I3 => \heartbeat_counter_reg_n_0_[8]\,
      O => heartbeat_state_i_5_n_0
    );
heartbeat_state_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFF"
    )
        port map (
      I0 => \heartbeat_counter_reg_n_0_[11]\,
      I1 => \heartbeat_counter_reg_n_0_[10]\,
      I2 => \heartbeat_counter_reg_n_0_[13]\,
      I3 => \heartbeat_counter_reg_n_0_[12]\,
      O => heartbeat_state_i_6_n_0
    );
heartbeat_state_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \heartbeat_counter_reg_n_0_[3]\,
      I1 => \heartbeat_counter_reg_n_0_[2]\,
      I2 => \heartbeat_counter_reg_n_0_[5]\,
      I3 => \heartbeat_counter_reg_n_0_[4]\,
      O => heartbeat_state_i_7_n_0
    );
heartbeat_state_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFFFFFFFFFFFFF"
    )
        port map (
      I0 => \heartbeat_counter_reg_n_0_[24]\,
      I1 => \heartbeat_counter_reg_n_0_[25]\,
      I2 => \heartbeat_counter_reg_n_0_[22]\,
      I3 => \heartbeat_counter_reg_n_0_[23]\,
      I4 => \heartbeat_counter_reg_n_0_[1]\,
      I5 => \heartbeat_counter_reg_n_0_[0]\,
      O => heartbeat_state_i_8_n_0
    );
heartbeat_state_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => heartbeat_state_i_1_n_0,
      Q => \^led_heartbeat\,
      R => clear
    );
\io_mode_reg[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \sys_ctrl_reg[31]_i_2_n_0\,
      I1 => \led_ctrl_reg[15]_i_3_n_0\,
      I2 => \led_ctrl_reg[0]_i_3_n_0\,
      I3 => \led_ctrl_reg[0]_i_6_n_0\,
      I4 => \led_ctrl_reg[0]_i_5_n_0\,
      I5 => \sys_ctrl_reg[31]_i_3_n_0\,
      O => \io_mode_reg[15]_i_1_n_0\
    );
\io_mode_reg[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \sys_ctrl_reg[31]_i_2_n_0\,
      I1 => \led_ctrl_reg[23]_i_3_n_0\,
      I2 => \led_ctrl_reg[0]_i_3_n_0\,
      I3 => \led_ctrl_reg[0]_i_6_n_0\,
      I4 => \led_ctrl_reg[0]_i_5_n_0\,
      I5 => \sys_ctrl_reg[31]_i_3_n_0\,
      O => \io_mode_reg[23]_i_1_n_0\
    );
\io_mode_reg[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
        port map (
      I0 => \sys_ctrl_reg[31]_i_2_n_0\,
      I1 => \led_ctrl_reg[31]_i_3_n_0\,
      I2 => \led_ctrl_reg[0]_i_3_n_0\,
      I3 => \led_ctrl_reg[0]_i_6_n_0\,
      I4 => \led_ctrl_reg[0]_i_5_n_0\,
      I5 => \sys_ctrl_reg[31]_i_3_n_0\,
      O => \io_mode_reg[31]_i_1_n_0\
    );
\io_mode_reg[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \sys_ctrl_reg[31]_i_2_n_0\,
      I1 => \led_ctrl_reg[0]_i_7_n_0\,
      I2 => \led_ctrl_reg[0]_i_3_n_0\,
      I3 => \led_ctrl_reg[0]_i_6_n_0\,
      I4 => \led_ctrl_reg[0]_i_5_n_0\,
      I5 => \sys_ctrl_reg[31]_i_3_n_0\,
      O => \io_mode_reg[7]_i_1_n_0\
    );
\io_mode_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[7]_i_1_n_0\,
      D => event_arbiter_n_6,
      Q => io_mode_reg(0),
      R => clear
    );
\io_mode_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[10]_i_1_n_0\,
      Q => io_mode_reg(10),
      R => clear
    );
\io_mode_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[11]_i_1_n_0\,
      Q => io_mode_reg(11),
      R => clear
    );
\io_mode_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[12]_i_1_n_0\,
      Q => io_mode_reg(12),
      R => clear
    );
\io_mode_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[13]_i_1_n_0\,
      Q => io_mode_reg(13),
      R => clear
    );
\io_mode_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[14]_i_1_n_0\,
      Q => io_mode_reg(14),
      R => clear
    );
\io_mode_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[15]_i_2_n_0\,
      Q => io_mode_reg(15),
      R => clear
    );
\io_mode_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[16]_i_1_n_0\,
      Q => io_mode_reg(16),
      R => clear
    );
\io_mode_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[17]_i_1_n_0\,
      Q => io_mode_reg(17),
      R => clear
    );
\io_mode_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[18]_i_1_n_0\,
      Q => io_mode_reg(18),
      R => clear
    );
\io_mode_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[19]_i_1_n_0\,
      Q => io_mode_reg(19),
      R => clear
    );
\io_mode_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[7]_i_1_n_0\,
      D => p_0_in15_in,
      Q => io_mode_reg(1),
      R => clear
    );
\io_mode_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[20]_i_1_n_0\,
      Q => io_mode_reg(20),
      R => clear
    );
\io_mode_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[21]_i_1_n_0\,
      Q => io_mode_reg(21),
      R => clear
    );
\io_mode_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[22]_i_1_n_0\,
      Q => io_mode_reg(22),
      R => clear
    );
\io_mode_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[23]_i_2_n_0\,
      Q => io_mode_reg(23),
      R => clear
    );
\io_mode_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[24]_i_1_n_0\,
      Q => io_mode_reg(24),
      R => clear
    );
\io_mode_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[25]_i_1_n_0\,
      Q => io_mode_reg(25),
      R => clear
    );
\io_mode_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[26]_i_1_n_0\,
      Q => io_mode_reg(26),
      R => clear
    );
\io_mode_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[27]_i_1_n_0\,
      Q => io_mode_reg(27),
      R => clear
    );
\io_mode_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[28]_i_1_n_0\,
      Q => io_mode_reg(28),
      R => clear
    );
\io_mode_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[29]_i_1_n_0\,
      Q => io_mode_reg(29),
      R => clear
    );
\io_mode_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[7]_i_1_n_0\,
      D => p_0_in13_in,
      Q => io_mode_reg(2),
      R => clear
    );
\io_mode_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[30]_i_1_n_0\,
      Q => io_mode_reg(30),
      R => clear
    );
\io_mode_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[31]_i_1_n_0\,
      D => p_0_in10_in,
      Q => io_mode_reg(31),
      R => clear
    );
\io_mode_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[3]_i_1_n_0\,
      Q => io_mode_reg(3),
      R => clear
    );
\io_mode_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[4]_i_1_n_0\,
      Q => io_mode_reg(4),
      R => clear
    );
\io_mode_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[5]_i_1_n_0\,
      Q => io_mode_reg(5),
      R => clear
    );
\io_mode_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[6]_i_1_n_0\,
      Q => io_mode_reg(6),
      R => clear
    );
\io_mode_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[7]_i_1_n_0\,
      Q => io_mode_reg(7),
      R => clear
    );
\io_mode_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[8]_i_1_n_0\,
      Q => io_mode_reg(8),
      R => clear
    );
\io_mode_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \io_mode_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[9]_i_1_n_0\,
      Q => io_mode_reg(9),
      R => clear
    );
\irq_enable_reg[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \irq_enable_reg[31]_i_3_n_0\,
      I1 => \led_ctrl_reg[0]_i_3_n_0\,
      I2 => \led_ctrl_reg[0]_i_6_n_0\,
      I3 => \led_ctrl_reg[0]_i_5_n_0\,
      I4 => \irq_enable_reg[31]_i_2_n_0\,
      I5 => \led_ctrl_reg[15]_i_3_n_0\,
      O => \irq_enable_reg[15]_i_1_n_0\
    );
\irq_enable_reg[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \irq_enable_reg[31]_i_3_n_0\,
      I1 => \led_ctrl_reg[0]_i_3_n_0\,
      I2 => \led_ctrl_reg[0]_i_6_n_0\,
      I3 => \led_ctrl_reg[0]_i_5_n_0\,
      I4 => \irq_enable_reg[31]_i_2_n_0\,
      I5 => \led_ctrl_reg[23]_i_3_n_0\,
      O => \irq_enable_reg[23]_i_1_n_0\
    );
\irq_enable_reg[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000004"
    )
        port map (
      I0 => \irq_enable_reg[31]_i_2_n_0\,
      I1 => \led_ctrl_reg[31]_i_3_n_0\,
      I2 => \irq_enable_reg[31]_i_3_n_0\,
      I3 => \led_ctrl_reg[0]_i_3_n_0\,
      I4 => \led_ctrl_reg[0]_i_6_n_0\,
      I5 => \led_ctrl_reg[0]_i_5_n_0\,
      O => \irq_enable_reg[31]_i_1_n_0\
    );
\irq_enable_reg[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFAACFFFFFFFFFFF"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => awaddr_reg(4),
      I2 => awaddr_reg(5),
      I3 => aw_pending,
      I4 => s_axi_awaddr(5),
      I5 => event_arbiter_n_17,
      O => \irq_enable_reg[31]_i_2_n_0\
    );
\irq_enable_reg[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"33553355F3FFF355"
    )
        port map (
      I0 => s_axi_awaddr(5),
      I1 => awaddr_reg(5),
      I2 => awaddr_reg(3),
      I3 => aw_pending,
      I4 => s_axi_awaddr(3),
      I5 => write_addr(4),
      O => \irq_enable_reg[31]_i_3_n_0\
    );
\irq_enable_reg[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \irq_enable_reg[31]_i_3_n_0\,
      I1 => \led_ctrl_reg[0]_i_3_n_0\,
      I2 => \led_ctrl_reg[0]_i_6_n_0\,
      I3 => \led_ctrl_reg[0]_i_5_n_0\,
      I4 => \irq_enable_reg[31]_i_2_n_0\,
      I5 => \led_ctrl_reg[0]_i_7_n_0\,
      O => \irq_enable_reg[7]_i_1_n_0\
    );
\irq_enable_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[7]_i_1_n_0\,
      D => event_arbiter_n_6,
      Q => irq_enable_reg(0),
      R => clear
    );
\irq_enable_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[10]_i_1_n_0\,
      Q => irq_enable_reg(10),
      R => clear
    );
\irq_enable_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[11]_i_1_n_0\,
      Q => irq_enable_reg(11),
      R => clear
    );
\irq_enable_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[12]_i_1_n_0\,
      Q => irq_enable_reg(12),
      R => clear
    );
\irq_enable_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[13]_i_1_n_0\,
      Q => irq_enable_reg(13),
      R => clear
    );
\irq_enable_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[14]_i_1_n_0\,
      Q => irq_enable_reg(14),
      R => clear
    );
\irq_enable_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[15]_i_2_n_0\,
      Q => irq_enable_reg(15),
      R => clear
    );
\irq_enable_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[16]_i_1_n_0\,
      Q => irq_enable_reg(16),
      R => clear
    );
\irq_enable_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[17]_i_1_n_0\,
      Q => irq_enable_reg(17),
      R => clear
    );
\irq_enable_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[18]_i_1_n_0\,
      Q => irq_enable_reg(18),
      R => clear
    );
\irq_enable_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[19]_i_1_n_0\,
      Q => irq_enable_reg(19),
      R => clear
    );
\irq_enable_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[7]_i_1_n_0\,
      D => p_0_in15_in,
      Q => irq_enable_reg(1),
      R => clear
    );
\irq_enable_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[20]_i_1_n_0\,
      Q => irq_enable_reg(20),
      R => clear
    );
\irq_enable_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[21]_i_1_n_0\,
      Q => irq_enable_reg(21),
      R => clear
    );
\irq_enable_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[22]_i_1_n_0\,
      Q => irq_enable_reg(22),
      R => clear
    );
\irq_enable_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[23]_i_2_n_0\,
      Q => irq_enable_reg(23),
      R => clear
    );
\irq_enable_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[24]_i_1_n_0\,
      Q => irq_enable_reg(24),
      R => clear
    );
\irq_enable_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[25]_i_1_n_0\,
      Q => irq_enable_reg(25),
      R => clear
    );
\irq_enable_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[26]_i_1_n_0\,
      Q => irq_enable_reg(26),
      R => clear
    );
\irq_enable_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[27]_i_1_n_0\,
      Q => irq_enable_reg(27),
      R => clear
    );
\irq_enable_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[28]_i_1_n_0\,
      Q => irq_enable_reg(28),
      R => clear
    );
\irq_enable_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[29]_i_1_n_0\,
      Q => irq_enable_reg(29),
      R => clear
    );
\irq_enable_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[7]_i_1_n_0\,
      D => p_0_in13_in,
      Q => irq_enable_reg(2),
      R => clear
    );
\irq_enable_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[30]_i_1_n_0\,
      Q => irq_enable_reg(30),
      R => clear
    );
\irq_enable_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[31]_i_1_n_0\,
      D => p_0_in10_in,
      Q => irq_enable_reg(31),
      R => clear
    );
\irq_enable_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[3]_i_1_n_0\,
      Q => irq_enable_reg(3),
      R => clear
    );
\irq_enable_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[4]_i_1_n_0\,
      Q => irq_enable_reg(4),
      R => clear
    );
\irq_enable_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[5]_i_1_n_0\,
      Q => irq_enable_reg(5),
      R => clear
    );
\irq_enable_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[6]_i_1_n_0\,
      Q => irq_enable_reg(6),
      R => clear
    );
\irq_enable_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[7]_i_1_n_0\,
      Q => irq_enable_reg(7),
      R => clear
    );
\irq_enable_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[8]_i_1_n_0\,
      Q => irq_enable_reg(8),
      R => clear
    );
\irq_enable_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \irq_enable_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[9]_i_1_n_0\,
      Q => irq_enable_reg(9),
      R => clear
    );
\led_ctrl_reg[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \led_ctrl_reg[0]_i_3_n_0\,
      I1 => \led_ctrl_reg[0]_i_4_n_0\,
      I2 => \led_ctrl_reg[0]_i_5_n_0\,
      I3 => \led_ctrl_reg[0]_i_6_n_0\,
      I4 => \led_ctrl_reg[0]_i_7_n_0\,
      O => \led_ctrl_reg[0]_i_1_n_0\
    );
\led_ctrl_reg[0]_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => awaddr_reg(0),
      I1 => aw_pending,
      I2 => s_axi_awaddr(0),
      O => \led_ctrl_reg[0]_i_10_n_0\
    );
\led_ctrl_reg[0]_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FFFE"
    )
        port map (
      I0 => s_axi_awaddr(13),
      I1 => s_axi_awaddr(14),
      I2 => aw_pending,
      I3 => s_axi_awaddr(15),
      I4 => event_arbiter_n_16,
      O => \led_ctrl_reg[0]_i_11_n_0\
    );
\led_ctrl_reg[0]_i_12\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00053305"
    )
        port map (
      I0 => s_axi_awaddr(0),
      I1 => awaddr_reg(0),
      I2 => s_axi_awaddr(12),
      I3 => aw_pending,
      I4 => awaddr_reg(12),
      O => \led_ctrl_reg[0]_i_12_n_0\
    );
\led_ctrl_reg[0]_i_13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => awaddr_reg(6),
      I1 => aw_pending,
      I2 => s_axi_awaddr(6),
      O => \led_ctrl_reg[0]_i_13_n_0\
    );
\led_ctrl_reg[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFAAAAFEAE"
    )
        port map (
      I0 => \led_ctrl_reg[0]_i_8_n_0\,
      I1 => s_axi_awaddr(2),
      I2 => aw_pending,
      I3 => awaddr_reg(2),
      I4 => \led_ctrl_reg[0]_i_9_n_0\,
      I5 => \led_ctrl_reg[0]_i_10_n_0\,
      O => \led_ctrl_reg[0]_i_3_n_0\
    );
\led_ctrl_reg[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF47FFFFFF"
    )
        port map (
      I0 => awaddr_reg(5),
      I1 => aw_pending,
      I2 => s_axi_awaddr(5),
      I3 => event_arbiter_n_17,
      I4 => write_addr(4),
      I5 => event_arbiter_n_14,
      O => \led_ctrl_reg[0]_i_4_n_0\
    );
\led_ctrl_reg[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEFEFFFFAEFEA"
    )
        port map (
      I0 => event_arbiter_n_18,
      I1 => awaddr_reg(10),
      I2 => aw_pending,
      I3 => s_axi_awaddr(10),
      I4 => awaddr_reg(9),
      I5 => s_axi_awaddr(9),
      O => \led_ctrl_reg[0]_i_5_n_0\
    );
\led_ctrl_reg[0]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFFFEEE"
    )
        port map (
      I0 => capture_arm_pulse_i_4_n_0,
      I1 => \led_ctrl_reg[0]_i_11_n_0\,
      I2 => awaddr_reg(11),
      I3 => aw_pending,
      I4 => s_axi_awaddr(11),
      O => \led_ctrl_reg[0]_i_6_n_0\
    );
\led_ctrl_reg[0]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1DFF"
    )
        port map (
      I0 => s_axi_wstrb(0),
      I1 => w_pending_reg_n_0,
      I2 => wstrb_reg(0),
      I3 => \led_ctrl_reg[0]_i_12_n_0\,
      O => \led_ctrl_reg[0]_i_7_n_0\
    );
\led_ctrl_reg[0]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CFCCAFAFCFCCAAAA"
    )
        port map (
      I0 => s_axi_awaddr(7),
      I1 => awaddr_reg(7),
      I2 => \led_ctrl_reg[0]_i_13_n_0\,
      I3 => awaddr_reg(1),
      I4 => aw_pending,
      I5 => s_axi_awaddr(1),
      O => \led_ctrl_reg[0]_i_8_n_0\
    );
\led_ctrl_reg[0]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => awaddr_reg(12),
      I1 => aw_pending,
      I2 => s_axi_awaddr(12),
      O => \led_ctrl_reg[0]_i_9_n_0\
    );
\led_ctrl_reg[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(10),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(10),
      O => \led_ctrl_reg[10]_i_1_n_0\
    );
\led_ctrl_reg[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(11),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(11),
      O => \led_ctrl_reg[11]_i_1_n_0\
    );
\led_ctrl_reg[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(12),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(12),
      O => \led_ctrl_reg[12]_i_1_n_0\
    );
\led_ctrl_reg[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(13),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(13),
      O => \led_ctrl_reg[13]_i_1_n_0\
    );
\led_ctrl_reg[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(14),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(14),
      O => \led_ctrl_reg[14]_i_1_n_0\
    );
\led_ctrl_reg[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \led_ctrl_reg[0]_i_3_n_0\,
      I1 => \led_ctrl_reg[0]_i_4_n_0\,
      I2 => \led_ctrl_reg[0]_i_5_n_0\,
      I3 => \led_ctrl_reg[0]_i_6_n_0\,
      I4 => \led_ctrl_reg[15]_i_3_n_0\,
      O => \led_ctrl_reg[15]_i_1_n_0\
    );
\led_ctrl_reg[15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(15),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(15),
      O => \led_ctrl_reg[15]_i_2_n_0\
    );
\led_ctrl_reg[15]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"57F7"
    )
        port map (
      I0 => \led_ctrl_reg[0]_i_12_n_0\,
      I1 => s_axi_wstrb(1),
      I2 => w_pending_reg_n_0,
      I3 => wstrb_reg(1),
      O => \led_ctrl_reg[15]_i_3_n_0\
    );
\led_ctrl_reg[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(16),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(16),
      O => \led_ctrl_reg[16]_i_1_n_0\
    );
\led_ctrl_reg[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(17),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(17),
      O => \led_ctrl_reg[17]_i_1_n_0\
    );
\led_ctrl_reg[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(18),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(18),
      O => \led_ctrl_reg[18]_i_1_n_0\
    );
\led_ctrl_reg[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(19),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(19),
      O => \led_ctrl_reg[19]_i_1_n_0\
    );
\led_ctrl_reg[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(1),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(1),
      O => p_0_in15_in
    );
\led_ctrl_reg[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(20),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(20),
      O => \led_ctrl_reg[20]_i_1_n_0\
    );
\led_ctrl_reg[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(21),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(21),
      O => \led_ctrl_reg[21]_i_1_n_0\
    );
\led_ctrl_reg[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(22),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(22),
      O => \led_ctrl_reg[22]_i_1_n_0\
    );
\led_ctrl_reg[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \led_ctrl_reg[0]_i_3_n_0\,
      I1 => \led_ctrl_reg[0]_i_4_n_0\,
      I2 => \led_ctrl_reg[0]_i_5_n_0\,
      I3 => \led_ctrl_reg[0]_i_6_n_0\,
      I4 => \led_ctrl_reg[23]_i_3_n_0\,
      O => \led_ctrl_reg[23]_i_1_n_0\
    );
\led_ctrl_reg[23]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(23),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(23),
      O => \led_ctrl_reg[23]_i_2_n_0\
    );
\led_ctrl_reg[23]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"57F7"
    )
        port map (
      I0 => \led_ctrl_reg[0]_i_12_n_0\,
      I1 => s_axi_wstrb(2),
      I2 => w_pending_reg_n_0,
      I3 => wstrb_reg(2),
      O => \led_ctrl_reg[23]_i_3_n_0\
    );
\led_ctrl_reg[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(24),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(24),
      O => \led_ctrl_reg[24]_i_1_n_0\
    );
\led_ctrl_reg[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(25),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(25),
      O => \led_ctrl_reg[25]_i_1_n_0\
    );
\led_ctrl_reg[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(26),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(26),
      O => \led_ctrl_reg[26]_i_1_n_0\
    );
\led_ctrl_reg[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(27),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(27),
      O => \led_ctrl_reg[27]_i_1_n_0\
    );
\led_ctrl_reg[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(28),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(28),
      O => \led_ctrl_reg[28]_i_1_n_0\
    );
\led_ctrl_reg[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(29),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(29),
      O => \led_ctrl_reg[29]_i_1_n_0\
    );
\led_ctrl_reg[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(2),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(2),
      O => p_0_in13_in
    );
\led_ctrl_reg[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(30),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(30),
      O => \led_ctrl_reg[30]_i_1_n_0\
    );
\led_ctrl_reg[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \led_ctrl_reg[31]_i_3_n_0\,
      I1 => \led_ctrl_reg[0]_i_3_n_0\,
      I2 => \led_ctrl_reg[0]_i_4_n_0\,
      I3 => \led_ctrl_reg[0]_i_5_n_0\,
      I4 => \led_ctrl_reg[0]_i_6_n_0\,
      O => \led_ctrl_reg[31]_i_1_n_0\
    );
\led_ctrl_reg[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(31),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(31),
      O => p_0_in10_in
    );
\led_ctrl_reg[31]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E200"
    )
        port map (
      I0 => s_axi_wstrb(3),
      I1 => w_pending_reg_n_0,
      I2 => wstrb_reg(3),
      I3 => \led_ctrl_reg[0]_i_12_n_0\,
      O => \led_ctrl_reg[31]_i_3_n_0\
    );
\led_ctrl_reg[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(3),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(3),
      O => \led_ctrl_reg[3]_i_1_n_0\
    );
\led_ctrl_reg[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(4),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(4),
      O => \led_ctrl_reg[4]_i_1_n_0\
    );
\led_ctrl_reg[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(5),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(5),
      O => \led_ctrl_reg[5]_i_1_n_0\
    );
\led_ctrl_reg[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(6),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(6),
      O => \led_ctrl_reg[6]_i_1_n_0\
    );
\led_ctrl_reg[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(7),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(7),
      O => \led_ctrl_reg[7]_i_1_n_0\
    );
\led_ctrl_reg[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(8),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(8),
      O => \led_ctrl_reg[8]_i_1_n_0\
    );
\led_ctrl_reg[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => wdata_reg(9),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wdata(9),
      O => \led_ctrl_reg[9]_i_1_n_0\
    );
\led_ctrl_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[0]_i_1_n_0\,
      D => event_arbiter_n_6,
      Q => \^led_ps_active\,
      R => clear
    );
\led_ctrl_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[10]_i_1_n_0\,
      Q => led_ctrl_reg(10),
      R => clear
    );
\led_ctrl_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[11]_i_1_n_0\,
      Q => led_ctrl_reg(11),
      R => clear
    );
\led_ctrl_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[12]_i_1_n_0\,
      Q => led_ctrl_reg(12),
      R => clear
    );
\led_ctrl_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[13]_i_1_n_0\,
      Q => led_ctrl_reg(13),
      R => clear
    );
\led_ctrl_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[14]_i_1_n_0\,
      Q => led_ctrl_reg(14),
      R => clear
    );
\led_ctrl_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[15]_i_2_n_0\,
      Q => led_ctrl_reg(15),
      R => clear
    );
\led_ctrl_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[16]_i_1_n_0\,
      Q => led_ctrl_reg(16),
      R => clear
    );
\led_ctrl_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[17]_i_1_n_0\,
      Q => led_ctrl_reg(17),
      R => clear
    );
\led_ctrl_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[18]_i_1_n_0\,
      Q => led_ctrl_reg(18),
      R => clear
    );
\led_ctrl_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[19]_i_1_n_0\,
      Q => led_ctrl_reg(19),
      R => clear
    );
\led_ctrl_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[0]_i_1_n_0\,
      D => p_0_in15_in,
      Q => led_ctrl_reg(1),
      R => clear
    );
\led_ctrl_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[20]_i_1_n_0\,
      Q => led_ctrl_reg(20),
      R => clear
    );
\led_ctrl_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[21]_i_1_n_0\,
      Q => led_ctrl_reg(21),
      R => clear
    );
\led_ctrl_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[22]_i_1_n_0\,
      Q => led_ctrl_reg(22),
      R => clear
    );
\led_ctrl_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[23]_i_2_n_0\,
      Q => led_ctrl_reg(23),
      R => clear
    );
\led_ctrl_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[24]_i_1_n_0\,
      Q => led_ctrl_reg(24),
      R => clear
    );
\led_ctrl_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[25]_i_1_n_0\,
      Q => led_ctrl_reg(25),
      R => clear
    );
\led_ctrl_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[26]_i_1_n_0\,
      Q => led_ctrl_reg(26),
      R => clear
    );
\led_ctrl_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[27]_i_1_n_0\,
      Q => led_ctrl_reg(27),
      R => clear
    );
\led_ctrl_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[28]_i_1_n_0\,
      Q => led_ctrl_reg(28),
      R => clear
    );
\led_ctrl_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[29]_i_1_n_0\,
      Q => led_ctrl_reg(29),
      R => clear
    );
\led_ctrl_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[0]_i_1_n_0\,
      D => p_0_in13_in,
      Q => led_ctrl_reg(2),
      R => clear
    );
\led_ctrl_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[30]_i_1_n_0\,
      Q => led_ctrl_reg(30),
      R => clear
    );
\led_ctrl_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[31]_i_1_n_0\,
      D => p_0_in10_in,
      Q => led_ctrl_reg(31),
      R => clear
    );
\led_ctrl_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[0]_i_1_n_0\,
      D => \led_ctrl_reg[3]_i_1_n_0\,
      Q => led_ctrl_reg(3),
      R => clear
    );
\led_ctrl_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[0]_i_1_n_0\,
      D => \led_ctrl_reg[4]_i_1_n_0\,
      Q => led_ctrl_reg(4),
      R => clear
    );
\led_ctrl_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[0]_i_1_n_0\,
      D => \led_ctrl_reg[5]_i_1_n_0\,
      Q => led_ctrl_reg(5),
      R => clear
    );
\led_ctrl_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[0]_i_1_n_0\,
      D => \led_ctrl_reg[6]_i_1_n_0\,
      Q => led_ctrl_reg(6),
      R => clear
    );
\led_ctrl_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[0]_i_1_n_0\,
      D => \led_ctrl_reg[7]_i_1_n_0\,
      Q => led_ctrl_reg(7),
      R => clear
    );
\led_ctrl_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[8]_i_1_n_0\,
      Q => led_ctrl_reg(8),
      R => clear
    );
\led_ctrl_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \led_ctrl_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[9]_i_1_n_0\,
      Q => led_ctrl_reg(9),
      R => clear
    );
s_axi_arready_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => snapshot_read_pending_reg_n_0,
      I1 => \^s_axi_rvalid\,
      O => s_axi_arready0
    );
s_axi_arready_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_arready0,
      Q => \^s_axi_arready\,
      R => clear
    );
s_axi_awready_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^s_axi_bvalid_reg_0\,
      I1 => aw_pending,
      O => s_axi_awready0
    );
s_axi_awready_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_awready0,
      Q => \^s_axi_awready\,
      R => clear
    );
s_axi_bvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000EEE0FFFFEEE0"
    )
        port map (
      I0 => aw_pending,
      I1 => aw_hs,
      I2 => w_hs,
      I3 => w_pending_reg_n_0,
      I4 => \^s_axi_bvalid_reg_0\,
      I5 => s_axi_bready,
      O => s_axi_bvalid_i_1_n_0
    );
s_axi_bvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_bvalid_i_1_n_0,
      Q => \^s_axi_bvalid_reg_0\,
      R => clear
    );
s_axi_rdata2_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => s_axi_rdata2_carry_n_0,
      CO(2) => s_axi_rdata2_carry_n_1,
      CO(1) => s_axi_rdata2_carry_n_2,
      CO(0) => s_axi_rdata2_carry_n_3,
      CYINIT => '0',
      DI(3) => capture_buffer_n_77,
      DI(2) => capture_buffer_n_78,
      DI(1) => capture_buffer_n_79,
      DI(0) => capture_buffer_n_80,
      O(3 downto 0) => NLW_s_axi_rdata2_carry_O_UNCONNECTED(3 downto 0),
      S(3) => capture_buffer_n_73,
      S(2) => capture_buffer_n_74,
      S(1) => capture_buffer_n_75,
      S(0) => capture_buffer_n_76
    );
\s_axi_rdata2_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => s_axi_rdata2_carry_n_0,
      CO(3 downto 1) => \NLW_s_axi_rdata2_carry__0_CO_UNCONNECTED\(3 downto 1),
      CO(0) => s_axi_rdata2,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => snapshot_count(8),
      O(3 downto 0) => \NLW_s_axi_rdata2_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3 downto 1) => B"000",
      S(0) => capture_buffer_n_81
    );
\s_axi_rdata[0]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(0),
      I1 => data5(0),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(0),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(0),
      O => \s_axi_rdata[0]_i_7_n_0\
    );
\s_axi_rdata[0]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1414544414141404"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(3),
      I2 => s_axi_araddr(4),
      I3 => sys_ctrl_reg(0),
      I4 => s_axi_araddr(2),
      I5 => io_mode_reg(0),
      O => \s_axi_rdata[0]_i_8_n_0\
    );
\s_axi_rdata[10]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(10),
      I2 => sys_ctrl_reg(10),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => s_axi_araddr(12),
      I5 => s_axi_araddr(0),
      O => \s_axi_rdata[10]_i_5_n_0\
    );
\s_axi_rdata[10]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(10),
      I1 => data5(10),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(10),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(10),
      O => \s_axi_rdata[10]_i_6_n_0\
    );
\s_axi_rdata[11]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(11),
      I2 => sys_ctrl_reg(11),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => \s_axi_rdata[29]_i_9_n_0\,
      O => \s_axi_rdata[11]_i_5_n_0\
    );
\s_axi_rdata[11]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(11),
      I1 => data5(11),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(11),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(11),
      O => \s_axi_rdata[11]_i_6_n_0\
    );
\s_axi_rdata[12]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(12),
      I1 => data5(12),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(12),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(12),
      O => \s_axi_rdata[12]_i_6_n_0\
    );
\s_axi_rdata[12]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000445100000051"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(4),
      I2 => sys_ctrl_reg(12),
      I3 => s_axi_araddr(3),
      I4 => s_axi_araddr(2),
      I5 => io_mode_reg(12),
      O => \s_axi_rdata[12]_i_7_n_0\
    );
\s_axi_rdata[13]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(13),
      I2 => sys_ctrl_reg(13),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => s_axi_araddr(12),
      I5 => s_axi_araddr(0),
      O => \s_axi_rdata[13]_i_5_n_0\
    );
\s_axi_rdata[13]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(13),
      I1 => data5(13),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(13),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(13),
      O => \s_axi_rdata[13]_i_6_n_0\
    );
\s_axi_rdata[14]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF444F4F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(14),
      I2 => \s_axi_rdata[30]_i_9_n_0\,
      I3 => sys_ctrl_reg(14),
      I4 => s_axi_araddr(4),
      I5 => \s_axi_rdata[31]_i_12_n_0\,
      O => \s_axi_rdata[14]_i_5_n_0\
    );
\s_axi_rdata[14]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(14),
      I1 => data5(14),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(14),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(14),
      O => \s_axi_rdata[14]_i_6_n_0\
    );
\s_axi_rdata[15]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(15),
      I2 => sys_ctrl_reg(15),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => s_axi_araddr(12),
      I5 => s_axi_araddr(0),
      O => \s_axi_rdata[15]_i_5_n_0\
    );
\s_axi_rdata[15]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(15),
      I1 => data5(15),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(15),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(15),
      O => \s_axi_rdata[15]_i_6_n_0\
    );
\s_axi_rdata[16]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(16),
      I1 => data5(16),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(16),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(16),
      O => \s_axi_rdata[16]_i_5_n_0\
    );
\s_axi_rdata[16]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FAEFFEEFFBEFFFEF"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(3),
      I2 => s_axi_araddr(2),
      I3 => s_axi_araddr(4),
      I4 => io_mode_reg(16),
      I5 => sys_ctrl_reg(16),
      O => \s_axi_rdata[16]_i_7_n_0\
    );
\s_axi_rdata[17]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(17),
      I2 => sys_ctrl_reg(17),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => \s_axi_rdata[29]_i_9_n_0\,
      O => \s_axi_rdata[17]_i_5_n_0\
    );
\s_axi_rdata[17]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(17),
      I1 => data5(17),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(17),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(17),
      O => \s_axi_rdata[17]_i_6_n_0\
    );
\s_axi_rdata[18]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(18),
      I2 => sys_ctrl_reg(18),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => \s_axi_rdata[29]_i_9_n_0\,
      O => \s_axi_rdata[18]_i_5_n_0\
    );
\s_axi_rdata[18]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(18),
      I1 => data5(18),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(18),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(18),
      O => \s_axi_rdata[18]_i_6_n_0\
    );
\s_axi_rdata[19]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(19),
      I2 => sys_ctrl_reg(19),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => s_axi_araddr(12),
      I5 => s_axi_araddr(0),
      O => \s_axi_rdata[19]_i_5_n_0\
    );
\s_axi_rdata[19]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(19),
      I1 => data5(19),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(19),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(19),
      O => \s_axi_rdata[19]_i_6_n_0\
    );
\s_axi_rdata[1]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(1),
      I1 => data5(1),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(1),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(1),
      O => \s_axi_rdata[1]_i_7_n_0\
    );
\s_axi_rdata[1]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0505050545455000"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => io_mode_reg(1),
      I2 => s_axi_araddr(4),
      I3 => sys_ctrl_reg(1),
      I4 => s_axi_araddr(3),
      I5 => s_axi_araddr(2),
      O => \s_axi_rdata[1]_i_8_n_0\
    );
\s_axi_rdata[20]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(20),
      I1 => data5(20),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(20),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(20),
      O => \s_axi_rdata[20]_i_6_n_0\
    );
\s_axi_rdata[20]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000445100000051"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(4),
      I2 => sys_ctrl_reg(20),
      I3 => s_axi_araddr(3),
      I4 => s_axi_araddr(2),
      I5 => io_mode_reg(20),
      O => \s_axi_rdata[20]_i_7_n_0\
    );
\s_axi_rdata[21]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(21),
      I2 => sys_ctrl_reg(21),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => \s_axi_rdata[29]_i_9_n_0\,
      O => \s_axi_rdata[21]_i_5_n_0\
    );
\s_axi_rdata[21]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(21),
      I1 => data5(21),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(21),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(21),
      O => \s_axi_rdata[21]_i_6_n_0\
    );
\s_axi_rdata[22]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(22),
      I1 => data5(22),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(22),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(22),
      O => \s_axi_rdata[22]_i_6_n_0\
    );
\s_axi_rdata[22]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000445100000051"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(4),
      I2 => sys_ctrl_reg(22),
      I3 => s_axi_araddr(3),
      I4 => s_axi_araddr(2),
      I5 => io_mode_reg(22),
      O => \s_axi_rdata[22]_i_7_n_0\
    );
\s_axi_rdata[23]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(23),
      I2 => sys_ctrl_reg(23),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => s_axi_araddr(12),
      I5 => s_axi_araddr(0),
      O => \s_axi_rdata[23]_i_5_n_0\
    );
\s_axi_rdata[23]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(23),
      I1 => data5(23),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(23),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(23),
      O => \s_axi_rdata[23]_i_6_n_0\
    );
\s_axi_rdata[24]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF444F4F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(24),
      I2 => \s_axi_rdata[30]_i_9_n_0\,
      I3 => sys_ctrl_reg(24),
      I4 => s_axi_araddr(4),
      I5 => \s_axi_rdata[31]_i_12_n_0\,
      O => \s_axi_rdata[24]_i_5_n_0\
    );
\s_axi_rdata[24]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(24),
      I1 => data5(24),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(24),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(24),
      O => \s_axi_rdata[24]_i_6_n_0\
    );
\s_axi_rdata[25]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(25),
      I2 => sys_ctrl_reg(25),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => s_axi_araddr(12),
      I5 => s_axi_araddr(0),
      O => \s_axi_rdata[25]_i_5_n_0\
    );
\s_axi_rdata[25]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(25),
      I1 => data5(25),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(25),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(25),
      O => \s_axi_rdata[25]_i_6_n_0\
    );
\s_axi_rdata[26]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(26),
      I1 => data5(26),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(26),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(26),
      O => \s_axi_rdata[26]_i_6_n_0\
    );
\s_axi_rdata[26]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000445100000051"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(4),
      I2 => sys_ctrl_reg(26),
      I3 => s_axi_araddr(3),
      I4 => s_axi_araddr(2),
      I5 => io_mode_reg(26),
      O => \s_axi_rdata[26]_i_7_n_0\
    );
\s_axi_rdata[27]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000445100000051"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(4),
      I2 => sys_ctrl_reg(27),
      I3 => s_axi_araddr(3),
      I4 => s_axi_araddr(2),
      I5 => io_mode_reg(27),
      O => \s_axi_rdata[27]_i_10_n_0\
    );
\s_axi_rdata[27]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFEFEFE"
    )
        port map (
      I0 => s_axi_araddr(6),
      I1 => s_axi_araddr(1),
      I2 => s_axi_araddr(8),
      I3 => s_axi_araddr(5),
      I4 => s_axi_araddr(12),
      I5 => s_axi_araddr(15),
      O => \s_axi_rdata[27]_i_7_n_0\
    );
\s_axi_rdata[27]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(27),
      I1 => data5(27),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(27),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(27),
      O => \s_axi_rdata[27]_i_9_n_0\
    );
\s_axi_rdata[28]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(28),
      I2 => sys_ctrl_reg(28),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => s_axi_araddr(12),
      I5 => s_axi_araddr(0),
      O => \s_axi_rdata[28]_i_5_n_0\
    );
\s_axi_rdata[28]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(28),
      I1 => data5(28),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(28),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(28),
      O => \s_axi_rdata[28]_i_6_n_0\
    );
\s_axi_rdata[29]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(29),
      I2 => sys_ctrl_reg(29),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => \s_axi_rdata[29]_i_9_n_0\,
      O => \s_axi_rdata[29]_i_5_n_0\
    );
\s_axi_rdata[29]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(29),
      I1 => data5(29),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(29),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(29),
      O => \s_axi_rdata[29]_i_6_n_0\
    );
\s_axi_rdata[29]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEFF"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => s_axi_araddr(2),
      I2 => s_axi_araddr(5),
      I3 => s_axi_araddr(4),
      O => \s_axi_rdata[29]_i_8_n_0\
    );
\s_axi_rdata[29]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4444444444444F44"
    )
        port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_araddr(12),
      I2 => s_axi_araddr(4),
      I3 => s_axi_araddr(3),
      I4 => s_axi_araddr(2),
      I5 => s_axi_araddr(5),
      O => \s_axi_rdata[29]_i_9_n_0\
    );
\s_axi_rdata[2]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(2),
      I1 => data5(2),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(2),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(2),
      O => \s_axi_rdata[2]_i_7_n_0\
    );
\s_axi_rdata[2]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000445100000051"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(4),
      I2 => sys_ctrl_reg(2),
      I3 => s_axi_araddr(3),
      I4 => s_axi_araddr(2),
      I5 => io_mode_reg(2),
      O => \s_axi_rdata[2]_i_8_n_0\
    );
\s_axi_rdata[30]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF444F4F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(30),
      I2 => \s_axi_rdata[30]_i_9_n_0\,
      I3 => sys_ctrl_reg(30),
      I4 => s_axi_araddr(4),
      I5 => \s_axi_rdata[31]_i_12_n_0\,
      O => \s_axi_rdata[30]_i_5_n_0\
    );
\s_axi_rdata[30]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(30),
      I1 => data5(30),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(30),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(30),
      O => \s_axi_rdata[30]_i_6_n_0\
    );
\s_axi_rdata[30]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FBFF"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(4),
      I2 => s_axi_araddr(2),
      I3 => s_axi_araddr(3),
      O => \s_axi_rdata[30]_i_8_n_0\
    );
\s_axi_rdata[30]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(3),
      I2 => s_axi_araddr(2),
      O => \s_axi_rdata[30]_i_9_n_0\
    );
\s_axi_rdata[31]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFAEAAAEAAAAAAAA"
    )
        port map (
      I0 => \s_axi_rdata[31]_i_12_n_0\,
      I1 => sys_ctrl_reg(31),
      I2 => s_axi_araddr(2),
      I3 => s_axi_araddr(3),
      I4 => io_mode_reg(31),
      I5 => \s_axi_rdata[31]_i_16_n_0\,
      O => \s_axi_rdata[31]_i_10_n_0\
    );
\s_axi_rdata[31]_i_11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FB"
    )
        port map (
      I0 => s_axi_araddr(4),
      I1 => s_axi_araddr(3),
      I2 => s_axi_araddr(2),
      O => \s_axi_rdata[31]_i_11_n_0\
    );
\s_axi_rdata[31]_i_12\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_araddr(12),
      I1 => s_axi_araddr(0),
      O => \s_axi_rdata[31]_i_12_n_0\
    );
\s_axi_rdata[31]_i_13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"DF"
    )
        port map (
      I0 => s_axi_araddr(2),
      I1 => s_axi_araddr(3),
      I2 => s_axi_araddr(4),
      O => \s_axi_rdata[31]_i_13_n_0\
    );
\s_axi_rdata[31]_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(31),
      I1 => data5(31),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(31),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(31),
      O => \s_axi_rdata[31]_i_14_n_0\
    );
\s_axi_rdata[31]_i_16\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_araddr(4),
      I1 => s_axi_araddr(5),
      O => \s_axi_rdata[31]_i_16_n_0\
    );
\s_axi_rdata[31]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFF"
    )
        port map (
      I0 => s_axi_araddr(12),
      I1 => s_axi_araddr(15),
      I2 => s_axi_araddr(14),
      I3 => s_axi_araddr(13),
      O => \s_axi_rdata[31]_i_4_n_0\
    );
\s_axi_rdata[31]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^s_axi_arready\,
      I1 => s_axi_arvalid,
      O => \s_axi_rdata[31]_i_5_n_0\
    );
\s_axi_rdata[3]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \s_axi_rdata[3]_i_14_n_0\,
      I1 => \s_axi_rdata[3]_i_15_n_0\,
      I2 => \s_axi_rdata[3]_i_16_n_0\,
      I3 => \s_axi_rdata[3]_i_17_n_0\,
      O => \s_axi_rdata[3]_i_10_n_0\
    );
\s_axi_rdata[3]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => \s_axi_rdata[3]_i_18_n_0\,
      I1 => \s_axi_rdata[3]_i_19_n_0\,
      I2 => \s_axi_rdata[3]_i_20_n_0\,
      I3 => \s_axi_rdata[3]_i_21_n_0\,
      O => \s_axi_rdata[3]_i_11_n_0\
    );
\s_axi_rdata[3]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \s_axi_rdata[3]_i_22_n_0\,
      I1 => \s_axi_rdata[3]_i_23_n_0\,
      I2 => \s_axi_rdata[3]_i_24_n_0\,
      I3 => \s_axi_rdata[3]_i_25_n_0\,
      O => \s_axi_rdata[3]_i_12_n_0\
    );
\s_axi_rdata[3]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \s_axi_rdata[3]_i_26_n_0\,
      I1 => \s_axi_rdata[3]_i_27_n_0\,
      I2 => \s_axi_rdata[3]_i_28_n_0\,
      I3 => \s_axi_rdata[3]_i_29_n_0\,
      O => \s_axi_rdata[3]_i_13_n_0\
    );
\s_axi_rdata[3]_i_14\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => ext_evt_dropped_count(21),
      I1 => ext_evt_dropped_count(20),
      I2 => ext_evt_dropped_count(23),
      I3 => ext_evt_dropped_count(22),
      O => \s_axi_rdata[3]_i_14_n_0\
    );
\s_axi_rdata[3]_i_15\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => ext_evt_dropped_count(18),
      I1 => ext_evt_dropped_count(17),
      I2 => ext_evt_dropped_count(19),
      I3 => ext_evt_dropped_count(16),
      O => \s_axi_rdata[3]_i_15_n_0\
    );
\s_axi_rdata[3]_i_16\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => ext_evt_dropped_count(29),
      I1 => ext_evt_dropped_count(28),
      I2 => ext_evt_dropped_count(30),
      I3 => ext_evt_dropped_count(31),
      O => \s_axi_rdata[3]_i_16_n_0\
    );
\s_axi_rdata[3]_i_17\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => ext_evt_dropped_count(27),
      I1 => ext_evt_dropped_count(26),
      I2 => ext_evt_dropped_count(25),
      I3 => ext_evt_dropped_count(24),
      O => \s_axi_rdata[3]_i_17_n_0\
    );
\s_axi_rdata[3]_i_18\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => ext_evt_dropped_count(5),
      I1 => ext_evt_dropped_count(4),
      I2 => ext_evt_dropped_count(7),
      I3 => ext_evt_dropped_count(6),
      O => \s_axi_rdata[3]_i_18_n_0\
    );
\s_axi_rdata[3]_i_19\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => ext_evt_dropped_count(2),
      I1 => ext_evt_dropped_count(1),
      I2 => ext_evt_dropped_count(3),
      I3 => ext_evt_dropped_count(0),
      O => \s_axi_rdata[3]_i_19_n_0\
    );
\s_axi_rdata[3]_i_20\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => ext_evt_dropped_count(14),
      I1 => ext_evt_dropped_count(13),
      I2 => ext_evt_dropped_count(15),
      I3 => ext_evt_dropped_count(12),
      O => \s_axi_rdata[3]_i_20_n_0\
    );
\s_axi_rdata[3]_i_21\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => ext_evt_dropped_count(9),
      I1 => ext_evt_dropped_count(8),
      I2 => ext_evt_dropped_count(11),
      I3 => ext_evt_dropped_count(10),
      O => \s_axi_rdata[3]_i_21_n_0\
    );
\s_axi_rdata[3]_i_22\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => dropped_count_reg(14),
      I1 => dropped_count_reg(13),
      I2 => dropped_count_reg(15),
      I3 => dropped_count_reg(12),
      O => \s_axi_rdata[3]_i_22_n_0\
    );
\s_axi_rdata[3]_i_23\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => dropped_count_reg(10),
      I1 => dropped_count_reg(9),
      I2 => dropped_count_reg(11),
      I3 => dropped_count_reg(8),
      O => \s_axi_rdata[3]_i_23_n_0\
    );
\s_axi_rdata[3]_i_24\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => dropped_count_reg(5),
      I1 => dropped_count_reg(4),
      I2 => dropped_count_reg(7),
      I3 => dropped_count_reg(6),
      O => \s_axi_rdata[3]_i_24_n_0\
    );
\s_axi_rdata[3]_i_25\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => dropped_count_reg(2),
      I1 => dropped_count_reg(0),
      I2 => dropped_count_reg(3),
      I3 => dropped_count_reg(1),
      O => \s_axi_rdata[3]_i_25_n_0\
    );
\s_axi_rdata[3]_i_26\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => dropped_count_reg(21),
      I1 => dropped_count_reg(20),
      I2 => dropped_count_reg(23),
      I3 => dropped_count_reg(22),
      O => \s_axi_rdata[3]_i_26_n_0\
    );
\s_axi_rdata[3]_i_27\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => dropped_count_reg(18),
      I1 => dropped_count_reg(17),
      I2 => dropped_count_reg(19),
      I3 => dropped_count_reg(16),
      O => \s_axi_rdata[3]_i_27_n_0\
    );
\s_axi_rdata[3]_i_28\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => dropped_count_reg(29),
      I1 => dropped_count_reg(28),
      I2 => dropped_count_reg(30),
      I3 => dropped_count_reg(31),
      O => \s_axi_rdata[3]_i_28_n_0\
    );
\s_axi_rdata[3]_i_29\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => dropped_count_reg(27),
      I1 => dropped_count_reg(26),
      I2 => dropped_count_reg(25),
      I3 => dropped_count_reg(24),
      O => \s_axi_rdata[3]_i_29_n_0\
    );
\s_axi_rdata[3]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(3),
      I2 => sys_ctrl_reg(3),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => s_axi_araddr(12),
      I5 => s_axi_araddr(0),
      O => \s_axi_rdata[3]_i_6_n_0\
    );
\s_axi_rdata[3]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(3),
      I1 => data5(3),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(3),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(3),
      O => \s_axi_rdata[3]_i_7_n_0\
    );
\s_axi_rdata[4]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF444F4F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(4),
      I2 => \s_axi_rdata[30]_i_9_n_0\,
      I3 => sys_ctrl_reg(4),
      I4 => s_axi_araddr(4),
      I5 => \s_axi_rdata[31]_i_12_n_0\,
      O => \s_axi_rdata[4]_i_5_n_0\
    );
\s_axi_rdata[4]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(4),
      I1 => data5(4),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(4),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(4),
      O => \s_axi_rdata[4]_i_7_n_0\
    );
\s_axi_rdata[5]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEAEFFAE"
    )
        port map (
      I0 => \s_axi_rdata[29]_i_9_n_0\,
      I1 => io_mode_reg(5),
      I2 => \s_axi_rdata[30]_i_8_n_0\,
      I3 => sys_ctrl_reg(5),
      I4 => \s_axi_rdata[29]_i_8_n_0\,
      O => \s_axi_rdata[5]_i_5_n_0\
    );
\s_axi_rdata[5]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(5),
      I1 => data5(5),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(5),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(5),
      O => \s_axi_rdata[5]_i_7_n_0\
    );
\s_axi_rdata[6]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(6),
      I1 => data5(6),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(6),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(6),
      O => \s_axi_rdata[6]_i_7_n_0\
    );
\s_axi_rdata[6]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000445100000051"
    )
        port map (
      I0 => s_axi_araddr(5),
      I1 => s_axi_araddr(4),
      I2 => sys_ctrl_reg(6),
      I3 => s_axi_araddr(3),
      I4 => s_axi_araddr(2),
      I5 => io_mode_reg(6),
      O => \s_axi_rdata[6]_i_8_n_0\
    );
\s_axi_rdata[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(7),
      I2 => sys_ctrl_reg(7),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => s_axi_araddr(12),
      I5 => s_axi_araddr(0),
      O => \s_axi_rdata[7]_i_5_n_0\
    );
\s_axi_rdata[7]_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_araddr(4),
      I1 => s_axi_araddr(3),
      O => \s_axi_rdata[7]_i_7_n_0\
    );
\s_axi_rdata[7]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"5D"
    )
        port map (
      I0 => s_axi_araddr(4),
      I1 => s_axi_araddr(2),
      I2 => s_axi_araddr(3),
      O => \s_axi_rdata[7]_i_8_n_0\
    );
\s_axi_rdata[7]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(7),
      I1 => data5(7),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(7),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(7),
      O => \s_axi_rdata[7]_i_9_n_0\
    );
\s_axi_rdata[8]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF44F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(8),
      I2 => sys_ctrl_reg(8),
      I3 => \s_axi_rdata[29]_i_8_n_0\,
      I4 => \s_axi_rdata[29]_i_9_n_0\,
      O => \s_axi_rdata[8]_i_5_n_0\
    );
\s_axi_rdata[8]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(8),
      I1 => data5(8),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(8),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(8),
      O => \s_axi_rdata[8]_i_7_n_0\
    );
\s_axi_rdata[9]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF444F4F4"
    )
        port map (
      I0 => \s_axi_rdata[30]_i_8_n_0\,
      I1 => io_mode_reg(9),
      I2 => \s_axi_rdata[30]_i_9_n_0\,
      I3 => sys_ctrl_reg(9),
      I4 => s_axi_araddr(4),
      I5 => \s_axi_rdata[31]_i_12_n_0\,
      O => \s_axi_rdata[9]_i_5_n_0\
    );
\s_axi_rdata[9]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => scratch_reg(9),
      I1 => data5(9),
      I2 => s_axi_araddr(3),
      I3 => timestamp_counter_reg(9),
      I4 => s_axi_araddr(2),
      I5 => irq_enable_reg(9),
      O => \s_axi_rdata[9]_i_6_n_0\
    );
\s_axi_rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_70,
      Q => s_axi_rdata(0),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_60,
      Q => s_axi_rdata(10),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_59,
      Q => s_axi_rdata(11),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_58,
      Q => s_axi_rdata(12),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_57,
      Q => s_axi_rdata(13),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_56,
      Q => s_axi_rdata(14),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_55,
      Q => s_axi_rdata(15),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_54,
      Q => s_axi_rdata(16),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_53,
      Q => s_axi_rdata(17),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_52,
      Q => s_axi_rdata(18),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_51,
      Q => s_axi_rdata(19),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_69,
      Q => s_axi_rdata(1),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_50,
      Q => s_axi_rdata(20),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_49,
      Q => s_axi_rdata(21),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_48,
      Q => s_axi_rdata(22),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_47,
      Q => s_axi_rdata(23),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_46,
      Q => s_axi_rdata(24),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_45,
      Q => s_axi_rdata(25),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_44,
      Q => s_axi_rdata(26),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_43,
      Q => s_axi_rdata(27),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_42,
      Q => s_axi_rdata(28),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_41,
      Q => s_axi_rdata(29),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_68,
      Q => s_axi_rdata(2),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_40,
      Q => s_axi_rdata(30),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_39,
      Q => s_axi_rdata(31),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_67,
      Q => s_axi_rdata(3),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_66,
      Q => s_axi_rdata(4),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_65,
      Q => s_axi_rdata(5),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_64,
      Q => s_axi_rdata(6),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_63,
      Q => s_axi_rdata(7),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_62,
      Q => s_axi_rdata(8),
      R => capture_buffer_n_2
    );
\s_axi_rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_3,
      D => capture_buffer_n_61,
      Q => s_axi_rdata(9),
      R => capture_buffer_n_2
    );
s_axi_rvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => capture_buffer_n_82,
      Q => \^s_axi_rvalid\,
      R => clear
    );
s_axi_wready_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^s_axi_bvalid_reg_0\,
      I1 => w_pending_reg_n_0,
      O => s_axi_wready0
    );
s_axi_wready_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_wready0,
      Q => \^s_axi_wready\,
      R => clear
    );
\scratch_reg[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => \scratch_reg[31]_i_2_n_0\,
      I1 => \scratch_reg[31]_i_3_n_0\,
      I2 => \led_ctrl_reg[15]_i_3_n_0\,
      I3 => \irq_enable_reg[31]_i_2_n_0\,
      O => \scratch_reg[15]_i_1_n_0\
    );
\scratch_reg[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => \scratch_reg[31]_i_2_n_0\,
      I1 => \scratch_reg[31]_i_3_n_0\,
      I2 => \led_ctrl_reg[23]_i_3_n_0\,
      I3 => \irq_enable_reg[31]_i_2_n_0\,
      O => \scratch_reg[23]_i_1_n_0\
    );
\scratch_reg[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
        port map (
      I0 => \scratch_reg[31]_i_2_n_0\,
      I1 => \led_ctrl_reg[31]_i_3_n_0\,
      I2 => \irq_enable_reg[31]_i_2_n_0\,
      I3 => \scratch_reg[31]_i_3_n_0\,
      O => \scratch_reg[31]_i_1_n_0\
    );
\scratch_reg[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000000002A2"
    )
        port map (
      I0 => \scratch_reg[31]_i_4_n_0\,
      I1 => s_axi_awaddr(10),
      I2 => aw_pending,
      I3 => awaddr_reg(10),
      I4 => \scratch_reg[31]_i_5_n_0\,
      I5 => capture_arm_pulse_i_4_n_0,
      O => \scratch_reg[31]_i_2_n_0\
    );
\scratch_reg[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFEFEEEFE"
    )
        port map (
      I0 => \scratch_reg[31]_i_6_n_0\,
      I1 => event_arbiter_n_19,
      I2 => event_arbiter_n_13,
      I3 => event_arbiter_n_14,
      I4 => write_addr(4),
      I5 => \led_ctrl_reg[0]_i_8_n_0\,
      O => \scratch_reg[31]_i_3_n_0\
    );
\scratch_reg[31]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BABFAAAFBABAAAAA"
    )
        port map (
      I0 => \led_ctrl_reg[0]_i_10_n_0\,
      I1 => awaddr_reg(12),
      I2 => aw_pending,
      I3 => s_axi_awaddr(12),
      I4 => awaddr_reg(2),
      I5 => s_axi_awaddr(2),
      O => \scratch_reg[31]_i_4_n_0\
    );
\scratch_reg[31]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000ACC0A"
    )
        port map (
      I0 => s_axi_awaddr(8),
      I1 => awaddr_reg(8),
      I2 => s_axi_awaddr(9),
      I3 => aw_pending,
      I4 => awaddr_reg(9),
      O => \scratch_reg[31]_i_5_n_0\
    );
\scratch_reg[31]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBBBBBBBBBBBBA"
    )
        port map (
      I0 => \scratch_reg[31]_i_7_n_0\,
      I1 => event_arbiter_n_16,
      I2 => s_axi_awaddr(15),
      I3 => aw_pending,
      I4 => s_axi_awaddr(14),
      I5 => s_axi_awaddr(13),
      O => \scratch_reg[31]_i_6_n_0\
    );
\scratch_reg[31]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => awaddr_reg(11),
      I1 => aw_pending,
      I2 => s_axi_awaddr(11),
      O => \scratch_reg[31]_i_7_n_0\
    );
\scratch_reg[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => \scratch_reg[31]_i_2_n_0\,
      I1 => \scratch_reg[31]_i_3_n_0\,
      I2 => \led_ctrl_reg[0]_i_7_n_0\,
      I3 => \irq_enable_reg[31]_i_2_n_0\,
      O => \scratch_reg[7]_i_1_n_0\
    );
\scratch_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[7]_i_1_n_0\,
      D => event_arbiter_n_6,
      Q => scratch_reg(0),
      R => clear
    );
\scratch_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[10]_i_1_n_0\,
      Q => scratch_reg(10),
      R => clear
    );
\scratch_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[11]_i_1_n_0\,
      Q => scratch_reg(11),
      R => clear
    );
\scratch_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[12]_i_1_n_0\,
      Q => scratch_reg(12),
      R => clear
    );
\scratch_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[13]_i_1_n_0\,
      Q => scratch_reg(13),
      R => clear
    );
\scratch_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[14]_i_1_n_0\,
      Q => scratch_reg(14),
      R => clear
    );
\scratch_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[15]_i_2_n_0\,
      Q => scratch_reg(15),
      R => clear
    );
\scratch_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[16]_i_1_n_0\,
      Q => scratch_reg(16),
      R => clear
    );
\scratch_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[17]_i_1_n_0\,
      Q => scratch_reg(17),
      R => clear
    );
\scratch_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[18]_i_1_n_0\,
      Q => scratch_reg(18),
      R => clear
    );
\scratch_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[19]_i_1_n_0\,
      Q => scratch_reg(19),
      R => clear
    );
\scratch_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[7]_i_1_n_0\,
      D => p_0_in15_in,
      Q => scratch_reg(1),
      R => clear
    );
\scratch_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[20]_i_1_n_0\,
      Q => scratch_reg(20),
      R => clear
    );
\scratch_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[21]_i_1_n_0\,
      Q => scratch_reg(21),
      R => clear
    );
\scratch_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[22]_i_1_n_0\,
      Q => scratch_reg(22),
      R => clear
    );
\scratch_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[23]_i_1_n_0\,
      D => \led_ctrl_reg[23]_i_2_n_0\,
      Q => scratch_reg(23),
      R => clear
    );
\scratch_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[24]_i_1_n_0\,
      Q => scratch_reg(24),
      R => clear
    );
\scratch_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[25]_i_1_n_0\,
      Q => scratch_reg(25),
      R => clear
    );
\scratch_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[26]_i_1_n_0\,
      Q => scratch_reg(26),
      R => clear
    );
\scratch_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[27]_i_1_n_0\,
      Q => scratch_reg(27),
      R => clear
    );
\scratch_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[28]_i_1_n_0\,
      Q => scratch_reg(28),
      R => clear
    );
\scratch_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[29]_i_1_n_0\,
      Q => scratch_reg(29),
      R => clear
    );
\scratch_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[7]_i_1_n_0\,
      D => p_0_in13_in,
      Q => scratch_reg(2),
      R => clear
    );
\scratch_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[31]_i_1_n_0\,
      D => \led_ctrl_reg[30]_i_1_n_0\,
      Q => scratch_reg(30),
      R => clear
    );
\scratch_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[31]_i_1_n_0\,
      D => p_0_in10_in,
      Q => scratch_reg(31),
      R => clear
    );
\scratch_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[3]_i_1_n_0\,
      Q => scratch_reg(3),
      R => clear
    );
\scratch_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[4]_i_1_n_0\,
      Q => scratch_reg(4),
      R => clear
    );
\scratch_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[5]_i_1_n_0\,
      Q => scratch_reg(5),
      R => clear
    );
\scratch_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[6]_i_1_n_0\,
      Q => scratch_reg(6),
      R => clear
    );
\scratch_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[7]_i_1_n_0\,
      D => \led_ctrl_reg[7]_i_1_n_0\,
      Q => scratch_reg(7),
      R => clear
    );
\scratch_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[8]_i_1_n_0\,
      Q => scratch_reg(8),
      R => clear
    );
\scratch_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \scratch_reg[15]_i_1_n_0\,
      D => \led_ctrl_reg[9]_i_1_n_0\,
      Q => scratch_reg(9),
      R => clear
    );
snapshot_rd_en_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => capture_buffer_n_4,
      Q => snapshot_rd_en,
      R => '0'
    );
\snapshot_rd_index_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => snapshot_rd_index,
      D => s_axi_araddr(4),
      Q => \snapshot_rd_index_reg_n_0_[0]\,
      R => clear
    );
\snapshot_rd_index_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => snapshot_rd_index,
      D => s_axi_araddr(5),
      Q => \snapshot_rd_index_reg_n_0_[1]\,
      R => clear
    );
\snapshot_rd_index_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => snapshot_rd_index,
      D => s_axi_araddr(6),
      Q => \snapshot_rd_index_reg_n_0_[2]\,
      R => clear
    );
\snapshot_rd_index_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => snapshot_rd_index,
      D => s_axi_araddr(7),
      Q => \snapshot_rd_index_reg_n_0_[3]\,
      R => clear
    );
\snapshot_rd_index_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => snapshot_rd_index,
      D => s_axi_araddr(8),
      Q => \snapshot_rd_index_reg_n_0_[4]\,
      R => clear
    );
\snapshot_rd_index_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => snapshot_rd_index,
      D => s_axi_araddr(9),
      Q => \snapshot_rd_index_reg_n_0_[5]\,
      R => clear
    );
\snapshot_rd_index_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => snapshot_rd_index,
      D => s_axi_araddr(10),
      Q => \snapshot_rd_index_reg_n_0_[6]\,
      R => clear
    );
\snapshot_rd_index_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => snapshot_rd_index,
      D => s_axi_araddr(11),
      Q => \snapshot_rd_index_reg_n_0_[7]\,
      R => clear
    );
snapshot_read_pending_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => capture_buffer_n_72,
      Q => snapshot_read_pending_reg_n_0,
      R => '0'
    );
\snapshot_word_select_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => snapshot_rd_index,
      D => s_axi_araddr(2),
      Q => snapshot_word_select(0),
      R => clear
    );
\snapshot_word_select_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => snapshot_rd_index,
      D => s_axi_araddr(3),
      Q => snapshot_word_select(1),
      R => clear
    );
\sys_ctrl_reg[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000100"
    )
        port map (
      I0 => \led_ctrl_reg[0]_i_3_n_0\,
      I1 => \led_ctrl_reg[0]_i_6_n_0\,
      I2 => \led_ctrl_reg[0]_i_5_n_0\,
      I3 => \sys_ctrl_reg[31]_i_3_n_0\,
      I4 => \sys_ctrl_reg[31]_i_2_n_0\,
      I5 => \led_ctrl_reg[15]_i_3_n_0\,
      O => \p_1_in__0\(15)
    );
\sys_ctrl_reg[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000100"
    )
        port map (
      I0 => \led_ctrl_reg[0]_i_3_n_0\,
      I1 => \led_ctrl_reg[0]_i_6_n_0\,
      I2 => \led_ctrl_reg[0]_i_5_n_0\,
      I3 => \sys_ctrl_reg[31]_i_3_n_0\,
      I4 => \sys_ctrl_reg[31]_i_2_n_0\,
      I5 => \led_ctrl_reg[23]_i_3_n_0\,
      O => \p_1_in__0\(23)
    );
\sys_ctrl_reg[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000400000000"
    )
        port map (
      I0 => \sys_ctrl_reg[31]_i_2_n_0\,
      I1 => \led_ctrl_reg[31]_i_3_n_0\,
      I2 => \led_ctrl_reg[0]_i_3_n_0\,
      I3 => \led_ctrl_reg[0]_i_6_n_0\,
      I4 => \led_ctrl_reg[0]_i_5_n_0\,
      I5 => \sys_ctrl_reg[31]_i_3_n_0\,
      O => \p_1_in__0\(31)
    );
\sys_ctrl_reg[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DFD5FFF5DFDFFFFF"
    )
        port map (
      I0 => event_arbiter_n_17,
      I1 => awaddr_reg(5),
      I2 => aw_pending,
      I3 => s_axi_awaddr(5),
      I4 => awaddr_reg(4),
      I5 => s_axi_awaddr(4),
      O => \sys_ctrl_reg[31]_i_2_n_0\
    );
\sys_ctrl_reg[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0300035533553355"
    )
        port map (
      I0 => s_axi_awaddr(5),
      I1 => awaddr_reg(5),
      I2 => awaddr_reg(3),
      I3 => aw_pending,
      I4 => s_axi_awaddr(3),
      I5 => write_addr(4),
      O => \sys_ctrl_reg[31]_i_3_n_0\
    );
\sys_ctrl_reg[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000100"
    )
        port map (
      I0 => \led_ctrl_reg[0]_i_3_n_0\,
      I1 => \led_ctrl_reg[0]_i_6_n_0\,
      I2 => \led_ctrl_reg[0]_i_5_n_0\,
      I3 => \sys_ctrl_reg[31]_i_3_n_0\,
      I4 => \sys_ctrl_reg[31]_i_2_n_0\,
      I5 => \led_ctrl_reg[0]_i_7_n_0\,
      O => \p_1_in__0\(7)
    );
\sys_ctrl_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(7),
      D => event_arbiter_n_6,
      Q => sys_ctrl_reg(0),
      R => clear
    );
\sys_ctrl_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(15),
      D => \led_ctrl_reg[10]_i_1_n_0\,
      Q => sys_ctrl_reg(10),
      R => clear
    );
\sys_ctrl_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(15),
      D => \led_ctrl_reg[11]_i_1_n_0\,
      Q => sys_ctrl_reg(11),
      R => clear
    );
\sys_ctrl_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(15),
      D => \led_ctrl_reg[12]_i_1_n_0\,
      Q => sys_ctrl_reg(12),
      R => clear
    );
\sys_ctrl_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(15),
      D => \led_ctrl_reg[13]_i_1_n_0\,
      Q => sys_ctrl_reg(13),
      R => clear
    );
\sys_ctrl_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(15),
      D => \led_ctrl_reg[14]_i_1_n_0\,
      Q => sys_ctrl_reg(14),
      R => clear
    );
\sys_ctrl_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(15),
      D => \led_ctrl_reg[15]_i_2_n_0\,
      Q => sys_ctrl_reg(15),
      R => clear
    );
\sys_ctrl_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(23),
      D => \led_ctrl_reg[16]_i_1_n_0\,
      Q => sys_ctrl_reg(16),
      R => clear
    );
\sys_ctrl_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(23),
      D => \led_ctrl_reg[17]_i_1_n_0\,
      Q => sys_ctrl_reg(17),
      R => clear
    );
\sys_ctrl_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(23),
      D => \led_ctrl_reg[18]_i_1_n_0\,
      Q => sys_ctrl_reg(18),
      R => clear
    );
\sys_ctrl_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(23),
      D => \led_ctrl_reg[19]_i_1_n_0\,
      Q => sys_ctrl_reg(19),
      R => clear
    );
\sys_ctrl_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(7),
      D => p_0_in15_in,
      Q => sys_ctrl_reg(1),
      R => clear
    );
\sys_ctrl_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(23),
      D => \led_ctrl_reg[20]_i_1_n_0\,
      Q => sys_ctrl_reg(20),
      R => clear
    );
\sys_ctrl_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(23),
      D => \led_ctrl_reg[21]_i_1_n_0\,
      Q => sys_ctrl_reg(21),
      R => clear
    );
\sys_ctrl_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(23),
      D => \led_ctrl_reg[22]_i_1_n_0\,
      Q => sys_ctrl_reg(22),
      R => clear
    );
\sys_ctrl_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(23),
      D => \led_ctrl_reg[23]_i_2_n_0\,
      Q => sys_ctrl_reg(23),
      R => clear
    );
\sys_ctrl_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(31),
      D => \led_ctrl_reg[24]_i_1_n_0\,
      Q => sys_ctrl_reg(24),
      R => clear
    );
\sys_ctrl_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(31),
      D => \led_ctrl_reg[25]_i_1_n_0\,
      Q => sys_ctrl_reg(25),
      R => clear
    );
\sys_ctrl_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(31),
      D => \led_ctrl_reg[26]_i_1_n_0\,
      Q => sys_ctrl_reg(26),
      R => clear
    );
\sys_ctrl_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(31),
      D => \led_ctrl_reg[27]_i_1_n_0\,
      Q => sys_ctrl_reg(27),
      R => clear
    );
\sys_ctrl_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(31),
      D => \led_ctrl_reg[28]_i_1_n_0\,
      Q => sys_ctrl_reg(28),
      R => clear
    );
\sys_ctrl_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(31),
      D => \led_ctrl_reg[29]_i_1_n_0\,
      Q => sys_ctrl_reg(29),
      R => clear
    );
\sys_ctrl_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(7),
      D => p_0_in13_in,
      Q => sys_ctrl_reg(2),
      R => clear
    );
\sys_ctrl_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(31),
      D => \led_ctrl_reg[30]_i_1_n_0\,
      Q => sys_ctrl_reg(30),
      R => clear
    );
\sys_ctrl_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(31),
      D => p_0_in10_in,
      Q => sys_ctrl_reg(31),
      R => clear
    );
\sys_ctrl_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(7),
      D => \led_ctrl_reg[3]_i_1_n_0\,
      Q => sys_ctrl_reg(3),
      R => clear
    );
\sys_ctrl_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(7),
      D => \led_ctrl_reg[4]_i_1_n_0\,
      Q => sys_ctrl_reg(4),
      R => clear
    );
\sys_ctrl_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(7),
      D => \led_ctrl_reg[5]_i_1_n_0\,
      Q => sys_ctrl_reg(5),
      R => clear
    );
\sys_ctrl_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(7),
      D => \led_ctrl_reg[6]_i_1_n_0\,
      Q => sys_ctrl_reg(6),
      R => clear
    );
\sys_ctrl_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(7),
      D => \led_ctrl_reg[7]_i_1_n_0\,
      Q => sys_ctrl_reg(7),
      R => clear
    );
\sys_ctrl_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(15),
      D => \led_ctrl_reg[8]_i_1_n_0\,
      Q => sys_ctrl_reg(8),
      R => clear
    );
\sys_ctrl_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \p_1_in__0\(15),
      D => \led_ctrl_reg[9]_i_1_n_0\,
      Q => sys_ctrl_reg(9),
      R => clear
    );
\timestamp_counter[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => timestamp_counter_reg(0),
      O => \timestamp_counter[0]_i_2_n_0\
    );
\timestamp_counter_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[0]_i_1_n_7\,
      Q => timestamp_counter_reg(0),
      R => clear
    );
\timestamp_counter_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \timestamp_counter_reg[0]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[0]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[0]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \timestamp_counter_reg[0]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[0]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[0]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[0]_i_1_n_7\,
      S(3 downto 1) => timestamp_counter_reg(3 downto 1),
      S(0) => \timestamp_counter[0]_i_2_n_0\
    );
\timestamp_counter_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[8]_i_1_n_5\,
      Q => timestamp_counter_reg(10),
      R => clear
    );
\timestamp_counter_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[8]_i_1_n_4\,
      Q => timestamp_counter_reg(11),
      R => clear
    );
\timestamp_counter_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[12]_i_1_n_7\,
      Q => timestamp_counter_reg(12),
      R => clear
    );
\timestamp_counter_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[8]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[12]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[12]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[12]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[12]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[12]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[12]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[12]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(15 downto 12)
    );
\timestamp_counter_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[12]_i_1_n_6\,
      Q => timestamp_counter_reg(13),
      R => clear
    );
\timestamp_counter_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[12]_i_1_n_5\,
      Q => timestamp_counter_reg(14),
      R => clear
    );
\timestamp_counter_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[12]_i_1_n_4\,
      Q => timestamp_counter_reg(15),
      R => clear
    );
\timestamp_counter_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[16]_i_1_n_7\,
      Q => timestamp_counter_reg(16),
      R => clear
    );
\timestamp_counter_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[12]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[16]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[16]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[16]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[16]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[16]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[16]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[16]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(19 downto 16)
    );
\timestamp_counter_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[16]_i_1_n_6\,
      Q => timestamp_counter_reg(17),
      R => clear
    );
\timestamp_counter_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[16]_i_1_n_5\,
      Q => timestamp_counter_reg(18),
      R => clear
    );
\timestamp_counter_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[16]_i_1_n_4\,
      Q => timestamp_counter_reg(19),
      R => clear
    );
\timestamp_counter_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[0]_i_1_n_6\,
      Q => timestamp_counter_reg(1),
      R => clear
    );
\timestamp_counter_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[20]_i_1_n_7\,
      Q => timestamp_counter_reg(20),
      R => clear
    );
\timestamp_counter_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[16]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[20]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[20]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[20]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[20]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[20]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[20]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[20]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(23 downto 20)
    );
\timestamp_counter_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[20]_i_1_n_6\,
      Q => timestamp_counter_reg(21),
      R => clear
    );
\timestamp_counter_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[20]_i_1_n_5\,
      Q => timestamp_counter_reg(22),
      R => clear
    );
\timestamp_counter_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[20]_i_1_n_4\,
      Q => timestamp_counter_reg(23),
      R => clear
    );
\timestamp_counter_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[24]_i_1_n_7\,
      Q => timestamp_counter_reg(24),
      R => clear
    );
\timestamp_counter_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[20]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[24]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[24]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[24]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[24]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[24]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[24]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[24]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(27 downto 24)
    );
\timestamp_counter_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[24]_i_1_n_6\,
      Q => timestamp_counter_reg(25),
      R => clear
    );
\timestamp_counter_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[24]_i_1_n_5\,
      Q => timestamp_counter_reg(26),
      R => clear
    );
\timestamp_counter_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[24]_i_1_n_4\,
      Q => timestamp_counter_reg(27),
      R => clear
    );
\timestamp_counter_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[28]_i_1_n_7\,
      Q => timestamp_counter_reg(28),
      R => clear
    );
\timestamp_counter_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[24]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[28]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[28]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[28]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[28]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[28]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[28]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[28]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(31 downto 28)
    );
\timestamp_counter_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[28]_i_1_n_6\,
      Q => timestamp_counter_reg(29),
      R => clear
    );
\timestamp_counter_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[0]_i_1_n_5\,
      Q => timestamp_counter_reg(2),
      R => clear
    );
\timestamp_counter_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[28]_i_1_n_5\,
      Q => timestamp_counter_reg(30),
      R => clear
    );
\timestamp_counter_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[28]_i_1_n_4\,
      Q => timestamp_counter_reg(31),
      R => clear
    );
\timestamp_counter_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[32]_i_1_n_7\,
      Q => timestamp_counter_reg(32),
      R => clear
    );
\timestamp_counter_reg[32]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[28]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[32]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[32]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[32]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[32]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[32]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[32]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[32]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[32]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(35 downto 32)
    );
\timestamp_counter_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[32]_i_1_n_6\,
      Q => timestamp_counter_reg(33),
      R => clear
    );
\timestamp_counter_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[32]_i_1_n_5\,
      Q => timestamp_counter_reg(34),
      R => clear
    );
\timestamp_counter_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[32]_i_1_n_4\,
      Q => timestamp_counter_reg(35),
      R => clear
    );
\timestamp_counter_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[36]_i_1_n_7\,
      Q => timestamp_counter_reg(36),
      R => clear
    );
\timestamp_counter_reg[36]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[32]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[36]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[36]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[36]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[36]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[36]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[36]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[36]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[36]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(39 downto 36)
    );
\timestamp_counter_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[36]_i_1_n_6\,
      Q => timestamp_counter_reg(37),
      R => clear
    );
\timestamp_counter_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[36]_i_1_n_5\,
      Q => timestamp_counter_reg(38),
      R => clear
    );
\timestamp_counter_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[36]_i_1_n_4\,
      Q => timestamp_counter_reg(39),
      R => clear
    );
\timestamp_counter_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[0]_i_1_n_4\,
      Q => timestamp_counter_reg(3),
      R => clear
    );
\timestamp_counter_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[40]_i_1_n_7\,
      Q => timestamp_counter_reg(40),
      R => clear
    );
\timestamp_counter_reg[40]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[36]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[40]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[40]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[40]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[40]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[40]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[40]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[40]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[40]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(43 downto 40)
    );
\timestamp_counter_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[40]_i_1_n_6\,
      Q => timestamp_counter_reg(41),
      R => clear
    );
\timestamp_counter_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[40]_i_1_n_5\,
      Q => timestamp_counter_reg(42),
      R => clear
    );
\timestamp_counter_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[40]_i_1_n_4\,
      Q => timestamp_counter_reg(43),
      R => clear
    );
\timestamp_counter_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[44]_i_1_n_7\,
      Q => timestamp_counter_reg(44),
      R => clear
    );
\timestamp_counter_reg[44]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[40]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[44]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[44]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[44]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[44]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[44]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[44]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[44]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[44]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(47 downto 44)
    );
\timestamp_counter_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[44]_i_1_n_6\,
      Q => timestamp_counter_reg(45),
      R => clear
    );
\timestamp_counter_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[44]_i_1_n_5\,
      Q => timestamp_counter_reg(46),
      R => clear
    );
\timestamp_counter_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[44]_i_1_n_4\,
      Q => timestamp_counter_reg(47),
      R => clear
    );
\timestamp_counter_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[48]_i_1_n_7\,
      Q => timestamp_counter_reg(48),
      R => clear
    );
\timestamp_counter_reg[48]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[44]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[48]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[48]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[48]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[48]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[48]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[48]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[48]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[48]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(51 downto 48)
    );
\timestamp_counter_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[48]_i_1_n_6\,
      Q => timestamp_counter_reg(49),
      R => clear
    );
\timestamp_counter_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[4]_i_1_n_7\,
      Q => timestamp_counter_reg(4),
      R => clear
    );
\timestamp_counter_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[0]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[4]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[4]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[4]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[4]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[4]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[4]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[4]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(7 downto 4)
    );
\timestamp_counter_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[48]_i_1_n_5\,
      Q => timestamp_counter_reg(50),
      R => clear
    );
\timestamp_counter_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[48]_i_1_n_4\,
      Q => timestamp_counter_reg(51),
      R => clear
    );
\timestamp_counter_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[52]_i_1_n_7\,
      Q => timestamp_counter_reg(52),
      R => clear
    );
\timestamp_counter_reg[52]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[48]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[52]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[52]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[52]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[52]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[52]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[52]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[52]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[52]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(55 downto 52)
    );
\timestamp_counter_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[52]_i_1_n_6\,
      Q => timestamp_counter_reg(53),
      R => clear
    );
\timestamp_counter_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[52]_i_1_n_5\,
      Q => timestamp_counter_reg(54),
      R => clear
    );
\timestamp_counter_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[52]_i_1_n_4\,
      Q => timestamp_counter_reg(55),
      R => clear
    );
\timestamp_counter_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[56]_i_1_n_7\,
      Q => timestamp_counter_reg(56),
      R => clear
    );
\timestamp_counter_reg[56]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[52]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[56]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[56]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[56]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[56]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[56]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[56]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[56]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[56]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(59 downto 56)
    );
\timestamp_counter_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[56]_i_1_n_6\,
      Q => timestamp_counter_reg(57),
      R => clear
    );
\timestamp_counter_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[56]_i_1_n_5\,
      Q => timestamp_counter_reg(58),
      R => clear
    );
\timestamp_counter_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[56]_i_1_n_4\,
      Q => timestamp_counter_reg(59),
      R => clear
    );
\timestamp_counter_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[4]_i_1_n_6\,
      Q => timestamp_counter_reg(5),
      R => clear
    );
\timestamp_counter_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[60]_i_1_n_7\,
      Q => timestamp_counter_reg(60),
      R => clear
    );
\timestamp_counter_reg[60]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[56]_i_1_n_0\,
      CO(3) => \NLW_timestamp_counter_reg[60]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \timestamp_counter_reg[60]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[60]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[60]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[60]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[60]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[60]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[60]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(63 downto 60)
    );
\timestamp_counter_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[60]_i_1_n_6\,
      Q => timestamp_counter_reg(61),
      R => clear
    );
\timestamp_counter_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[60]_i_1_n_5\,
      Q => timestamp_counter_reg(62),
      R => clear
    );
\timestamp_counter_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[60]_i_1_n_4\,
      Q => timestamp_counter_reg(63),
      R => clear
    );
\timestamp_counter_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[4]_i_1_n_5\,
      Q => timestamp_counter_reg(6),
      R => clear
    );
\timestamp_counter_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[4]_i_1_n_4\,
      Q => timestamp_counter_reg(7),
      R => clear
    );
\timestamp_counter_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[8]_i_1_n_7\,
      Q => timestamp_counter_reg(8),
      R => clear
    );
\timestamp_counter_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \timestamp_counter_reg[4]_i_1_n_0\,
      CO(3) => \timestamp_counter_reg[8]_i_1_n_0\,
      CO(2) => \timestamp_counter_reg[8]_i_1_n_1\,
      CO(1) => \timestamp_counter_reg[8]_i_1_n_2\,
      CO(0) => \timestamp_counter_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \timestamp_counter_reg[8]_i_1_n_4\,
      O(2) => \timestamp_counter_reg[8]_i_1_n_5\,
      O(1) => \timestamp_counter_reg[8]_i_1_n_6\,
      O(0) => \timestamp_counter_reg[8]_i_1_n_7\,
      S(3 downto 0) => timestamp_counter_reg(11 downto 8)
    );
\timestamp_counter_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \timestamp_counter_reg[8]_i_1_n_6\,
      Q => timestamp_counter_reg(9),
      R => clear
    );
\timestamp_shadow[63]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => s_axi_araddr(2),
      O => \timestamp_shadow[63]_i_2_n_0\
    );
\timestamp_shadow[63]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => s_axi_araddr(9),
      I1 => s_axi_araddr(10),
      I2 => s_axi_araddr(7),
      I3 => s_axi_araddr(6),
      I4 => s_axi_araddr(1),
      I5 => s_axi_araddr(8),
      O => \timestamp_shadow[63]_i_5_n_0\
    );
\timestamp_shadow_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(32),
      Q => data5(0),
      R => clear
    );
\timestamp_shadow_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(33),
      Q => data5(1),
      R => clear
    );
\timestamp_shadow_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(34),
      Q => data5(2),
      R => clear
    );
\timestamp_shadow_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(35),
      Q => data5(3),
      R => clear
    );
\timestamp_shadow_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(36),
      Q => data5(4),
      R => clear
    );
\timestamp_shadow_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(37),
      Q => data5(5),
      R => clear
    );
\timestamp_shadow_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(38),
      Q => data5(6),
      R => clear
    );
\timestamp_shadow_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(39),
      Q => data5(7),
      R => clear
    );
\timestamp_shadow_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(40),
      Q => data5(8),
      R => clear
    );
\timestamp_shadow_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(41),
      Q => data5(9),
      R => clear
    );
\timestamp_shadow_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(42),
      Q => data5(10),
      R => clear
    );
\timestamp_shadow_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(43),
      Q => data5(11),
      R => clear
    );
\timestamp_shadow_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(44),
      Q => data5(12),
      R => clear
    );
\timestamp_shadow_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(45),
      Q => data5(13),
      R => clear
    );
\timestamp_shadow_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(46),
      Q => data5(14),
      R => clear
    );
\timestamp_shadow_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(47),
      Q => data5(15),
      R => clear
    );
\timestamp_shadow_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(48),
      Q => data5(16),
      R => clear
    );
\timestamp_shadow_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(49),
      Q => data5(17),
      R => clear
    );
\timestamp_shadow_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(50),
      Q => data5(18),
      R => clear
    );
\timestamp_shadow_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(51),
      Q => data5(19),
      R => clear
    );
\timestamp_shadow_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(52),
      Q => data5(20),
      R => clear
    );
\timestamp_shadow_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(53),
      Q => data5(21),
      R => clear
    );
\timestamp_shadow_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(54),
      Q => data5(22),
      R => clear
    );
\timestamp_shadow_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(55),
      Q => data5(23),
      R => clear
    );
\timestamp_shadow_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(56),
      Q => data5(24),
      R => clear
    );
\timestamp_shadow_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(57),
      Q => data5(25),
      R => clear
    );
\timestamp_shadow_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(58),
      Q => data5(26),
      R => clear
    );
\timestamp_shadow_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(59),
      Q => data5(27),
      R => clear
    );
\timestamp_shadow_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(60),
      Q => data5(28),
      R => clear
    );
\timestamp_shadow_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(61),
      Q => data5(29),
      R => clear
    );
\timestamp_shadow_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(62),
      Q => data5(30),
      R => clear
    );
\timestamp_shadow_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => capture_buffer_n_71,
      D => timestamp_counter_reg(63),
      Q => data5(31),
      R => clear
    );
\virtual_evt_data[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_wdata(0),
      I1 => w_pending_reg_n_0,
      I2 => wdata_reg(0),
      I3 => s_axi_awaddr(4),
      I4 => aw_pending,
      I5 => awaddr_reg(4),
      O => \virtual_evt_data[0]_i_1_n_0\
    );
\virtual_evt_data[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(10),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(10),
      O => \virtual_evt_data[10]_i_1_n_0\
    );
\virtual_evt_data[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(11),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(11),
      O => \virtual_evt_data[11]_i_1_n_0\
    );
\virtual_evt_data[127]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0001000100010000"
    )
        port map (
      I0 => \virtual_evt_data[127]_i_3_n_0\,
      I1 => \virtual_evt_data[127]_i_4_n_0\,
      I2 => capture_arm_pulse_i_4_n_0,
      I3 => \scratch_reg[31]_i_6_n_0\,
      I4 => \virtual_evt_data[127]_i_5_n_0\,
      I5 => \virtual_evt_data[127]_i_6_n_0\,
      O => \virtual_evt_data[127]_i_2_n_0\
    );
\virtual_evt_data[127]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFBBFCB8"
    )
        port map (
      I0 => awaddr_reg(2),
      I1 => aw_pending,
      I2 => s_axi_awaddr(2),
      I3 => awaddr_reg(5),
      I4 => s_axi_awaddr(5),
      I5 => \dropped_count_reg[31]_i_8_n_0\,
      O => \virtual_evt_data[127]_i_3_n_0\
    );
\virtual_evt_data[127]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => event_arbiter_n_19,
      I1 => \led_ctrl_reg[0]_i_10_n_0\,
      I2 => \led_ctrl_reg[0]_i_13_n_0\,
      I3 => \virtual_evt_data[127]_i_7_n_0\,
      I4 => event_arbiter_n_18,
      O => \virtual_evt_data[127]_i_4_n_0\
    );
\virtual_evt_data[127]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCA000A0"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => awaddr_reg(4),
      I2 => s_axi_awaddr(3),
      I3 => aw_pending,
      I4 => awaddr_reg(3),
      O => \virtual_evt_data[127]_i_5_n_0\
    );
\virtual_evt_data[127]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000020222000"
    )
        port map (
      I0 => p_0_in13_in,
      I1 => event_arbiter_n_14,
      I2 => wstrb_reg(0),
      I3 => w_pending_reg_n_0,
      I4 => s_axi_wstrb(0),
      I5 => write_addr(4),
      O => \virtual_evt_data[127]_i_6_n_0\
    );
\virtual_evt_data[127]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => awaddr_reg(7),
      I1 => aw_pending,
      I2 => s_axi_awaddr(7),
      O => \virtual_evt_data[127]_i_7_n_0\
    );
\virtual_evt_data[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(12),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(12),
      O => \virtual_evt_data[12]_i_1_n_0\
    );
\virtual_evt_data[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(13),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(13),
      O => \virtual_evt_data[13]_i_1_n_0\
    );
\virtual_evt_data[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(14),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(14),
      O => \virtual_evt_data[14]_i_1_n_0\
    );
\virtual_evt_data[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(15),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(15),
      O => \virtual_evt_data[15]_i_1_n_0\
    );
\virtual_evt_data[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(16),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(16),
      O => \virtual_evt_data[16]_i_1_n_0\
    );
\virtual_evt_data[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(17),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(17),
      O => \virtual_evt_data[17]_i_1_n_0\
    );
\virtual_evt_data[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(18),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(18),
      O => \virtual_evt_data[18]_i_1_n_0\
    );
\virtual_evt_data[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(19),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(19),
      O => \virtual_evt_data[19]_i_1_n_0\
    );
\virtual_evt_data[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(1),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(1),
      O => \virtual_evt_data[1]_i_1_n_0\
    );
\virtual_evt_data[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(20),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(20),
      O => \virtual_evt_data[20]_i_1_n_0\
    );
\virtual_evt_data[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(21),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(21),
      O => \virtual_evt_data[21]_i_1_n_0\
    );
\virtual_evt_data[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(22),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(22),
      O => \virtual_evt_data[22]_i_1_n_0\
    );
\virtual_evt_data[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(23),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(23),
      O => \virtual_evt_data[23]_i_1_n_0\
    );
\virtual_evt_data[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(2),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(2),
      O => \virtual_evt_data[2]_i_1_n_0\
    );
\virtual_evt_data[32]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8308800FFFFFFFF"
    )
        port map (
      I0 => wstrb_reg(3),
      I1 => w_pending_reg_n_0,
      I2 => s_axi_wstrb(3),
      I3 => wdata_reg(31),
      I4 => s_axi_wdata(31),
      I5 => write_addr(4),
      O => \virtual_evt_data[32]_i_1_n_0\
    );
\virtual_evt_data[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(3),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(3),
      O => \virtual_evt_data[3]_i_1_n_0\
    );
\virtual_evt_data[49]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"1D"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      O => \virtual_evt_data[49]_i_1_n_0\
    );
\virtual_evt_data[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(4),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(4),
      O => \virtual_evt_data[4]_i_1_n_0\
    );
\virtual_evt_data[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(5),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(5),
      O => \virtual_evt_data[5]_i_1_n_0\
    );
\virtual_evt_data[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(6),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(6),
      O => \virtual_evt_data[6]_i_1_n_0\
    );
\virtual_evt_data[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(7),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(7),
      O => \virtual_evt_data[7]_i_1_n_0\
    );
\virtual_evt_data[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(8),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(8),
      O => \virtual_evt_data[8]_i_1_n_0\
    );
\virtual_evt_data[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E2E2E2000000E200"
    )
        port map (
      I0 => s_axi_awaddr(4),
      I1 => aw_pending,
      I2 => awaddr_reg(4),
      I3 => s_axi_wdata(9),
      I4 => w_pending_reg_n_0,
      I5 => wdata_reg(9),
      O => \virtual_evt_data[9]_i_1_n_0\
    );
\virtual_evt_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[0]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[0]\,
      R => clear
    );
\virtual_evt_data_reg[100]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(36),
      Q => \virtual_evt_data_reg_n_0_[100]\,
      R => clear
    );
\virtual_evt_data_reg[101]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(37),
      Q => \virtual_evt_data_reg_n_0_[101]\,
      R => clear
    );
\virtual_evt_data_reg[102]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(38),
      Q => \virtual_evt_data_reg_n_0_[102]\,
      R => clear
    );
\virtual_evt_data_reg[103]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(39),
      Q => \virtual_evt_data_reg_n_0_[103]\,
      R => clear
    );
\virtual_evt_data_reg[104]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(40),
      Q => \virtual_evt_data_reg_n_0_[104]\,
      R => clear
    );
\virtual_evt_data_reg[105]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(41),
      Q => \virtual_evt_data_reg_n_0_[105]\,
      R => clear
    );
\virtual_evt_data_reg[106]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(42),
      Q => \virtual_evt_data_reg_n_0_[106]\,
      R => clear
    );
\virtual_evt_data_reg[107]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(43),
      Q => \virtual_evt_data_reg_n_0_[107]\,
      R => clear
    );
\virtual_evt_data_reg[108]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(44),
      Q => \virtual_evt_data_reg_n_0_[108]\,
      R => clear
    );
\virtual_evt_data_reg[109]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(45),
      Q => \virtual_evt_data_reg_n_0_[109]\,
      R => clear
    );
\virtual_evt_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[10]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[10]\,
      R => clear
    );
\virtual_evt_data_reg[110]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(46),
      Q => \virtual_evt_data_reg_n_0_[110]\,
      R => clear
    );
\virtual_evt_data_reg[111]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(47),
      Q => \virtual_evt_data_reg_n_0_[111]\,
      R => clear
    );
\virtual_evt_data_reg[112]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(48),
      Q => \virtual_evt_data_reg_n_0_[112]\,
      R => clear
    );
\virtual_evt_data_reg[113]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(49),
      Q => \virtual_evt_data_reg_n_0_[113]\,
      R => clear
    );
\virtual_evt_data_reg[114]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(50),
      Q => \virtual_evt_data_reg_n_0_[114]\,
      R => clear
    );
\virtual_evt_data_reg[115]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(51),
      Q => \virtual_evt_data_reg_n_0_[115]\,
      R => clear
    );
\virtual_evt_data_reg[116]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(52),
      Q => \virtual_evt_data_reg_n_0_[116]\,
      R => clear
    );
\virtual_evt_data_reg[117]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(53),
      Q => \virtual_evt_data_reg_n_0_[117]\,
      R => clear
    );
\virtual_evt_data_reg[118]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(54),
      Q => \virtual_evt_data_reg_n_0_[118]\,
      R => clear
    );
\virtual_evt_data_reg[119]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(55),
      Q => \virtual_evt_data_reg_n_0_[119]\,
      R => clear
    );
\virtual_evt_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[11]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[11]\,
      R => clear
    );
\virtual_evt_data_reg[120]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(56),
      Q => \virtual_evt_data_reg_n_0_[120]\,
      R => clear
    );
\virtual_evt_data_reg[121]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(57),
      Q => \virtual_evt_data_reg_n_0_[121]\,
      R => clear
    );
\virtual_evt_data_reg[122]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(58),
      Q => \virtual_evt_data_reg_n_0_[122]\,
      R => clear
    );
\virtual_evt_data_reg[123]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(59),
      Q => \virtual_evt_data_reg_n_0_[123]\,
      R => clear
    );
\virtual_evt_data_reg[124]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(60),
      Q => \virtual_evt_data_reg_n_0_[124]\,
      R => clear
    );
\virtual_evt_data_reg[125]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(61),
      Q => \virtual_evt_data_reg_n_0_[125]\,
      R => clear
    );
\virtual_evt_data_reg[126]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(62),
      Q => \virtual_evt_data_reg_n_0_[126]\,
      R => clear
    );
\virtual_evt_data_reg[127]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(63),
      Q => \virtual_evt_data_reg_n_0_[127]\,
      R => clear
    );
\virtual_evt_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[12]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[12]\,
      R => clear
    );
\virtual_evt_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[13]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[13]\,
      R => clear
    );
\virtual_evt_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[14]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[14]\,
      R => clear
    );
\virtual_evt_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[15]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[15]\,
      R => clear
    );
\virtual_evt_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[16]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[16]\,
      R => clear
    );
\virtual_evt_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[17]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[17]\,
      R => clear
    );
\virtual_evt_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[18]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[18]\,
      R => clear
    );
\virtual_evt_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[19]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[19]\,
      R => clear
    );
\virtual_evt_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[1]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[1]\,
      R => clear
    );
\virtual_evt_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[20]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[20]\,
      R => clear
    );
\virtual_evt_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[21]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[21]\,
      R => clear
    );
\virtual_evt_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[22]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[22]\,
      R => clear
    );
\virtual_evt_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[23]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[23]\,
      R => clear
    );
\virtual_evt_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[2]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[2]\,
      R => clear
    );
\virtual_evt_data_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[32]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[32]\,
      R => clear
    );
\virtual_evt_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[3]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[3]\,
      R => clear
    );
\virtual_evt_data_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => write_addr(4),
      Q => \virtual_evt_data_reg_n_0_[48]\,
      R => clear
    );
\virtual_evt_data_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[49]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[49]\,
      R => clear
    );
\virtual_evt_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[4]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[4]\,
      R => clear
    );
\virtual_evt_data_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => '1',
      Q => \virtual_evt_data_reg_n_0_[55]\,
      R => clear
    );
\virtual_evt_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[5]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[5]\,
      R => clear
    );
\virtual_evt_data_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(0),
      Q => \virtual_evt_data_reg_n_0_[64]\,
      R => clear
    );
\virtual_evt_data_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(1),
      Q => \virtual_evt_data_reg_n_0_[65]\,
      R => clear
    );
\virtual_evt_data_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(2),
      Q => \virtual_evt_data_reg_n_0_[66]\,
      R => clear
    );
\virtual_evt_data_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(3),
      Q => \virtual_evt_data_reg_n_0_[67]\,
      R => clear
    );
\virtual_evt_data_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(4),
      Q => \virtual_evt_data_reg_n_0_[68]\,
      R => clear
    );
\virtual_evt_data_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(5),
      Q => \virtual_evt_data_reg_n_0_[69]\,
      R => clear
    );
\virtual_evt_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[6]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[6]\,
      R => clear
    );
\virtual_evt_data_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(6),
      Q => \virtual_evt_data_reg_n_0_[70]\,
      R => clear
    );
\virtual_evt_data_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(7),
      Q => \virtual_evt_data_reg_n_0_[71]\,
      R => clear
    );
\virtual_evt_data_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(8),
      Q => \virtual_evt_data_reg_n_0_[72]\,
      R => clear
    );
\virtual_evt_data_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(9),
      Q => \virtual_evt_data_reg_n_0_[73]\,
      R => clear
    );
\virtual_evt_data_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(10),
      Q => \virtual_evt_data_reg_n_0_[74]\,
      R => clear
    );
\virtual_evt_data_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(11),
      Q => \virtual_evt_data_reg_n_0_[75]\,
      R => clear
    );
\virtual_evt_data_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(12),
      Q => \virtual_evt_data_reg_n_0_[76]\,
      R => clear
    );
\virtual_evt_data_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(13),
      Q => \virtual_evt_data_reg_n_0_[77]\,
      R => clear
    );
\virtual_evt_data_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(14),
      Q => \virtual_evt_data_reg_n_0_[78]\,
      R => clear
    );
\virtual_evt_data_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(15),
      Q => \virtual_evt_data_reg_n_0_[79]\,
      R => clear
    );
\virtual_evt_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[7]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[7]\,
      R => clear
    );
\virtual_evt_data_reg[80]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(16),
      Q => \virtual_evt_data_reg_n_0_[80]\,
      R => clear
    );
\virtual_evt_data_reg[81]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(17),
      Q => \virtual_evt_data_reg_n_0_[81]\,
      R => clear
    );
\virtual_evt_data_reg[82]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(18),
      Q => \virtual_evt_data_reg_n_0_[82]\,
      R => clear
    );
\virtual_evt_data_reg[83]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(19),
      Q => \virtual_evt_data_reg_n_0_[83]\,
      R => clear
    );
\virtual_evt_data_reg[84]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(20),
      Q => \virtual_evt_data_reg_n_0_[84]\,
      R => clear
    );
\virtual_evt_data_reg[85]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(21),
      Q => \virtual_evt_data_reg_n_0_[85]\,
      R => clear
    );
\virtual_evt_data_reg[86]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(22),
      Q => \virtual_evt_data_reg_n_0_[86]\,
      R => clear
    );
\virtual_evt_data_reg[87]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(23),
      Q => \virtual_evt_data_reg_n_0_[87]\,
      R => clear
    );
\virtual_evt_data_reg[88]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(24),
      Q => \virtual_evt_data_reg_n_0_[88]\,
      R => clear
    );
\virtual_evt_data_reg[89]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(25),
      Q => \virtual_evt_data_reg_n_0_[89]\,
      R => clear
    );
\virtual_evt_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[8]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[8]\,
      R => clear
    );
\virtual_evt_data_reg[90]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(26),
      Q => \virtual_evt_data_reg_n_0_[90]\,
      R => clear
    );
\virtual_evt_data_reg[91]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(27),
      Q => \virtual_evt_data_reg_n_0_[91]\,
      R => clear
    );
\virtual_evt_data_reg[92]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(28),
      Q => \virtual_evt_data_reg_n_0_[92]\,
      R => clear
    );
\virtual_evt_data_reg[93]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(29),
      Q => \virtual_evt_data_reg_n_0_[93]\,
      R => clear
    );
\virtual_evt_data_reg[94]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(30),
      Q => \virtual_evt_data_reg_n_0_[94]\,
      R => clear
    );
\virtual_evt_data_reg[95]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(31),
      Q => \virtual_evt_data_reg_n_0_[95]\,
      R => clear
    );
\virtual_evt_data_reg[96]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(32),
      Q => \virtual_evt_data_reg_n_0_[96]\,
      R => clear
    );
\virtual_evt_data_reg[97]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(33),
      Q => \virtual_evt_data_reg_n_0_[97]\,
      R => clear
    );
\virtual_evt_data_reg[98]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(34),
      Q => \virtual_evt_data_reg_n_0_[98]\,
      R => clear
    );
\virtual_evt_data_reg[99]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => timestamp_counter_reg(35),
      Q => \virtual_evt_data_reg_n_0_[99]\,
      R => clear
    );
\virtual_evt_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => virtual_evt_valid7_out,
      D => \virtual_evt_data[9]_i_1_n_0\,
      Q => \virtual_evt_data_reg_n_0_[9]\,
      R => clear
    );
virtual_evt_trigger_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1015505515155555"
    )
        port map (
      I0 => \virtual_evt_data[127]_i_6_n_0\,
      I1 => wstrb_reg(3),
      I2 => w_pending_reg_n_0,
      I3 => s_axi_wstrb(3),
      I4 => wdata_reg(31),
      I5 => s_axi_wdata(31),
      O => virtual_evt_trigger_i_2_n_0
    );
virtual_evt_trigger_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8C8C8C8C8C8C8CCC"
    )
        port map (
      I0 => write_addr(4),
      I1 => virtual_evt_valid_reg_n_0,
      I2 => virtual_evt_valid_i_2_n_0,
      I3 => \scratch_reg[31]_i_6_n_0\,
      I4 => capture_arm_pulse_i_4_n_0,
      I5 => virtual_evt_trigger_i_4_n_0,
      O => virtual_evt_trigger_i_3_n_0
    );
virtual_evt_trigger_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \dropped_count_reg[31]_i_8_n_0\,
      I1 => capture_arm_pulse_i_5_n_0,
      I2 => event_arbiter_n_18,
      I3 => \virtual_evt_data[127]_i_7_n_0\,
      I4 => virtual_evt_trigger_i_5_n_0,
      I5 => event_arbiter_n_19,
      O => virtual_evt_trigger_i_4_n_0
    );
virtual_evt_trigger_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => s_axi_awaddr(0),
      I1 => awaddr_reg(0),
      I2 => s_axi_awaddr(6),
      I3 => aw_pending,
      I4 => awaddr_reg(6),
      O => virtual_evt_trigger_i_5_n_0
    );
virtual_evt_trigger_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => event_arbiter_n_180,
      Q => virtual_evt_trigger_reg_n_0,
      R => clear
    );
virtual_evt_valid_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0C000A0A0C000000"
    )
        port map (
      I0 => s_axi_wstrb(0),
      I1 => wstrb_reg(0),
      I2 => event_arbiter_n_14,
      I3 => wdata_reg(2),
      I4 => w_pending_reg_n_0,
      I5 => s_axi_wdata(2),
      O => virtual_evt_valid_i_2_n_0
    );
virtual_evt_valid_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \scratch_reg[31]_i_6_n_0\,
      I1 => capture_arm_pulse_i_4_n_0,
      I2 => \led_ctrl_reg[0]_i_5_n_0\,
      I3 => virtual_evt_valid_i_5_n_0,
      I4 => \virtual_evt_data[127]_i_3_n_0\,
      O => virtual_evt_valid_i_3_n_0
    );
virtual_evt_valid_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF4540"
    )
        port map (
      I0 => event_arbiter_n_18,
      I1 => awaddr_reg(7),
      I2 => aw_pending,
      I3 => s_axi_awaddr(7),
      I4 => \led_ctrl_reg[0]_i_13_n_0\,
      I5 => \led_ctrl_reg[0]_i_10_n_0\,
      O => virtual_evt_valid_i_5_n_0
    );
virtual_evt_valid_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => event_arbiter_n_181,
      Q => virtual_evt_valid_reg_n_0,
      R => clear
    );
w_pending_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"E0E0E0EE00000000"
    )
        port map (
      I0 => w_pending_reg_n_0,
      I1 => w_hs,
      I2 => \^s_axi_bvalid_reg_0\,
      I3 => aw_hs,
      I4 => aw_pending,
      I5 => s_axi_aresetn,
      O => w_pending_i_1_n_0
    );
w_pending_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => w_pending_i_1_n_0,
      Q => w_pending_reg_n_0,
      R => '0'
    );
\wdata_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(0),
      Q => wdata_reg(0),
      R => clear
    );
\wdata_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(10),
      Q => wdata_reg(10),
      R => clear
    );
\wdata_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(11),
      Q => wdata_reg(11),
      R => clear
    );
\wdata_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(12),
      Q => wdata_reg(12),
      R => clear
    );
\wdata_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(13),
      Q => wdata_reg(13),
      R => clear
    );
\wdata_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(14),
      Q => wdata_reg(14),
      R => clear
    );
\wdata_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(15),
      Q => wdata_reg(15),
      R => clear
    );
\wdata_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(16),
      Q => wdata_reg(16),
      R => clear
    );
\wdata_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(17),
      Q => wdata_reg(17),
      R => clear
    );
\wdata_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(18),
      Q => wdata_reg(18),
      R => clear
    );
\wdata_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(19),
      Q => wdata_reg(19),
      R => clear
    );
\wdata_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(1),
      Q => wdata_reg(1),
      R => clear
    );
\wdata_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(20),
      Q => wdata_reg(20),
      R => clear
    );
\wdata_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(21),
      Q => wdata_reg(21),
      R => clear
    );
\wdata_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(22),
      Q => wdata_reg(22),
      R => clear
    );
\wdata_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(23),
      Q => wdata_reg(23),
      R => clear
    );
\wdata_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(24),
      Q => wdata_reg(24),
      R => clear
    );
\wdata_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(25),
      Q => wdata_reg(25),
      R => clear
    );
\wdata_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(26),
      Q => wdata_reg(26),
      R => clear
    );
\wdata_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(27),
      Q => wdata_reg(27),
      R => clear
    );
\wdata_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(28),
      Q => wdata_reg(28),
      R => clear
    );
\wdata_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(29),
      Q => wdata_reg(29),
      R => clear
    );
\wdata_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(2),
      Q => wdata_reg(2),
      R => clear
    );
\wdata_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(30),
      Q => wdata_reg(30),
      R => clear
    );
\wdata_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(31),
      Q => wdata_reg(31),
      R => clear
    );
\wdata_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(3),
      Q => wdata_reg(3),
      R => clear
    );
\wdata_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(4),
      Q => wdata_reg(4),
      R => clear
    );
\wdata_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(5),
      Q => wdata_reg(5),
      R => clear
    );
\wdata_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(6),
      Q => wdata_reg(6),
      R => clear
    );
\wdata_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(7),
      Q => wdata_reg(7),
      R => clear
    );
\wdata_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(8),
      Q => wdata_reg(8),
      R => clear
    );
\wdata_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wdata(9),
      Q => wdata_reg(9),
      R => clear
    );
\wstrb_reg[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^s_axi_wready\,
      I1 => s_axi_wvalid,
      O => w_hs
    );
\wstrb_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wstrb(0),
      Q => wstrb_reg(0),
      R => clear
    );
\wstrb_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wstrb(1),
      Q => wstrb_reg(1),
      R => clear
    );
\wstrb_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wstrb(2),
      Q => wstrb_reg(2),
      R => clear
    );
\wstrb_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => w_hs,
      D => s_axi_wstrb(3),
      Q => wstrb_reg(3),
      R => clear
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity multi_protocol_bd_multi_protocol_core_0_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    ext_evt_valid : in STD_LOGIC;
    ext_evt_ready : out STD_LOGIC;
    ext_evt_data : in STD_LOGIC_VECTOR ( 127 downto 0 );
    ext_evt_trigger : in STD_LOGIC;
    ext_evt_dropped_count : in STD_LOGIC_VECTOR ( 31 downto 0 );
    led_heartbeat : out STD_LOGIC;
    led_ps_active : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of multi_protocol_bd_multi_protocol_core_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of multi_protocol_bd_multi_protocol_core_0_0 : entity is "multi_protocol_bd_multi_protocol_core_0_0,multi_protocol_core,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of multi_protocol_bd_multi_protocol_core_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of multi_protocol_bd_multi_protocol_core_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of multi_protocol_bd_multi_protocol_core_0_0 : entity is "multi_protocol_core,Vivado 2018.3";
end multi_protocol_bd_multi_protocol_core_0_0;

architecture STRUCTURE of multi_protocol_bd_multi_protocol_core_0_0 is
  signal \<const0>\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of s_axi_aclk : signal is "xilinx.com:signal:clock:1.0 s_axi_aclk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of s_axi_aclk : signal is "XIL_INTERFACENAME s_axi_aclk, ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_aresetn, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN multi_protocol_bd_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_aresetn : signal is "xilinx.com:signal:reset:1.0 s_axi_aresetn RST";
  attribute X_INTERFACE_PARAMETER of s_axi_aresetn : signal is "XIL_INTERFACENAME s_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute X_INTERFACE_INFO of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARVALID";
  attribute X_INTERFACE_INFO of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute X_INTERFACE_INFO of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWVALID";
  attribute X_INTERFACE_INFO of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 s_axi BREADY";
  attribute X_INTERFACE_INFO of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute X_INTERFACE_INFO of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 s_axi RREADY";
  attribute X_INTERFACE_PARAMETER of s_axi_rready : signal is "XIL_INTERFACENAME s_axi, PROTOCOL AXI4LITE, DATA_WIDTH 32, ADDR_WIDTH 16, FREQ_HZ 100000000, ID_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, SUPPORTS_NARROW_BURST 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_PROT 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_DOMAIN multi_protocol_bd_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute X_INTERFACE_INFO of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute X_INTERFACE_INFO of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi WVALID";
  attribute X_INTERFACE_INFO of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 s_axi ARADDR";
  attribute X_INTERFACE_INFO of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 s_axi AWADDR";
  attribute X_INTERFACE_PARAMETER of s_axi_awaddr : signal is "XIL_INTERFACENAME s_axi, PROTOCOL AXI4LITE, DATA_WIDTH 32, ADDR_WIDTH 16, FREQ_HZ 100000000, ID_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, SUPPORTS_NARROW_BURST 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1";
  attribute X_INTERFACE_INFO of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 s_axi BRESP";
  attribute X_INTERFACE_INFO of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 s_axi RRESP";
  attribute X_INTERFACE_INFO of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 s_axi WDATA";
  attribute X_INTERFACE_INFO of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 s_axi WSTRB";
begin
  s_axi_bresp(1) <= \<const0>\;
  s_axi_bresp(0) <= \<const0>\;
  s_axi_rresp(1) <= \<const0>\;
  s_axi_rresp(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.multi_protocol_bd_multi_protocol_core_0_0_multi_protocol_core
     port map (
      ext_evt_data(127 downto 0) => ext_evt_data(127 downto 0),
      ext_evt_dropped_count(31 downto 0) => ext_evt_dropped_count(31 downto 0),
      ext_evt_ready => ext_evt_ready,
      ext_evt_trigger => ext_evt_trigger,
      ext_evt_valid => ext_evt_valid,
      led_heartbeat => led_heartbeat,
      led_ps_active => led_ps_active,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(15 downto 0) => s_axi_araddr(15 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(15 downto 0) => s_axi_awaddr(15 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bvalid_reg_0 => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
