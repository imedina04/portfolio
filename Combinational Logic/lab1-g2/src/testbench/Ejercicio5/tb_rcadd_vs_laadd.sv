`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2023 07:21:49 PM
// Design Name: 
// Module Name: tb_rcadd_vs_laadd
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


module tb_rcadd_vs_laadd(

    );
    
    //Entradas del carry lookahead adder
    logic [7:0] a_i;
    logic [7:0] b_i;
    logic       ci_i;
    
    //Entradas del carry lookahead adder
    logic [7:0] cla_sum_o;
    logic [8:0] cla_co_o;
   
   

    //Salidas del ripple carry adder
    logic [7:0] rca_sum_o;
    logic [8:0] rca_co_o;
    
    //Llamado de funciones 
    top_sumadores suma (
        .a_i        (a_i),
        .b_i        (b_i),
        .ci_i       (ci_i), 
        
        .rca_sum_o  (rca_sum_o),
        .rca_co_o   (rca_co_o),
        
        .cla_sum_o  (cla_sum_o),
        .cla_co_o   (cla_co_o)
    );
    
    
    initial begin
    
        a_i = 8'b11111111;
        b_i = 8'b00000000;
        ci_i= 1'b0;
        
        #100
        
        a_i = 8'b11111111;
        b_i = 8'b00000000;
        ci_i= 1'b1;

        #100
        
        $finish;
        
    end 
    
    
    
    
endmodule
