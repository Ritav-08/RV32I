
`timescale 1ns / 1ps

module fetch_stage(
   input wire clk, 
   input wire rst_n,
   input wire pc_src,
   input wire [31:0] pc_target,  //imm_out
   output wire [31:0] pc_out,
   output wire [31:0] mem_inst, 
   output wire [31:0] pc_plus4
);

//internal wirings
   wire [31:0] pc_next; //addr_p4 -> pc_in (conditional connect in future)
   wire [31:0] addr_p4; //addr_y -> pc_next
   
   
//Combinational assignments
   assign pc_next = pc_src ? pc_target : addr_p4;
   assign pc_plus4 = addr_p4;
   
   pc pc_0 (.clk(clk), 
            .rst_n(rst_n), 
            .pc_in(pc_next), 
            .pc_out(pc_out)
           );
           
   adder addr_0 (.a(pc_out), 
                 .b(32'd4), 
                 .y(addr_p4)
                );
                
   imem rom_0 (.addr(pc_out), 
               .inst(mem_inst) //module output
              );
   
endmodule
