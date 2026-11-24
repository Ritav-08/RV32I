
`timescale 1ns / 1ps

module reg_file(
   input  wire clk, 
   input  wire rst_n, 
   input  wire we,         //Active high
   input  wire [4:0] rs1, 
   input  wire [4:0] rs2, 
   input  wire [4:0] rd, 
   input  wire [31:0] wd, 
   output wire [31:0] rd1, 
   output wire [31:0] rd2
);

//register file
   reg [31:0] rf [0:31];
   
   integer i;

//combinational read (x0 hardwired to 0)
   assign rd1 = (rs1 == 5'b0) ? 32'd0 : rf[rs1];
   assign rd2 = (rs2 == 5'b0) ? 32'd0 : rf[rs2];

//sequential write (x0 protected, cannot be overwritten)
   always@ (posedge clk, negedge rst_n) begin
      if(!rst_n) begin
         for(i = 0; i < 32; i = i + 1) begin
            rf[i] = 32'd0;
         end
      end
      else if(we && (rd != 5'b0)) begin
         rf[rd] <= wd;
      end
   end
   
endmodule
