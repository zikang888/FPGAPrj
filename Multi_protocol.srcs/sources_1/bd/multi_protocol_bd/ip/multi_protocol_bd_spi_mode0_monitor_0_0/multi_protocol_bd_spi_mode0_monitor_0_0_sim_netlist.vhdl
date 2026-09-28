-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sat Sep 26 16:49:59 2026
-- Host        : LAPTOP-MK9F4NL5 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               D:/Vivado/Project/Multi_protocol/Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/ip/multi_protocol_bd_spi_mode0_monitor_0_0/multi_protocol_bd_spi_mode0_monitor_0_0_sim_netlist.vhdl
-- Design      : multi_protocol_bd_spi_mode0_monitor_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor is
  port (
    monitor_active_reg_0 : out STD_LOGIC;
    evt_data : out STD_LOGIC_VECTOR ( 108 downto 0 );
    transaction_id : out STD_LOGIC_VECTOR ( 23 downto 0 );
    dropped_event_count : out STD_LOGIC_VECTOR ( 31 downto 0 );
    evt_valid_reg_0 : out STD_LOGIC;
    evt_trigger : out STD_LOGIC;
    rst_n : in STD_LOGIC;
    spi_cs_n : in STD_LOGIC;
    clk : in STD_LOGIC;
    spi_sclk : in STD_LOGIC;
    spi_mosi : in STD_LOGIC;
    spi_miso : in STD_LOGIC;
    timestamp : in STD_LOGIC_VECTOR ( 63 downto 0 );
    evt_ready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor : entity is "spi_mode0_monitor";
end multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor;

architecture STRUCTURE of multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor is
  signal bit_count : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal bit_count08_out : STD_LOGIC;
  signal \bit_count[0]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count[1]_i_1_n_0\ : STD_LOGIC;
  signal \bit_count[2]_i_1_n_0\ : STD_LOGIC;
  signal clear : STD_LOGIC;
  signal cs_falling : STD_LOGIC;
  signal \^dropped_event_count\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \dropped_event_count[31]_i_1_n_0\ : STD_LOGIC;
  signal \dropped_event_count[3]_i_2_n_0\ : STD_LOGIC;
  signal \dropped_event_count_reg[11]_i_1_n_0\ : STD_LOGIC;
  signal \dropped_event_count_reg[11]_i_1_n_1\ : STD_LOGIC;
  signal \dropped_event_count_reg[11]_i_1_n_2\ : STD_LOGIC;
  signal \dropped_event_count_reg[11]_i_1_n_3\ : STD_LOGIC;
  signal \dropped_event_count_reg[11]_i_1_n_4\ : STD_LOGIC;
  signal \dropped_event_count_reg[11]_i_1_n_5\ : STD_LOGIC;
  signal \dropped_event_count_reg[11]_i_1_n_6\ : STD_LOGIC;
  signal \dropped_event_count_reg[11]_i_1_n_7\ : STD_LOGIC;
  signal \dropped_event_count_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal \dropped_event_count_reg[15]_i_1_n_1\ : STD_LOGIC;
  signal \dropped_event_count_reg[15]_i_1_n_2\ : STD_LOGIC;
  signal \dropped_event_count_reg[15]_i_1_n_3\ : STD_LOGIC;
  signal \dropped_event_count_reg[15]_i_1_n_4\ : STD_LOGIC;
  signal \dropped_event_count_reg[15]_i_1_n_5\ : STD_LOGIC;
  signal \dropped_event_count_reg[15]_i_1_n_6\ : STD_LOGIC;
  signal \dropped_event_count_reg[15]_i_1_n_7\ : STD_LOGIC;
  signal \dropped_event_count_reg[19]_i_1_n_0\ : STD_LOGIC;
  signal \dropped_event_count_reg[19]_i_1_n_1\ : STD_LOGIC;
  signal \dropped_event_count_reg[19]_i_1_n_2\ : STD_LOGIC;
  signal \dropped_event_count_reg[19]_i_1_n_3\ : STD_LOGIC;
  signal \dropped_event_count_reg[19]_i_1_n_4\ : STD_LOGIC;
  signal \dropped_event_count_reg[19]_i_1_n_5\ : STD_LOGIC;
  signal \dropped_event_count_reg[19]_i_1_n_6\ : STD_LOGIC;
  signal \dropped_event_count_reg[19]_i_1_n_7\ : STD_LOGIC;
  signal \dropped_event_count_reg[23]_i_1_n_0\ : STD_LOGIC;
  signal \dropped_event_count_reg[23]_i_1_n_1\ : STD_LOGIC;
  signal \dropped_event_count_reg[23]_i_1_n_2\ : STD_LOGIC;
  signal \dropped_event_count_reg[23]_i_1_n_3\ : STD_LOGIC;
  signal \dropped_event_count_reg[23]_i_1_n_4\ : STD_LOGIC;
  signal \dropped_event_count_reg[23]_i_1_n_5\ : STD_LOGIC;
  signal \dropped_event_count_reg[23]_i_1_n_6\ : STD_LOGIC;
  signal \dropped_event_count_reg[23]_i_1_n_7\ : STD_LOGIC;
  signal \dropped_event_count_reg[27]_i_1_n_0\ : STD_LOGIC;
  signal \dropped_event_count_reg[27]_i_1_n_1\ : STD_LOGIC;
  signal \dropped_event_count_reg[27]_i_1_n_2\ : STD_LOGIC;
  signal \dropped_event_count_reg[27]_i_1_n_3\ : STD_LOGIC;
  signal \dropped_event_count_reg[27]_i_1_n_4\ : STD_LOGIC;
  signal \dropped_event_count_reg[27]_i_1_n_5\ : STD_LOGIC;
  signal \dropped_event_count_reg[27]_i_1_n_6\ : STD_LOGIC;
  signal \dropped_event_count_reg[27]_i_1_n_7\ : STD_LOGIC;
  signal \dropped_event_count_reg[31]_i_2_n_1\ : STD_LOGIC;
  signal \dropped_event_count_reg[31]_i_2_n_2\ : STD_LOGIC;
  signal \dropped_event_count_reg[31]_i_2_n_3\ : STD_LOGIC;
  signal \dropped_event_count_reg[31]_i_2_n_4\ : STD_LOGIC;
  signal \dropped_event_count_reg[31]_i_2_n_5\ : STD_LOGIC;
  signal \dropped_event_count_reg[31]_i_2_n_6\ : STD_LOGIC;
  signal \dropped_event_count_reg[31]_i_2_n_7\ : STD_LOGIC;
  signal \dropped_event_count_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \dropped_event_count_reg[3]_i_1_n_1\ : STD_LOGIC;
  signal \dropped_event_count_reg[3]_i_1_n_2\ : STD_LOGIC;
  signal \dropped_event_count_reg[3]_i_1_n_3\ : STD_LOGIC;
  signal \dropped_event_count_reg[3]_i_1_n_4\ : STD_LOGIC;
  signal \dropped_event_count_reg[3]_i_1_n_5\ : STD_LOGIC;
  signal \dropped_event_count_reg[3]_i_1_n_6\ : STD_LOGIC;
  signal \dropped_event_count_reg[3]_i_1_n_7\ : STD_LOGIC;
  signal \dropped_event_count_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \dropped_event_count_reg[7]_i_1_n_1\ : STD_LOGIC;
  signal \dropped_event_count_reg[7]_i_1_n_2\ : STD_LOGIC;
  signal \dropped_event_count_reg[7]_i_1_n_3\ : STD_LOGIC;
  signal \dropped_event_count_reg[7]_i_1_n_4\ : STD_LOGIC;
  signal \dropped_event_count_reg[7]_i_1_n_5\ : STD_LOGIC;
  signal \dropped_event_count_reg[7]_i_1_n_6\ : STD_LOGIC;
  signal \dropped_event_count_reg[7]_i_1_n_7\ : STD_LOGIC;
  signal event_transaction_id : STD_LOGIC_VECTOR ( 23 downto 1 );
  signal \evt_data[0]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[10]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[11]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[127]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[127]_i_2_n_0\ : STD_LOGIC;
  signal \evt_data[127]_i_3_n_0\ : STD_LOGIC;
  signal \evt_data[127]_i_4_n_0\ : STD_LOGIC;
  signal \evt_data[127]_i_5_n_0\ : STD_LOGIC;
  signal \evt_data[127]_i_6_n_0\ : STD_LOGIC;
  signal \evt_data[12]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[13]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[14]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[15]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[16]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[17]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[18]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[19]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[1]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[20]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[21]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[22]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[23]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[25]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[2]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[32]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[33]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[34]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[3]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[47]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[48]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[49]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[4]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[53]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[5]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[6]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[7]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[8]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data[9]_i_1_n_0\ : STD_LOGIC;
  signal \evt_data_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \evt_data_reg[12]_i_2_n_1\ : STD_LOGIC;
  signal \evt_data_reg[12]_i_2_n_2\ : STD_LOGIC;
  signal \evt_data_reg[12]_i_2_n_3\ : STD_LOGIC;
  signal \evt_data_reg[16]_i_2_n_0\ : STD_LOGIC;
  signal \evt_data_reg[16]_i_2_n_1\ : STD_LOGIC;
  signal \evt_data_reg[16]_i_2_n_2\ : STD_LOGIC;
  signal \evt_data_reg[16]_i_2_n_3\ : STD_LOGIC;
  signal \evt_data_reg[20]_i_2_n_0\ : STD_LOGIC;
  signal \evt_data_reg[20]_i_2_n_1\ : STD_LOGIC;
  signal \evt_data_reg[20]_i_2_n_2\ : STD_LOGIC;
  signal \evt_data_reg[20]_i_2_n_3\ : STD_LOGIC;
  signal \evt_data_reg[23]_i_2_n_2\ : STD_LOGIC;
  signal \evt_data_reg[23]_i_2_n_3\ : STD_LOGIC;
  signal \evt_data_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \evt_data_reg[4]_i_2_n_1\ : STD_LOGIC;
  signal \evt_data_reg[4]_i_2_n_2\ : STD_LOGIC;
  signal \evt_data_reg[4]_i_2_n_3\ : STD_LOGIC;
  signal \evt_data_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \evt_data_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \evt_data_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \evt_data_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \^evt_trigger\ : STD_LOGIC;
  signal evt_trigger_i_1_n_0 : STD_LOGIC;
  signal evt_trigger_i_2_n_0 : STD_LOGIC;
  signal evt_trigger_i_3_n_0 : STD_LOGIC;
  signal evt_valid_i_2_n_0 : STD_LOGIC;
  signal evt_valid_i_3_n_0 : STD_LOGIC;
  signal \^evt_valid_reg_0\ : STD_LOGIC;
  signal miso_shift : STD_LOGIC;
  signal \miso_shift_reg_n_0_[0]\ : STD_LOGIC;
  signal \miso_shift_reg_n_0_[1]\ : STD_LOGIC;
  signal \miso_shift_reg_n_0_[2]\ : STD_LOGIC;
  signal \miso_shift_reg_n_0_[3]\ : STD_LOGIC;
  signal \miso_shift_reg_n_0_[4]\ : STD_LOGIC;
  signal \miso_shift_reg_n_0_[5]\ : STD_LOGIC;
  signal \miso_shift_reg_n_0_[6]\ : STD_LOGIC;
  signal monitor_active_i_1_n_0 : STD_LOGIC;
  signal \^monitor_active_reg_0\ : STD_LOGIC;
  signal \mosi_shift_reg_n_0_[0]\ : STD_LOGIC;
  signal \mosi_shift_reg_n_0_[1]\ : STD_LOGIC;
  signal \mosi_shift_reg_n_0_[2]\ : STD_LOGIC;
  signal \mosi_shift_reg_n_0_[3]\ : STD_LOGIC;
  signal \mosi_shift_reg_n_0_[4]\ : STD_LOGIC;
  signal \mosi_shift_reg_n_0_[5]\ : STD_LOGIC;
  signal \mosi_shift_reg_n_0_[6]\ : STD_LOGIC;
  signal spi_cs_d : STD_LOGIC;
  signal spi_cs_meta : STD_LOGIC;
  attribute async_reg : string;
  attribute async_reg of spi_cs_meta : signal is "true";
  signal spi_cs_sync : STD_LOGIC;
  attribute async_reg of spi_cs_sync : signal is "true";
  signal spi_miso_meta : STD_LOGIC;
  attribute async_reg of spi_miso_meta : signal is "true";
  signal spi_miso_sync : STD_LOGIC;
  attribute async_reg of spi_miso_sync : signal is "true";
  signal spi_mosi_meta : STD_LOGIC;
  attribute async_reg of spi_mosi_meta : signal is "true";
  signal spi_mosi_sync : STD_LOGIC;
  attribute async_reg of spi_mosi_sync : signal is "true";
  signal spi_sclk_d : STD_LOGIC;
  signal spi_sclk_meta : STD_LOGIC;
  attribute async_reg of spi_sclk_meta : signal is "true";
  signal spi_sclk_sync : STD_LOGIC;
  attribute async_reg of spi_sclk_sync : signal is "true";
  signal \^transaction_id\ : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal \transaction_id[3]_i_2_n_0\ : STD_LOGIC;
  signal \transaction_id_reg[11]_i_1_n_0\ : STD_LOGIC;
  signal \transaction_id_reg[11]_i_1_n_1\ : STD_LOGIC;
  signal \transaction_id_reg[11]_i_1_n_2\ : STD_LOGIC;
  signal \transaction_id_reg[11]_i_1_n_3\ : STD_LOGIC;
  signal \transaction_id_reg[11]_i_1_n_4\ : STD_LOGIC;
  signal \transaction_id_reg[11]_i_1_n_5\ : STD_LOGIC;
  signal \transaction_id_reg[11]_i_1_n_6\ : STD_LOGIC;
  signal \transaction_id_reg[11]_i_1_n_7\ : STD_LOGIC;
  signal \transaction_id_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal \transaction_id_reg[15]_i_1_n_1\ : STD_LOGIC;
  signal \transaction_id_reg[15]_i_1_n_2\ : STD_LOGIC;
  signal \transaction_id_reg[15]_i_1_n_3\ : STD_LOGIC;
  signal \transaction_id_reg[15]_i_1_n_4\ : STD_LOGIC;
  signal \transaction_id_reg[15]_i_1_n_5\ : STD_LOGIC;
  signal \transaction_id_reg[15]_i_1_n_6\ : STD_LOGIC;
  signal \transaction_id_reg[15]_i_1_n_7\ : STD_LOGIC;
  signal \transaction_id_reg[19]_i_1_n_0\ : STD_LOGIC;
  signal \transaction_id_reg[19]_i_1_n_1\ : STD_LOGIC;
  signal \transaction_id_reg[19]_i_1_n_2\ : STD_LOGIC;
  signal \transaction_id_reg[19]_i_1_n_3\ : STD_LOGIC;
  signal \transaction_id_reg[19]_i_1_n_4\ : STD_LOGIC;
  signal \transaction_id_reg[19]_i_1_n_5\ : STD_LOGIC;
  signal \transaction_id_reg[19]_i_1_n_6\ : STD_LOGIC;
  signal \transaction_id_reg[19]_i_1_n_7\ : STD_LOGIC;
  signal \transaction_id_reg[23]_i_2_n_1\ : STD_LOGIC;
  signal \transaction_id_reg[23]_i_2_n_2\ : STD_LOGIC;
  signal \transaction_id_reg[23]_i_2_n_3\ : STD_LOGIC;
  signal \transaction_id_reg[23]_i_2_n_4\ : STD_LOGIC;
  signal \transaction_id_reg[23]_i_2_n_5\ : STD_LOGIC;
  signal \transaction_id_reg[23]_i_2_n_6\ : STD_LOGIC;
  signal \transaction_id_reg[23]_i_2_n_7\ : STD_LOGIC;
  signal \transaction_id_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \transaction_id_reg[3]_i_1_n_1\ : STD_LOGIC;
  signal \transaction_id_reg[3]_i_1_n_2\ : STD_LOGIC;
  signal \transaction_id_reg[3]_i_1_n_3\ : STD_LOGIC;
  signal \transaction_id_reg[3]_i_1_n_4\ : STD_LOGIC;
  signal \transaction_id_reg[3]_i_1_n_5\ : STD_LOGIC;
  signal \transaction_id_reg[3]_i_1_n_6\ : STD_LOGIC;
  signal \transaction_id_reg[3]_i_1_n_7\ : STD_LOGIC;
  signal \transaction_id_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \transaction_id_reg[7]_i_1_n_1\ : STD_LOGIC;
  signal \transaction_id_reg[7]_i_1_n_2\ : STD_LOGIC;
  signal \transaction_id_reg[7]_i_1_n_3\ : STD_LOGIC;
  signal \transaction_id_reg[7]_i_1_n_4\ : STD_LOGIC;
  signal \transaction_id_reg[7]_i_1_n_5\ : STD_LOGIC;
  signal \transaction_id_reg[7]_i_1_n_6\ : STD_LOGIC;
  signal \transaction_id_reg[7]_i_1_n_7\ : STD_LOGIC;
  signal \NLW_dropped_event_count_reg[31]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_evt_data_reg[23]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_evt_data_reg[23]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_transaction_id_reg[23]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \evt_data[127]_i_3\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \evt_data[53]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of evt_trigger_i_3 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of evt_valid_i_2 : label is "soft_lutpair1";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of spi_cs_meta_reg : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of spi_cs_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of spi_cs_sync_reg : label is std.standard.true;
  attribute KEEP of spi_cs_sync_reg : label is "yes";
  attribute ASYNC_REG_boolean of spi_miso_meta_reg : label is std.standard.true;
  attribute KEEP of spi_miso_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of spi_miso_sync_reg : label is std.standard.true;
  attribute KEEP of spi_miso_sync_reg : label is "yes";
  attribute ASYNC_REG_boolean of spi_mosi_meta_reg : label is std.standard.true;
  attribute KEEP of spi_mosi_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of spi_mosi_sync_reg : label is std.standard.true;
  attribute KEEP of spi_mosi_sync_reg : label is "yes";
  attribute ASYNC_REG_boolean of spi_sclk_meta_reg : label is std.standard.true;
  attribute KEEP of spi_sclk_meta_reg : label is "yes";
  attribute ASYNC_REG_boolean of spi_sclk_sync_reg : label is std.standard.true;
  attribute KEEP of spi_sclk_sync_reg : label is "yes";
begin
  dropped_event_count(31 downto 0) <= \^dropped_event_count\(31 downto 0);
  evt_trigger <= \^evt_trigger\;
  evt_valid_reg_0 <= \^evt_valid_reg_0\;
  monitor_active_reg_0 <= \^monitor_active_reg_0\;
  transaction_id(23 downto 0) <= \^transaction_id\(23 downto 0);
\bit_count[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6006000066060000"
    )
        port map (
      I0 => bit_count(0),
      I1 => bit_count08_out,
      I2 => spi_cs_d,
      I3 => spi_cs_sync,
      I4 => rst_n,
      I5 => \^monitor_active_reg_0\,
      O => \bit_count[0]_i_1_n_0\
    );
\bit_count[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000006A"
    )
        port map (
      I0 => bit_count(1),
      I1 => bit_count08_out,
      I2 => bit_count(0),
      I3 => miso_shift,
      I4 => evt_trigger_i_2_n_0,
      O => \bit_count[1]_i_1_n_0\
    );
\bit_count[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000006AAA"
    )
        port map (
      I0 => bit_count(2),
      I1 => bit_count08_out,
      I2 => bit_count(0),
      I3 => bit_count(1),
      I4 => miso_shift,
      I5 => evt_trigger_i_2_n_0,
      O => \bit_count[2]_i_1_n_0\
    );
\bit_count_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \bit_count[0]_i_1_n_0\,
      Q => bit_count(0),
      R => '0'
    );
