`timescale 1ns/ 1ps

//==================================================
//alu_transaction.sv
//Transaction class for alu of rv32i project
//==================================================

`ifndef ALU_TRANSACTION_SV
`define ALU_TRANSACTION_SV

class alu_transaction;
   
   bit zero;
   rand bit [3:0]  alu_ctrl;
   rand bit [31:0] a;
   rand bit [31:0] b;
   bit      [31:0] alu_result; 
   
   bit             exp_zero;
   bit      [31:0] exp_alu_result;
   
//--------------------------------------------------
//constraint
//--------------------------------------------------
   constraint define_ctrl_range{
      alu_ctrl inside {[4'b0000 : 4'b1001]};
   }
   
//--------------------------------------------------
//constructor  //no need to initialize though, cause i already used bit type
//--------------------------------------------------
   function new();
      alu_ctrl = 4'h0;
      a        = 32'd0;
      b        = 32'd0;
   endfunction : new
   
//--------------------------------------------------
//clone function
//--------------------------------------------------
   function alu_transaction clone();
      alu_transaction copy;
      copy            = new();
      copy.zero       = this.zero;
      copy.alu_ctrl   = this.alu_ctrl;
      copy.a          = this.a;
      copy.b          = this.b;
      copy.alu_result = this.alu_result;
      return copy;
   endfunction : clone 
   
//--------------------------------------------------
//print function
//--------------------------------------------------
   function print(
      input string str = " "
   );
      $display("@%0t [%0s-TR] Ctrl: %0b, A: %0b, B: %0b | Result: %0b, Zero: %0b | ExpResult: %0b, ExpZero: %0b", 
         $time, str, alu_ctrl, a, b, alu_result, zero, exp_alu_result, exp_zero);
   endfunction : print
   
endclass : alu_transaction

`endif //ALU_TRANSACTION_SV
