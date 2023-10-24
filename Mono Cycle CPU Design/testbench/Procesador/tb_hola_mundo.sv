`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2023 11:47:59 AM
// Design Name: 
// Module Name: tb_hola_mundo
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


module tb_hola_mundo();

logic        clk_i;
logic        rst_i;
logic [31:0] writedata_o;
logic [31:0] dataadr_o;
logic        memwrite_o;
    
logic        rx;
logic        tx;

initial begin
    clk_i = 0;
    forever #5 clk_i = !clk_i;
end


top t(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
//    .writedata_o    (writedata_o),
//    .dataadr_o      (dataadr_o),
//    .memwrite_o     (memwrite_o),
    
    .rx             (rx),
    
    .tx             (tx)
);


initial begin
    rst_i = 0;
    #10
    $finish;
    
    
end 
endmodule
