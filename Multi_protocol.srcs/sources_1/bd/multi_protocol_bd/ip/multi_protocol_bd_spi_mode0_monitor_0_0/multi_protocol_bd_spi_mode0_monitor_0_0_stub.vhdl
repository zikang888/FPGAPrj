-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sat Sep 26 16:49:59 2026
-- Host        : LAPTOP-MK9F4NL5 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/Vivado/Project/Multi_protocol/Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/ip/multi_protocol_bd_spi_mode0_monitor_0_0/multi_protocol_bd_spi_mode0_monitor_0_0_stub.vhdl
-- Design      : multi_protocol_bd_spi_mode0_monitor_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multi_protocol_bd_spi_mode0_monitor_0_0 is
  Port ( 
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

end multi_protocol_bd_spi_mode0_monitor_0_0;

architecture stub of multi_protocol_bd_spi_mode0_monitor_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst_n,timestamp[63:0],spi_sclk,spi_cs_n,spi_mosi,spi_miso,evt_valid,evt_ready,evt_trigger,evt_data[127:0],monitor_active,transaction_id[23:0],dropped_event_count[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "spi_mode0_monitor_bd,Vivado 2018.3";
begin
end;