\bit_count_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \bit_count[1]_i_1_n_0\,
      Q => bit_count(1),
      R => '0'
    );
\bit_count_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => \bit_count[2]_i_1_n_0\,
      Q => bit_count(2),
      R => '0'
    );
\dropped_event_count[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => evt_valid_i_3_n_0,
      I1 => \^evt_valid_reg_0\,
      I2 => evt_ready,
      O => \dropped_event_count[31]_i_1_n_0\
    );
\dropped_event_count[3]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^dropped_event_count\(0),
      O => \dropped_event_count[3]_i_2_n_0\
    );
\dropped_event_count_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[3]_i_1_n_7\,
      Q => \^dropped_event_count\(0),
      R => clear
    );
\dropped_event_count_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[11]_i_1_n_5\,
      Q => \^dropped_event_count\(10),
      R => clear
    );
\dropped_event_count_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[11]_i_1_n_4\,
      Q => \^dropped_event_count\(11),
      R => clear
    );
\dropped_event_count_reg[11]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_event_count_reg[7]_i_1_n_0\,
      CO(3) => \dropped_event_count_reg[11]_i_1_n_0\,
      CO(2) => \dropped_event_count_reg[11]_i_1_n_1\,
      CO(1) => \dropped_event_count_reg[11]_i_1_n_2\,
      CO(0) => \dropped_event_count_reg[11]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \dropped_event_count_reg[11]_i_1_n_4\,
      O(2) => \dropped_event_count_reg[11]_i_1_n_5\,
      O(1) => \dropped_event_count_reg[11]_i_1_n_6\,
      O(0) => \dropped_event_count_reg[11]_i_1_n_7\,
      S(3 downto 0) => \^dropped_event_count\(11 downto 8)
    );
