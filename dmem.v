`timescale 1ns / 1ps

module dmem(
   input wire clk, 
   input wire we, //Active high
   input wire [31:0] addr, 
   input wire [31:0] wd, 
   output wire [31:0] rd_data
);
//256 words of 32-bit RAM (1KB data memory)
   reg [31:0] ram [0:255];

//synchronus write (sequential)
   always@(posedge clk) begin
      if(we) begin
         ram[ addr[9:2] ] <= wd;
      end
   end
   
//asynchronus read (combinational)
   assign rd_data = ram[ addr[9:2] ];
   
endmodule
