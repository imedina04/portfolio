`timescale 10ns/1ps 

module tb_ripple_carry_adder;
    
    localparam ANCHO_DE_PRUEBA = 64;                         //Ancho de la prueba
    
    
    // Variables de estimulo 
    
    logic [ANCHO_DE_PRUEBA - 1 : 0] a_i, b_i;
    logic ci_i;
    
    //Salidas de estimulo
    
    logic [ANCHO_DE_PRUEBA - 1 : 0] sum_o;
    logic [ANCHO_DE_PRUEBA : 0]     co_o;
    
    ripple_carry_adder #(.ANCHO(ANCHO_DE_PRUEBA)) sumador_prueba (.a_i(a_i), .b_i(b_i), .ci_i(ci_i), .sum_o(sum_o), .co_o(co_o));
    
    int i = 0;
    
    initial begin
        
        repeat(100000000)begin //Hace 100 M- pruebas/s
         
        a_i  =  $random;
        b_i  =  $random;
        ci_i =  $random;
        i= i+1;    
        #1;
        
        end
    end
     
endmodule