\dropped_event_count_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[15]_i_1_n_7\,
      Q => \^dropped_event_count\(12),
      R => clear
    );
\dropped_event_count_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[15]_i_1_n_6\,
      Q => \^dropped_event_count\(13),
      R => clear
    );
\dropped_event_count_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[15]_i_1_n_5\,
      Q => \^dropped_event_count\(14),
      R => clear
    );
\dropped_event_count_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[15]_i_1_n_4\,
      Q => \^dropped_event_count\(15),
      R => clear
    );
\dropped_event_count_reg[15]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_event_count_reg[11]_i_1_n_0\,
      CO(3) => \dropped_event_count_reg[15]_i_1_n_0\,
      CO(2) => \dropped_event_count_reg[15]_i_1_n_1\,
      CO(1) => \dropped_event_count_reg[15]_i_1_n_2\,
      CO(0) => \dropped_event_count_reg[15]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \dropped_event_count_reg[15]_i_1_n_4\,
      O(2) => \dropped_event_count_reg[15]_i_1_n_5\,
      O(1) => \dropped_event_count_reg[15]_i_1_n_6\,
      O(0) => \dropped_event_count_reg[15]_i_1_n_7\,
      S(3 downto 0) => \^dropped_event_count\(15 downto 12)
    );
\dropped_event_count_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[19]_i_1_n_7\,
      Q => \^dropped_event_count\(16),
      R => clear
    );
\dropped_event_count_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[19]_i_1_n_6\,
      Q => \^dropped_event_count\(17),
      R => clear
    );
\dropped_event_count_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[19]_i_1_n_5\,
      Q => \^dropped_event_count\(18),
      R => clear
    );
\dropped_event_count_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[19]_i_1_n_4\,
      Q => \^dropped_event_count\(19),
      R => clear
    );
\dropped_event_count_reg[19]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_event_count_reg[15]_i_1_n_0\,
      CO(3) => \dropped_event_count_reg[19]_i_1_n_0\,
      CO(2) => \dropped_event_count_reg[19]_i_1_n_1\,
      CO(1) => \dropped_event_count_reg[19]_i_1_n_2\,
      CO(0) => \dropped_event_count_reg[19]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \dropped_event_count_reg[19]_i_1_n_4\,
      O(2) => \dropped_event_count_reg[19]_i_1_n_5\,
      O(1) => \dropped_event_count_reg[19]_i_1_n_6\,
      O(0) => \dropped_event_count_reg[19]_i_1_n_7\,
      S(3 downto 0) => \^dropped_event_count\(19 downto 16)
    );
\dropped_event_count_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[3]_i_1_n_6\,
      Q => \^dropped_event_count\(1),
      R => clear
    );
\dropped_event_count_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[23]_i_1_n_7\,
      Q => \^dropped_event_count\(20),
      R => clear
    );
\dropped_event_count_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[23]_i_1_n_6\,
      Q => \^dropped_event_count\(21),
      R => clear
    );
\dropped_event_count_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[23]_i_1_n_5\,
      Q => \^dropped_event_count\(22),
      R => clear
    );
\dropped_event_count_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[23]_i_1_n_4\,
      Q => \^dropped_event_count\(23),
      R => clear
    );
