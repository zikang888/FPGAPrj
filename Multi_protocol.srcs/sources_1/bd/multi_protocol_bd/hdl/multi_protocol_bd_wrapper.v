//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Thu Sep 24 16:18:08 2026
//Host        : LAPTOP-MK9F4NL5 running 64-bit major release  (build 9200)
//Command     : generate_target multi_protocol_bd_wrapper.bd
//Design      : multi_protocol_bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module multi_protocol_bd_wrapper
   (LCD_BL,
    LCD_DATA,
    LCD_DE,
    LCD_HS,
    LCD_PCLK,
    LCD_VS,
    led_heartbeat,
    led_ps_active,
    touch_int_tri_io);
  output [0:0]LCD_BL;
  output [15:0]LCD_DATA;
  output LCD_DE;
  output LCD_HS;
  output LCD_PCLK;
  output LCD_VS;
  output led_heartbeat;
  output led_ps_active;
  inout [0:0]touch_int_tri_io;

  wire [0:0]LCD_BL;
  wire [15:0]LCD_DATA;
  wire LCD_DE;
  wire LCD_HS;
  wire LCD_PCLK;
  wire LCD_VS;
  wire led_heartbeat;
  wire led_ps_active;
  wire [0:0]touch_int_tri_i_0;
  wire [0:0]touch_int_tri_io_0;
  wire [0:0]touch_int_tri_o_0;
  wire [0:0]touch_int_tri_t_0;

  multi_protocol_bd multi_protocol_bd_i
       (.LCD_BL(LCD_BL),
        .LCD_DATA(LCD_DATA),
        .LCD_DE(LCD_DE),
        .LCD_HS(LCD_HS),
        .LCD_PCLK(LCD_PCLK),
        .LCD_VS(LCD_VS),
        .led_heartbeat(led_heartbeat),
        .led_ps_active(led_ps_active),
        .touch_int_tri_i(touch_int_tri_i_0),
        .touch_int_tri_o(touch_int_tri_o_0),
        .touch_int_tri_t(touch_int_tri_t_0));
  IOBUF touch_int_tri_iobuf_0
       (.I(touch_int_tri_o_0),
        .IO(touch_int_tri_io[0]),
        .O(touch_int_tri_i_0),
        .T(touch_int_tri_t_0));
endmodule
