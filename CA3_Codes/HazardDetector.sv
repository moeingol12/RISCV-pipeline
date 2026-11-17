`timescale 1ns/1ns
module hazardDet(input pcSrcE,regWrM,regWrW,input[4:0] RdD,Rs1D,Rs2D,Rs1E,Rs2E,RdM,RdW,RdE,input [1:0] resSrcE,resSrcM,
    output logic flushE,flushD,stallD,en,output logic[1:0] forwardAE,forwardBE ,input rst );
    
    always@(pcSrcE,regWrM,regWrW,RdD,Rs1D,Rs2D,Rs1E,Rs2E,RdM,RdW,resSrcE,RdE,posedge rst)begin
        {flushE,flushD,stallD,en,forwardAE,forwardBE} = 8'd0 ;
        
        if(rst)
        {flushE,flushD,stallD,en,forwardAE,forwardBE} = 8'd0 ;
        //handle RT
        else begin
            if(regWrM ==1 && Rs1E==RdM && Rs1E != 0) forwardAE =2'b01;
            else if(regWrW ==1 && Rs1E==RdW && Rs1E != 0) forwardAE = 2'b10;
            if(regWrM ==1 && Rs2E==RdM && Rs2E != 0) forwardBE =2'b01;
            else if(regWrW ==1 && Rs2E==RdW && Rs2E != 0) forwardBE = 2'b10;
            //handle Lw
            if((Rs1D == RdE || Rs2D == RdE) && resSrcE ==2'b01 && RdE != 0 ) {stallD,en,flushE}=3'b111;
            else if((Rs1D == RdM || Rs2D == RdM) && resSrcM==2'b01 && RdM != 0) {stallD,en,flushE}=3'b111;
            //handle jumps means branches or jalr or jal
            if(pcSrcE ==1 ) {flushD,flushE} = 2'b11;
        end
    end


endmodule