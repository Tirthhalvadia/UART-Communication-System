module uart_tx #(
parameter DATA_WIDTH = 8,
parameter baud_rate = 9600,
parameter clk_freq  = 50000000
)
(
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire valid,
    output wire send, 
    output wire data_tx,
    output wire tx_done
);

wire baud_clk_tx;

uart_br #(
    .baud_rate(baud_rate),
    .clk_freq(clk_freq)
)
uart_br_tx(
    .rst(rst),
    .clk(clk),
    .baud_clk(baud_clk_tx)
);

uart_piso #(
    .DATA_WIDTH(DATA_WIDTH)
)
uart_piso_inst(
    .baud_clk(baud_clk_tx),
    .rst(rst),
    .data_in(data_in),
    .valid_tx(valid),
    .send(send),
    .data_tx(data_tx),
    .tx_done(tx_done)
);


endmodule