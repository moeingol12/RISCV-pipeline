`timescale 1ns/1ns
module MUX3 (input [31:0] if2, input [31:0] if1, input [31:0] if0, input [1:0] sel, output [31:0] muxout);
    assign muxout = (sel == 2'b10) ? if2 : (sel == 2'b01) ?if1 : if0; 
endmodule