`timescale 1ns / 1ps

module uart_piso #(
    parameter DATA_WIDTH = 8
)
( 
input wire baud_clk,
input wire rst,
input wire [DATA_WIDTH-1:0] data_in,
input wire valid_tx,
output reg send,
output reg data_tx,
output reg tx_done

);

reg [DATA_WIDTH+1:0] shift_reg;
reg [$clog2(DATA_WIDTH+2)-1:0] bit_count;

always @(posedge baud_clk or posedge rst) begin
    if (rst)begin
    bit_count<=0;
    send<=0;
    data_tx <= 1'b1; //idle state
    end else if (valid_tx && !send) begin
        shift_reg<={^data_in, data_in,1'b0}; //MSB is the parity bit which will be later used for error checking and LSB is start bit
        bit_count<=0;
        send<=1;
        tx_done<=0;
    end else if (send) begin 
        data_tx<=shift_reg[0];
        shift_reg<=shift_reg >> 1;
        bit_count<=bit_count+1;
        if (bit_count==DATA_WIDTH+2) begin
            send<=0;
            tx_done <= 1;
            data_tx <= 1'b1;  // return to idle state after transmission
        end else begin
            tx_done <=0;
        end
    end
end

endmodule