\dropped_event_count_reg[23]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_event_count_reg[19]_i_1_n_0\,
      CO(3) => \dropped_event_count_reg[23]_i_1_n_0\,
      CO(2) => \dropped_event_count_reg[23]_i_1_n_1\,
      CO(1) => \dropped_event_count_reg[23]_i_1_n_2\,
      CO(0) => \dropped_event_count_reg[23]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \dropped_event_count_reg[23]_i_1_n_4\,
      O(2) => \dropped_event_count_reg[23]_i_1_n_5\,
      O(1) => \dropped_event_count_reg[23]_i_1_n_6\,
      O(0) => \dropped_event_count_reg[23]_i_1_n_7\,
      S(3 downto 0) => \^dropped_event_count\(23 downto 20)
    );
\dropped_event_count_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[27]_i_1_n_7\,
      Q => \^dropped_event_count\(24),
      R => clear
    );
\dropped_event_count_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[27]_i_1_n_6\,
      Q => \^dropped_event_count\(25),
      R => clear
    );
\dropped_event_count_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[27]_i_1_n_5\,
      Q => \^dropped_event_count\(26),
      R => clear
    );
\dropped_event_count_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[27]_i_1_n_4\,
      Q => \^dropped_event_count\(27),
      R => clear
    );
\dropped_event_count_reg[27]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_event_count_reg[23]_i_1_n_0\,
      CO(3) => \dropped_event_count_reg[27]_i_1_n_0\,
      CO(2) => \dropped_event_count_reg[27]_i_1_n_1\,
      CO(1) => \dropped_event_count_reg[27]_i_1_n_2\,
      CO(0) => \dropped_event_count_reg[27]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \dropped_event_count_reg[27]_i_1_n_4\,
      O(2) => \dropped_event_count_reg[27]_i_1_n_5\,
      O(1) => \dropped_event_count_reg[27]_i_1_n_6\,
      O(0) => \dropped_event_count_reg[27]_i_1_n_7\,
      S(3 downto 0) => \^dropped_event_count\(27 downto 24)
    );
\dropped_event_count_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[31]_i_2_n_7\,
      Q => \^dropped_event_count\(28),
      R => clear
    );
\dropped_event_count_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[31]_i_2_n_6\,
      Q => \^dropped_event_count\(29),
      R => clear
    );
\dropped_event_count_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[3]_i_1_n_5\,
      Q => \^dropped_event_count\(2),
      R => clear
    );
\dropped_event_count_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[31]_i_2_n_5\,
      Q => \^dropped_event_count\(30),
      R => clear
    );
\dropped_event_count_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[31]_i_2_n_4\,
      Q => \^dropped_event_count\(31),
      R => clear
    );
\dropped_event_count_reg[31]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_event_count_reg[27]_i_1_n_0\,
      CO(3) => \NLW_dropped_event_count_reg[31]_i_2_CO_UNCONNECTED\(3),
      CO(2) => \dropped_event_count_reg[31]_i_2_n_1\,
      CO(1) => \dropped_event_count_reg[31]_i_2_n_2\,
      CO(0) => \dropped_event_count_reg[31]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \dropped_event_count_reg[31]_i_2_n_4\,
      O(2) => \dropped_event_count_reg[31]_i_2_n_5\,
      O(1) => \dropped_event_count_reg[31]_i_2_n_6\,
      O(0) => \dropped_event_count_reg[31]_i_2_n_7\,
      S(3 downto 0) => \^dropped_event_count\(31 downto 28)
    );
\dropped_event_count_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[3]_i_1_n_4\,
      Q => \^dropped_event_count\(3),
      R => clear
    );
\dropped_event_count_reg[3]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \dropped_event_count_reg[3]_i_1_n_0\,
      CO(2) => \dropped_event_count_reg[3]_i_1_n_1\,
      CO(1) => \dropped_event_count_reg[3]_i_1_n_2\,
      CO(0) => \dropped_event_count_reg[3]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \dropped_event_count_reg[3]_i_1_n_4\,
      O(2) => \dropped_event_count_reg[3]_i_1_n_5\,
      O(1) => \dropped_event_count_reg[3]_i_1_n_6\,
      O(0) => \dropped_event_count_reg[3]_i_1_n_7\,
      S(3 downto 1) => \^dropped_event_count\(3 downto 1),
      S(0) => \dropped_event_count[3]_i_2_n_0\
    );
\dropped_event_count_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[7]_i_1_n_7\,
      Q => \^dropped_event_count\(4),
      R => clear
    );
\dropped_event_count_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[7]_i_1_n_6\,
      Q => \^dropped_event_count\(5),
      R => clear
    );
\dropped_event_count_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[7]_i_1_n_5\,
      Q => \^dropped_event_count\(6),
      R => clear
    );
\dropped_event_count_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[7]_i_1_n_4\,
      Q => \^dropped_event_count\(7),
      R => clear
    );
\dropped_event_count_reg[7]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \dropped_event_count_reg[3]_i_1_n_0\,
      CO(3) => \dropped_event_count_reg[7]_i_1_n_0\,
      CO(2) => \dropped_event_count_reg[7]_i_1_n_1\,
      CO(1) => \dropped_event_count_reg[7]_i_1_n_2\,
      CO(0) => \dropped_event_count_reg[7]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \dropped_event_count_reg[7]_i_1_n_4\,
      O(2) => \dropped_event_count_reg[7]_i_1_n_5\,
      O(1) => \dropped_event_count_reg[7]_i_1_n_6\,
      O(0) => \dropped_event_count_reg[7]_i_1_n_7\,
      S(3 downto 0) => \^dropped_event_count\(7 downto 4)
    );
\dropped_event_count_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[11]_i_1_n_7\,
      Q => \^dropped_event_count\(8),
      R => clear
    );
\dropped_event_count_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \dropped_event_count[31]_i_1_n_0\,
      D => \dropped_event_count_reg[11]_i_1_n_6\,
      Q => \^dropped_event_count\(9),
      R => clear
    );
\evt_data[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8848"
    )
        port map (
      I0 => \^transaction_id\(0),
      I1 => rst_n,
      I2 => spi_cs_d,
      I3 => spi_cs_sync,
      O => \evt_data[0]_i_1_n_0\
    );
\evt_data[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(10),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(10),
      O => \evt_data[10]_i_1_n_0\
    );
\evt_data[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(11),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(11),
      O => \evt_data[11]_i_1_n_0\
    );
\evt_data[127]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \evt_data[127]_i_2_n_0\,
      I1 => rst_n,
      O => \evt_data[127]_i_1_n_0\
    );
\evt_data[127]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA8A8A8AFFFFFFFF"
    )
        port map (
      I0 => \evt_data[127]_i_3_n_0\,
      I1 => evt_trigger_i_2_n_0,
      I2 => \evt_data[127]_i_4_n_0\,
      I3 => \evt_data[127]_i_5_n_0\,
      I4 => \evt_data[127]_i_6_n_0\,
      I5 => rst_n,
      O => \evt_data[127]_i_2_n_0\
    );
\evt_data[127]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => evt_ready,
      I1 => \^evt_valid_reg_0\,
      O => \evt_data[127]_i_3_n_0\
    );
\evt_data[127]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => spi_cs_sync,
      I1 => spi_cs_d,
      O => \evt_data[127]_i_4_n_0\
    );
\evt_data[127]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => spi_cs_sync,
      I1 => bit_count(2),
      I2 => bit_count(1),
      I3 => bit_count(0),
      O => \evt_data[127]_i_5_n_0\
    );
\evt_data[127]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \^monitor_active_reg_0\,
      I1 => spi_sclk_sync,
      I2 => spi_sclk_d,
      O => \evt_data[127]_i_6_n_0\
    );
\evt_data[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(12),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(12),
      O => \evt_data[12]_i_1_n_0\
    );
\evt_data[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(13),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(13),
      O => \evt_data[13]_i_1_n_0\
    );
\evt_data[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(14),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(14),
      O => \evt_data[14]_i_1_n_0\
    );
\evt_data[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(15),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(15),
      O => \evt_data[15]_i_1_n_0\
    );
\evt_data[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(16),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(16),
      O => \evt_data[16]_i_1_n_0\
    );
\evt_data[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(17),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(17),
      O => \evt_data[17]_i_1_n_0\
    );
\evt_data[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(18),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(18),
      O => \evt_data[18]_i_1_n_0\
    );
\evt_data[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(19),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(19),
      O => \evt_data[19]_i_1_n_0\
    );
