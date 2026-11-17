module PC(input [31:0] addr, input en, input clk, rst, output logic [31:0] pcout);
    always @(posedge clk or posedge rst) begin
        if (rst)
            pcout <= 32'b0;
        else if(~en)        // en=0 → آپدیت، en=1 → stall
            pcout <= addr;
    end
endmodule