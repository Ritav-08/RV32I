`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2026 11:24:24 AM
// Design Name: 
// Module Name: fetch_stage
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fetch_stage(
   input wire clk, 
   input wire rst_n,
   output wire [31:0] pc_out,
   output wire [31:0] mem_inst
);

//internal wirings
   wire [31:0] pc_next; //addr_p4 -> pc_in (conditional connect in future)
   wire [31:0] addr_p4; //addr_y -> pc_next
   
   
//Adder_out as Next PC Instruction
   assign pc_next = addr_p4;
   
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
