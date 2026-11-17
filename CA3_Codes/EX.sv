`timescale 1ns/1ns
module EX(input[2:0] aluFuncE,input[1:0] forwardAE,forwardBE,
        input[31:0] RD1E,RD2E,aluOutM,resultW,pcE,ImmE,input AluSrcE,jSrcE,
        output [31:0] jpcE,aluOutE,memdE,output zero);
        wire[31:0] muxAout,muxBout,muxBoutSec,ImmJumpE;
        MUX3 muxA(.if2(resultW),.if1(aluOutM), .if0(RD1E), .sel(forwardAE), .muxout(muxAout));
        MUX3 muxB(.if2(resultW),.if1(aluOutM), .if0(RD2E), .sel(forwardBE), .muxout(muxBout));
        MUX2 muxBsec(.if1(ImmE), .if0(muxBout), .sel(AluSrcE), .muxout(muxBoutSec));
        ALU alu(muxAout,muxBoutSec,aluFuncE,aluOutE, zero);
        Adder adder(ImmE, pcE, ImmJumpE);
        MUX2 muxJump(.if1(aluOutE), .if0(ImmJumpE), .sel(jSrcE), .muxout(jpcE));
        assign memdE = muxBout; //test
endmodule