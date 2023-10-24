`timescale 1ns/1ps

module tb_carry_lookahead_adder;

    logic [7:0] a_i;
    logic [7:0] b_i;
    logic ci_i;
    
    logic [7:0] sum_o;
    logic [7:0] co_o;
    int i;
    
    carry_lookahead_adder sumador_prueba(
    
        .a_i(a_i),
        .b_i(b_i),
        .ci_i(ci_i),
        .sum_o(sum_o),
        .co_o(co_o)
    
    );
    
    initial begin 
    
        repeat(10)begin 
             
            a_i  =  $random;
            b_i  =  $random;
            ci_i =  $random;
            i= i+1;   
   
           #10;
            
        end
    end

endmodule