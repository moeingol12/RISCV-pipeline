module InstMem(input [31:0] addr, output [31:0] rd);
    parameter n = 128;
    logic [31:0] mem [0:(n-1)];
    initial begin
        $readmemh("tasks.hex", mem);
    end
    assign rd = mem[addr[31:2]];
endmodule