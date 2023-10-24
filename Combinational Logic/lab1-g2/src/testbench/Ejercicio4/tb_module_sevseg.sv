`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2023 08:19:55 PM
// Design Name: 
// Module Name: tb_module_sevseg
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


module tb_module_sevseg(
    );
    
    logic  [15:0] s_i;
    logic  [1:0]  b_i;
    logic  [6:0]  s_o;
    logic  [7:0]  en;
    
    top_segsev tss ( .s_i(s_i), .b_i(b_i), .s_o(s_o), .en(en));

    initial begin
        s_i = 16'h12AF; b_i = 0;
        #10
        
        s_i = 16'h12AF; b_i = 1;
        #10
        
        s_i = 16'h12AF; b_i = 2;
        #10
        
        s_i = 16'h12AF; b_i = 3;
        #10
        
        
        $finish;
    end
    
endmodule
