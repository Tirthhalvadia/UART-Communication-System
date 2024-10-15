# UART Communication System

## Description
This project implements a complete UART (Universal Asynchronous Receiver-Transmitter) communication system in Verilog and has been successfully deployed on the **ZedBoard Zynq Evaluation and Development Kit (xc7z020clg484-1)**. The system is designed to support configurable baud rates and data widths. It includes separate modules for the transmitter (PISO), receiver (SIPO), baud rate generation, and an optional top-level integration module.

The project was developed using Xilinx Vivado and includes testbenches for the PISO and SIPO modules. The design has been verified through simulation. Additionally, both the UART transmitter and receiver modules were synthesized and implemented with timing optimizations, achieving the least possible clock period of **4ns (250MHz)**.

## FPGA Implementation Details
- **UART Transmitter (tx)**:
  - Achieved **+0.704ns WNS** (Worst Negative Slack for setup) and **+0.337ns WHS** (Worst Hold Slack).
  - Clock period: **4ns (250MHz)**.
  
- **UART Receiver (rx)**:
  - Achieved **+0.679ns WNS** and **+0.321ns WHS**.
  - Clock period: **4ns (250MHz)**.


## Features
- **Configurable Baud Rate**: Default 9600 baud with a 50 MHz clock frequency.
- **Parameterizable Data Width**: Default 8 bits.
- **PISO (Parallel In Serial Out)**: Handles data transmission with start and stop bits and parity for error checking.
- **SIPO (Serial In Parallel Out)**: Receives serial data, verifies the start bit and parity, and outputs the data in parallel.
- **Baud Rate Generator**: Generates the required clock signal for UART transmission and reception.
- **Error Detection**: Uses parity bits for error checking during reception.

## Project Files

### Netlist Schematics
- `rx_schematic.pdf` – Receiver module netlist schematic.
- `tx_schematic.pdf` – Transmitter module netlist schematic.

### Verilog Code
- `uart.v` – Top-level UART module.
- `uart_br.v` – Baud rate generator.
- `uart_piso.v` – Parallel In Serial Out (PISO) module.
- `uart_piso_tb.v` – Testbench for PISO.
- `uart_rx.v` – Receiver module.
- `uart_sipo.v` – Serial In Parallel Out (SIPO) module.
- `uart_sipo_tb.v` – Testbench for SIPO.
- `uart_tx.v` – Transmitter module.

### Waveforms
- `uart_piso_tb_behav.wcfg` – Waveform configuration for PISO testbench.
- `uart_sipo_tb_behav.wcfg` – Waveform configuration for SIPO testbench.

### Timing Reports
- `timing_rx.rpx` – Timing report for receiver module.
- `timing_tx.rpx` – Timing report for transmitter module.

### Bitstreams
- `rx_bitstream.bit` – Bitstream file for receiver module.
- `tx_bitstream.bit` – Bitstream file for transmitter module.

### Constraints
- `rx_constraints.xdc` – Constraints file for receiver module.
- `tx_constraints.xdc` – Constraints file for transmitter module.


## How to Use
1. Clone or download the repository.
2. Open the project in **Xilinx Vivado**.
3. Simulate the testbenches for the PISO and SIPO modules to verify functionality.
4. Synthesize and implement the design on the **ZedBoard Zynq** FPGA.
5. Upload the respective bitstreams to test UART communication in hardware.

## Tools Used
- **Xilinx Vivado**: Design, simulation, synthesis, and implementation.
- **ZedBoard Zynq Evaluation Kit**: FPGA hardware platform.


