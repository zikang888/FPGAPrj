-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Thu Sep 24 16:19:27 2026
-- Host        : LAPTOP-MK9F4NL5 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/Vivado/Project/Multi_protocol/Multi_protocol.srcs/sources_1/bd/multi_protocol_bd/ip/multi_protocol_bd_rgb888torgb565_0_0/multi_protocol_bd_rgb888torgb565_0_0_stub.vhdl
-- Design      : multi_protocol_bd_rgb888torgb565_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multi_protocol_bd_rgb888torgb565_0_0 is
  Port ( 
    rgb888_data : in STD_LOGIC_VECTOR ( 23 downto 0 );
    rgb565_data : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );

end multi_protocol_bd_rgb888torgb565_0_0;

architecture stub of multi_protocol_bd_rgb888torgb565_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "rgb888_data[23:0],rgb565_data[15:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "rgb888torgb565,Vivado 2018.3";
begin
end;
