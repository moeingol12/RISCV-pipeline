`timescale 1ns/1ns;
module FDreg(input clk,rst ,input[31:0] instMemF,pcF,npcF,input stallD,flushD,output logic[31:0] InstMemD,pcD,npcD);
    always@(posedge clk)begin
        if(flushD ==1 || rst ==1) {InstMemD,pcD,npcD} = 96'd0;
        else if(stallD ==0)begin
            InstMemD <= instMemF;
            pcD <= pcF;
            npcD <= npcF;
        end
    end
endmodule