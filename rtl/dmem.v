
`timescale 1ns / 1ps

module dmem #(parameter MEM_WORDS = 256)(
   input wire clk, 
   input wire we, //Active high
   input wire [31:0] addr, 
   input wire [31:0] wd, 
   output wire [31:0] rd_data
);
//256 words of 32-bit RAM (1KB data memory)
   reg [31:0] ram [0:MEM_WORDS - 1];
   
   integer i;

//synchronus write (sequential)
   always@(posedge clk) begin
      if(we) begin
         ram[ addr[31:2] ] <= wd;
      end
   end
   
//asynchronus read (combinational)
   assign rd_data = ram[ addr[31:2] ];
   
   initial begin
      for(i = 0; i < MEM_WORDS; i = i + 1) begin 
         ram[i] = 32'd0;
      end 
   end
   
endmodule
