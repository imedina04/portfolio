`timescale 10ns/1ps

module tb_key_deteccion();


    logic [3 : 0] filas_i;
    logic         clck_i;
    logic         locked;
    logic         deteccion;
    
    initial
        begin
        clck_i = 0;
        forever #5 clck_i = ~clck_i;
        
        end

    key_deteccion detector (
    
       .filas_i(filas_i),
       .clck_i(clck_i),
       .locked(locked),
       .deteccion_o(deteccion) 
   
   );

   initial
    begin
    
    filas_i = 4'b1111;
    locked = 0;
    
    #1000000
    
    filas_i = 4'b1111;
    locked = 1;
    
    #20
    
    filas_i = 4'b1110;
    locked = 1;
    
    #1000000
    
    filas_i = 4'b1111;
    locked = 1;
   
    #1000000
    
    filas_i = 4'b0110;
    locked = 1; 
    #1000000
    
    $finish;
    
    end


endmodule
