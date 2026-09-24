-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Thu Sep 24 16:19:27 2026
-- Host        : LAPTOP-MK9F4NL5 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ multi_protocol_bd_rgb888torgb565_0_0_sim_netlist.vhdl
-- Design      : multi_protocol_bd_rgb888torgb565_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    rgb888_data : in STD_LOGIC_VECTOR ( 23 downto 0 );
    rgb565_data : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "multi_protocol_bd_rgb888torgb565_0_0,rgb888torgb565,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "rgb888torgb565,Vivado 2018.3";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \^rgb888_data\ : STD_LOGIC_VECTOR ( 23 downto 0 );
begin
  \^rgb888_data\(23 downto 19) <= rgb888_data(23 downto 19);
  \^rgb888_data\(15 downto 10) <= rgb888_data(15 downto 10);
  \^rgb888_data\(7 downto 3) <= rgb888_data(7 downto 3);
  rgb565_data(15 downto 11) <= \^rgb888_data\(23 downto 19);
  rgb565_data(10 downto 5) <= \^rgb888_data\(15 downto 10);
  rgb565_data(4 downto 0) <= \^rgb888_data\(7 downto 3);
end STRUCTURE;
