`timescale 10ns/1ps

module tb_bus_addr ();

logic [31 : 0] addr_mp_i;
logic          we_mp_i;
logic [31 : 0] data_mp_i;
logic [31 : 0] data_mp_o;
logic [31 : 0] read_ram_i;
logic [31 : 0] read_switches_i;
logic [31 : 0] read_uart_a_i;
logic [31 : 0] read_uart_b_i;
logic [31 : 0] read_uart_c_i;
logic [31 : 0] read_siete_segmento_i;
logic [31 : 0] read_led_i;
logic          we_ram_o;
logic          we_uart_a_o;
logic          we_uart_b_o;
logic          we_uart_c_o;
logic          we_switches_o;
logic          we_led_o;
logic          we_siete_segmentos_o;
logic [31 : 0] dato_pr_o;
logic          reg_sel_o;
logic          addr_o;
logic [7 :0]   addr_ram_o;
logic clck;

initial 
    begin
        clck = 0;
        forever #50 clck = ~clck; 
    
    end


bus_addr prueba_esa_vara (

// Entradas que vienen del microprecesaor
    .addr_mp_i              (addr_mp_i),
    .we_mp_i                (we_mp_i),
    .data_mp_i              (data_mp_i),

// Dato de salida que envia el microprocesador
    .data_mp_o              (data_mp_o),

//Entradas del dato leido de los perifericos

    .read_ram_i             (read_ram_i),
    .read_swithces_i        (read_switches_i),
    .read_uart_a_i          (read_uart_a_i),
    .read_uart_b_i          (read_uart_b_i),
    .read_uart_c_i          (read_uart_c_i),
    .read_siente_segmento_i (read_siete_segmento_i),
    .read_led_i             (read_led_i),

// Salidas de los wr enable para cada periférico
    
    .we_ram_o               (we_ram_o),
    .we_uart_a_o            (we_uart_a_o),
    .we_uart_b_o            (we_uart_b_o),
    .we_uart_c_o            (we_uart_c_o),
    .we_switches_o          (we_switches_o),
    .we_led_o               (we_led_o),
    .we_siete_segmentos_o   (we_siete_segmentos_o),

// Salida dato que viene del procesador 

    .dato_pr_o              (dato_pr_o),

// Salida para controlar los UART

    .regg_sel_o             (reg_sel_o),
    .adddr_o                (addr_o),

// Salida para controlar las lineas del ram

    .addr_ram_o             (addr_ram_o)

);

initial begin

we_mp_i = 1;
addr_mp_i = 31'h1000;
data_mp_i = 31'h04;
read_ram_i             = 31'h1;
read_switches_i        = 31'h2;
read_uart_a_i          = 31'h3;
read_uart_b_i          = 31'h4;
read_uart_c_i          = 31'h5;
read_siete_segmento_i  = 31'h6;
read_led_i             = 31'h7;

repeat(5)
    begin
    @(posedge clck);
    end
addr_mp_i = 31'h13FC;

repeat(5)
    begin
    @(posedge clck);
    end
addr_mp_i = 31'h2000;

repeat(5)
    begin
    @(posedge clck);
    end

addr_mp_i = 31'h2004;

repeat(5)
    begin
    @(posedge clck);
    end
    
addr_mp_i = 31'h2008;

repeat(5)
    begin
    @(posedge clck);
    end
    
addr_mp_i = 31'h2010;

repeat(5)
    begin
    @(posedge clck);
    end
    
addr_mp_i = 31'h2018;

repeat(5)
    begin
    @(posedge clck);
    end
    
addr_mp_i = 31'h201C;

repeat(5)
    begin
    @(posedge clck);
    end
addr_mp_i = 31'h2020;

repeat(5)
    begin
    @(posedge clck);
    end
    
addr_mp_i = 31'h2028;

repeat(5)
    begin
    @(posedge clck);
    end
    
addr_mp_i = 31'h202C;

repeat(5)
    begin
    @(posedge clck);
    end
addr_mp_i = 31'h2030;

repeat(5)
    begin
    @(posedge clck);
    end
    
addr_mp_i = 31'h2038;

repeat(5)
    begin
    @(posedge clck);
    end
    
addr_mp_i = 31'h203C;

repeat(5)
    begin
    @(posedge clck);
    end

    $finish;

end


endmodule