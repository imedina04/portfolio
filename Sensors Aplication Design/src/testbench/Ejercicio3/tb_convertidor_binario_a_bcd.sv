`timescale 10ns/1ps

module tb_convertidor_binario_a_bcd ();

    logic             clck_i;
    logic             rst_clck_i;

    logic             begin_i;
    logic  [7 : 0]    data_i;

    logic [15: 0]    data_o;
    logic            end_o;
    
    logic [31: 0]    ascii_1;
    logic [31: 0]    ascii_2;
    logic [31: 0]    ascii_3;

    initial
        begin

            clck_i = 0;
            forever #5 clck_i = ~clck_i;

        end
    
    convetidor_binario_BCD cbb (

        .clck_i         (clck_i),
        .rst_clck_i     (rst_clck_i),

        .begin_i        (begin_i),
        .data_i         (data_i),
       
        .data_o         (data_o),
        .end_o          (end_o)

    );

    initial
        begin
            
            begin_i = 0;
            data_i = 8'd255;
            rst_clck_i = 0;

            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)

            rst_clck_i = 1;

            @(posedge clck_i)

            begin_i = 1;

            @(posedge clck_i)

            begin_i = 0;
            
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
            @(posedge clck_i)
           
            

            if(data_o == 24'b000000000000001001010101)begin

                $display("Correcto");
                $finish;
                end
            else begin

                $display("Incorrecto");
                $finish;
                end
        end
        
endmodule