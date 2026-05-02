// Reusable tasks to keep the main testbench clean

task reset_system;
    begin
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;
        #20;
        rst = 0;
        #50;
    end
endtask

task send_uart_byte;
    input [7:0] data_to_send;
    begin
        @(posedge clk);
        tx_data = data_to_send;
        tx_start = 1;
        
        @(posedge clk);
        tx_start = 0;
        
        // Wait until transmission is complete
        wait(tx_busy == 0);
        #100; // Small buffer delay
    end
endtask