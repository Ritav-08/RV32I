`timescale 1ns / 1ps

module control_unit(
   input wire [6:0] op, 
   input wire [3:0] funct3, 
   input wire funct7b5,
   output wire [31:0] pc_b, 
   output wire [2:0] imm_src, 
   output wire reg_write, 
   output wire result_src, 
   output wire mem_write, 
   output wire [3:0] alu_ctrl, 
   output wire alu_src, 
   output wire branch, 
   output wire jump
);

//intermediate wirings
   reg [31:0] pc_j;
   reg [1:0] alu_op;
   
//parameters

//Main Decoder
   always@(*) begin
      case(op)
      //R-Type :: register to register operations (10)
         7'b0110011: ;
      //I-Type (15)
         //immediate arithematic and logical operations (6)
         7'b0010011: ;
         //immediate shift operations (3)
         7'b0010011: ;
         //load instructions (5)
         7'b000011: ;
         //idirect jump (1)
         7'b1100111: ;
      //S-Type :: store instructions (3)
         7'b0100011: ;
      //B-Type :: conditional branch instructions (6)
         7'b1100011: ;
      //U-Type :: upper immediate instructions (2)
         //LUI
         7'b0110111: ;
         //AUIPC
         7'b0010111: ;
      //J-Type :: direct jump (1)
         7'b1101111: ;
      //Additional Base Instructions :: fence and system (3)
         //memory ordering (1)
         7'b0001111: ;
         //environment and breakpount (2)
         7'b1110011: ;
      //Default
         default: ;
      endcase
   end
   
endmodule
