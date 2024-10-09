`timescale 1ns / 1ps

module uart_br
#(
parameter baud_rate = 9600,
parameter clk_freq  = 50000000 //50MHz clock
)
(
 input wire rst,
 input wire clk,
 output reg baud_clk
);

integer clock_tick = (clk_freq + baud_rate - 1) / baud_rate; // to ensure it takes ceiling value and there is no discrepency in the rate
integer count=0;

always @(posedge clk or posedge rst) begin //asynchronus rst
    if (rst) begin
        count<=0;
        baud_clk<=0;
    end else begin
        if (count==clock_tick) begin
            baud_clk<=~baud_clk;
            count<=0;   
        end else begin
            count<=count+1;
            baud_clk<=baud_clk;
        end          
    end 
end
endmodule