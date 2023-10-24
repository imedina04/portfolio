`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2023 10:08:36 PM
// Design Name: 
// Module Name: tb_top
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


module tb_top(

    );
    
    logic            clk_i;
    logic            rst_i =0;
    
    logic  [ 3 : 0]   botones_i = 0;
    logic  [15 : 0]   switches_i = 0;
    
    logic            rx_a = 1;
    
    logic            tx_a;
    logic            rx_b;
    
    logic            tx_b;
    logic            rx_c = 1;
    
    logic            tx_c;
    logic [15 :0]    leds_o;
    logic [6 : 0]    siete_segmento_o;
    logic [3 : 0]    enable_o;
    
    //###########################################################
    logic  [ 3 : 0]   botones2_i = 0;
    logic  [15 : 0]   switches2_i = 0;
    
    
    
 
    logic            rx2_b = 1;
    
    logic            tx2_b;
    logic            rx2_c = 1;
    
    logic            tx2_c;
    logic [15 :0]    leds2_o;
    logic [6 : 0]    siete_segmento2_o;
    logic [3 : 0]    enable2_o;
    
    //###########################################################
    logic  [ 3 : 0]   botones3_i = 0;
    logic  [15 : 0]   switches3_i = 0;
    
    
    
 
    logic            rx3_b = 1;
    
    logic            tx3_b;
    logic            rx3_c = 1;
    
    logic            tx3_c;
    logic [15 :0]    leds3_o;
    logic [6 : 0]    siete_segmento3_o;
    logic [3 : 0]    enable3_o;
    
    
    initial begin
        clk_i = 0;
        forever #5  clk_i = !clk_i;
    end
    
    logic [31:0]addr;
    
    top dut1 (
          .clk_i             ( clk_i            ),
          .rst_i             ( rst_i            ),
                             
          .botones_i         ( botones_i       ),
          .switches_i        ( switches_i      ),
                             
          .rx_a              ( rx_a             ),                  
          .tx_a              ( tx_a             ),
          
          .rx_b              ( rx_b             ),         
          .tx_b              ( tx_b             ),
          
          .rx_c              (          ),       
          .tx_c              (              ),
          
          
          .leds_o            ( leds_o           ),
          .siete_segmento_o  ( siete_segmento_o ),
          .enable_o          ( enable_o         )
        
    );
    
    top dut2 (
          .clk_i             ( clk_i            ),
          .rst_i             ( rst_i            ),
                             
          .botones_i         ( botones2_i       ),
          .switches_i        ( switches2_i      ),
                             
          .rx_a              ( tx_b             ),
          .tx_a              ( rx_b              ),
          
          .rx_b              ( rx2_b             ),
          .tx_b              ( tx2_b             ),
          
          .rx_c              ( rx2_c             ),
          .tx_c              ( tx2_c             ),
          
          .leds_o            ( leds2_o           ),
          .siete_segmento_o  ( siete_segmento2_o ),
          .enable_o          ( enable2_o         )
        
    );
    
    
    top dut3 (
          .clk_i             ( clk_i            ),
          .rst_i             ( rst_i            ),
                             
          .botones_i         ( botones3_i       ),
          .switches_i        ( switches3_i      ),
                             
          .rx_a              ( tx2_c             ),
          .tx_a              ( rx2_c              ),
          
          .rx_b              (              ),
          .tx_b              (              ),
          
          .rx_c              (              ),
          .tx_c              (              ),
          
          .leds_o            ( leds3_o           ),
          .siete_segmento_o  ( siete_segmento3_o ),
          .enable_o          ( enable3_o         )
        
    );
    
    assign addr = dut2.pc;
    
    initial begin 
        #10000
        botones_i = 'h0;
        switches_i = 'b0001_1000_0011;
        switches2_i = 'b0010_0100_0000;
        switches3_i = 'b0011_1100_0000;
        
        #100
        botones_i = 'hF; //Envio dut 1 - dut 3
        
        #1100000 
        botones_i = 'h0;
        switches_i = 'b0001_1111_0011;
        
        #1100000
        botones_i = 'hF; //Envio dut 1 - dut 3
        
        #1700000
        botones_i = 'h0;
        switches_i = 'b0001_1010_0010;
        
        #1100000
        botones_i = 'hF; //Envio dut 1 - dut 2
        
        #1700000
        botones_i = 'h0;
        switches3_i = 'b0011_0101_0001;
        
        #1100000
        botones3_i = 'hF; //Envio dut 3 - dut 1
        
        #1700000
        botones3_i = 'h0;
        switches2_i = 'b0010_1111_0001;
        
        #1100000
        botones2_i = 'hF; //Envio dut 2 - dut 1
        
        #1700000
        botones2_i = 'h0;
        
        while (addr != 'h2bc) begin
            @(posedge clk_i);
        end
        #100
        $stop;
    end 

    
    
endmodule
