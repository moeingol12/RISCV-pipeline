`timescale 1ns/1ns
module MWreg(input clk,rst,input regWrM,input[1:0]resSrcM,input[31:0]aluOutM,memOutM,npcM,input[4:0]RdM,
                    output logic regWrW,output logic[1:0]resSrcW,output logic[31:0]aluOutW,memOutW,npcW,output logic[4:0]RdW);
            always@(posedge clk,posedge rst)begin
                if(rst) {regWrW,resSrcW,aluOutW,memOutW,RdW,npcW}=0;
                else {regWrW,resSrcW,aluOutW,memOutW,RdW,npcW}<={regWrM,resSrcM,aluOutM,memOutM,RdM,npcM};
            end
endmodule