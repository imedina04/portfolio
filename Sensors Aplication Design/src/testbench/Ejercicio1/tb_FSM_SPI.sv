`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2023 03:26:13 PM
// Design Name: 
// Module Name: tb_FSM_SPI
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_FSM_SPI(
    );
   
    logic          clck_i;
    logic          rst_i;
    logic [31 : 0] reg_i;
    //logic          miso_i;
    
    logic          ss_o;
    logic          mosi_o;
    logic          sclk_o;
    logic          wr1_o;
    logic [31 : 0] in1_o;
    logic          wr2_o;
    logic [4 : 0] addr2_o;
    logic          hold_ctrl_o;
    logic [31 : 0] in2_o;
    
    typedef struct packed {
        logic [5:0] na1;
        logic [9:0] n_rx_en;
        logic [2:0] na2;
        logic [8:0] n_tx_end;
        logic       all_0s;
        logic       all_1s;
        logic       cs_ctrl;
        logic       send;
    } instruccion;
    
    instruccion inst_i;
    
    initial begin
        clck_i = 0;
        forever #5 clck_i = !clck_i;
    end
    
    top_fsm_spi spi
    (
    .clck_i         (clck_i),
    .rst_i          (rst_i),
    .inst_i         (inst_i),
    .reg_i          (reg_i),
    .miso_i         (mosi_o),
    
    .ss_o           (ss_o),
    .mosi_o         (mosi_o),
    .sclk_o         (sclk_o),
    .wr1_o          (wr1_o),
    .in1_o          (in1_o),
    .wr2_o          (wr2_o),
    .addr2_o        (addr2_o),
    .hold_ctrl_o    (hold_ctrl_o),
    .in2_o          (in2_o)
    );
    
    initial begin
    reg_i = 32'h000000af;
    rst_i = 0;
    #10
    
    rst_i = 1;
    #10
    
    rst_i = 0;
    #10
    
    inst_i.na1      = 0;
    inst_i.n_rx_en  = 0;
    inst_i.na2      = 0;
    inst_i.n_tx_end = 1;
    inst_i.all_0s   = 0;
    inst_i.all_1s   = 0;
    inst_i.cs_ctrl  = 0;
    inst_i.send     = 0;
    #10
    
    inst_i.na1      = 0;
    inst_i.n_rx_en  = 0;
    inst_i.na2      = 0;
    inst_i.n_tx_end = 1;
    inst_i.all_0s   = 0;
    inst_i.all_1s   = 0;
    inst_i.cs_ctrl  = 1;
    inst_i.send     = 1;
    #10
    
    #5000
    $finish;
    end
    
endmodule
