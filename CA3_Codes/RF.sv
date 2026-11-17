module RF(input [4:0] r1, r2, w, input [31:0] wd,
        input clk, rst, we, output signed [31:0] rd1, rd2);

    parameter n = 32;
    logic signed [31:0] mem [(n-1):0];

    assign rd1 = mem[r1];
    assign rd2 = mem[r2];

    always @(negedge clk or posedge rst) begin
        if (rst)
            for (int i=0;i<32;i++)
                mem[i] <= 32'b0;
        else if(we && (w != 5'b0))
            mem[w]<= wd;
    end
endmodule