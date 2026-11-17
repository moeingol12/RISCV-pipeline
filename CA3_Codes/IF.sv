`timescale 1ns/1ns
module IF(input clk, rst, input[31:0] jpcE, input pcSrcE, en,
          output[31:0] instMemF, pcF, npcF);
    
    wire[31:0] pcMuxOut, pcout, npc_internal;
    
    assign pcF = pcout;
    assign npcF = npc_internal;  // ← output
    
    Adder adder(.A(pcout), .B(32'd4), .addout(npc_internal));
    MUX2 pcmux(.if1(jpcE), .if0(npc_internal), .sel(pcSrcE), .muxout(pcMuxOut));
    PC pc(.en(en), .addr(pcMuxOut), .clk(clk), .rst(rst), .pcout(pcout));
    InstMem instMem(.addr(pcout),  .rd(instMemF));

endmodule