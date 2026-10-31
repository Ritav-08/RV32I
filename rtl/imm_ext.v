
`timescale 1ns / 1ps
   
module imm_ext(
   input wire [31:0] inst, 
   input wire [2:0] imm_sel, 
   output reg [31:0] imm_out
);

//parameters
   parameter I = 3'b000, 
             S = 3'b001,
             B = 3'b010,
             U = 3'b100, 
             J = 3'b101;
   
   always@(*) begin
      case (imm_sel)
         I : imm_out = {{20{inst[31]}}, inst[31:20]};
         S : imm_out = {{20{inst[31]}}, inst[31:25], inst[11:7]};
         B : imm_out = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
         U : imm_out = {inst[31:12], 12'b0};
         J : imm_out = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
         default : imm_out = 32'h0000_0000;
      endcase
   end
   
endmodule
