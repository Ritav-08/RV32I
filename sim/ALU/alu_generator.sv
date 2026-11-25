`timescale 1ns/ 1ps
typedef int unsigned uint;

//==================================================
//alu_generator.sv
//Generator class for alu of rv32i project
//==================================================

`ifndef ALU_GENERATOR_SV
`define ALU_GENERATOR_SV

class alu_generator;
   
//--------------------------------------------------
//statistics variable
//--------------------------------------------------
   int unsigned txn_count;  //can also use typedef : uint txn_count;
   bit ack_var;  //ack_mbx receive value 1 in here when driver done driving...

//--------------------------------------------------
//mailboxes
//--------------------------------------------------
   mailbox #(alu_transaction) gen2drv_mbx;
   mailbox #(bit)             ack_mbx;   
   
//--------------------------------------------------
//constructor
//--------------------------------------------------
   function new(
      mailbox #(alu_transaction) gen2drv_mbx, 
      mailbox #(bit)             ack_mbx
   );
      this.gen2drv_mbx = gen2drv_mbx;
      this.ack_mbx     = ack_mbx;
      this.txn_count   = 32'd0;  //no need to initialize, cause it's already 2 state, same as bit
      this.ack_var     = 1'b0;  //but it's more like reset
   endfunction : new
   
//--------------------------------------------------
//run task
//--------------------------------------------------
   task run(
      input int unsigned rand_num,  //number of randomized txns to sent to the driver
      input [3:0]        alu_ctrl[],  //manual inputs in case of non randomized test cases
      input [31:0]       a[],  //need a construct to check array size before accesing invalid index in loop (done)
      input [31:0]       b[],
      input int unsigned n = rand_num  //number of txns to sent to driver
   );
      alu_transaction txn;
      
      if(alu_ctrl.size < n || a.size < n || b.size < n) begin  //less array.size than loop variable
         $display("[GEN] Manual Input Array Size (no. of values) is less than Intended size (no. of txns)"); 
      end
      
      //manual transactions using input arrays
      if(!rand_num) begin 
         for(int i = 0; i < n; i++) begin 
            //proceeding if Ctrl is valid
            if(alu_ctrl[i] inside {[4'b0000 : 4'b1001]}) begin 
               txn = new();
               txn_count++;
               
               txn.alu_ctrl = alu_ctrl[i];
               txn.a        = a[i];
               txn.b        = b[i];
                
               gen2drv_mbx.put(txn.clone());
            end 
            //proceeding if Ctrl is invalid (unsupported by alu)
            else begin 
               $display("[GEN] The current value %0b of ALU_Ctrl at Index %d is invalid", 
                  alu_ctrl[i], i);
               continue;
            end
         end 
      end 
      //randomized transactions using .randomize()
      else begin : rand_txn
         for(int i = 0; i < n; i++) begin 
            txn = new();
            txn_count++;
            
            assert(txn.randomize())
            else begin 
               $fatal(0, "[GEN] Randomization failed at Index: %d", i);
            end
               
            gen2drv_mbx.put(txn.clone());
         end 
      end : rand_txn
      //waiting for all the acknowledgements to return
      wait_ack(txn_count);
      $display("[GEN] Generation done");
      
   endtask : run 
   
//--------------------------------------------------
//drive task
//--------------------------------------------------
//   task drive(/*arguments*/);
//      alu_transaction txn = new();
//      gen2drv_mbx.put(txn.clone());
//   endtask
   
//--------------------------------------------------
//ack task
//--------------------------------------------------
   task wait_ack(int unsigned n = txn_count);
      repeat(n) begin
         ack_mbx.get(ack_var);
      end
   endtask : wait_ack 
   
endclass 

`endif //ALU_GENERATOR_SV