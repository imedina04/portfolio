`timescale 10ns/1ps

module tb_generador_y_control ();


    logic               wr_i;
    logic               clck_i;
    logic               rst_clck_i;
    logic               reg_sel_i;
    logic [2 : 0]       seleccion_generador;
    logic               addr_in_i;
    logic [31 : 0]      salida_i;

    logic               wr_o;
    logic               reg_sel_o;
    logic [31 : 0]      entrada_o;
    logic [ 4 : 0]      addr_in_o;
    logic [ 3 : 0]      en_o;
    logic [ 6 : 0]      seg_o;



    initial begin

        clck_i = 0;
        forever #5 clck_i = ~clck_i;

    end

    generador_y_control_datos gcd (

        .wr_i                   (wr_i),
        .clck_i                 (clck_i),
        .rst_clck_i             (rst_clck_i),
        .reg_sel_i              (reg_sel_i),
        .seleccion_generador    (seleccion_generador),
        .addr_in_i              (addr_in_i),
        .salida_i               (salida_i),

        .wr_o                   (wr_o),
        .reg_sel_o              (reg_sel_o),
        .entrada_o              (entrada_o),
        .addr_in_o              (addr_in_o),
        .en_o                   (en_o),
        .seg_o                  (seg_o)

    );

    initial
        begin

            wr_i                =  0;
            rst_clck_i          =  0;
            reg_sel_i           =  0;
            seleccion_generador = '0;
            addr_in_i           = '0;
            salida_i            = '0;

            repeat (3)
                begin

                    @(posedge clck_i);
                
                end

            rst_clck_i = 1;

            repeat (5)
                begin

                    @(posedge clck_i);
                
                end
            
            wr_i                =  1;
            
            @(posedge clck_i);
            @(posedge clck_i);
            
            wr_i                =  0;
            reg_sel_i           =  1;
            seleccion_generador = '0;
            addr_in_i           = 5'd1;
            salida_i            = 32'd5;

            repeat (5)
                begin

                    @(posedge clck_i);
                
                end
            
            wr_i                =  0;
            reg_sel_i           =  0;
            seleccion_generador =  3'b001;
            addr_in_i           = '0;
            salida_i            = '0;
            
            repeat (5)
                begin

                    @(posedge clck_i);
                
                end
            
            wr_i                =  0;
            reg_sel_i           =  0;
            seleccion_generador =  3'b010;
            addr_in_i           = '0;
            salida_i            = 32'd6;
            
            repeat (5)
                begin

                    @(posedge clck_i);
                
                end
            
            wr_i                =  0;
            reg_sel_i           =  1;
            seleccion_generador =  3'b011;
            addr_in_i           = '0;
            salida_i            = '0;

            repeat (5)
                begin

                    @(posedge clck_i);
                
                end
            
            wr_i                =  0;
            reg_sel_i           =  0;
            seleccion_generador =  3'b100;
            addr_in_i           = '0;
            salida_i            = '0;
            
            repeat (5)
                begin

                    @(posedge clck_i);
                
                end
            
            wr_i                =  0;
            reg_sel_i           =  1;
            seleccion_generador =  3'b101;
            addr_in_i           = '0;
            salida_i            = 32'd7;
        
            repeat (5)
            begin

                @(posedge clck_i);
            
            end

            $finish;


        end

endmodule