\evt_data[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(1),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(1),
      O => \evt_data[1]_i_1_n_0\
    );
\evt_data[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(20),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(20),
      O => \evt_data[20]_i_1_n_0\
    );
\evt_data[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(21),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(21),
      O => \evt_data[21]_i_1_n_0\
    );
\evt_data[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(22),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(22),
      O => \evt_data[22]_i_1_n_0\
    );
\evt_data[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(23),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(23),
      O => \evt_data[23]_i_1_n_0\
    );
\evt_data[25]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9D00"
    )
        port map (
      I0 => spi_cs_d,
      I1 => spi_cs_sync,
      I2 => \^monitor_active_reg_0\,
      I3 => rst_n,
      O => \evt_data[25]_i_1_n_0\
    );
\evt_data[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(2),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(2),
      O => \evt_data[2]_i_1_n_0\
    );
\evt_data[32]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CA0CCC0C00000000"
    )
        port map (
      I0 => bit_count(0),
      I1 => spi_mosi_sync,
      I2 => spi_cs_d,
      I3 => spi_cs_sync,
      I4 => \^monitor_active_reg_0\,
      I5 => rst_n,
      O => \evt_data[32]_i_1_n_0\
    );
\evt_data[33]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CA0CCC0C00000000"
    )
        port map (
      I0 => bit_count(1),
      I1 => \mosi_shift_reg_n_0_[0]\,
      I2 => spi_cs_d,
      I3 => spi_cs_sync,
      I4 => \^monitor_active_reg_0\,
      I5 => rst_n,
      O => \evt_data[33]_i_1_n_0\
    );
\evt_data[34]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CA0CCC0C00000000"
    )
        port map (
      I0 => bit_count(2),
      I1 => \mosi_shift_reg_n_0_[1]\,
      I2 => spi_cs_d,
      I3 => spi_cs_sync,
      I4 => \^monitor_active_reg_0\,
      I5 => rst_n,
      O => \evt_data[34]_i_1_n_0\
    );
\evt_data[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(3),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(3),
      O => \evt_data[3]_i_1_n_0\
    );
\evt_data[47]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"22AAA222"
    )
        port map (
      I0 => \evt_data[127]_i_2_n_0\,
      I1 => rst_n,
      I2 => \^monitor_active_reg_0\,
      I3 => spi_cs_sync,
      I4 => spi_cs_d,
      O => \evt_data[47]_i_1_n_0\
    );
\evt_data[48]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFE000000"
    )
        port map (
      I0 => bit_count(2),
      I1 => bit_count(1),
      I2 => bit_count(0),
      I3 => spi_cs_sync,
      I4 => rst_n,
      I5 => \evt_data[25]_i_1_n_0\,
      O => \evt_data[48]_i_1_n_0\
    );
\evt_data[49]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => spi_cs_d,
      I1 => \^monitor_active_reg_0\,
      I2 => spi_cs_sync,
      I3 => rst_n,
      O => \evt_data[49]_i_1_n_0\
    );
\evt_data[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(4),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(4),
      O => \evt_data[4]_i_1_n_0\
    );
\evt_data[53]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA8"
    )
        port map (
      I0 => \evt_data[49]_i_1_n_0\,
      I1 => bit_count(0),
      I2 => bit_count(1),
      I3 => bit_count(2),
      O => \evt_data[53]_i_1_n_0\
    );
\evt_data[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(5),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(5),
      O => \evt_data[5]_i_1_n_0\
    );
\evt_data[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(6),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(6),
      O => \evt_data[6]_i_1_n_0\
    );
\evt_data[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(7),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(7),
      O => \evt_data[7]_i_1_n_0\
    );
\evt_data[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(8),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(8),
      O => \evt_data[8]_i_1_n_0\
    );
\evt_data[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FB000800"
    )
        port map (
      I0 => event_transaction_id(9),
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      I3 => rst_n,
      I4 => \^transaction_id\(9),
      O => \evt_data[9]_i_1_n_0\
    );
\evt_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[0]_i_1_n_0\,
      Q => evt_data(0),
      R => '0'
    );
\evt_data_reg[100]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(36),
      Q => evt_data(81),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[101]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(37),
      Q => evt_data(82),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[102]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(38),
      Q => evt_data(83),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[103]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(39),
      Q => evt_data(84),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[104]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(40),
      Q => evt_data(85),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[105]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(41),
      Q => evt_data(86),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[106]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(42),
      Q => evt_data(87),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[107]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(43),
      Q => evt_data(88),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[108]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(44),
      Q => evt_data(89),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[109]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(45),
      Q => evt_data(90),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[10]_i_1_n_0\,
      Q => evt_data(10),
      R => '0'
    );
\evt_data_reg[110]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(46),
      Q => evt_data(91),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[111]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(47),
      Q => evt_data(92),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[112]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(48),
      Q => evt_data(93),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[113]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(49),
      Q => evt_data(94),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[114]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(50),
      Q => evt_data(95),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[115]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(51),
      Q => evt_data(96),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[116]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(52),
      Q => evt_data(97),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[117]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(53),
      Q => evt_data(98),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[118]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(54),
      Q => evt_data(99),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[119]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(55),
      Q => evt_data(100),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[11]_i_1_n_0\,
      Q => evt_data(11),
      R => '0'
    );
\evt_data_reg[120]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(56),
      Q => evt_data(101),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[121]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(57),
      Q => evt_data(102),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[122]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(58),
      Q => evt_data(103),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[123]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(59),
      Q => evt_data(104),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[124]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(60),
      Q => evt_data(105),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[125]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(61),
      Q => evt_data(106),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[126]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(62),
      Q => evt_data(107),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[127]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(63),
      Q => evt_data(108),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[12]_i_1_n_0\,
      Q => evt_data(12),
      R => '0'
    );
\evt_data_reg[12]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \evt_data_reg[8]_i_2_n_0\,
      CO(3) => \evt_data_reg[12]_i_2_n_0\,
      CO(2) => \evt_data_reg[12]_i_2_n_1\,
      CO(1) => \evt_data_reg[12]_i_2_n_2\,
      CO(0) => \evt_data_reg[12]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => event_transaction_id(12 downto 9),
      S(3 downto 0) => \^transaction_id\(12 downto 9)
    );
\evt_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[13]_i_1_n_0\,
      Q => evt_data(13),
      R => '0'
    );
\evt_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[14]_i_1_n_0\,
      Q => evt_data(14),
      R => '0'
    );
\evt_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[15]_i_1_n_0\,
      Q => evt_data(15),
      R => '0'
    );
\evt_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[16]_i_1_n_0\,
      Q => evt_data(16),
      R => '0'
    );
\evt_data_reg[16]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \evt_data_reg[12]_i_2_n_0\,
      CO(3) => \evt_data_reg[16]_i_2_n_0\,
      CO(2) => \evt_data_reg[16]_i_2_n_1\,
      CO(1) => \evt_data_reg[16]_i_2_n_2\,
      CO(0) => \evt_data_reg[16]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => event_transaction_id(16 downto 13),
      S(3 downto 0) => \^transaction_id\(16 downto 13)
    );
\evt_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[17]_i_1_n_0\,
      Q => evt_data(17),
      R => '0'
    );
\evt_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[18]_i_1_n_0\,
      Q => evt_data(18),
      R => '0'
    );
\evt_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[19]_i_1_n_0\,
      Q => evt_data(19),
      R => '0'
    );
\evt_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[1]_i_1_n_0\,
      Q => evt_data(1),
      R => '0'
    );
\evt_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[20]_i_1_n_0\,
      Q => evt_data(20),
      R => '0'
    );
\evt_data_reg[20]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \evt_data_reg[16]_i_2_n_0\,
      CO(3) => \evt_data_reg[20]_i_2_n_0\,
      CO(2) => \evt_data_reg[20]_i_2_n_1\,
      CO(1) => \evt_data_reg[20]_i_2_n_2\,
      CO(0) => \evt_data_reg[20]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => event_transaction_id(20 downto 17),
      S(3 downto 0) => \^transaction_id\(20 downto 17)
    );
\evt_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[21]_i_1_n_0\,
      Q => evt_data(21),
      R => '0'
    );
\evt_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[22]_i_1_n_0\,
      Q => evt_data(22),
      R => '0'
    );
\evt_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[23]_i_1_n_0\,
      Q => evt_data(23),
      R => '0'
    );
