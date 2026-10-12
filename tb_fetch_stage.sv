
`timescale 1ns / 1ps

module tb_fetch_stage;
   bit clk;
   bit rst_n;
   bit [31:0] pc_out;
   logic [31:0] mem_inst;

//instantiation
   fetch_stage fs_0 (.clk(clk), 
                     .rst_n(rst_n), 
                     .pc_out(pc_out), 
                     .mem_inst(mem_inst)
                    );

//clock generation
   initial begin
      clk = 1'b0;
      forever #5 clk = ~clk;
   end
   
//stimulus
   initial begin : stimulus_fs
   //monitor
   $monitor ("@%0t Reset: %0d | PCin: %0h, PCout: %0h, Instruction: %0h", $time, rst_n, fs_0.pc_0.pc_in, pc_out, mem_inst);
   
   //reset
          rst_n = 1'b0;
      #15 rst_n = 1'b1;
      
      #100 $finish;
      
   end : stimulus_fs
   
endmodule
