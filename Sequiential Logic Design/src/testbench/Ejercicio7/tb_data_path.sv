`timescale 1ns / 1ps

module tb_data_path;


logic [3:0] teclado_i;
logic clk;
logic reset;
logic mux_sel;
logic [4:0] addr_rs1;
logic [4:0] addr_rs2;
logic [4:0] addr_rd;
logic       we_banco;
logic [3:0] op_alu;
    
logic [3:0] seg_o;

module_datapath  data(

    .teclado_i      (teclado_i),
    .clk             (clk),
    .reset           (reset),
    .mux_sel        (mux_sel),
    .addr_rs1       (addr_rs1),
    .addr_rs2       (addr_rs2),
    .addr_rd        (addr_rd),
    .we_banco       (we_banco),
    .op_alu         (op_alu),
    
    .seg_o          (seg_o)
);


initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    reset = 0;
    #10
    reset = 1;
    #100
    
    op_alu = 0;
    mux_sel = 0;
    we_banco = 0;
    addr_rd =  1;
    addr_rs1 = 1;
    addr_rs2 = 1;
    teclado_i = 'h2;
    #10
    we_banco = 1;
    #50
    
    
    op_alu = 0;
    mux_sel = 0;
    we_banco = 0;
    addr_rd = 1;
    addr_rs1 = 1;
    addr_rs2 = 1;
    teclado_i = 'hb;
    #50
    
    mux_sel = 0;
    we_banco = 0;
    addr_rd = 2;
    addr_rs1 = 1;
    addr_rs2 = 2;
    teclado_i = 'h3;
    #10
    we_banco = 1;
    #50
    
    mux_sel = 0;
    we_banco = 0;
    addr_rd = 3;
    addr_rs1 = 2;
    addr_rs2 = 3;
    teclado_i = 'ha;  //enter
    #50
    
    op_alu = 'hb;
    
    #10
    mux_sel = 1;
    we_banco = 1;
    addr_rd = 3;
    addr_rs1 = 2;
    addr_rs2 = 1;
    
    #10
    
    addr_rs2 = 3;
    op_alu = 0;
    mux_sel = 0;
    we_banco = 0;
    
    #100
    $finish;
end




endmodule
