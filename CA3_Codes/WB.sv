`timescale 1ns/1ns
module WB(input[1:0] resSrcW,input[31:0] aluOutW,memOutW,npcW,output[31:0] WdW);
    MUX3 muxres(.if2(npcW), .if1(memOutW), .if0(aluOutW), .sel(resSrcW), .muxout(WdW));
endmodule