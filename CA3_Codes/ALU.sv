`timescale 1ns/1ns
module ALU (input signed [31:0] A, [31:0] B, input [2:0] func, output logic [31:0] aluout, output zero);

    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND = 3'b010;
    localparam OR  = 3'b011;
    localparam XOR = 3'b100;
    localparam SLT = 3'b101;

	always@(A, B, func) begin
		case(func)
			ADD: aluout = A + B;
			SUB: aluout = A - B;
			AND: aluout = A & B;
			OR: aluout = A | B;
			XOR: aluout = A ^ B;
			SLT: aluout = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;
			default aluout = 32'b0;
		endcase
	end

	assign zero = (aluout == 0) ? 1'b1 : 1'b0;
	
endmodule