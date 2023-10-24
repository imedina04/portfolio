timescale 10ns / 1ps

module tb_registro_de_corrimiento_receptor ();

    logic           sclck_i;
    logic           miso_i;
    logic [31 : 0]  dato_guardado_o;


    registro_de_corrimiento_receptor receptor (
        
        .sclck_i(sclck_i),
        .miso_i(miso_i),
        .dato_guardado_o(dato_guardado_o)

    );

    initial begin
        
      
        
        sclck_i = 0;
        
        #5;

        repeat(16)
                begin 
                    
                    #25; 
                    sclck_i = ~sclck_i;
                   
                end

            sclck_i = 0;       
            #100;
            
            repeat(16)
                begin 
                    
                    #25; 
                    sclck_i = ~sclck_i;
                   
                end
            
    end

    initial
        begin
            
            @(posedge sclck_i)
            miso_i = 1;

            @(posedge sclck_i)
            miso_i = 0;

            @(posedge sclck_i)
            miso_i = 1;

            @(posedge sclck_i)
            miso_i = 0;

            @(posedge sclck_i)
            miso_i = 1;

            @(posedge sclck_i)
            miso_i = 0;

            @(posedge sclck_i)
            miso_i = 1;

            @(posedge sclck_i)
            miso_i = 0;
            
            @(negedge sclck_i)
            #5;
            
            if (dato_guardado_o == 31'b00000000000000000000000010101010)
                
                $display("Correcto");
            
            else
                
                $display("Error");
                
            
            @(posedge sclck_i)
            miso_i = 0;

            @(posedge sclck_i)
            miso_i = 1;

            @(posedge sclck_i)
            miso_i = 0;

            @(posedge sclck_i)
            miso_i = 1;

            @(posedge sclck_i)
            miso_i = 0;

            @(posedge sclck_i)
            miso_i = 1;

            @(posedge sclck_i)
            miso_i = 0;

            @(posedge sclck_i)
            miso_i = 1;
            
            @(negedge sclck_i)
            #5;
            
            if (dato_guardado_o == 31'b00000000000000000000000001010101)
                
                $display("Correcto");
            
            else
                
                $display("Error");

            
            
            
            
        end

endmodule