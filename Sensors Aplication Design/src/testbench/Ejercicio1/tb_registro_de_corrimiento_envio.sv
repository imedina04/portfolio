`timescale 10ns/1ps
module tb_registro_de_corrimiento_envio ();


    //Variables de estimulo
    
    logic clck_i;
    logic sclck_i;
    logic enable_i;
    logic [31 :0] datos_envio_i;
    logic verificacion;

    //Variable de salida

    logic bit_enviado_o;

    initial 
        begin
        
            clck_i = 0;
            forever #5 clck_i = ~clck_i;

        end

    registro_de_corrimiento_envio envio (

        .clck_i(clck_i),
        .sclck_i(sclck_i),
        .enable_i(enable_i),
        .datos_envio_i(datos_envio_i),
        .bit_enviado_o(bit_enviado_o)

    );

    initial
        begin
            
            datos_envio_i = 32'b11110000111100001111000010101010;
            #5;
            
            enable_i = 1;
            
            #5;
            enable_i = 0;
            #5;
            
            sclck_i=0;
            
            repeat(16)
                begin 
                    
                    #25; 
                    sclck_i = ~sclck_i;
                   
                end
            sclck_i = 0;   
            #15;    
    
            $finish;

        end

    initial
        
        begin
        verificacion = 1;
            
            repeat (8)
                begin
                
                @(posedge sclck_i)
                
                verificacion =  ~verificacion;
                 
                @(negedge sclck_i)  
                
                if(verificacion == bit_enviado_o)
                    
                    $display("Bien");
                
                else
                    
                    $display("Error");   
                    
                end
        end

endmodule