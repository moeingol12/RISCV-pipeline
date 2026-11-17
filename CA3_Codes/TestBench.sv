`timescale 1ns/1ns
module TestBench();
    logic clk = 0, rst = 0;
    integer i;

    RISCV risc(clk, rst);
    
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        #40 rst = 0;
        #500;

        #20000;
        
        $display("=========================================");
        $display("          Data Memory           ");
        $display("=========================================");
        
        for (i = 0; i < 10; i = i + 1) begin
            $display("Mem[%0d] = %d", i, risc.mem.memory.mem[i]);
        end
        
        $display("=========================================");

        $stop;
    end

endmodule