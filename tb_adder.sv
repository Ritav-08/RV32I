`timescale 1ns / 1ps

module tb_adder(
   input bit [31:0] y, 
   output bit [31:0] a, 
   output bit [31:0] b
   );
   
//Instantiation
   adder adder_m1 (.y(y),
                   .a(a), 
                   .b(b)
                  );
                  
//Stimulus
   initial begin : stimulus_adder
      $monitor("%0t | A: %d, B: %d | Sum: %d", $time, a, b, y);
         a <= 32'h0000_0000;
         b <= 32'h0000_0000;
      #5 a <= 32'h0000_2009;
         b <= 32'h1804_0000;
      #5 a <= 32'h0000_1804;
         b <= 32'h1804_0000;
      #5 a <= 32'h1804_2009;
         b <= 32'h1804_0000;
      #5 a <= 32'h1804_2009;
         b <= 32'h1804_2009;
      #5 a <= 32'h2004_2009;
         b <= 32'h1804_0809;
      #5 a <= 32'h0809_2009;
         b <= 32'h1804_2004;
      #5 $finish;
   end : stimulus_adder
   
endmodule
