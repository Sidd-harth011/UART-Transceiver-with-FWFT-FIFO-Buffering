`ifndef UART_PKG_VH
`define UART_PKG_VH

`define CLK_FREQ  100_000_000
`define BAUD_RATE 10_000_000
`define DATA_BITS 8

`define DIVISOR    (`CLK_FREQ / `BAUD_RATE)
`define MID_SAMPLE (`DIVISOR / 2)

`define IDLE  2'b00
`define START 2'b01
`define DATA  2'b10
`define STOP  2'b11

`endif