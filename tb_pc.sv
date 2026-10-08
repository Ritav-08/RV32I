`timescale 1ns / 1ps

module tb_pc(
   input logic [31:0] pc_out,
   output bit clk, 
   output logic rst_n, 
   output logic [31:0] pc_in
);
   
//DUT Instantiation...
   pc dut (.clk(clk), 
           .rst_n(rst_n), 
           .pc_in(pc_in), 
           .pc_out(pc_out)
          );
          
//Clock Generation...
   initial forever 
      #5 clk = ~clk;

//Applying Stimulus...
   initial begin
//Hold Reset : Active
          rst_n = 1'b0;
          pc_in = 32'h0000_0000;
//Free Reset
      #15 rst_n = 1'b1;
//Applying PC values
      #10 pc_in = 32'h0000_1804;
      #10 pc_in = 32'h0000_2009;
      #10 pc_in = 32'h1804_2009;
      #10 pc_in = 32'h1804_0000;
      #10 pc_in = 32'h4252_2009;
      #30 $finish;
   end
   
endmodule
