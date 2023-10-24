`timescale 10ns/1ps

module tb_interfaz ();

    logic clk_i;
    logic locked;
    logic [1 : 0] salidas_contador;
    logic [3 : 0] filas_i;
    logic [1 : 0] filas_codificadas_i;  
    logic [3 : 0] numero_o;
    logic led_o;

    initial
        begin
        
            clk_i = 0;
            forever #5 clk_i = ~clk_i;
        
        end
    
   top_interfaz interfaz (
   
        .clck_i(clk_i),
        .locked(locked),
        .filas_i(filas_i),
        .filas_codificadas_i(filas_codificadas_i),
        .salidas_contador_o(salidas_contador),
        .numero_o(numero_o),
        .led_o(led_o)  
   );

    initial
    
        begin
        
        locked = 0;
        
        #200
        
        locked = 1;
        
        filas_i = 4'b1111;
        filas_codificadas_i = 2'b00;
        
        #1000000;
        
        filas_i = 4'b0111;
        filas_codificadas_i = 2'b11;
        
        #1000000;
        
        filas_i = 4'b1111;
        filas_codificadas_i = 2'b00;
        if (numero_o != 4'b0010)
            $display("Erorr");
            
        #1000000;
        
        filas_i = 4'b1011;
        filas_codificadas_i = 2'b10;
        
          #1000000;
        
        filas_i = 4'b1111;
        filas_codificadas_i = 2'b00;
        if (numero_o != 4'b1011)
            $display("Erorr");
        
        #1000000;
        
        filas_i = 4'b1101;
        filas_codificadas_i = 2'b10;
        
          #1000000;
        
        filas_i = 4'b1111;
        filas_codificadas_i = 2'b00;
        if (numero_o != 4'b0101)
            $display("Erorr");
        
        #1000000;
        
        filas_i = 4'b1110;
        filas_codificadas_i = 2'b11;
        #1000000;
        if (numero_o != 4'b0001)
            $display("Erorr");
        
        #1000000;
        $finish;
        end
      

endmodule