\evt_data_reg[23]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \evt_data_reg[20]_i_2_n_0\,
      CO(3 downto 2) => \NLW_evt_data_reg[23]_i_2_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \evt_data_reg[23]_i_2_n_2\,
      CO(0) => \evt_data_reg[23]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_evt_data_reg[23]_i_2_O_UNCONNECTED\(3),
      O(2 downto 0) => event_transaction_id(23 downto 21),
      S(3) => '0',
      S(2 downto 0) => \^transaction_id\(23 downto 21)
    );
\evt_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[25]_i_1_n_0\,
      Q => evt_data(24),
      R => '0'
    );
\evt_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[2]_i_1_n_0\,
      Q => evt_data(2),
      R => '0'
    );
\evt_data_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[32]_i_1_n_0\,
      Q => evt_data(25),
      R => '0'
    );
\evt_data_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[33]_i_1_n_0\,
      Q => evt_data(26),
      R => '0'
    );
\evt_data_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[34]_i_1_n_0\,
      Q => evt_data(27),
      R => '0'
    );
\evt_data_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \mosi_shift_reg_n_0_[2]\,
      Q => evt_data(28),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \mosi_shift_reg_n_0_[3]\,
      Q => evt_data(29),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \mosi_shift_reg_n_0_[4]\,
      Q => evt_data(30),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \mosi_shift_reg_n_0_[5]\,
      Q => evt_data(31),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \mosi_shift_reg_n_0_[6]\,
      Q => evt_data(32),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[3]_i_1_n_0\,
      Q => evt_data(3),
      R => '0'
    );
\evt_data_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => spi_miso_sync,
      Q => evt_data(33),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \miso_shift_reg_n_0_[0]\,
      Q => evt_data(34),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \miso_shift_reg_n_0_[1]\,
      Q => evt_data(35),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \miso_shift_reg_n_0_[2]\,
      Q => evt_data(36),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \miso_shift_reg_n_0_[3]\,
      Q => evt_data(37),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \miso_shift_reg_n_0_[4]\,
      Q => evt_data(38),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \miso_shift_reg_n_0_[5]\,
      Q => evt_data(39),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \miso_shift_reg_n_0_[6]\,
      Q => evt_data(40),
      R => \evt_data[47]_i_1_n_0\
    );
\evt_data_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[48]_i_1_n_0\,
      Q => evt_data(41),
      R => '0'
    );
\evt_data_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[49]_i_1_n_0\,
      Q => evt_data(42),
      R => '0'
    );
\evt_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[4]_i_1_n_0\,
      Q => evt_data(4),
      R => '0'
    );
\evt_data_reg[4]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \evt_data_reg[4]_i_2_n_0\,
      CO(2) => \evt_data_reg[4]_i_2_n_1\,
      CO(1) => \evt_data_reg[4]_i_2_n_2\,
      CO(0) => \evt_data_reg[4]_i_2_n_3\,
      CYINIT => \^transaction_id\(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => event_transaction_id(4 downto 1),
      S(3 downto 0) => \^transaction_id\(4 downto 1)
    );
\evt_data_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[53]_i_1_n_0\,
      Q => evt_data(43),
      R => '0'
    );
\evt_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[5]_i_1_n_0\,
      Q => evt_data(5),
      R => '0'
    );
\evt_data_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => rst_n,
      Q => evt_data(44),
      R => '0'
    );
\evt_data_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(0),
      Q => evt_data(45),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[65]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(1),
      Q => evt_data(46),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[66]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(2),
      Q => evt_data(47),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[67]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(3),
      Q => evt_data(48),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[68]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(4),
      Q => evt_data(49),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[69]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(5),
      Q => evt_data(50),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[6]_i_1_n_0\,
      Q => evt_data(6),
      R => '0'
    );
\evt_data_reg[70]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(6),
      Q => evt_data(51),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[71]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(7),
      Q => evt_data(52),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[72]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(8),
      Q => evt_data(53),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[73]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(9),
      Q => evt_data(54),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[74]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(10),
      Q => evt_data(55),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[75]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(11),
      Q => evt_data(56),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[76]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(12),
      Q => evt_data(57),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[77]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(13),
      Q => evt_data(58),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[78]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(14),
      Q => evt_data(59),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[79]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(15),
      Q => evt_data(60),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[7]_i_1_n_0\,
      Q => evt_data(7),
      R => '0'
    );
\evt_data_reg[80]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(16),
      Q => evt_data(61),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[81]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(17),
      Q => evt_data(62),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[82]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(18),
      Q => evt_data(63),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[83]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(19),
      Q => evt_data(64),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[84]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(20),
      Q => evt_data(65),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[85]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(21),
      Q => evt_data(66),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[86]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(22),
      Q => evt_data(67),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[87]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(23),
      Q => evt_data(68),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[88]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(24),
      Q => evt_data(69),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[89]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(25),
      Q => evt_data(70),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[8]_i_1_n_0\,
      Q => evt_data(8),
      R => '0'
    );
\evt_data_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \evt_data_reg[4]_i_2_n_0\,
      CO(3) => \evt_data_reg[8]_i_2_n_0\,
      CO(2) => \evt_data_reg[8]_i_2_n_1\,
      CO(1) => \evt_data_reg[8]_i_2_n_2\,
      CO(0) => \evt_data_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => event_transaction_id(8 downto 5),
      S(3 downto 0) => \^transaction_id\(8 downto 5)
    );
\evt_data_reg[90]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(26),
      Q => evt_data(71),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[91]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(27),
      Q => evt_data(72),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[92]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(28),
      Q => evt_data(73),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[93]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(29),
      Q => evt_data(74),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[94]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(30),
      Q => evt_data(75),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[95]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(31),
      Q => evt_data(76),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[96]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(32),
      Q => evt_data(77),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[97]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(33),
      Q => evt_data(78),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[98]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(34),
      Q => evt_data(79),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[99]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => timestamp(35),
      Q => evt_data(80),
      R => \evt_data[127]_i_1_n_0\
    );
\evt_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \evt_data[127]_i_2_n_0\,
      D => \evt_data[9]_i_1_n_0\,
      Q => evt_data(9),
      R => '0'
    );
evt_trigger_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8F888FFF80888000"
    )
        port map (
      I0 => evt_trigger_i_2_n_0,
      I1 => evt_trigger_i_3_n_0,
      I2 => evt_ready,
      I3 => \^evt_valid_reg_0\,
      I4 => evt_valid_i_3_n_0,
      I5 => \^evt_trigger\,
      O => evt_trigger_i_1_n_0
    );
evt_trigger_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => spi_cs_sync,
      I1 => \^monitor_active_reg_0\,
      I2 => spi_cs_d,
      O => evt_trigger_i_2_n_0
    );
evt_trigger_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => bit_count(2),
      I1 => bit_count(1),
      I2 => bit_count(0),
      O => evt_trigger_i_3_n_0
    );
evt_trigger_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => evt_trigger_i_1_n_0,
      Q => \^evt_trigger\,
      R => clear
    );
evt_valid_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rst_n,
      O => clear
    );
evt_valid_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F4"
    )
        port map (
      I0 => evt_ready,
      I1 => \^evt_valid_reg_0\,
      I2 => evt_valid_i_3_n_0,
      O => evt_valid_i_2_n_0
    );
evt_valid_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"66F6666644444444"
    )
        port map (
      I0 => spi_cs_sync,
      I1 => spi_cs_d,
      I2 => \evt_data[127]_i_5_n_0\,
      I3 => spi_sclk_d,
      I4 => spi_sclk_sync,
      I5 => \^monitor_active_reg_0\,
      O => evt_valid_i_3_n_0
    );
evt_valid_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => evt_valid_i_2_n_0,
      Q => \^evt_valid_reg_0\,
      R => clear
    );
\miso_shift_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => spi_miso_sync,
      Q => \miso_shift_reg_n_0_[0]\,
      R => miso_shift
    );
\miso_shift_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \miso_shift_reg_n_0_[0]\,
      Q => \miso_shift_reg_n_0_[1]\,
      R => miso_shift
    );
\miso_shift_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \miso_shift_reg_n_0_[1]\,
      Q => \miso_shift_reg_n_0_[2]\,
      R => miso_shift
    );
\miso_shift_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \miso_shift_reg_n_0_[2]\,
      Q => \miso_shift_reg_n_0_[3]\,
      R => miso_shift
    );
