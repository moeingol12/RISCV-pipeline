`timescale 1ns/1ns
module RISCV (input clk, rst);
    wire [31:0] instMemF,pcF,npcF;//out IF
    wire [31:0] InstMemD,pcD,npcD;//out IF/ID
    wire [31:0] RD1D,RD2D,ImmD;wire [4:0] RdD,Rs1D,Rs2D; //out ID
    wire [31:0] pcE,RD1E,RD2E,ImmE,npcE;wire[4:0] RdE,Rs1E,Rs2E;wire [2:0] aluFuncE;wire[1:0] resSrcE;wire jSrcE,regWrE,
                                                                        memWrE,pcWrE,isBeqE,isBneqE,isBltE,isBgeE,AluSrcE;//out ID/EX
    wire [31:0] jpcE,aluOutE,memdE; wire zero; //out EX
    wire [31:0] aluOutM,memdM,npcM;wire [4:0] RdM;wire [1:0] resSrcM;wire memWrM,regWrM;//out E/M
    wire [31:0] memRdM; //out M
    wire [31:0] aluOutW,memOutW,npcW;wire [4:0] RdW;wire[1:0] resSrcW;wire regWrW; //out M/W
    wire [31:0] WdW; //out WB
    //out controllers
    wire en,pcSrcE; //IF
    wire stallD,flushD; // IF/ID
    wire [1:0] ImmSrcD;wire regWrD; //ID
    wire [2:0] aluFuncD;wire [1:0] resSrcD;wire jSrcD,memWrD,pcWrD,isBeqD,isBneqD,isBltD,isBgeD,AluSrcD, flushE; // ID/EX
    wire [1:0] forwardAE,forwardBE; //EX

    IF F(.clk(clk),.rst(rst),.jpcE(jpcE),.pcSrcE(pcSrcE),.en(en),.instMemF(instMemF),.pcF(pcF),.npcF(npcF));
    FDreg FDregister(.clk(clk),.rst(rst),.instMemF(instMemF),.pcF(pcF),.npcF(npcF),.stallD(stallD),.flushD(flushD),.InstMemD(InstMemD),.pcD(pcD),.npcD(npcD));
    ID D(.InstMemD(InstMemD),.RdW(RdW),.WdW(WdW),.ImmSrcD(ImmSrcD),.clk(clk),.regWrW(regWrW),.rst(rst),.RD1D(RD1D),
            .RD2D(RD2D),.ImmD(ImmD),.RdD(RdD),.Rs1D(Rs1D),.Rs2D(Rs2D));
    DEreg DEregister(clk,rst,pcD,RD1D,RD2D,ImmD,npcD,RdD,Rs1D,Rs2D,aluFuncD,resSrcD,
            jSrcD,regWrD,memWrD,pcWrD,isBeqD,isBneqD,isBltD,isBgeD,AluSrcD, flushE,
            pcE,RD1E,RD2E,ImmE,npcE,RdE,Rs1E,Rs2E, aluFuncE, resSrcE,
            jSrcE,regWrE,memWrE,pcWrE,isBeqE,isBneqE,isBltE,isBgeE,AluSrcE );
    EX E(aluFuncE,forwardAE,forwardBE,
        RD1E,RD2E,aluOutM,WdW,pcE,ImmE,AluSrcE,jSrcE,
        jpcE,aluOutE,memdE,zero);
    EMreg EMregister(clk ,rst,memWrE,regWrE,resSrcE,aluOutE,memdE,npcE,RdE,
             memWrM,regWrM,resSrcM,aluOutM,memdM,npcM,RdM   );
    M mem(clk,memWrM,memdM,aluOutM,memRdM);
    MWreg MWregister(clk,rst, regWrM,resSrcM,aluOutM,memRdM,npcM,RdM,
                    regWrW,resSrcW,aluOutW,memOutW,npcW,RdW);
    WB W(resSrcW,aluOutW,memOutW,npcW, WdW);

    Controller control(rst,
    InstMemD,RdD,Rs1D,Rs2D,Rs1E,Rs2E,RdM,RdW,RdE,
    zero,pcWrE,isBeqE,isBneqE,regWrM,isBltE,isBgeE,regWrW,resSrcE,resSrcM,
    en,pcSrcE, //IF
    stallD,flushD, // IF/ID
    ImmSrcD, //ID
    aluFuncD,resSrcD,jSrcD,regWrD,memWrD,pcWrD,isBeqD,isBneqD,isBltD,isBgeD,AluSrcD, flushE, // ID/EX
    forwardAE,forwardBE //EX
);
endmodule