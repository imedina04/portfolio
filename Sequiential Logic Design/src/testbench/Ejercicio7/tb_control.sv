`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 11:10:59 PM
// Design Name: 
// Module Name: tb_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_control(
    );
    
    logic       switch;
    logic [3:0] teclado;
    logic clk;
    logic rst;
        
        //Salidas
    logic led_error;
    logic led_operacion;
        
        //7 segmentos
    logic WE;
        
        //ALU
    logic [3:0] OP;
        
        //Banco de registros
    logic       we_banco;
    logic [4:0] addr_rs1;
    logic [4:0] addr_rs2;
    logic [4:0] addr_rd;
        
        //Mux
    logic mux_sel;
        
    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end 
    
    module_control c(
        .switch         (switch),
        .teclado        (teclado),
        .clk            (clk),
        .rst            (rst),
        
        //Salidas
        .led_error      (led_error),
        .led_operacion  (led_operacion),
        
        //7 segmentos
        .WE             (WE),
        
        //ALU
        .OP             (OP),
        
        //Banco de registros
        .we_banco       (we_banco),
        .addr_rs1       (addr_rs1),
        .addr_rs2       (addr_rs2),
        .addr_rd        (addr_rd),
        
        //Mux
        .mux_sel        (mux_sel)
    );
    
    initial begin
        switch = 1;
        rst    = 0;
        #10
        teclado = 'h2;
        rst     = 1;
        #100
        
        teclado = 'hb;
        #100
        
        teclado = 'h3;
        #100
        
        teclado = 'ha;
        #100
        
        
        
        teclado = 'h1;
        #100
        
        teclado = 'hb;
        #100
        
        teclado = 'h4;
        #100
        
        teclado = 'ha;
        #100
        
         teclado = 'h1;
        #100
        
        teclado = 'hb;
        #100
        
        teclado = 'h4;
        #100
        
        teclado = 'ha;
        #100
        
        
        switch = 0;
        #1000
        
        
        switch = 1;
        #100
        
        teclado = 'h6;
        #100
        
        teclado = 'hb;
        #100
        
        teclado = 'h1;
        #100
        
        teclado = 'ha;
        #100

        $finish;
        
        
    end
    
    
endmodule
