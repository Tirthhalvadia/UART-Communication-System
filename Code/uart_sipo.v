`timescale 1ns / 1ps

module uart_sipo #(
    parameter DATA_WIDTH = 8
)
(
input wire baud_clk,
input wire rst,
input wire data_in,
output reg [DATA_WIDTH-1:0] data_out,
output reg receive,
output reg error
);


reg [DATA_WIDTH+1:0] shift;
reg [$clog2(DATA_WIDTH+2)-1:0] bit_count;

always @(posedge baud_clk or posedge rst) begin
    if (rst) begin
        data_out<=0;
        receive<=0;
        error<=0;
        bit_count<=0;
        shift<=0;
    end else begin 
        if (receive) begin
            // shift[DATA_WIDTH+1]<=data_in;
            // shift<= shift >> 1;
            shift <= {data_in, shift[DATA_WIDTH+1:1]};
            bit_count<= bit_count+1;
            
            if (bit_count==DATA_WIDTH + 1) begin
                // bit_count<=0;
                // receive<=0;
                
                if (shift[0] == 1'b0 && shift[DATA_WIDTH+1] == ^shift[DATA_WIDTH:1]) begin
                    data_out<=shift[DATA_WIDTH:1];
                    receive<=0;
                    error<=0; 
                    bit_count<=0;
                end else begin
                    error<=1;

                end
            end
        end else begin
            if (data_in == 0) begin
                receive <= 1;  // Begin reception on start bit
                shift <= 0;    // Clear the shift register
                bit_count <= 0;
            end
        end
    end
end
endmodule