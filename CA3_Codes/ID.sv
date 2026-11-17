`timescale 1ns/1ns
module ID(input[31:0] InstMemD,input[4:0]RdW,input[31:0] WdW,input[1:0] ImmSrcD,input clk,regWrW,rst,output[31:0] RD1D,RD2D,ImmD,output[4:0]RdD,Rs1D,Rs2D);
    RF regFile(InstMemD[19:15], InstMemD[24:20], RdW,  WdW,
         clk, rst, regWrW, RD1D, RD2D);
    IMM ImmExtD(InstMemD[31:7], ImmSrcD, ImmD);
    assign Rs1D = InstMemD[19:15];
    assign Rs2D = InstMemD[24:20];
    assign RdD = InstMemD[11:7];
endmodule