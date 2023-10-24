`timescale 1ns / 1ps


/// JUST to test using 5 bits 

module lfsr_individual_test_top(
        input i_clk,
        input i_rst,
        input i_enable,
        
        // Optional Seed Value
        input  [5-1:0] i_seed_data,
        
        output [5-1:0] o_lfsr_data,
        output o_lfsr_done
    );
    
    LFSR #(.NUM_BITS(5)) LFSR_inst
         (.i_clk       (i_clk),
          .i_rst       (i_rst),
          .i_enable    (i_enable),
          .i_seed_data (i_seed_data), 
          .o_lfsr_data (o_lfsr_data),
          .o_lfsr_done (o_lfsr_done)
          );
          
endmodule
