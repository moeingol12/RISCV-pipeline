module Mem(input [31:0] addr, [31:0] wd, input we, clk, output signed [31:0] rd);
    parameter n = 256;
    logic signed [31:0] mem [0:(n-1)];

    initial begin
        $readmemh("data.txt", mem);
    end
    assign rd = mem[addr[31:2]];
    
    always@(posedge clk) begin
        if(we)
            mem[addr[31:2]] <= wd;
    end
endmodule