\miso_shift_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \miso_shift_reg_n_0_[3]\,
      Q => \miso_shift_reg_n_0_[4]\,
      R => miso_shift
    );
\miso_shift_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \miso_shift_reg_n_0_[4]\,
      Q => \miso_shift_reg_n_0_[5]\,
      R => miso_shift
    );
\miso_shift_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \miso_shift_reg_n_0_[5]\,
      Q => \miso_shift_reg_n_0_[6]\,
      R => miso_shift
    );
monitor_active_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"8E"
    )
        port map (
      I0 => \^monitor_active_reg_0\,
      I1 => spi_cs_d,
      I2 => spi_cs_sync,
      O => monitor_active_i_1_n_0
    );
monitor_active_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => monitor_active_i_1_n_0,
      Q => \^monitor_active_reg_0\,
      R => clear
    );
\mosi_shift[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"2F"
    )
        port map (
      I0 => spi_cs_d,
      I1 => spi_cs_sync,
      I2 => rst_n,
      O => miso_shift
    );
\mosi_shift[6]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => spi_sclk_d,
      I1 => spi_sclk_sync,
      I2 => spi_cs_sync,
      I3 => \^monitor_active_reg_0\,
      O => bit_count08_out
    );
\mosi_shift_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => spi_mosi_sync,
      Q => \mosi_shift_reg_n_0_[0]\,
      R => miso_shift
    );
\mosi_shift_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \mosi_shift_reg_n_0_[0]\,
      Q => \mosi_shift_reg_n_0_[1]\,
      R => miso_shift
    );
\mosi_shift_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \mosi_shift_reg_n_0_[1]\,
      Q => \mosi_shift_reg_n_0_[2]\,
      R => miso_shift
    );
\mosi_shift_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \mosi_shift_reg_n_0_[2]\,
      Q => \mosi_shift_reg_n_0_[3]\,
      R => miso_shift
    );
\mosi_shift_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \mosi_shift_reg_n_0_[3]\,
      Q => \mosi_shift_reg_n_0_[4]\,
      R => miso_shift
    );
\mosi_shift_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \mosi_shift_reg_n_0_[4]\,
      Q => \mosi_shift_reg_n_0_[5]\,
      R => miso_shift
    );
\mosi_shift_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => bit_count08_out,
      D => \mosi_shift_reg_n_0_[5]\,
      Q => \mosi_shift_reg_n_0_[6]\,
      R => miso_shift
    );
spi_cs_d_reg: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => '1',
      D => spi_cs_sync,
      Q => spi_cs_d,
      S => clear
    );
spi_cs_meta_reg: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => '1',
      D => spi_cs_n,
      Q => spi_cs_meta,
      S => clear
    );
spi_cs_sync_reg: unisim.vcomponents.FDSE
     port map (
      C => clk,
      CE => '1',
      D => spi_cs_meta,
      Q => spi_cs_sync,
      S => clear
    );
spi_miso_meta_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => spi_miso,
      Q => spi_miso_meta,
      R => clear
    );
spi_miso_sync_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => spi_miso_meta,
      Q => spi_miso_sync,
      R => clear
    );
spi_mosi_meta_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => spi_mosi,
      Q => spi_mosi_meta,
      R => clear
    );
spi_mosi_sync_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => spi_mosi_meta,
      Q => spi_mosi_sync,
      R => clear
    );
spi_sclk_d_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => spi_sclk_sync,
      Q => spi_sclk_d,
      R => clear
    );
spi_sclk_meta_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => spi_sclk,
      Q => spi_sclk_meta,
      R => clear
    );
spi_sclk_sync_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => spi_sclk_meta,
      Q => spi_sclk_sync,
      R => clear
    );
\transaction_id[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => spi_cs_d,
      I1 => spi_cs_sync,
      O => cs_falling
    );
\transaction_id[3]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^transaction_id\(0),
      O => \transaction_id[3]_i_2_n_0\
    );
\transaction_id_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[3]_i_1_n_7\,
      Q => \^transaction_id\(0),
      R => clear
    );
\transaction_id_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[11]_i_1_n_5\,
      Q => \^transaction_id\(10),
      R => clear
    );
\transaction_id_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[11]_i_1_n_4\,
      Q => \^transaction_id\(11),
      R => clear
    );
\transaction_id_reg[11]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \transaction_id_reg[7]_i_1_n_0\,
      CO(3) => \transaction_id_reg[11]_i_1_n_0\,
      CO(2) => \transaction_id_reg[11]_i_1_n_1\,
      CO(1) => \transaction_id_reg[11]_i_1_n_2\,
      CO(0) => \transaction_id_reg[11]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \transaction_id_reg[11]_i_1_n_4\,
      O(2) => \transaction_id_reg[11]_i_1_n_5\,
      O(1) => \transaction_id_reg[11]_i_1_n_6\,
      O(0) => \transaction_id_reg[11]_i_1_n_7\,
      S(3 downto 0) => \^transaction_id\(11 downto 8)
    );
\transaction_id_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[15]_i_1_n_7\,
      Q => \^transaction_id\(12),
      R => clear
    );
\transaction_id_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[15]_i_1_n_6\,
      Q => \^transaction_id\(13),
      R => clear
    );
\transaction_id_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[15]_i_1_n_5\,
      Q => \^transaction_id\(14),
      R => clear
    );
\transaction_id_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[15]_i_1_n_4\,
      Q => \^transaction_id\(15),
      R => clear
    );
\transaction_id_reg[15]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \transaction_id_reg[11]_i_1_n_0\,
      CO(3) => \transaction_id_reg[15]_i_1_n_0\,
      CO(2) => \transaction_id_reg[15]_i_1_n_1\,
      CO(1) => \transaction_id_reg[15]_i_1_n_2\,
      CO(0) => \transaction_id_reg[15]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \transaction_id_reg[15]_i_1_n_4\,
      O(2) => \transaction_id_reg[15]_i_1_n_5\,
      O(1) => \transaction_id_reg[15]_i_1_n_6\,
      O(0) => \transaction_id_reg[15]_i_1_n_7\,
      S(3 downto 0) => \^transaction_id\(15 downto 12)
    );
\transaction_id_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[19]_i_1_n_7\,
      Q => \^transaction_id\(16),
      R => clear
    );
\transaction_id_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[19]_i_1_n_6\,
      Q => \^transaction_id\(17),
      R => clear
    );
\transaction_id_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[19]_i_1_n_5\,
      Q => \^transaction_id\(18),
      R => clear
    );
\transaction_id_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[19]_i_1_n_4\,
      Q => \^transaction_id\(19),
      R => clear
    );
\transaction_id_reg[19]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \transaction_id_reg[15]_i_1_n_0\,
      CO(3) => \transaction_id_reg[19]_i_1_n_0\,
      CO(2) => \transaction_id_reg[19]_i_1_n_1\,
      CO(1) => \transaction_id_reg[19]_i_1_n_2\,
      CO(0) => \transaction_id_reg[19]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \transaction_id_reg[19]_i_1_n_4\,
      O(2) => \transaction_id_reg[19]_i_1_n_5\,
      O(1) => \transaction_id_reg[19]_i_1_n_6\,
      O(0) => \transaction_id_reg[19]_i_1_n_7\,
      S(3 downto 0) => \^transaction_id\(19 downto 16)
    );
\transaction_id_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[3]_i_1_n_6\,
      Q => \^transaction_id\(1),
      R => clear
    );
\transaction_id_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[23]_i_2_n_7\,
      Q => \^transaction_id\(20),
      R => clear
    );
\transaction_id_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[23]_i_2_n_6\,
      Q => \^transaction_id\(21),
      R => clear
    );
\transaction_id_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[23]_i_2_n_5\,
      Q => \^transaction_id\(22),
      R => clear
    );
\transaction_id_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[23]_i_2_n_4\,
      Q => \^transaction_id\(23),
      R => clear
    );
\transaction_id_reg[23]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \transaction_id_reg[19]_i_1_n_0\,
      CO(3) => \NLW_transaction_id_reg[23]_i_2_CO_UNCONNECTED\(3),
      CO(2) => \transaction_id_reg[23]_i_2_n_1\,
      CO(1) => \transaction_id_reg[23]_i_2_n_2\,
      CO(0) => \transaction_id_reg[23]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \transaction_id_reg[23]_i_2_n_4\,
      O(2) => \transaction_id_reg[23]_i_2_n_5\,
      O(1) => \transaction_id_reg[23]_i_2_n_6\,
      O(0) => \transaction_id_reg[23]_i_2_n_7\,
      S(3 downto 0) => \^transaction_id\(23 downto 20)
    );
