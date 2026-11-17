`timescale 1ns/1ns
module Controller (input rst,
    input [31:0] instMem,input[4:0] RdD,Rs1D,Rs2D,Rs1E,Rs2E,RdM,RdW,RdE,
    input zero,pcWrE,isBeqE,isBneqE,regWrM,isBltE,isBgeE,regWrW,input[1:0] resSrcE,resSrcM,
    output en,output logic pcSrcE, //IF
    output stallD,flushD, // IF/ID
    output logic [1:0]  ImmSrcD, //ID
    output logic [2:0]  aluFuncD,output logic [1:0] resSrcD,output logic jSrcD,regWrD,memWrD,pcWrD,output logic isBeqD,isBneqD,isBltD,isBgeD,AluSrcD,output flushE, // ID/EX
    output [1:0] forwardAE,forwardBE //EX
);
    hazardDet Det(pcSrcE,regWrM,regWrW,RdD,Rs1D,Rs2D,Rs1E,Rs2E,RdM,RdW,RdE,resSrcE,resSrcM,
    flushE,flushD,stallD,en,forwardAE,forwardBE, rst);
    wire [6:0] opc,func7;wire[2:0] func3;
    assign opc = instMem[6:0];
    assign func3 = instMem[14:12];
    assign func7 = instMem[31:25];
    always @(opc, func7, func3,posedge rst) begin
        {jSrcD,  regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_0_0_0_0_00_000_00;
        {isBeqD,isBneqD,isBltD,isBgeD} = 4'b0000;
        pcWrD =0;
        if(rst)begin
        {jSrcD,  regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_0_0_0_0_00_000_00;
        {isBeqD,isBneqD,isBltD,isBgeD} = 4'b0000;
        pcWrD =0;
        end
        else begin
            if (opc == 51 && func3 == 0 && func7 == 0)          // add
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_1_0_0_00_000_00;

            else if (opc == 51 && func3 == 0 && func7 == 32)    // sub
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_1_0_0_00_001_00;

            else if (opc == 51 && func3 == 7 && func7 == 0)     // and
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_1_0_0_00_010_00;

            else if (opc == 51 && func3 == 6 && func7 == 0)     // or
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_1_0_0_00_011_00;

            else if (opc == 51 && func3 == 2 && func7 == 0)     // slt
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_1_0_0_00_101_00;

            else if (opc == 3 && func3 == 2)                    // lw
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_1_0_1_01_000_00;

            else if (opc == 19 && func3 == 0)                   // addi
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_1_0_1_00_000_00;

            else if (opc == 19 && func3 == 4)                   // 0ori
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_1_0_1_00_100_00;

            else if (opc == 19 && func3 == 6)                   // ori
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_1_0_1_00_011_00;

            else if (opc == 19 && func3 == 2)                   // slti
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_1_0_1_00_101_00;

            else if (opc == 103 && func3 == 0)                  // jalr
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD,pcWrD} = 12'b1_1_0_1_10_000_00_1;

            else if (opc == 35 && func3 == 2)                   // sw
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD} = 11'b0_0_1_1_00_000_01;

            else if (opc == 111)                                // jal
                { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD,pcWrD} = 12'b0_1_0_0_10_000_11_1;

            else if (opc == 99 && func3 == 0)                   // beq
            { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD,isBeqD} = {  1'b0, 3'b0_0_0, 2'b00, 3'b001, 2'b10,1'b1};

            else if (opc == 99 && func3 == 1)                   // bne
            { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD,isBneqD} = { 1'b0, 3'b0_0_0, 2'b00, 3'b001, 2'b10,1'b1};

            else if (opc == 99 && func3 == 4)                   // blt
            { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD,isBltD} = {   1'b0, 3'b0_0_0, 2'b00, 3'b101, 2'b10,1'b1};

            else if (opc == 99 && func3 == 5)                   // bge
            { jSrcD,   regWrD, memWrD, AluSrcD, resSrcD, aluFuncD, ImmSrcD,isBgeD} = {   1'b0, 3'b0_0_0, 2'b00, 3'b101, 2'b10,1'b1};
        end
    end
    always@(pcWrE,isBeqE,isBneqE,isBltE,isBgeE,zero )begin
         pcSrcE = pcWrE ||(isBeqE && zero) || (isBneqE && ~zero) || (isBltE && ~zero) || (isBgeE && zero);
    end


endmodule