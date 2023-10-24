`timescale 10ns/1ps 

module tb_key_encoding ();

    logic [1:0] fila_i;
    logic [1:0] columna_i;
    
    logic [3:0] num_o;
    
    key_encoding key_encoding (.columna1_i(columna_i[1]),.columna0_i(columna_i[0]), 
                               .fila1_i(fila_i[1]), .fila0_i(fila_i[0]), 
                               .num_o(num_o));

    initial 
        begin
    
            
            columna_i = 2'b00;
            fila_i = 2'b00;
            #1;
            
            repeat(3) 
                
                begin
            
                    fila_i = fila_i + 1;
                    #1;
                end
                
            columna_i = 2'b01;
            fila_i = 2'b00;
            #1;
            
            repeat(3) 
                
                begin
            
                    fila_i = fila_i + 1;
                    #1;
                end
                
            columna_i = 2'b10;
            fila_i = 2'b00;
            #1;
            
            repeat(3) 
                
                begin
            
                    fila_i = fila_i + 1;
                    #1;
                end
                
            columna_i = 2'b11;
            fila_i = 2'b00;
            #1;
            
            repeat(3) 
                
                begin
            
                    fila_i = fila_i + 1;
                    #1;
                end
        end
        

endmodule