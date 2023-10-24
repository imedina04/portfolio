`timescale 10ns/1ps

module tb_clock_divider();

    logic clk_i;
    logic clk_divided_o;
    logic rst;
    
    initial begin
    
            clk_i = 0;
            forever #5 clk_i = !clk_i;
    
    end
    
    clock_divider clock_diver (
    
    .clck_i(clk_i), 
    .rst_i(rst),
    .clck_divided_o(clk_divided_o));
    
    initial begin
        
        rst= 0;
        #10
        rst = 1;
        
    end
 
    
 
endmodule
 

