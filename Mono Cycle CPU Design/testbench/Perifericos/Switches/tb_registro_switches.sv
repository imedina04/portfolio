`timescale 10ns/1ps

module tb_registro_switches ();

logic          clck_i;
logic          rst_i;

logic [15 : 0] switches_i;
logic [ 3 : 0] botones_i;
logic [31 : 0] registro_switches_o; 

initial begin

clck_i = 0;
forever #5 clck_i = ~clck_i;

end

registro_switches pruba_module_switches (

.clck_i             (clck_i),
.rst_i              (rst_i),
                    
.switches_i         (switches_i),
.botones_i          (botones_i),
.registro_switches_o(registro_switches_o) 

);

initial begin

switches_i = '0;
botones_i = '0;
rst_i = 0;
@(posedge clck_i);
@(posedge clck_i);
@(posedge clck_i);
rst_i = 1;
repeat (65336)
    begin
        @(posedge clck_i);
        switches_i = switches_i + 1'b1;;
        @(posedge clck_i);
    end

switches_i = '0;
@(posedge clck_i);
@(posedge clck_i);
@(posedge clck_i);

repeat (1)
    begin
        @(posedge clck_i);
        botones_i[0] =  1'b1;
        repeat (200)
        begin
        @(posedge clck_i);
        @(posedge clck_i);
        @(posedge clck_i);
        end
        botones_i[0] =  1'b0;
        repeat (200)
        begin
        @(posedge clck_i);
        @(posedge clck_i);
        @(posedge clck_i);
        end
    end
    @(posedge clck_i);
    @(posedge clck_i);
    @(posedge clck_i);
    @(posedge clck_i);
    
    
repeat (1)
    begin
        @(posedge clck_i);
        botones_i[1] =  1'b1;
        repeat (200)
        begin
        @(posedge clck_i);
        @(posedge clck_i);
        @(posedge clck_i);
        end
        botones_i[1] =  1'b0;
        repeat (200)
        begin
        @(posedge clck_i);
        @(posedge clck_i);
        @(posedge clck_i);
        end
        
    @(posedge clck_i);
    @(posedge clck_i);
    @(posedge clck_i);
    @(posedge clck_i);
    
    repeat (1)
    begin
        @(posedge clck_i);
        botones_i[2] =  1'b1;
    repeat (200)
    begin
        @(posedge clck_i);
        @(posedge clck_i);
        @(posedge clck_i);
        end
        botones_i[2] =  1'b0;
        repeat (200)
        begin
        @(posedge clck_i);
        @(posedge clck_i);
        @(posedge clck_i);
        end        
    @(posedge clck_i);
    @(posedge clck_i);
    @(posedge clck_i);
    @(posedge clck_i);
    end
    repeat (1)
    begin
        @(posedge clck_i);
        botones_i[3] =  1'b1;
        repeat (200)
        begin
        @(posedge clck_i);
        @(posedge clck_i);
        @(posedge clck_i);
        end
        botones_i[3] =  1'b0;
        repeat (200)
        begin
        @(posedge clck_i);
        @(posedge clck_i);
        @(posedge clck_i);
        end
        
    end
    end

    $finish;
 
 end



endmodule


