`timescale 1ns / 1ps

module tb_fsm_reception;

logic clk;
logic rst;
logic rx_pulse;         // Pulso de rx que llega del uart

logic wr1_datos;
logic wr2_datos;       // WE para el reg datos
logic wr1_ctrl;
logic wr2_ctrl;        // WE para el reg control
logic bit_new_rx;          // bit de new_rx hacia el reg control
logic bit_send;
 
logic [31:0] data1;
logic [31:0] data2;
 
logic [31:0] out_datos1;
logic [31:0] out_datos2;
logic [31:0] out_control; 
 
fsm_reception fsm2 (
    .clk_i            (clk),
    .rst_i            (rst),
    .rx_pulse_i       (rx_pulse),
    
    .wr2_datos_o      (wr2_datos),
    .wr2_ctrl_o       (wr2_ctrl),
    .new_rx_o         (bit_new_rx)
);

// Registro de control
reg_control reg0(
    .clk_i      (clk),
    .rst_i      (rst),
    .wr1_i      (wr1_ctrl),
    .wr2_i      (wr2_ctrl),
    .data1_i    (data1),
    .data2_i    ({30'd0,bit_new_rx,bit_send}),
 
    .out_o      (out_control)
);

// Registro de datos
reg_datos reg1(
    .clk_i       (clk),
    .rst_i       (rst),
    .wr1_i      (wr1_datos),
    .wr2_i      (wr2_datos),
    .data1_i    (data1),
    .data2_i    (data2),
   
    .out1_o     (out_datos1),
    .out2_o     (out_datos2)
);


initial begin
    clk = 0;
    rx_pulse = 0;
    wr1_datos = 0;
    wr1_ctrl = 0;
    bit_send = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst = '0;
    #30;
    
    @(posedge clk);
    rst <= 1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    data2 = 32'd4;
    @(posedge clk);
    rx_pulse = 1;
    @(posedge clk);

    rx_pulse = 0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    data2 = 32'd2;
    @(posedge clk);
    rx_pulse = 1;
    @(posedge clk);
 
    rx_pulse = 0;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    data2 = 32'd7;
    @(posedge clk);
    rx_pulse = 1;
    @(posedge clk);
    rx_pulse = 0;
    #50;
    
    $finish;    
    
end

endmodule
