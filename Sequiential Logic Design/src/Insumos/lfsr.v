`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////////////////
// File downloaded from http://www.nandland.com
///////////////////////////////////////////////////////////////////////////////
// Description: 
// A LFSR or Linear Feedback Shift Register is a quick and easy way to generate
// pseudo-random data inside of an FPGA.  The LFSR can be used for things like
// counters, test patterns, scrambling of data, and others.  This module
// creates an LFSR whose width gets set by a parameter.  The o_lfsr_done will
// pulse once all combinations of the LFSR are complete.  The number of clock
// cycles that it takes o_lfsr_done to pulse is equal to 2^g_Num_Bits-1.  For
// example setting g_Num_Bits to 5 means that o_lfsr_done will pulse every
// 2^5-1 = 31 clock cycles.  o_lfsr_data will change on each clock cycle that
// the module is enabled, which can be used if desired.
//
// Parameters:
// NUM_BITS - Set to the integer number of bits wide to create your LFSR.
///////////////////////////////////////////////////////////////////////////////

// https://www.nandland.com/vhdl/modules/lfsr-linear-feedback-shift-register.html

///////////////////////////////////////////////////////////////////////////////
// Versión modificada para Taller de digitales - I 2022
///////////////////////////////////////////////////////////////////////////////


module LFSR #(parameter NUM_BITS = 4) //por defecto 4 BITS!
  (
   input i_clk,
   input i_rst,
   input i_enable,
 
   // Optional Seed Value
   input [NUM_BITS-1:0] i_seed_data,
 
   output [NUM_BITS-1:0] o_lfsr_data,
   output o_lfsr_done
   );
 
  reg [NUM_BITS:1] r_lfsr;
  reg              r_xnor;
 
 
  // Purpose: Load up LFSR with Seed if Data Valid (DV) pulse is detected.
  // Othewise just run LFSR when enabled.
  always @(posedge i_clk)
    begin
      if (!i_rst) // Reset con LÓGICA NEGATIVA!
         r_lfsr <= i_seed_data; //El sistema inicia con el valor establecido por i_seed_data
      else if (i_enable == 1'b1) //mientras Enable es 1, entonces el sistema genera un nuevo valor!
        begin
            r_lfsr <= {r_lfsr[NUM_BITS-1:1], r_xnor};
        end
    end
 
  // Create Feedback Polynomials.  Based on Application Note:
  // http://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
  always @(*)
    begin
      case (NUM_BITS)
        3: begin
          r_xnor = r_lfsr[3] ^~ r_lfsr[2];
        end
        4: begin
          r_xnor = r_lfsr[4] ^~ r_lfsr[3];
        end
        5: begin
          r_xnor = r_lfsr[5] ^~ r_lfsr[3];
        end
        6: begin
          r_xnor = r_lfsr[6] ^~ r_lfsr[5];
        end
        7: begin
          r_xnor = r_lfsr[7] ^~ r_lfsr[6];
        end
        8: begin
          r_xnor = r_lfsr[8] ^~ r_lfsr[6] ^~ r_lfsr[5] ^~ r_lfsr[4];
        end
        9: begin
          r_xnor = r_lfsr[9] ^~ r_lfsr[5];
        end
        10: begin
          r_xnor = r_lfsr[10] ^~ r_lfsr[7];
        end
        11: begin
          r_xnor = r_lfsr[11] ^~ r_lfsr[9];
        end
        12: begin
          r_xnor = r_lfsr[12] ^~ r_lfsr[6] ^~ r_lfsr[4] ^~ r_lfsr[1];
        end
        13: begin
          r_xnor = r_lfsr[13] ^~ r_lfsr[4] ^~ r_lfsr[3] ^~ r_lfsr[1];
        end
        14: begin
          r_xnor = r_lfsr[14] ^~ r_lfsr[5] ^~ r_lfsr[3] ^~ r_lfsr[1];
        end
        15: begin
          r_xnor = r_lfsr[15] ^~ r_lfsr[14];
        end
        16: begin
          r_xnor = r_lfsr[16] ^~ r_lfsr[15] ^~ r_lfsr[13] ^~ r_lfsr[4];
          end
        17: begin
          r_xnor = r_lfsr[17] ^~ r_lfsr[14];
        end
        18: begin
          r_xnor = r_lfsr[18] ^~ r_lfsr[11];
        end
        19: begin
          r_xnor = r_lfsr[19] ^~ r_lfsr[6] ^~ r_lfsr[2] ^~ r_lfsr[1];
        end
        20: begin
          r_xnor = r_lfsr[20] ^~ r_lfsr[17];
        end
        21: begin
          r_xnor = r_lfsr[21] ^~ r_lfsr[19];
        end
        22: begin
          r_xnor = r_lfsr[22] ^~ r_lfsr[21];
        end
        23: begin
          r_xnor = r_lfsr[23] ^~ r_lfsr[18];
        end
        24: begin
          r_xnor = r_lfsr[24] ^~ r_lfsr[23] ^~ r_lfsr[22] ^~ r_lfsr[17];
        end
        25: begin
          r_xnor = r_lfsr[25] ^~ r_lfsr[22];
        end
        26: begin
          r_xnor = r_lfsr[26] ^~ r_lfsr[6] ^~ r_lfsr[2] ^~ r_lfsr[1];
        end
        27: begin
          r_xnor = r_lfsr[27] ^~ r_lfsr[5] ^~ r_lfsr[2] ^~ r_lfsr[1];
        end
        28: begin
          r_xnor = r_lfsr[28] ^~ r_lfsr[25];
        end
        29: begin
          r_xnor = r_lfsr[29] ^~ r_lfsr[27];
        end
        30: begin
          r_xnor = r_lfsr[30] ^~ r_lfsr[6] ^~ r_lfsr[4] ^~ r_lfsr[1];
        end
        31: begin
          r_xnor = r_lfsr[31] ^~ r_lfsr[28];
        end
        32: begin
          r_xnor = r_lfsr[32] ^~ r_lfsr[22] ^~ r_lfsr[2] ^~ r_lfsr[1];
        end
        default r_xnor=0; //En caso de que NUM_BITS esté por fuera del rango, usar cero! (el sistema se queda fijo en cero)
      endcase // case (NUM_BITS)
    end // always @ (*)
 
 
  assign o_lfsr_data = r_lfsr[NUM_BITS:1];
 
  // Conditional Assignment (?)
  assign o_lfsr_done = (r_lfsr[NUM_BITS:1] == i_seed_data) ? 1'b1 : 1'b0; // se terminó un cicl
 
endmodule // LFSR