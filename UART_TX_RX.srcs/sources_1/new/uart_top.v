`timescale 1ns / 1ps
`include "uart_pkg.vh"

module uart_top (
    input  wire clk,
    input  wire rst,
    
    // Physical FPGA Pins
    input  wire rx_pin,
    output wire tx_pin,
    
    // User Interface (Connecting to CPU/Testbench)
    input  wire tx_wr_en,                     // User requests to write a byte
    input  wire [`DATA_BITS-1:0] tx_wr_data,  // Byte to transmit
    output wire tx_fifo_full,                 // CPU must stop if full
    
    input  wire rx_rd_en,                     // User requests to read a byte
    output wire [`DATA_BITS-1:0] rx_rd_data,  // Byte received
    output wire rx_fifo_empty                 // CPU shouldn't read if empty
);

    // --------------------------------------------------------
    // TX Path: FIFO -> UART TX
    // --------------------------------------------------------
    wire tx_fifo_empty;
    wire [`DATA_BITS-1:0] tx_fifo_out;
    wire tx_busy;
    
    // The TX module starts if the FIFO isn't empty and the TX isn't already busy
    wire tx_start_trigger = !tx_fifo_empty && !tx_busy;

    uart_fifo #(
        .DATA_WIDTH(`DATA_BITS),
        .ADDR_WIDTH(4) // 16-byte buffer
    ) tx_fifo (
        .clk(clk),
        .rst(rst),
        .wr_en(tx_wr_en),
        .wr_data(tx_wr_data),
        .full(tx_fifo_full),
        .rd_en(tx_start_trigger), // Pop data off exactly when TX starts
        .rd_data(tx_fifo_out),
        .empty(tx_fifo_empty)
    );

    uart_tx tx_inst (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start_trigger),
        .tx_data(tx_fifo_out),
        .tx(tx_pin),
        .tx_busy(tx_busy)
    );

    // --------------------------------------------------------
    // RX Path: UART RX -> FIFO
    // --------------------------------------------------------
    wire rx_done;
    wire [`DATA_BITS-1:0] rx_data_out;
    wire rx_fifo_full;

    uart_rx rx_inst (
        .clk(clk),
        .rst(rst),
        .rx(rx_pin),
        .rx_data(rx_data_out),
        .rx_done(rx_done)
    );

    uart_fifo #(
        .DATA_WIDTH(`DATA_BITS),
        .ADDR_WIDTH(4) // 16-byte buffer
    ) rx_fifo (
        .clk(clk),
        .rst(rst),
        .wr_en(rx_done),       // Push data in exactly when RX finishes a byte
        .wr_data(rx_data_out),
        .full(rx_fifo_full),
        .rd_en(rx_rd_en),
        .rd_data(rx_rd_data),
        .empty(rx_fifo_empty)
    );

endmodule