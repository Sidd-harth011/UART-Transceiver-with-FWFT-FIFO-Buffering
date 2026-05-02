//`timescale 1ns / 1ps
`include "uart_pkg.vh"

// Optional: Isolated Control Path for RX
module uart_rx_fsm (
    input  wire clk,
    input  wire rst,
    input  wire rx_sync,
    input  wire baud_tick,
    input  wire mid_tick,
    input  wire bit_done,
    output reg  [1:0] state,
    output reg  shift_en,
    output reg  rx_done_pulse
);
    // Control logic decoupled from datapath would go here
endmodule