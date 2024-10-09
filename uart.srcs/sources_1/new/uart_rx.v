`timescale 1ns / 1ps

module uart_rx #(
parameter DATA_WIDTH = 8,
parameter baud_rate = 9600,
parameter clk_freq  = 50000000
)
(
    input wire clk,
    input wire rst,
    input wire data_rx,
    output wire [DATA_WIDTH-1:0] data_out,
    output wire receive,
    output wire error
);

wire baud_clk_rx;

uart_br #(
    .baud_rate(baud_rate),
    .clk_freq(clk_freq)
)
uart_br_rx(
    .rst(rst),
    .clk(clk),
    .baud_clk(baud_clk_rx)
);

uart_sipo #(
    .DATA_WIDTH(DATA_WIDTH)
)
uart_sipo_inst(
    .baud_clk(baud_clk_rx),
    .rst(rst),
    .data_in(data_rx),
    .data_out(data_out),
    .receive(receive),
    .error(error)
);
   
endmodule