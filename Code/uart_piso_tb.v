`timescale 1ns / 1ps

module uart_piso_tb;

    // Parameters
    parameter DATA_WIDTH = 8;
    
    // Inputs
    reg baud_clk;
    reg rst;
    reg [DATA_WIDTH-1:0] data_in;
    reg valid_tx;

    // Outputs
    wire send;
    wire data_tx;
    wire tx_done;

    // Instantiate the UART PISO (Parallel In Serial Out) module
    uart_piso #(
        .DATA_WIDTH(DATA_WIDTH)
    ) uut (
        .baud_clk(baud_clk),
        .rst(rst),
        .data_in(data_in),
        .valid_tx(valid_tx),
        .send(send),
        .data_tx(data_tx),
        .tx_done(tx_done)
    );

    // Clock generation
    initial begin
        baud_clk = 0;
        forever #7 baud_clk = ~baud_clk;  // 14ns clock period
    end

    initial begin
        // Initialize inputs
        rst = 1;
        valid_tx = 0;
        data_in = 8'b00000000;

        // Reset the system
        #20;
        rst = 0;

        // Test Case 1: Transmit 0x54
        #20;
        data_in = 8'h54;  // 0b01010100
        valid_tx = 1;     // Assert valid_tx signal to start transmission
        #14;
        valid_tx = 0;     // Deassert valid_tx once transmission starts

        // Wait for transmission to complete
        wait (tx_done == 1);
        #10;

        // Test Case 2: Transmit 0xA3
        #50;
        data_in = 8'hA3;  // 0b10100011
        valid_tx = 1;     
        #14;
        valid_tx = 0;     

        wait (tx_done == 1);
        #10;

        // Test Case 3: Transmit 0xFF
        #50;
        data_in = 8'hFF;  // 0b11111111
        valid_tx = 1;     
        #14;
        valid_tx = 0;     

        wait (tx_done == 1);
        #10;

        // End the simulation
        #100;
        $stop;
    end

endmodule
