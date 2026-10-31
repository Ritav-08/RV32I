
`timescale 1ns / 1ps

module reg_file(
   input  wire clk, 
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

//combinational read (x0 hardwired to 0)
   assign rd1 = (rs1 == 5'b0) ? 32'h0000_0000 : rf[rs1];
   assign rd2 = (rs2 == 5'b0) ? 32'h0000_0000 : rf[rs2];

//sequential write (x0 protected, cannot be overwritten)
   always@ (posedge clk) begin
      if(we && (rd != 5'b0)) begin
         rf[rd] <= wd;
      end
   end
   
endmodule
