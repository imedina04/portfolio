`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 12:49:20 PM
// Design Name: 
// Module Name: tb_anti_rebote
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


module tb_anti_rebote(
    );
    
    //Variables del anti rebote
    logic        bn, clk, p, rst;
    logic [3:0]  cont1;
    logic [3:0]  cont2;
    
    initial begin
        clk = 0;
        forever #50 clk = !clk;
    end 
    
    top_antirebotes tar (
    
        .clck_i     (clk),
        .btn_i      (bn),
        .rst_i      (rst),

        .btn_signal_o(p)
    );
    
    contador_prueba c1(
        .clk(clk), 
        .rst_n_i(rst), 
        .en_i(bn), 
        .conta_o(cont1)
    );
    
    contador_prueba c2(
        .clk(clk), 
        .rst_n_i(rst), 
        .en_i(p), 
        .conta_o(cont2)
    );
    
    initial begin
        rst = 0; bn = 0;
        @(posedge clk);
        @(posedge clk);
        rst = 1;
        #966
        
        repeat(10)begin 
            bn = 1;
            #10
            bn = 0;
            #10;
           
        end
        
        bn = 1;
        #2000
        
        repeat(10)begin 
            bn = 1;
            #10
            bn = 0;
            #10;
        end
       
        #1967
        
        repeat(10)begin 
            bn = 1;
            #10
            bn = 0;
            #10;
           
        end
        
        bn = 1;
        #2000
        
        repeat(10)begin 
            bn = 1;
            #10
            bn = 0;
            #10;
        end
        
        #1957
        
        repeat(10)begin 
            bn = 1;
            #10
            bn = 0;
            #10;
           
        end
        
        bn = 1;
        #4000
        
        repeat(10)begin 
            bn = 1;
            #10
            bn = 0;
            #10;
        end
        
        #5000
        
        if (cont2 == 3)
            $display("Rebote eliminado");
        else
            $display("Error");
        $finish;
    end
endmodule
