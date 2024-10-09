`timescale 1ns / 1ps

module uart#(
    parameter DATA_WIDTH = 8,
    parameter baud_rate = 9600,
    parameter clk_freq  = 50000000
)
(
    input wire clk,              
    input wire rst,              
    input wire [DATA_WIDTH-1:0] data_in, 
    input wire valid_tx,   
    output wire send,                
    output wire data_tx,         
    output wire [DATA_WIDTH-1:0] data_out, 
    output wire receive,         
    output wire error,           
    output wire tx_done          
);

    wire serial_data; 

    uart_tx #(
        .DATA_WIDTH(DATA_WIDTH),
        .baud_rate(baud_rate),
        .clk_freq(clk_freq)
    ) 
    
    uart_tx_inst (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .valid(valid_tx),
        .send(send),
        .data_tx(serial_data),
        .tx_done(tx_done)
    );


    uart_rx #(
        .DATA_WIDTH(DATA_WIDTH),
        .baud_rate(baud_rate),
        .clk_freq(clk_freq)
    ) uart_rx_inst (
        .clk(clk),
        .rst(rst),
        .data_rx(serial_data),
        .data_out(data_out),
        .receive(receive),
        .error(error)
    );

endmodule
