`timescale 1ns/1ns
module MUX2(input [31:0] if1, if0, input sel, output [31:0] muxout);
    assign muxout = sel ? if1 : if0; 
endmodule