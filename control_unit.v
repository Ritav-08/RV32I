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
   
   
   always@(*) begin
      case(op)
      //R-Type :: register to register operations (10)
         7'b0110011: begin
            case(funct3)
               3'b000: begin 
                  if(funct7b5) begin //SUB
                     
                  end else begin //ADD
                     
                  end
               end 3'b001: begin //SLL
                  
               end 3'b010: begin //SLT
                  
               end 3'b011: begin //SLTU
                  
               end 3'b100: begin //XOR
                  
               end 3'b101: begin 
                  if(funct7b5) begin //SRA
                     
                  end else begin //SRL
                     
                  end
               end 3'b110: begin //OR
                  
               end 3'b111: begin //AND
               
               end default ; //default R-Type
            endcase
         end
         
      //I-Type (15)
         //immediate arithematic and logical operations (6)
         7'b0010011: begin
            case(funct3)
               3'b000: begin //ADDI
                  
               end 3'b010: begin //begin
                  
               end 3'b011: begin //SLTIU
                  
               end 3'b100: begin //XORI
                  
               end 3'b110: begin //ORI
                  
               end 3'b111: begin //ANDI
               
               end default ; //default I-Type
            endcase
         end
         //immediate shift operations (3)
         7'b0010011: begin
            case(funct3)
               3'b001: begin //SLLI
                  
               end 3'b101: begin //SRLI
                  
               end 3'b101: begin //begin
                  
               end default ;
            endcase
         end
         //load instructions (5)
         7'b000011: begin
            case(funct3)
               3'b000: begin //LB
                  
               end 3'b001: begin //LH
                  
               end 3'b010: begin //LW
                  
               end 3'b100: begin //LBU
                  
               end 3'b101: begin //LHU
                  
               end default ; //default
            endcase
         end
         //idirect jump (1)
         7'b1100111: begin //JALR
            
         end
         
      //S-Type :: store instructions (3)
         7'b0100011: begin
            case(funct3)
               3'b000: begin //SB
               
               end 3'b001: begin //SH
               
               end 3'b010: begin //SW
               
               end default ; //default
            endcase
         end
         
      //B-Type :: conditional branch instructions (6)
         7'b1100011: begin
            case(funct3)
               3'b000: begin //BEQ
               
               end 3'b001: begin //BNE
               
               end 3'b100: begin //BLT
               
               end 3'b101: begin //BGE
               
               end 3'b110: begin //BLTU
               
               end 3'b111: begin //BGEU
               
               end default ; //default
            endcase
         end
         
      //U-Type :: upper immediate instructions (2)
         7'b0110111: begin //LUI
         
         end
         7'b0010111: begin //AUIPC
         
         end
         
      //J-Type :: direct jump (1)
         7'b1101111: begin //JAL
         
         end
      //Additional Base Instructions :: fence and system (3)
         //memory ordering (1)
         7'b0001111: begin //FENCE (funct3 == 000, !funct3)
         
         end
         //environment and breakpount (2)
         7'b1110011: begin //ECALL (!funct3) (imm[11:0] == 000000000000)
         
                           //EBREAK (!funct3) (imm[11:0] == 000000000001)
         
         end
      //Default
         default: ;
      endcase
   end
   
endmodule
