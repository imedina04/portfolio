`timescale 1ns/1ps

module tb_one_bit_full_adder_cla;

// Entradas de estimulo

    logic a_i;
    logic b_i;
    logic ci_i;
    
// Contador para un ciclo de prueba
    
    logic [2:0] i = 3'd0;

// Salidas de estimulo    
    
    logic sum_o;
    logic p_o;
    logic g_o;
    
    one_bit_full_adder_cla one_bit_full_adder_prueba (
    
        .a_i(a_i),
        .b_i(b_i),
        .ci_i(ci_i),
        .sum_o(sum_o),
        .p_o(p_o),
        .g_o(g_o)
    
    );
    
    initial begin
    
        #10 $display ("a, b, c, s, p, g");
        a_i =1'b0;
        b_i =1'b0;
        ci_i =1'b0;
        #20
    
        for(i = 1; i < 8; i = i + 1'b1)begin //Hace un loop variando las entradas

            #10 $display ("%b, %b, %b, %b, %b, %b", a_i, b_i, ci_i, sum_o, p_o, g_o);
            {a_i,b_i,ci_i} = {a_i,b_i,ci_i} + 1'b1;
            #20;
               
        end
    
    end

endmodule