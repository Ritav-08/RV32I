
`timescale 1ns / 1ps

module tb_alu;
   
   logic [31:0] a;
   logic [31:0] b;
   logic [3:0] alu_ctrl;
   logic [31:0] alu_result;
   logic zero;
   
//instantiation
   alu alu_0 (.a(a), 
              .b(b), 
              .alu_ctrl(alu_ctrl), 
              .alu_result(alu_result), 
              .zero(zero)
             );
   
   int count = 0;
   int pass  = 0;
   logic [31:0] exp_result = 32'b0;
   logic exp_zero = 1'b0;
   
//checker
   always@(a, b, alu_ctrl) begin : alu_sb
      case(alu_ctrl) 
         4'b0000 : begin exp_result = a + b; end
         4'b0001 : begin exp_result = a - b; end
         4'b0010 : begin exp_result = a & b; end
         4'b0011 : begin exp_result = a | b; end
         4'b0100 : begin exp_result = a ^ b; end
         4'b0101 : begin exp_result = a << b[4:0]; end
         4'b0110 : begin exp_result = a >> b[4:0]; end
         4'b0111 : begin exp_result = $signed(a) >>> b[4:0]; end
         4'b1000 : begin exp_result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0; end
         4'b1001 : begin exp_result = (a < b) ? 32'd1 : 32'd0; end
         default : begin exp_result = 32'h0000_0000; end
      endcase
      
      exp_zero = (exp_result == 32'd0);
      #0;
      if((zero == exp_zero) && (alu_result == exp_result)) begin
         pass++;
      end else begin
         $display("ERROR :: @%0t, OP: %0b, A: %0h, B: %0h | Result: %0h, Zf: %0b | Exp- R: %0h, Z: %0b", 
                $time, alu_ctrl, a, b, alu_result, zero, exp_result, exp_zero);
      end
   end : alu_sb
   
//stimulus
   static int num = 0;
   assign alu_ctrl = num;
   initial begin : stimulus_alu
      //monitor
      $monitor("@%0t, OP: %0b, A: %0h, B: %0h | Result: %0h, Zf: %0b",
                $time, alu_ctrl, a, b, alu_result, zero);
   
      //random stimulus generation
      for (int j = 0; j < 30; j++) begin : ctrl_op
         for (int i = 0; i < 3; i++) begin : operands
            a = $urandom_range(32'h0000_0000, 32'h1111_1111);
            b = $urandom_range(32'h0000_0000, 32'h1111_1111);
            #5 count++;
         end : operands
         num++;  //next operation @3stimulus consumed per op
      end : ctrl_op
      
      $display("===============================");
      $display("Count: %0d | Pass: %0d", count, pass);
      $display("===============================");
      #10 $finish;
      
   end : stimulus_alu
   
endmodule
