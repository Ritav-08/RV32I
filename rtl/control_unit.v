
`timescale 1ns / 1ps

module control_unit(
   input wire [6:0] op, 
   input wire [2:0] funct3, //inst[14:12]
   input wire funct7b5,     //inst[30]
   
   output wire [2:0] imm_src, 
   output wire reg_write, 
   output wire result_src, 
   output wire mem_write, 
   output wire [3:0] alu_ctrl, 
   output wire alu_src, 
   output wire branch, 
   output wire jump
);

//Internal intermediate control signals
   reg [1:0] alu_op;
   reg alu_src_reg;
   reg reg_write_reg;
   reg [3:0] alu_ctrl_reg;
   reg [2:0] imm_src_reg;
   reg mem_write_reg;
   reg result_src_reg;
   reg branch_reg;
   reg jump_reg;
   
//Parameters
   parameter r_type  = 7'b0110011, //r_r
             ia_type = 7'b0010011, //ALU
             il_type = 7'b0000011, //Load
             s_type  = 7'b0100011, //sw
             b_type  = 7'b1100011, //beq, bne
             j_type  = 7'b1101111; //jal
   
//Main Decoder
   always@(*) begin
   //default values to prevent accidental latches
      alu_op         = 2'b00;
      imm_src_reg    = 3'b000;
      reg_write_reg  = 1'b0;
      result_src_reg = 1'b0;
      mem_write_reg  = 1'b0;
      alu_ctrl_reg   = 4'b0000;
      alu_src_reg    = 1'b0;
      branch_reg     = 1'b0;
      jump_reg       = 1'b0;
      
      case(op)
         r_type: begin
            alu_src_reg   = 1'b0;
            reg_write_reg = 1'b1;
            alu_op        = 2'b10;
         end 
         ia_type: begin
            alu_src_reg   = 1'b1;
            reg_write_reg = 1'b1;
            alu_op        = 2'b10;
         end 
         il_type: begin
            imm_src_reg    = 3'b000;
            alu_src_reg    = 1'b1;
            alu_ctrl_reg   = 4'b0000;
            mem_write_reg  = 1'b0;
            result_src_reg = 1'b1;
            reg_write_reg  = 1'b1;
         end 
         s_type: begin
            imm_src_reg   = 3'b001;
            alu_src_reg   = 1'b1;
            alu_ctrl_reg  = 4'b0000;
            mem_write_reg = 1'b1;
            reg_write_reg = 1'b0;
         end 
         b_type: begin
            imm_src_reg = 3'b010;
            alu_op      = 2'b01;
            branch_reg  = 1'b1;
         end 
         j_type: begin 
            imm_src_reg   = 3'b101;
            jump_reg      = 1'b1;
            reg_write_reg = 1'b1;
         end default: ;
      endcase
   end
   
//ALU Decoder
   always@(*) begin
      case(alu_op)
         2'b00: begin 
            alu_ctrl_reg = 4'b0000; //add
         end 
         2'b01: begin 
            alu_ctrl_reg = 4'b0001; //sub
         end 
         2'b10: begin
            case(funct3)
               3'b000: alu_ctrl_reg = (op == 7'b0110011 && (funct7b5)) ? 4'b0001 : 4'b0000; //sub, add
               3'b111: alu_ctrl_reg = 4'b0010; //and
               3'b110: alu_ctrl_reg = 4'b0011; //or
               3'b100: alu_ctrl_reg = 4'b0100; //xor
               3'b001: alu_ctrl_reg = 4'b0101; //sll
               3'b101: alu_ctrl_reg = (funct7b5) ? 4'b0111 : 4'b0110; //sra, srl
               3'b010: alu_ctrl_reg = 4'b1000; //slt
               3'b011: alu_ctrl_reg = 4'b1001; //sltu
               default:  alu_ctrl_reg = 4'b0000;
            endcase
         end
      endcase
   end
   
//reg to wire connections
   assign alu_src    = alu_src_reg;
   assign reg_write  = reg_write_reg;
   assign alu_ctrl   = alu_ctrl_reg;
   assign imm_src    = imm_src_reg;
   assign mem_write  = mem_write_reg;
   assign result_src = result_src_reg;
   assign branch     = branch_reg;
   assign jump       = jump_reg;
 
endmodule
