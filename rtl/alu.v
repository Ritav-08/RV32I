   
`timescale 1ns / 1ps

localparam ADD  = 4'b0000, 
           SUB  = 4'b0001, 
           AND  = 4'b0010, 
           OR   = 4'b0011, 
           XOR  = 4'b0100, 
           SLL  = 4'b0101, 
           SRL  = 4'b0110, 
           SRA  = 4'b0111, 
           SLT  = 4'b1000, 
           SLTU = 4'b1001;

module alu(
   input wire [31:0] a, 
   input wire [31:0] b, 
   input wire [3:0] alu_ctrl,
   output reg [31:0] alu_result,
   output wire zero
);
   
   assign zero = (alu_result == 32'h0000_0000)? 1'b1 : 1'b0;
   
   always@(*) begin
      case(alu_ctrl)                                                   //parameter value
         ADD : alu_result = a + b;                                     //0000
         SUB : alu_result = a - b;                                     //0001
         AND : alu_result = a & b;                                     //0010
         OR  : alu_result = a | b;                                     //0011
         XOR : alu_result = a ^ b;                                     //0100
         SLL : alu_result = a << b[4:0];                               //0101
         SRL : alu_result = a >> b[4:0];                               //0110
         SRA : alu_result = $signed(a) >>> b[4:0];                     //0111
         SLT : alu_result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0; //1000
         SLTU: alu_result = (a < b) ? 32'd1 : 32'd0;                   //1001
         default: alu_result = 32'h0000_0000; 
      endcase
   end
   
endmodule
