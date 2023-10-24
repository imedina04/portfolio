`timescale 10ns/1ps

module tb_registro_leds ();


logic          we_i;
logic [31 : 0] data_i;
logic [31 : 0] reg_leds_o;
logic          clck_i;
logic          rst_i;

initial
    begin
    
    clck_i = 0;
    forever #5 clck_i = ~clck_i;
    
    end
    
registro_leds leds_prueba (

    .clck_i   ( clck_i),
    .rst_i    ( rst_i),
    .data_i   ( data_i),
    .we_i     ( we_i),

    .reg_leds_o( reg_leds_o)

);    


initial begin

data_i = 32'h1644;
rst_i = 0;
we_i = 0;
@(posedge clck_i)
@(posedge clck_i)
@(posedge clck_i)
rst_i = 1;
@(posedge clck_i)
@(posedge clck_i)
@(posedge clck_i)
@(posedge clck_i)
@(posedge clck_i)
@(posedge clck_i)
we_i = 1;
@(posedge clck_i)
we_i = 0;




end

endmodule