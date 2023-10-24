`timescale 1ns / 1ps


module tb_banco_de_registros;

 //Parámetros 
 localparam N = 32;
 localparam W = 4;

 //Entradas al módulo
 logic [$clog2(N)-1:0] addr_rs1;
 logic [$clog2(N)-1:0] addr_rs2;
 logic [$clog2(N)-1:0] addr_rd;
 logic clk;
 logic we;
 logic rst;
 logic [W-1:0] data_in;
 
 //Salidas del módulo
 logic [W-1:0] rs1;
 logic [W-1:0] rs2;
 


initial begin
    clk = 0;
    forever #5 clk = !clk;
 end 

module_banco_de_registros register_file(
    .addr_rs1  (addr_rs1),
    .addr_rs2  (addr_rs2),
    .addr_rd   (addr_rd),
    .clk       (clk),
    .we        (we),
    .data_in   (data_in),
    .rs1       (rs1),
    .rs2       (rs2),
    .rst       (rst)
    
    );
    
//Creaccion de registro artificial

//Salidas del registro artificia
logic   [W-1:0] rsp1;
logic   [W-1:0] rsp2;
logic   [W-1:0] [N-1:0] registro;
logic   [W-1:0] vector_ceros = '0;

always_ff@(posedge clk)begin
    //Reinicio del banco de registros
    if (!rst)
        registro <= 0;
    //Asignación de cero siempre a la posición cero del registro
    else if(addr_rd == 0)
        registro [addr_rd] <= vector_ceros;
    //Asignación de un valor en cierta posición del registro
    else if (we)
        registro [addr_rd] <= data_in;
end

//Asignación de la dirección del registro a leer 
assign rsp1 = registro [addr_rs1];
assign rsp2 = registro [addr_rs2];

///////////////////////////////////////////////////////////////////////////

initial begin
    rst      = 0;
    #10
    rst      = 1;
    #10
    addr_rs1 ='0;
    addr_rs2 ='0;
    addr_rd  = 0;
    we       = 1;
   
    repeat(31) begin
      addr_rd      <= $urandom_range(0,N-1);
      data_in      <= $urandom_range(0,W-1);
      
      #10;
    end
    we = 0; 
    #100
    repeat(31) begin
      addr_rs1 = $urandom_range(0,W-1);
      addr_rs2 = $urandom_range(0,W-1);
      if ((rs1 == rsp1) | (rs2 == rsp2))
        $display("Igual");
        
      #5;
    end  
    $finish;  
    $display ("Final");
end


endmodule
