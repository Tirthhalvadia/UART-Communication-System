`timescale 1ns / 1ps

module uart_sipo_tb; 

parameter DATA_WIDTH = 8;


reg baud_clk;
reg rst;
reg data_in;
wire [DATA_WIDTH-1:0] data_out;
wire receive;
wire error;

   // Instantiate the UART PISO (Serial In and Parallel Out) module
   uart_sipo #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    uart_sipo_inst(
        .baud_clk(baud_clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out),
        .receive(receive),
        .error(error)
    );
    
    initial begin
        baud_clk=0;
        forever #7 baud_clk=~baud_clk;
    end
    
    task transmit_byte (input [DATA_WIDTH-1:0] byte_data);
        integer i;
        begin
            data_in = 0; //start bit
            #14;

            for (i=0; i<DATA_WIDTH; i=i+1) begin
                data_in = byte_data[i];
                #14;
            end

            data_in = ^byte_data; //sends parity bit
            #14;

            data_in = 1; //stop bit
            #14;
        end
    endtask

    initial begin
        //initialize inputs
        rst= 1;
        data_in = 1'b1; //idle state

        #20;
        rst = 0;

        //Test Case 1: Receive 0x54
        #20;
        transmit_byte(8'h54);
        #10;

        if (data_out == 8'h54 && error == 0)
            $display ("Test Case 1 passed: Received 0x54");
        else 
             $display ("Test Case 1 failed: Data= %h, Error=%b",data_out, error);


        //Test Case 2: Receive 0xA3
        #20;
        transmit_byte(8'hA3);
        #10;

        if (data_out == 8'hA3 && error == 0)
            $display ("Test Case 2 passed: Received 0xA3");
        else 
             $display ("Test Case 2 failed: Data= %h, Error=%b",data_out, error);

        //Test Case 3: Transmit 0xFF
        #20;
        transmit_byte(8'hFF);
        #10;

        if (data_out == 8'hFF && error == 0)
            $display ("Test Case 3 passed: Received 0xFF");
        else 
             $display ("Test Case 3 failed: Data= %h, Error=%b",data_out, error);

        // End the simulation
        #100;
        $stop;
    end   
endmodule
