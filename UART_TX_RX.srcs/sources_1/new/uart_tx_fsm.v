//`timescale 1ns / 1ps
`include "uart_pkg.vh"

// Optional: Isolated Control Path for TX
module uart_tx_fsm (
    input  wire clk,
    input  wire rst,
    input  wire tx_start,
    input  wire baud_tick,
    input  wire bit_done,
    output reg  [1:0] state,
    output reg  tx_busy,
    output reg  load_en,
    output reg  shift_en
);
    // Control logic decoupled from datapath would go here
endmodule