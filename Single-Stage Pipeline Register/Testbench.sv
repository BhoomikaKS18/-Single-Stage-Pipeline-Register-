TESTBENCH

`timescale 1ns/1ps

module tb_pipeline_reg;

    logic clk;
    logic rst_n;

    logic [7:0] in_data;
    logic in_valid;
    logic in_ready;

    logic [7:0] out_data;
    logic out_valid;
    logic out_ready;

    pipeline_reg dut (clk,rst_n,in_data,in_valid,in_ready,out_data,
 out_valid,out_ready);

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        rst_n = 0;
        in_valid = 0;
        out_ready = 0;
        in_data = 8'h00;

        #20 rst_n = 1;

        // Send data
        #10;
        in_data  = 8'h55;
        in_valid = 1;

        #10;
        in_valid = 0;

        // Accept data
        #20;
        out_ready = 1;

        #20;
        $finish;
    end

    initial begin
        $monitor("T=%0t | in_valid=%b in_ready=%b in_data=%h | out_valid=%b out_ready=%b out_data=%h",
                  $time, in_valid, in_ready, in_data,
                  out_valid, out_ready, out_data);
    end

endmodule
