`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
// File downloaded from http://www.nandland.com
///////////////////////////////////////////////////////////////////////////////
// description: Simple Testbench for lfsr.v.  Set c_NUM_BITS to different
// values to verify operation of lfsr
///////////////////////////////////////////////////////////////////////////////

// https://www.nandland.com/vhdl/modules/lfsr-linear-feedback-shift-register.html

///////////////////////////////////////////////////////////////////////////////
// Versión modificada para Taller de digitales - I 2022
///////////////////////////////////////////////////////////////////////////////

module lfsr_tb ();
 
    parameter clock_cycle = 10;//periodo 10ns
    parameter half_cycle = clock_cycle/2;
    parameter delay_val=1;//1 ns delay de escritura
    
    
    
    
    reg clk = 1'b0;
    reg rst = 1'b0;
    reg r_enable = 1'b0;
    
    wire [5-1:0] w_lfsr_data;
    wire w_lfsr_done;
    
    always @(*)
        #(half_cycle) clk <= ~clk; 
        
    task wait_clk(input integer num);
        repeat(num) begin
            @(posedge clk); #(delay_val);
        end
    endtask
   
  lfsr_individual_test_top lfsr_inst
         (.i_clk(clk),
          .i_rst(rst),
          .i_enable(r_enable),
          .i_seed_data({5{1'b0}}), // replication
          .o_lfsr_data(w_lfsr_data),
          .o_lfsr_done(w_lfsr_done)
          );
          
  initial begin 
    wait_clk(2);
    rst=1;
    wait_clk(5);
    r_enable=1;
    wait_clk(100);
    r_enable=1;
    wait_clk(10);
    r_enable=0;
    wait_clk(10);
    repeat(15) begin
        r_enable=~r_enable;
        wait_clk(1);
    end
    r_enable=0;
    wait_clk(10);
    $finish;
  end
  
  
   
endmodule // lfsr_tb
