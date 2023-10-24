module tb_convertidor_bcd_ascii ();

    logic [15 :0] data_i;
    logic [31 :0] ascii_1_o;
    logic [31 :0] ascii_2_o;
    logic [31 :0] ascii_3_o;

    conversor_bcd_ascii prueba_convertidor_bcd_ascii (

        .data_i     (data_i),
        .ascii_1_o  (ascii_1_o),
        .ascii_2_o  (ascii_2_o),
        .ascii_3_o  (ascii_3_o)

    );

    initial 
        begin

            data_i = {4'h0, 4'b0010, 4'b0101, 4'b0101};

        end

endmodule