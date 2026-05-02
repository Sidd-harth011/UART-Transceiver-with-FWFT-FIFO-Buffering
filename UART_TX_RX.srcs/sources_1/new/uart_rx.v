`timescale 1ns / 1ps
`include "uart_pkg.vh"

module uart_rx (
    input  wire clk,
    input  wire rst,
    input  wire rx,              
    output reg  [`DATA_BITS-1:0] rx_data,
    output reg  rx_done          
);

    reg [1:0] state;
    reg [$clog2(`DIVISOR)-1:0] clk_count;
    reg [`DATA_BITS-1:0] shift_reg;
    reg [$clog2(`DATA_BITS):0] bit_count;

    reg rx_sync_1, rx_sync_2;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_sync_1 <= 1'b1;
            rx_sync_2 <= 1'b1;
        end else begin
            rx_sync_1 <= rx;
            rx_sync_2 <= rx_sync_1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= `IDLE;
            rx_done   <= 0;
            rx_data   <= 0;
            clk_count <= 0;
            shift_reg <= 0;
            bit_count <= 0;
        end else begin
            rx_done <= 0; 
            
            case (state)
                `IDLE: begin
                    clk_count <= 0;
                    if (rx_sync_2 == 1'b0) begin 
                        state <= `START; 
                    end
                end

                `START: begin
                    if (clk_count == `MID_SAMPLE) begin
                        if (rx_sync_2 == 1'b0) begin 
                            clk_count <= 0;
                            bit_count <= 0;
                            state     <= `DATA;
                        end else begin
                            state <= `IDLE; 
                        end
                    end else begin
                        clk_count <= clk_count + 1;
                    end
                end

                `DATA: begin
                    if (clk_count == `DIVISOR - 1) begin
                        clk_count <= 0;
                        shift_reg <= {rx_sync_2, shift_reg[`DATA_BITS-1:1]}; 
                        bit_count <= bit_count + 1;

                        if (bit_count == `DATA_BITS - 1) begin
                            state <= `STOP;
                        end
                    end else begin
                        clk_count <= clk_count + 1;
                    end
                end

                `STOP: begin
                    if (clk_count == `DIVISOR - 1) begin
                        clk_count <= 0;
                        if (rx_sync_2 == 1'b1) begin 
                            rx_data <= shift_reg;
                            rx_done <= 1'b1;
                        end
                        state <= `IDLE;
                    end else begin
                        clk_count <= clk_count + 1;
                    end
                end
            endcase
        end
    end
endmodule