`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2023 14:29:16
// Design Name: 
// Module Name: tb_module_ALU
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

module tb_module_ALU;

localparam N = 4;

logic  [N-1:0] ALUA;
logic  [N-1:0] ALUB;
logic          ALUFlagIn;
logic  [3:0]   ALUControl;
logic  [N-1:0] ALUResult;
logic          ALUFlags;
logic          Cero;
    
module_ALU #(.N(N)) ALU(
    
    .ALUA           (ALUA),          
    .ALUB           (ALUB),
    .ALUFlagIn      (ALUFlagIn),
    .ALUControl     (ALUControl),
    .ALUResult      (ALUResult),
    .ALUFlags       (ALUFlags),
    .Cero           (Cero)
 );

logic [N-1:0] rcomp = 0;
logic         cero_comp = 0;
logic         flag_comp = 0;
logic [N-1:0] vector_ceros = '0;
logic [N-1:0] vector_unos  = '1;

initial begin
    ALUA       = 4'b0101;
    ALUB       = 4'b0010;
    ALUControl = 'h0;
    ALUFlagIn  = '0;
    
    #10
    for (int i=0; i<=9; i=i+1) begin
        
         case(ALUControl)
           'h0          : begin                                   // Operación lógica AND
                                   cero_comp = 0;
                                   rcomp = ALUA & ALUB;
                                   if (rcomp == vector_ceros) begin
                                       cero_comp = 1;
                                    end 
                               end
            'h1            : begin                                   // Operación lógica OR
                                   cero_comp = 0;
                                   rcomp = ALUA | ALUB;
                                   if (rcomp == vector_ceros) begin
                                       cero_comp = 1;
                                   end 
                               end
            'h2          : begin                                   // Operación aritmética SUMA                   
                                   cero_comp = 0;
                                   rcomp = ALUA + ALUB + ALUFlagIn;
                                   if (rcomp == vector_ceros) begin
                                       cero_comp = 1;
                                   end 
                               end
           'h3   : begin                                   // Operación aritmética DE INCREMENTAR EN 1
                                   if (ALUFlagIn=='0)                         
                                       begin 
                                           rcomp = ALUA+1;
                                       end
                                   else
                                       begin
                                           rcomp = ALUB+1;
                                       end
                                end                
           'h4   : begin                                   // Operación aritmética DECREMENTAR EN 1
                                   if (ALUFlagIn=='0)                       
                                       begin
                                           cero_comp = 0; 
                                           rcomp = ALUA-1;
                                           if (rcomp == vector_ceros) begin
                                               cero_comp = 1;
                                           end 
                                    end
                                   else
                                       begin
                                           cero_comp = 0;
                                           rcomp = ALUB-1;
                                           if (rcomp == vector_ceros) begin
                                                cero_comp = 1;
                                           end 
                                       end
                                end
            'h5           : begin                                   // Operación lógica NOT
                                   if (ALUFlagIn=='0)                      
                                       begin 
                                           cero_comp = 0;
                                           rcomp = ~ALUA;
                                           if (rcomp == vector_ceros) begin
                                               cero_comp = 1;
                                           end 
                                      end
                                   else
                                       begin
                                           cero_comp = 0;
                                           rcomp = ~ALUB;
                                           if (rcomp == vector_ceros) begin
                                               cero_comp = 1;
                                           end 
                                       end
                                end
            'h6         : begin                                   // Operación aritmética RESTA  
                                   cero_comp = 0;
                                   //ALUResult = (ALUA + (ALUB*-1)) + (ALUFlagIn*-1);
                                   rcomp = ALUA - ALUB;
                                   if (rcomp == vector_ceros) begin
                                      cero_comp = 1;
                                   end 
                               end
                                   
            'h7          : begin                                   // Operación lógica XOR
                                   cero_comp = 0;
                                   rcomp = ALUA ^ ALUB;
                                   if (rcomp == vector_ceros) begin
                                       cero_comp = 1;
                                   end
                               end 
            'h8 :  begin                                  // Operación corrimiento a la izquierda
                                    cero_comp = 0;
                                    if (ALUFlagIn=='0)                                     
                                        begin 
                                            flag_comp = ALUA [N-ALUB] ;
                                            rcomp = ALUA << ALUB;
                                            if (rcomp == vector_ceros) begin
                                                cero_comp = 1;
                                            end 
                                        end
                                   else if (ALUFlagIn=='1)
                                        begin   
                                            flag_comp = ALUA [N-ALUB] ;
                                            rcomp = ALUA << ALUB;
                                            vector_unos = vector_unos >> (N-ALUB);
                                            rcomp = rcomp + vector_unos;
                                            if (rcomp == vector_ceros) begin
                                                cero_comp = 1;
                                            end 
                                        end
                                end
                                         
            'h9 :  begin                                 // Operación corrimiento a la izquierda
                                    cero_comp = 0;
                                    if (ALUFlagIn=='0)                                
                                        begin 
                                            flag_comp  = ALUA [ALUB-1];
                                            rcomp = ALUA >> ALUB;
                                            if (rcomp == vector_ceros) begin
                                                cero_comp = 1;
                                            end 
                                        end
                                    else if (ALUFlagIn=='1)
                                        begin
                                            flag_comp  = ALUA [ALUB-1];
                                            rcomp = ALUA >> ALUB; 
                                            vector_unos = vector_unos << (N-ALUB);
                                            rcomp = rcomp + vector_unos;
                                            if (rcomp == vector_ceros) begin
                                                cero_comp = 1;
                                            end 
                                        end
                                end
            default: begin
                        rcomp = '0;
                        cero_comp = 1;
                     end                                    
          endcase
          
         if ( rcomp != ALUResult | flag_comp != ALUFlags | cero_comp != Cero)
            $display ("ERROR DE CALCULO");
            
         
         #10;
         ALUControl = ALUControl + 'h1;
    end
    
    $display("Simulacion exitosa");
    $finish;
 end
 
endmodule
