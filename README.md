# UART Communication System

## Description
This project implements a complete UART (Universal Asynchronous Receiver-Transmitter) communication system in Verilog. The system is designed to support configurable baud rates and data widths, and includes separate modules for the transmitter (PISO), receiver (SIPO), baud rate generation, and an optional top-level integration module.

The project was developed using Xilinx Vivado and includes testbenches for the PISO and SIPO modules. The design has been verified through simulation, but FPGA implementation and synthesis are still pending.

## Features
- **Configurable Baud Rate**: Default 9600 baud with a 50 MHz clock frequency.
- **Parameterizable Data Width**: Default 8 bits.
- **PISO (Parallel In Serial Out)**: Handles data transmission with start and stop bits and parity for error checking.
- **SIPO (Serial In Parallel Out)**: Receives serial data, verifies the start bit and parity, and outputs the data in parallel.
- **Baud Rate Generator**: Generates the required clock signal for UART transmission and reception.
- **Error Detection**: Uses parity bits for error checking during reception.

## Modules
- **`uart_br`**: Baud rate generator.
- **`uart_piso`**: Converts parallel data into serial format for transmission.
- **`uart_rx`**: Receives serial data and outputs parallel data with error checking.
- **`uart_sipo`**: Converts received serial data into parallel format.
- **`uart_tx`**: Handles data transmission using the `uart_piso` module.
- **`uart`**: Top-level integration module combining `uart_tx` and `uart_rx`.

## Testbenches
- **`uart_piso_tb`**: Validates the functionality of the PISO module.
- **`uart_sipo_tb`**: Verifies the SIPO module.

## Tools Used
- **Xilinx Vivado**: Design and simulation was done using Xilinx Vivado.

## Next Steps
- **FPGA Implementation**: Synthesize the design and implement it on an FPGA.
- **Synthesis and Timing Analysis**: Analyze the design's timing and ensure correct operation on hardware.

## How to Use
1. Clone or download the repository.
2. Open the project in **Xilinx Vivado**.
3. Simulate the PISO and SIPO testbenches to verify functionality.


