`timescale 10ns/1ps

module tb_contador_2_bits ();

    logic hold;
    logic enable;
    logic clck;
    logic rst;
    logic [1 : 0] state;
        
    initial begin
    
            clck = 0;
            forever #5 clck = !clck;
    
    end
   
    
    contador_2_bits contador_2_bits (
    
        .clck_i(clck),
        .enable_i(enable),
        .hold_i (hold),
        .rst_i(rst),
        .state_o(state)
    
    );
    
    clock_divider clock_divider (
    
        .clck_i(clck),
        .rst_i(rst),
        .clck_divided_o(enable)
    );
    
    initial
        begin
            
            hold = 0;
            rst  = 0;
            #10;
            
            rst = 1;
            
            #10000000
            
            hold = 1;
            
            #1000000;
            
            
        end
    

endmodule