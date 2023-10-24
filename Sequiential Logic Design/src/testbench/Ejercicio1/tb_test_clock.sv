`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 11:38:03 AM
// Design Name: 
// Module Name: tb_test_clock
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


module tb_test_clock(
    );
    
    logic       clk, rst;
    logic [7:0] leds1;
    logic [7:0] leds2;
   
    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end 
    
    top_test_clock ttc(
        .clk_pi         (clk), 
        .rst            (rst), 
        .leds1_po       (leds1),
        .leds2_po       (leds2)
    );
    
    logic [3:0] cont;
    always@(posedge clk)begin
        if(rst)
            cont <= 0;
        else 
            if(cont == 10)
                begin
                    cont <= 0;
                    if(leds2 == leds1*10)
                        $display("Funciona");
                end
                
            else 
                cont <= cont + 1;
    end 
            
    initial begin
        #2390
        rst = 1;
        #10
        rst = 0;
        #8600
        if ((leds2+1)/leds1 == 10)
            $display("Si funciona");
        else
            $display("No funciona");

        $finish;
    end
        
endmodule
