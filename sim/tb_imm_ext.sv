
`timescale 1ns / 1ps

module tb_imm_ext;
   
   logic [31:0] inst;
   logic [2:0] imm_sel;
   logic [31:0] imm_out;
   
   static int num = 0; //change imm_sel in for loop
   logic [31:0] exp_out; 
   int count = 0;
   int pass  = 0;
   int fail  = 0;
   
//DUT instantition
   imm_ext iext_0 (.inst(inst), 
                    .imm_sel(imm_sel), 
                    .imm_out(imm_out)
                   );
                   
//checker
   always@(imm_sel) begin : checker_imm
   //expected result
      case (imm_sel)
         3'b000 : exp_out = {{20{inst[31]}}, inst[31:20]};                                         //I
         3'b001 : exp_out = {{20{inst[31]}}, inst[31:25], inst[11:7]};                             //S
         3'b010 : exp_out = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};    //B
         3'b100 : exp_out = {inst[31:12], 12'b0};                                                  //U
         3'b101 : exp_out = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};  //J
         default : exp_out = 32'h0000_0000;
      endcase
      
   //checking
      #0;
      if(imm_out == exp_out) begin
         pass++;
      end else begin
         fail++;
         $display("ERROR :: @%0t IS: %0b, Inst: %0b | Imm: %0b", 
                $time, imm_sel, inst, imm_out);
      end
   end : checker_imm
   
//Stimulus
   initial begin : stimulus_logic
   //monitor
      $monitor("@%0t IS: %0b, Inst: %0b | Imm: %0b", 
                $time, imm_sel, inst, imm_out);
      
   //stimulus generation
      for(int i = 0; i < 10; i++) begin : gen_stimulus
         inst = $urandom_range(32'h0000_0000, 32'h1111_1111);
      //@5select per instruction
         for(int j = 0; j < 5; j++) begin : gen_sel
            imm_sel = num;
            #5 num++;
            count++;         
         end : gen_sel
         
         num = 0;
      end : gen_stimulus
      
   //scoreboard
      $display("===================================================");
      $display("Count: %d | Pass: %d | Fail: %d", count, pass, fail);
      $display("==================================================="); 
      #20 $finish;
   end : stimulus_logic
   
endmodule
