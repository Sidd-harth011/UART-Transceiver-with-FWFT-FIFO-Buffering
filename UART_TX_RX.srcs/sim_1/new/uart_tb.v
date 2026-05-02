`timescale 1ns / 1ps

module uart_tb (
    output reg clk,
    output reg rst,
    output reg tx_wr_en,
    output reg [7:0] tx_wr_data,
    input wire tx_fifo_full
);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Task for a quick burst write
    task write_byte(input [7:0] data);
        begin
            @(posedge clk);
            if (!tx_fifo_full) begin
                tx_wr_en = 1;
                tx_wr_data = data;
            end
            @(posedge clk);
            tx_wr_en = 0;
        end
    endtask

    initial begin
        rst = 1;
        tx_wr_en = 0;
        tx_wr_data = 0;
        #50;
        rst = 0;
        #50;

        // Blast 4 bytes in immediately! No waiting for tx_busy.
        write_byte(8'hA1);
        write_byte(8'hB2);
        write_byte(8'hC3);
        write_byte(8'hD4);

        // Now just sit back and watch the simulation empty the FIFO
        #5000;
        $stop;
    end

endmodule