\transaction_id_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[3]_i_1_n_5\,
      Q => \^transaction_id\(2),
      R => clear
    );
\transaction_id_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[3]_i_1_n_4\,
      Q => \^transaction_id\(3),
      R => clear
    );
\transaction_id_reg[3]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \transaction_id_reg[3]_i_1_n_0\,
      CO(2) => \transaction_id_reg[3]_i_1_n_1\,
      CO(1) => \transaction_id_reg[3]_i_1_n_2\,
      CO(0) => \transaction_id_reg[3]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \transaction_id_reg[3]_i_1_n_4\,
      O(2) => \transaction_id_reg[3]_i_1_n_5\,
      O(1) => \transaction_id_reg[3]_i_1_n_6\,
      O(0) => \transaction_id_reg[3]_i_1_n_7\,
      S(3 downto 1) => \^transaction_id\(3 downto 1),
      S(0) => \transaction_id[3]_i_2_n_0\
    );
\transaction_id_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[7]_i_1_n_7\,
      Q => \^transaction_id\(4),
      R => clear
    );
\transaction_id_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[7]_i_1_n_6\,
      Q => \^transaction_id\(5),
      R => clear
    );
\transaction_id_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[7]_i_1_n_5\,
      Q => \^transaction_id\(6),
      R => clear
    );
\transaction_id_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[7]_i_1_n_4\,
      Q => \^transaction_id\(7),
      R => clear
    );
\transaction_id_reg[7]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \transaction_id_reg[3]_i_1_n_0\,
      CO(3) => \transaction_id_reg[7]_i_1_n_0\,
      CO(2) => \transaction_id_reg[7]_i_1_n_1\,
      CO(1) => \transaction_id_reg[7]_i_1_n_2\,
      CO(0) => \transaction_id_reg[7]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \transaction_id_reg[7]_i_1_n_4\,
      O(2) => \transaction_id_reg[7]_i_1_n_5\,
      O(1) => \transaction_id_reg[7]_i_1_n_6\,
      O(0) => \transaction_id_reg[7]_i_1_n_7\,
      S(3 downto 0) => \^transaction_id\(7 downto 4)
    );
\transaction_id_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[11]_i_1_n_7\,
      Q => \^transaction_id\(8),
      R => clear
    );
\transaction_id_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => cs_falling,
      D => \transaction_id_reg[11]_i_1_n_6\,
      Q => \^transaction_id\(9),
      R => clear
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor_bd is
  port (
    monitor_active_reg : out STD_LOGIC;
    evt_data : out STD_LOGIC_VECTOR ( 108 downto 0 );
    transaction_id : out STD_LOGIC_VECTOR ( 23 downto 0 );
    dropped_event_count : out STD_LOGIC_VECTOR ( 31 downto 0 );
    evt_valid_reg : out STD_LOGIC;
    evt_trigger : out STD_LOGIC;
    rst_n : in STD_LOGIC;
    spi_cs_n : in STD_LOGIC;
    clk : in STD_LOGIC;
    spi_sclk : in STD_LOGIC;
    spi_mosi : in STD_LOGIC;
    spi_miso : in STD_LOGIC;
    timestamp : in STD_LOGIC_VECTOR ( 63 downto 0 );
    evt_ready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor_bd : entity is "spi_mode0_monitor_bd";
end multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor_bd;

architecture STRUCTURE of multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor_bd is
begin
implementation: entity work.multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor
     port map (
      clk => clk,
      dropped_event_count(31 downto 0) => dropped_event_count(31 downto 0),
      evt_data(108 downto 0) => evt_data(108 downto 0),
      evt_ready => evt_ready,
      evt_trigger => evt_trigger,
      evt_valid_reg_0 => evt_valid_reg,
      monitor_active_reg_0 => monitor_active_reg,
      rst_n => rst_n,
      spi_cs_n => spi_cs_n,
      spi_miso => spi_miso,
      spi_mosi => spi_mosi,
      spi_sclk => spi_sclk,
      timestamp(63 downto 0) => timestamp(63 downto 0),
      transaction_id(23 downto 0) => transaction_id(23 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity multi_protocol_bd_spi_mode0_monitor_0_0 is
  port (
    clk : in STD_LOGIC;
    rst_n : in STD_LOGIC;
    timestamp : in STD_LOGIC_VECTOR ( 63 downto 0 );
    spi_sclk : in STD_LOGIC;
    spi_cs_n : in STD_LOGIC;
    spi_mosi : in STD_LOGIC;
    spi_miso : in STD_LOGIC;
    evt_valid : out STD_LOGIC;
    evt_ready : in STD_LOGIC;
    evt_trigger : out STD_LOGIC;
    evt_data : out STD_LOGIC_VECTOR ( 127 downto 0 );
    monitor_active : out STD_LOGIC;
    transaction_id : out STD_LOGIC_VECTOR ( 23 downto 0 );
    dropped_event_count : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of multi_protocol_bd_spi_mode0_monitor_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of multi_protocol_bd_spi_mode0_monitor_0_0 : entity is "multi_protocol_bd_spi_mode0_monitor_0_0,spi_mode0_monitor_bd,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of multi_protocol_bd_spi_mode0_monitor_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of multi_protocol_bd_spi_mode0_monitor_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of multi_protocol_bd_spi_mode0_monitor_0_0 : entity is "spi_mode0_monitor_bd,Vivado 2018.3";
end multi_protocol_bd_spi_mode0_monitor_0_0;

architecture STRUCTURE of multi_protocol_bd_spi_mode0_monitor_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^evt_data\ : STD_LOGIC_VECTOR ( 127 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN multi_protocol_bd_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst_n : signal is "xilinx.com:signal:reset:1.0 rst_n RST";
  attribute X_INTERFACE_PARAMETER of rst_n : signal is "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
  evt_data(127 downto 64) <= \^evt_data\(127 downto 64);
  evt_data(63) <= \<const0>\;
  evt_data(62) <= \<const0>\;
  evt_data(61) <= \^evt_data\(55);
  evt_data(60) <= \<const0>\;
  evt_data(59) <= \<const0>\;
  evt_data(58) <= \<const0>\;
  evt_data(57) <= \<const0>\;
  evt_data(56) <= \<const0>\;
  evt_data(55) <= \^evt_data\(55);
  evt_data(54) <= \^evt_data\(55);
  evt_data(53) <= \^evt_data\(52);
  evt_data(52) <= \^evt_data\(52);
  evt_data(51) <= \^evt_data\(52);
  evt_data(50) <= \^evt_data\(52);
  evt_data(49 downto 32) <= \^evt_data\(49 downto 32);
  evt_data(31) <= \<const0>\;
  evt_data(30) <= \<const0>\;
  evt_data(29) <= \<const0>\;
  evt_data(28) <= \<const0>\;
  evt_data(27) <= \<const0>\;
  evt_data(26) <= \<const0>\;
  evt_data(25) <= \^evt_data\(25);
  evt_data(24) <= \<const0>\;
  evt_data(23 downto 0) <= \^evt_data\(23 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.multi_protocol_bd_spi_mode0_monitor_0_0_spi_mode0_monitor_bd
     port map (
      clk => clk,
      dropped_event_count(31 downto 0) => dropped_event_count(31 downto 0),
      evt_data(108 downto 45) => \^evt_data\(127 downto 64),
      evt_data(44) => \^evt_data\(55),
      evt_data(43) => \^evt_data\(52),
      evt_data(42 downto 25) => \^evt_data\(49 downto 32),
      evt_data(24) => \^evt_data\(25),
      evt_data(23 downto 0) => \^evt_data\(23 downto 0),
      evt_ready => evt_ready,
      evt_trigger => evt_trigger,
      evt_valid_reg => evt_valid,
      monitor_active_reg => monitor_active,
      rst_n => rst_n,
      spi_cs_n => spi_cs_n,
      spi_miso => spi_miso,
      spi_mosi => spi_mosi,
      spi_sclk => spi_sclk,
      timestamp(63 downto 0) => timestamp(63 downto 0),
      transaction_id(23 downto 0) => transaction_id(23 downto 0)
    );
end STRUCTURE;
