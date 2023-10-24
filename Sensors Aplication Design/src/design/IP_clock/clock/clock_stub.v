// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Tue Apr 25 19:40:08 2023
// Host        : LAPTOP-33U5NA2A running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/Usuario/Documents/Lab3/lab3-g2/src/design/IP_clock/clock/clock_stub.v
// Design      : clock
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clock(clk_o, reset, locked, clk_i)
/* synthesis syn_black_box black_box_pad_pin="clk_o,reset,locked,clk_i" */;
  output clk_o;
  input reset;
  output locked;
  input clk_i;
endmodule
