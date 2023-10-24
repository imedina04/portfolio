`timescale 1ns / 1ps

module tb_mini_calculo;

logic clk_i;
logic [3:0] teclado_i;
logic switch_i;
logic led_error_o = 0;
logic led_op_o = 0;
logic reset = 0;

logic  we;
logic [3:0] op_alu;
logic [3:0] operando1;
logic [3:0] operando2;
logic mux_sel = 0;
logic [3:0] mux_out;
logic [3:0] Y;
logic [4:0] addr_rd;
logic [4:0] addr_rs1;
logic [4:0] addr_rs2;
logic       we_reg;
logic [3:0] display;
//logic ALUA;
//logic ALUB;

initial begin
    clk_i = 0;
    forever #5 clk_i = ~clk_i;
end


top_mini_calculo top(
    .clk_pi             (clk_i),
    .teclado_pi         (teclado_i),
    .switch_pi          (switch_i),         
    .led_error_po       (led_error_o),
    .led_op_po          (led_op_o)
);


initial begin
   
   switch_i = 1;
//   clk_i = 1;
//    reset = 0;
//    #10;
    reset = 1;
    
    #20 teclado_i = 'h2;
    
    
    #10 teclado_i = 'hb;
    
    
    #40 teclado_i = 'h3;
    
    #40 teclado_i = 'ha;
    
    #50;
    
    
    $finish;
end 

endmodule