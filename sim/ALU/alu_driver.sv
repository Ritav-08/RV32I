`timescale 1ns/ 1ps

//==================================================
//alu_driver.sv
//Driver for alu of rv32i project
//==================================================

`ifndef ALU_DRIVER_SV
`define ALU_DRIVER_SV

class alu_driver;
   
//--------------------------------------------------
//statistics variable
//--------------------------------------------------
   int unsigned txn_count;  //can also use typedef, as it's declared in $unit
   
//--------------------------------------------------
//virtual interface
//--------------------------------------------------
   virtual interface alu_if.DRV vif;
   
//--------------------------------------------------
//mailbox
//--------------------------------------------------
   mailbox #(alu_transaction) gen2drv_mbx; 
   mailbox #(bit)             ack_mbx; 
   
//--------------------------------------------------
//constructor
//--------------------------------------------------
   function new(
      virtual interface alu_if.DRV vif, 
      mailbox #(alu_transaction)   gen2drv_mbx, 
      mailbox #(bit)               ack_mbx
   );
      this.vif         = vif;
      this.gen2drv_mbx = gen2drv_mbx;
      this.ack_mbx     = ack_mbx;
      this.txn_count   = 32'd0;
   endfunction : new
   
//--------------------------------------------------
//reset task
//--------------------------------------------------
//   task reset(
//      alu_transaction txn,
//      input int unsigned n = 2
//   );
//      //assert reset
//      $display("[DRV] Reset Asserted");
//      repeat(n) begin
//         #5;
//         txn.zero = 1'b0;
//         txn.alu_ctrl = 4'h0;
//         txn.a = 32'd0;
//         txn.b = 32'd0;
//         txn.alu_result = 32'd0;
//      end
//      //deassert reset
//      #5; 
//      $display("[DRV] Reset Deasserted");
      
//   endtask
   
//--------------------------------------------------
//run task
//--------------------------------------------------
   task run();
      alu_transaction txn;
      forever begin 
         txn = new();
         
         gen2drv_mbx.get(txn);
         drive(txn);

         txn.print("[DRV]");  //print values
         ack_mbx.put(1'b1);  //send acknowledgement
//         reset(txn, 2);  //reset txn
         
      end
   endtask : run
   
//--------------------------------------------------
//drive task
//--------------------------------------------------
   task drive(
      alu_transaction txn
   );
      vif.alu_ctrl   = txn.alu_ctrl;
      vif.a          = txn.a;
      vif.b          = txn.b;
      
      #5;  //settling delay for combinational logic
   endtask : drive
 
endclass : alu_driver 

`endif //ALU_DRIVER_SV