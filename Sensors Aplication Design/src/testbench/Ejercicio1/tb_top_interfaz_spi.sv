`timescale 10ns/1ps

module tb_top_interfaz();

// Variables de entrada del tiempo 

logic clck_i;
logic rst_i;


// Variables al modulo spi 

logic          wr_2;
logic          wr_i ;
logic          reg_sel_i;
logic [4 : 0]  addr_in_i;
logic [31 : 0] entrada_i;

//Variables de salida del modulo spi

logic [31 : 0] salida_o;
logic          mosi_o;
logic          sclk_o;
logic          cs_o;

initial begin
    
    clck_i = 0;
    forever #5 clck_i = ~clck_i;

end

top_interfaz_spi top_interfaz_spi (
    
    .clck_i     (clck_i),
    .rst_i      (rst_i),
    .wr_i       (wr_i),
    .reg_sel_i  (reg_sel_i),
    .addr_in_i  (addr_in_i),
    .entrada_i  (entrada_i),
    .miso_i     (mosi_o),
    .salida_o   (salida_o),
    .mosi_o     (mosi_o),
    .sclk_o     (sclk_o),
    .cs_o       (cs_o)
    

);

initial
    begin
        
    //Pone las variables de estimulo en su valor inicial 
    
        rst_i       = 1;
        wr_i        = 0;
        reg_sel_i   = 0;
        addr_in_i   = '0;
        entrada_i   = '0;
        
    // Espera 3 ciclos de reloj para quitar el reset
    
        repeat (3)
            begin
                @(posedge clck_i);
            end
            
            
        rst_i = 0; // Desactiva el reset
        
    // Espera otros 3 ciclos de reloj
        
        repeat (3)
            begin
                @(posedge clck_i);
            end
            
    // Pone el valor de la instruccion para enviar solo 1s
    
        entrada_i =  32'h7;
    
    // Espera otros 3 ciclos de reloj
        
        repeat (3)
            begin
                @(posedge clck_i);
            end
            
    // Activa el writeenable
    
        wr_i = 1;
        
    // Espera un ciclo de reloj
    
        @(posedge clck_i) 
        
    // Desactiva el wr_i;
        
        wr_i = 0;
    
    // Espera que se realice la transacción y revisa si el registro de control cambia despues de haber terminado
    
      repeat (75)
            begin
                @(posedge clck_i);
            end
            
   // Revisa los que los datos sean los correctos
   
        if (salida_o == 32'h20006)
            begin
            
            $display("Correcto la revisión del registro de control con 1s");
            @(posedge clck_i);
            
            
            
            end
        else
            begin
            
            $display("Incorrecto la revisión del registro de control con 1s");
            @(posedge clck_i);
            $finish;
                     
            end    
  
  // Espera 3 clock
  
      repeat (3) 
            begin
                @(posedge clck_i);
            end  
        
        reg_sel_i = 1;
  
  // Espera 3 clock
        
      repeat (75)
            begin
                @(posedge clck_i);
            end
  
  // Revisa los que los datos recibidos sean los correctos
   
        if (salida_o == 32'hff)
            begin
            
            $display("Correcto la revisión del dato recibido con 1s");
            @(posedge clck_i);
            
            
            
            end
        else
            begin
            
            $display("Incorrecto la revisión del registro del dato recibido con 1s");
            @(posedge clck_i);
            $finish;
            
            end  
            
    // Simulacion para 0s
            
        wr_i        = 0;
        reg_sel_i   = 0;
        addr_in_i   = '0;
        entrada_i   = '0;
        
    // Espera 3 ciclos de reloj para quitar el reset
    
        repeat (3)
            begin
                @(posedge clck_i);
            end
            
    // Pone el valor de la instruccion para enviar solo 1s
    
        entrada_i =  32'hb;
    
    // Espera otros 3 ciclos de reloj
        
        repeat (3)
            begin
                @(posedge clck_i);
            end
            
    // Activa el writeenable
    
        wr_i = 1;
        
    // Espera un ciclo de reloj
    
        @(posedge clck_i) 
        
    // Desactiva el wr_i;
        
        wr_i = 0;
    
    // Espera que se realice la transacción y revisa si el registro de control cambia despues de haber terminado
    
      repeat (75)
            begin
                @(posedge clck_i);
            end
            
   // Revisa los que los datos sean los correctos
   
        if (salida_o == 32'h3000a)
            begin
            
            $display("Correcto la revisión del registro de control con 0s");
            @(posedge clck_i);
            
            
            
            end
        else
            begin
            
            $display("Incorrecto la revisión del registro de control con 0s");
            @(posedge clck_i);
            $finish;
                     
            end    
  
  // Espera 3 clock
  
      repeat (3) 
            begin
                @(posedge clck_i);
            end  
        
        reg_sel_i = 1;
  
  // Espera 3 clock
        
      repeat (75)
            begin
                @(posedge clck_i);
            end
  
  // Revisa los que los datos recibidos sean los correctos
   
        if (salida_o == 32'h0)
            begin
            
            $display("Correcto la revisión del dato recibido con 0s");
            @(posedge clck_i);
            
            end
        else
            begin
            
            $display("Incorrecto la revisión del registro del dato recibido con 0s");
            @(posedge clck_i);
            $finish;
            
            end 
    
    // Simulacion para 1 numero
    
    //  Espera 75 clck 
    
        repeat (75)
            begin
                @(posedge clck_i);
            end
            
    // Guarda valor en el primer registro
    
    
        entrada_i = 32'd5;
        reg_sel_i = 1;
        
     //  Espera 75 clck 
    
        repeat (75)
            begin
                @(posedge clck_i);
            end
           
      // Esribe el dato
      
        wr_i = 1;
        
        @(posedge clck_i);
        
        wr_i      = 0;
        reg_sel_i = 0;
        
        @(posedge clck_i);
        
        // Pone el valor de la instruccion para enviar solo 1s
    
        entrada_i =  32'h3;
    
    // Espera otros 3 ciclos de reloj
        
        repeat (3)
            begin
                @(posedge clck_i);
            end
            
    // Activa el writeenable
    
        wr_i = 1;
        
    // Espera un ciclo de reloj
    
        @(posedge clck_i) 
        
    // Desactiva el wr_i;
        
        wr_i = 0;
    
    // Espera que se realice la transacción y revisa si el registro de control cambia despues de haber terminado
    
      repeat (75)
            begin
                @(posedge clck_i);
            end
            
   // Revisa los que los datos sean los correctos
   
        if (salida_o == 32'h40002)
            begin
            
            $display("Correcto la revisión del registro de control con numero");
            @(posedge clck_i);
            
            
            
            end
        else
            begin
            
            $display("Incorrecto la revisión del registro de control con numero");
            @(posedge clck_i);
            $finish;
                     
            end    
  
  // Espera 3 clock
  
      repeat (3) 
            begin
                @(posedge clck_i);
            end  
        
        reg_sel_i = 1;
  
  // Espera 75 clock
        
      repeat (75)
            begin
                @(posedge clck_i);
            end
  
  // Revisa los que los datos recibidos sean los correctos
   
        if (salida_o == 32'h5)
            begin
            
            $display("Correcto la revisión del dato recibido con numero");
            @(posedge clck_i);
            
            end
        else
            begin
            
            $display("Incorrecto la revisión del registro del dato recibido con numero");
            @(posedge clck_i);
            $finish;
            
            end
        
   //Pone las variables de estimulo en su valor inicial 
    
        wr_i        = 0;
        reg_sel_i   = 0;
        addr_in_i   = '0;
        entrada_i   = '0;
        
    // Espera otros 3 ciclos de reloj
        
        repeat (3)
            begin
                @(posedge clck_i);
            end
            
    // Pone el valor de la instruccion para enviar solo 1s
    
        entrada_i =  32'h7;
    
    // Espera otros 3 ciclos de reloj
        
        repeat (3)
            begin
                @(posedge clck_i);
            end
            
    // Activa el writeenable
    
        wr_i = 1;
        
    // Espera un ciclo de reloj
    
        @(posedge clck_i) 
        
    // Desactiva el wr_i;
        
        wr_i = 0;
    
    // Espera que se realice la transacción y revisa si el registro de control cambia despues de haber terminado
    
      repeat (75)
            begin
                @(posedge clck_i);
            end
            
   // Revisa los que los datos sean los correctos
   
        if (salida_o == 32'h50006)
            begin
            
            $display("Correcto la revisión del registro de control con 1s");
            @(posedge clck_i);
            
            
            
            end
        else
            begin
            
            $display("Incorrecto la revisión del registro de control con 1s");
            @(posedge clck_i);
            $finish;
                     
            end    
  
  // Espera 3 clock
  
      repeat (3) 
            begin
                @(posedge clck_i);
            end  
        
        reg_sel_i = 1;
  
  // Espera 3 clock
        
      repeat (75)
            begin
                @(posedge clck_i);
            end
  
  // Revisa los que los datos recibidos sean los correctos
   
        if (salida_o == 32'hff)
            begin
            
            $display("Correcto la revisión del dato recibido con 1s");
            @(posedge clck_i);
            $finish;
            
            end
        else
            begin
            
            $display("Incorrecto la revisión del registro del dato recibido con 1s");
            @(posedge clck_i);
            $finish;
            
            
            end     
        
    end


endmodule