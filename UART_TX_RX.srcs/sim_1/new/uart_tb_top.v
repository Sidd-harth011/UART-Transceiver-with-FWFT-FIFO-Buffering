`timescale 1ns / 1ps
`include "uart_pkg.vh"

module uart_tb_top;
    wire clk, rst;
    wire serial_line; 
    
    // New Interface wires
    wire tx_wr_en;
    wire [`DATA_BITS-1:0] tx_wr_data;
    wire tx_fifo_full;
    
    wire rx_rd_en;
    wire [`DATA_BITS-1:0] rx_rd_data;
    wire rx_fifo_empty;

    uart_top DUT (
        .clk(clk),
        .rst(rst),
        .rx_pin(serial_line),  
        .tx_pin(serial_line),
        .tx_wr_en(tx_wr_en),
        .tx_wr_data(tx_wr_data),
        .tx_fifo_full(tx_fifo_full),
        .rx_rd_en(rx_rd_en),
        .rx_rd_data(rx_rd_data),
        .rx_fifo_empty(rx_fifo_empty)
    );

    uart_tb TB_DRIVER (
        .clk(clk),
        .rst(rst),
        .tx_wr_en(tx_wr_en),
        .tx_wr_data(tx_wr_data),
        .tx_fifo_full(tx_fifo_full)
    );
endmodule