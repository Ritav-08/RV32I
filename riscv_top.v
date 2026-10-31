
`timescale 1ns / 1ps

module riscv_top(
   input wire clk,
   input wire rst_n, 
   
   output wire [31:0] pc_out, 
   output wire [31:0] alu_result_debug 
);
   
//Intermediate wirings
   wire [31:0] inst;          //u_fetch :: u_control :: u_inst
   wire [2:0] imm_src;        //u_control :: u_imm_ext
   wire reg_write;            //u_control :: u_reg_file
   wire result_src;           //u_control :: u_wb_mux
   wire mem_write;            //u_control :: u_dmem
   wire [3:0] alu_ctrl;       //u_control :: u_alu
   wire alu_src;              //u_control :: alu_src_b
   wire branch;               //u_control :: FLAGS
   wire jump;                 //u_control :: FLAGS
   wire [4:0] rs1, rs2, rd;   //u_inst :: u_reg_file
   wire [31:0] wd, rd1, rd2;  //u_reg_file :: alu_src_b :: u_dmem :: u_wb_mux
   wire [31:0] imm_out;       //u_imm_ext :: alu_src_b
   wire [31:0] alu_b;         //alu_src_b :: u_alu
   wire zero;                 //FLAGS
   wire [31:0] rd_data;       //u_dmem :: u_wb_mux
   wire [31:0] alu_result;    //u_alu :: u_dmem :: MONITOR
   
   
//Components wired together
   fetch_stage u_fetch(.clk(clk), 
                       .rst_n(rst_n), 
                       .pc_out(pc_out), 
                       .mem_inst(inst)
                      );
   
   control_unit u_control (.op(inst[6:0]), 
                           .funct3(inst[14:12]), 
                           .funct7b5(inst[30]), 
                           .imm_src(imm_src), 
                           .reg_write(reg_write), 
                           .result_src(result_src), 
                           .mem_write(mem_write), 
                           .alu_ctrl(alu_ctrl), 
                           .alu_src(alu_src), 
                           .branch(branch), 
                           .jump(jump)
                          );
   
   //Instruction Decoder (u_inst)
   assign rs1 = inst[19:15];
   assign rs2 = inst[24:20];
   assign rd = inst[11:7];
   
   reg_file u_reg_file (.clk(clk), 
                        .we(reg_write), 
                        .rs1(rs1), 
                        .rs2(rs2), 
                        .rd(rd), 
                        .wd(wd), 
                        .rd1(rd1), 
                        .rd2(rd2)
                       );
   
   imm_ext u_imm_ext (.inst(inst), 
                      .imm_sel(imm_src), 
                      .imm_out(imm_out)
                     );
   
   //source multiplexer (alu_src_b) for ALU
   assign alu_b = alu_src ? imm_out : rd2;
   
   alu u_alu (.a(rd1), 
              .b(alu_b), 
              .alu_ctrl(alu_ctrl),
              .alu_result(alu_result),
              .zero(zero)
             );
   
   dmem u_dmem (.clk(clk), 
                .we(mem_write), 
                .addr(alu_result), 
                .wd(rd2), 
                .rd_data(rd_data)
               );
   
   //writeback mux (u_wb_mux) for reg_file
   assign wd = result_src ? rd_data : alu_result;
   
   //alu immediate result debug monitor
   assign alu_result_debug = alu_result;

endmodule
