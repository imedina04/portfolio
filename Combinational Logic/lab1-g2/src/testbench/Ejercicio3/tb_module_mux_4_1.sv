`timescale 1ns/1ps

module tb_module_mux_4_1;

//PARAMETROS
localparam WIDTH_TEST=16;

//VARIABLES DE ESTIMULO
logic [WIDTH_TEST - 1:0]   a_i;    
logic [WIDTH_TEST - 1:0]   b_i;
logic [WIDTH_TEST - 1:0]   c_i;
logic [WIDTH_TEST - 1:0]   d_i;
logic [1:0]                sel_i;

//SALIDAS DEL MODULO
logic [WIDTH_TEST - 1:0]  out_o;

module_mux_4_1 #(.BUS_WIDTH(WIDTH_TEST)) dut (

    .a_i          (a_i),
    .b_i          (b_i),
    .c_i          (c_i),
    .d_i          (d_i),
    .sel_i        (sel_i),
    .out_o        (out_o)
);

initial begin
    for(int i =0; i<50;i++) begin
          a_i   =   $urandom;
          b_i   =   $urandom;
          c_i   =   $urandom;
          d_i   =   $urandom;
          sel_i =   $urandom;
          #10;
    end 
    $finish;
end

endmodule
