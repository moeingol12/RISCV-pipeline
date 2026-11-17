`timescale 1ns/1ns
module DEreg(input clk,rst,input[31:0] pcD,RD1D,RD2D,ImmD,npcD,input[4:0]RdD,Rs1D,Rs2D,input[2:0] aluFuncD,input[1:0]resSrcD,
            input jSrcD,regWrD,memWrD,pcWrD,isBeqD,isBneqD,isBltD,isBgeD,AluSrcD,input flushE,
            output logic [31:0] pcE,RD1E,RD2E,ImmE,npcE,output logic [4:0]RdE,Rs1E,Rs2E,output logic[2:0] aluFuncE,output logic[1:0] resSrcE,
            output logic jSrcE,regWrE,memWrE,pcWrE,isBeqE,isBneqE,isBltE,isBgeE,AluSrcE );
            always@(posedge clk) begin
                // {RD1E,RD2E,ImmE,npcE,RdE,Rs1E,Rs2E,aluFuncE,resSrcE,
                //     regWrE,memWrE,pcWrE,isBeqE,isBneqE,isBltE,isBgeE,AluSrcE,jSrcE,pcE} = 0;
                if(flushE || rst) begin
                    {RD1E,RD2E,ImmE,npcE,RdE,Rs1E,Rs2E,aluFuncE,resSrcE,
                    regWrE,memWrE,pcWrE,isBeqE,isBneqE,isBltE,isBgeE,AluSrcE,jSrcE,pcE} <= 0;
                end
                else begin
                    {RD1E,RD2E,ImmE,npcE,RdE,Rs1E,Rs2E,aluFuncE,resSrcE,
                    regWrE,memWrE,pcWrE,isBeqE,isBneqE,isBltE,isBgeE,AluSrcE,jSrcE,pcE} <=
                    {RD1D,RD2D,ImmD,npcD,RdD,Rs1D,Rs2D,aluFuncD,resSrcD,
                    regWrD,memWrD,pcWrD,isBeqD,isBneqD,isBltD,isBgeD,AluSrcD,jSrcD,pcD};
                end
            end

endmodule