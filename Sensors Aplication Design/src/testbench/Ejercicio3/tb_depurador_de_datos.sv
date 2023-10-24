`timescale 10ns/1ps

module tb_depurador_de_datos();

    logic          clck_i;
    logic          rst_clck_i;

    logic          wr_i;
    logic [31 : 0] data_i;
    logic          addr_in_i;
    logic [ 7 : 0] data_o;

    initial
        begin

            clck_i = 0;
            forever #5 clck_i = ~clck_i;

        end
        
    depurador_de_datos dd (

        .clck_i     (clck_i),
        .rst_clck_i (rst_clck_i),
        .wr_i       (wr_i),
        .addr_in_i  (addr_in_i),
        .data_i     (data_i),
        .data_o     (data_o)
        
    );

    initial
        begin

            //reset de los datos
            
            wr_i = 0;
            rst_clck_i = 0;
            data_i  =32'h1F;
            addr_in_i  = 0;
            
            @(posedge clck_i)
            @(posedge clck_i)
            
            rst_clck_i = 1;

            @(posedge clck_i);

            wr_i = 1;

            @(posedge clck_i)

            wr_i   = 0;
            addr_in_i  = 1;
            data_i = 32'hE0;

            @(posedge clck_i);

            wr_i = 1;

            @(posedge clck_i);

            wr_i   = 0;

            @(posedge clck_i)
           
            
            @(posedge clck_i)
            
            if(data_o ==  32'hFF)

                $display("Dato correcto");

            else

                $display("Dato Incorrecto");
            
            @(posedge clck_i)

            $finish;


            



        end

endmodule