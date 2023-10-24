`timescale 1ns/1ps

module tb_module_pc;

//PARAMETROS
localparam W = 4;

//VARIABLES DE ESTIMULO
logic  [W-1:0] pc_i;
logic  [1:0]   pc_op_i;
logic          clk_i;
logic          reset;

//SALIDAS DEL MODULO
logic [W-1:0]   pc_o;
logic [W-1:0]   pcinc_o;

module_pc #(.W(W)) pc_counter (

    .pc_i             (pc_i),
    .pc_op_i          (pc_op_i),
    .clk_i            (clk_i),
    .reset            (reset),
    .pc_o             (pc_o),
    .pcinc_o          (pcinc_o)
    
);

initial begin
    clk_i = 0;
    forever #5 clk_i = !clk_i;
end 

initial begin
    
    reset = 0;
    #10
    reset = 1;
    #20
       
    pc_i = 4'b0000;
    
    //reset
    #10 pc_op_i = 2'b00;
    #10 assert(pc_o == 4'b0000);
    #10 assert(pcinc_o == 4'b0000);
    
    // incremento +4
    #10 pc_op_i = 2'b10;
    #10 assert(pc_o == 4'b0100);
    #10 assert(pcinc_o == 4'b0100);
    
    // hold 
    #10 pc_op_i = 2'b01;
    #20 assert(pc_o == 4'b0100);
    #20 assert(pcinc_o == 4'b0100);
    
    // salto 
    #10 pc_i = 4'b1110;
    #20 pc_op_i = 2'b11;
    #20 assert(pc_o == 4'b1110);
    #20 assert(pcinc_o == 4'b0010);
    
    //reset
    #10 pc_op_i = 2'b00;
    #20 assert(pc_o == 4'b0000);
    #20 assert(pcinc_o == 4'b0000);
    
    
    $finish;
end
    
endmodule
