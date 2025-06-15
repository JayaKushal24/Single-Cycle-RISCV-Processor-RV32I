`timescale 1ns / 1ps

module tb_top;
    reg clk;
    reg rst;
    top dut (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #10;
        rst = 0;
        #150;
        $finish;
    end
    always @(posedge clk) begin
        $display("Cycle: %d, PC: %h, Instruction: %h",$time/10,dut.pc,dut.instruction);
        
    end

endmodule
