`timescale 1ns / 1ps

module tb_top_UART;

logic clk;
logic rst;
logic btn_send;     
logic btn_clear;    
logic btn_write;    
logic btn_read;     
logic switch_read;    
logic [7:0] data_in; 

logic rx;
logic tx;
logic [7:0] leds_out;
logic clk_interno;

top_UART top(
    .clk_pi             (clk),
    .rst                (rst),
    .btn_send_pi        (btn_send),     
    .btn_clear_pi       (btn_clear),    
    .btn_write_pi       (btn_write),    
    .btn_read_pi        (btn_read),      
    .switch_read_pi     (switch_read),      
    .data_in_pi         ({24'h0,data_in}),
    .rx                 (tx+2'b01),         
    
    .leds_po            (leds_out),
    .tx                 (tx)
    
);

assign clk_interno = top.clk2;

initial begin
    clk = 0;
    btn_send = 0;
    btn_clear = 0;
    btn_write = 0;
    btn_read = 0;
    switch_read = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst = '0;
    #30;
    
    @(posedge clk_interno);
    @(posedge clk_interno);
    @(posedge clk_interno);
    @(posedge clk_interno);
    rst <= 1;
    @(posedge clk_interno);
    @(posedge clk_interno);
    #110000;
    @(posedge clk_interno);
    data_in = 8'hA5;
    @(posedge clk_interno);
    btn_write = 1;
    @(posedge clk_interno);
    btn_write = 0;
    @(posedge clk_interno);
    @(posedge clk_interno);
    @(posedge clk_interno);
    btn_send = 1;
    @(posedge clk_interno);
    btn_send = 0;
    @(posedge clk_interno);
    @(posedge clk_interno);
    @(posedge clk_interno);
    btn_read = 1;
    @(posedge clk_interno);
    btn_read = 0;
    
    #1300000;
    @(posedge clk_interno);
    btn_clear = 1;
    @(posedge clk_interno);
    btn_clear = 0;
    switch_read = 1;
    @(posedge clk_interno);
    btn_read = 1;
    @(posedge clk_interno);
    btn_read = 0;
   
    #100;
    
    $finish;    
    
end


endmodule
