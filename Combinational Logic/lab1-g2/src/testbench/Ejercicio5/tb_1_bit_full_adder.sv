`timescale 1ns/1ps

module tb_one_bit_full_adder;

    logic a_i, b_i, ci_i;                         //Variables de estimulo
    
    logic sum_o, co_o;                          //Salidas del modulo
    
    logic [2:0] i = 3'd0;                   //Contador para las interaciones
    
one_bit_full_adder_sv adder_1 (.a_i(a_i), .b_i(b_i), .ci_i(ci_i), .sum_o(sum_o), .co_o(co_o));

initial begin

    a_i  = 1'b0;
    b_i  = 1'b0;
    ci_i = 1'b0;
    
    #20;  
    
   for(i = 1; i < 8; i = i + 1'b1)begin //Hace un loop variando las entradas

   {a_i,b_i,ci_i} = {a_i,b_i,ci_i} + 1'b1;

   #20;

  end

 end  

endmodule




