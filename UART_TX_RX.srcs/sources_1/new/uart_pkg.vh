`ifndef UART_PKG_VH
`define UART_PKG_VH

// Global UART Macros
`define CLK_FREQ  100_000_000
`define BAUD_RATE 10_000_000 // change it to 115200 or 9200 for working with real fpga
`define DATA_BITS 8

// Derived Macros 
`define DIVISOR    (`CLK_FREQ / `BAUD_RATE)
`define MID_SAMPLE (`DIVISOR / 2)

// Shared FSM States
`define IDLE  2'b00
`define START 2'b01
`define DATA  2'b10
`define STOP  2'b11

`endif