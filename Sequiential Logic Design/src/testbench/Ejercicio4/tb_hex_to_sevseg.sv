`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2023 07:12:38 PM
// Design Name: 
// Module Name: tb_hex_to_sevseg
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


module tb_hex_to_sevseg(

    );
    
    logic        clk;
    
    logic [3:0]  en;
    logic [6:0]  seg;
    logic [15:0] led;
    
    logic [3:0] s, s1, s2, s3, s4;
    logic [6:0] sega; //Segmento artificial
    
    assign s1 = led[3:0];
    assign s2 = led[7:4];
    assign s3 = led[11:8];
    assign s4 = led[15:12];
    
    initial begin
        clk = 0;
        forever #5 clk = !clk;
    end 
    
    always@(posedge clk)begin
        case(en)
            4'b1110:
                s = s1;
            4'b1101:
                s = s2;
            4'b1011:
                s = s3;
            4'b0111:
                s = s4;
        endcase
    end
        
    test_hex_to_segsev thts(
        .clk_pi     (clk),
        
        .en_po      (en),
        .seg_po     (seg),
        .led        (led)
   );
   
   module_sevseg segsev (
        .d_i        (s),
        .s_o        (sega)
    );
    
    always@(posedge clk)begin
        if(sega == seg)
            $display ("Funciona");
    end 
        
    initial begin
        #50000;
        $finish;
    end
   
   
   
    
endmodule
