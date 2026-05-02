`timescale 1ns / 1ps
`include "uart_pkg.vh"

module uart_tx (
    input  wire clk,
    input  wire rst,
    input  wire tx_start,
    input  wire [`DATA_BITS-1:0] tx_data,
    output reg  tx,
    output reg  tx_busy
);

    reg [1:0] state;
    reg [$clog2(`DIVISOR)-1:0] clk_count;
    reg [`DATA_BITS-1:0] shift_reg;
    reg [$clog2(`DATA_BITS):0] bit_count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= `IDLE;
            tx        <= 1'b1;
            tx_busy   <= 0;
            clk_count <= 0;
            shift_reg <= 0;
            bit_count <= 0;
        end else begin
            case (state)
                `IDLE: begin
                    tx        <= 1'b1;
                    tx_busy   <= 0;
                    clk_count <= 0;
                    
                    if (tx_start) begin
                        shift_reg <= tx_data;
                        tx_busy   <= 1;
                        tx        <= 1'b0; 
                        state     <= `START;
                    end
                end

                `START: begin
                    if (clk_count == `DIVISOR - 1) begin
                        clk_count <= 0;
                        tx        <= shift_reg[0]; 
                        bit_count <= 0;
                        state     <= `DATA;
                    end else begin
                        clk_count <= clk_count + 1;
                    end
                end

                `DATA: begin
                    if (clk_count == `DIVISOR - 1) begin
                        clk_count <= 0;
                        if (bit_count == `DATA_BITS - 1) begin
                            tx    <= 1'b1; 
                            state <= `STOP;
                        end else begin
                            shift_reg <= shift_reg >> 1;
                            tx        <= shift_reg[1]; 
                            bit_count <= bit_count + 1;
                        end
                    end else begin
                        clk_count <= clk_count + 1;
                    end
                end

                `STOP: begin
                    if (clk_count == `DIVISOR - 1) begin
                        clk_count <= 0;
                        tx_busy   <= 0; 
                        state     <= `IDLE;
                    end else begin
                        clk_count <= clk_count + 1;
                    end
                end
            endcase
        end
    end
endmodule