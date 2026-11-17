`timescale 1ns/1ns
module EMreg(input clk,rst ,input memWrE,regWrE,input[1:0] resSrcE,                input[31:0]aluOutE,memdE,npcE,input[4:0]RdE,
             output logic memWrM,regWrM,output logic [1:0] resSrcM,output logic[31:0]aluOutM,memdM,npcM,output logic [4:0]RdM   );

             always@(posedge clk,posedge rst)begin
               if(rst) {memWrM,regWrM,resSrcM,aluOutM,memdM,RdM,npcM} <=0;
               else{memWrM,regWrM,resSrcM,aluOutM,memdM,RdM,npcM} <=  {memWrE,regWrE,resSrcE,aluOutE,memdE,RdE,npcE}  ;
             end

endmodule