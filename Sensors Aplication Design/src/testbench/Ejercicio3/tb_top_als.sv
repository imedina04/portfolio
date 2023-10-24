`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 08:24:27 PM
// Design Name: 
// Module Name: tb_top_als
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

module tb_top_als(
    );
    
    logic clk_i;
    logic rst_i = 0;
    logic miso_i = 1;
        
    logic sclk_o = 0;
    logic cs_o;
    logic mosi_o;
    //logic [ 15 : 0] data_bcd_o;
    logic tx_o;
    logic [3:0]     en_o;
    logic [6:0]     seg_o;
    
    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;
    end 
    
    
    top_als als (
        .clck_i     (clk_i),
        .rst_i      (rst_i),
        .miso_i     (miso_i),
        
        .sclk_o     (sclk_o),
        .cs_o       (cs_o),
        .mosi_o     (mosi_o),
        .tx_o        (tx_o),
        .en_o        (en_o),
        .seg_o       (seg_o)
    );
    
    
    
    initial begin
        
        
        @(posedge clk_i);
        @(posedge clk_i);
        #200000;
    end 
    
    
endmodule
