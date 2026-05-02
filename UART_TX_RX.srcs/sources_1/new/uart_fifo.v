`timescale 1ns / 1ps

module uart_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4 // 4 bits = 16 depth
)(
    input  wire clk,
    input  wire rst,
    
    // Write Port
    input  wire wr_en,
    input  wire [DATA_WIDTH-1:0] wr_data,
    output wire full,
    
    // Read Port
    input  wire rd_en,
    output wire [DATA_WIDTH-1:0] rd_data,
    output wire empty
);

    localparam DEPTH = 2**ADDR_WIDTH;
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    
    reg [ADDR_WIDTH:0] wr_ptr; // Extra bit for full/empty detection
    reg [ADDR_WIDTH:0] rd_ptr;

    // Full and Empty flags
    assign empty = (wr_ptr == rd_ptr);
    assign full  = (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) && 
                   (wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0]);

    // FWFT Data output (always shows the data at the read pointer)
    assign rd_data = mem[rd_ptr[ADDR_WIDTH-1:0]];

    // Write Logic
    always @(posedge clk) begin
        if (wr_en && !full) begin
            mem[wr_ptr[ADDR_WIDTH-1:0]] <= wr_data;
        end
    end

    // Pointer Updates
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
        end else begin
            if (wr_en && !full) begin
                wr_ptr <= wr_ptr + 1;
            end
            if (rd_en && !empty) begin
                rd_ptr <= rd_ptr + 1;
            end
        end
    end

endmodule