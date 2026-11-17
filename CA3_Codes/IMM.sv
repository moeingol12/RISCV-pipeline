`timescale 1ns/1ns
module IMM(input [24:0] in, input [1:0] immsrc, output logic [31:0] imm);

    localparam I= 2'b00;
    localparam S= 2'b01;
    localparam B= 2'b10;
    localparam J = 2'b11;
    
    always @(in, immsrc) begin
        case (immsrc)
            I: imm = {{20{in[24]}}, in[24:13]}; 
            S: imm = {{20{in[24]}}, in[24:18], in[4:0]}; 
            B: imm = {{20{in[24]}}, in[0], in[23:18], in[4:1], 1'b0}; 
            J: imm = {{11{in[24]}}, in[24], in[12:5], in[13], in[23:14], 1'b0}; 
            default: imm = 32'b0;
        endcase
    end
endmodule