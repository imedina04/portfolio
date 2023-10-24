`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2023 10:34:46 AM
// Design Name: 
// Module Name: tb_module_top
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


module tb_module_top(
    );
    
    logic [15:0] s_pi;
    logic [3:0]  en_pi;
    logic [15:0] leds_po;
    
    module_top top ( .s_pi(s_pi), .en_pi(en_pi), .leds_po(leds_po));

    initial begin
        s_pi = 16'b0001001000110100; en_pi = 4'b1000;
        #10
        
        en_pi = 4'b0100;
        #10
        
        en_pi = 4'b0010;
        #10
        
        en_pi = 4'b0001;
        #10
        
        s_pi = 16'b0010001100100001; en_pi = 4'b0001;
        #10
        
        s_pi = 16'b0010001100100001; en_pi = 4'b0011;
        #10
        
        s_pi = 16'b0010001100100001; en_pi = 4'b0111;
        #10
        
        s_pi = 16'b0010001100100001; en_pi = 4'b1111;
        #10
        
        s_pi = 16'b0010001100100001; en_pi = 4'b0000;
        #10
        
        
        $finish;
    end

endmodule
