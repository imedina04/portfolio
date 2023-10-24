`timescale 10ns/1ps

module tb_d_flip_flop ();


    logic clk;
    logic d;
    logic q;
    
    initial
         begin
    
            clk = 0;
            forever #5 clk = !clk;
    
        end
        
        d_flip_flop d_flip_flop (
        
            .enable_i(clk),
            .d_i(d),
            .q_o(q)
        );
        
        initial
            begin
            
                d = 0;
                #5;
                d = 1;
                #5;
                d = 0;
                #5;
                d = 1;
                #1;

                #5;
                d = 1;
                #5;
                d = 0;
                #10;
                
                d = 0;
                #5
                d = 1;
                #5;

            end
        
endmodule