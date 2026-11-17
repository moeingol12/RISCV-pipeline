`timescale 1ns/1ns
module M(input clk,memWrM,input [31:0]memdM,aluOutM,output[31:0]memRdM);
    Mem memory(aluOutM,memdM,memWrM,clk,memRdM);
endmodule