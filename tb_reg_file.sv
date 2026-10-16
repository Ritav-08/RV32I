`timescale 1ns / 1ps

module tb_reg_file();

   bit clk;
   bit we;
   bit [4:0] rs1;
   bit [4:0] rs2;
   bit [4:0] rd;
   bit [31:0] wd;
   logic [31:0] rd1;
   logic [31:0] rd2;

//instantiation
   reg_file rf_0 (.clk(clk), 
                  .we(we), 
                  .rs1(rs1), 
                  .rs2(rs2), 
                  .rd(rd), 
                  .wd(wd), 
                  .rd1(rd1), 
                  .rd2(rd2)
                 );
                 
//clock generation
   initial begin
      clk = 1'b0;
      forever #5 clk = ~clk; //bit type, initialized to 0
   end
   
   int pass, count;
   
//checker
   always@(posedge clk) begin : write_s
         count++;
         if(rf_0.rf[rd] == wd);
            pass++;
   end : write_s
   
   always@(rs1 | rs2) begin : read_s
      count++;
      if( rd1 == rf_0.rf[rs1] && rd2 == rf_0.rf[rs2])
         pass++;
   end : read_s
   
//stimulus
   initial begin : stimulus_rf
      $monitor("@%0t clk: %0b, we: %0b | \nrs1: %0d, rd1: %0h, rs2: %0d, rd2: %0h, rf1[%0d]: %0h, rf2[%0d|: %0h |\nrd: %0d wd: %0h rf[%0d]: %0h", 
                $time, clk, we, 
                rs1, rd1, rs2, rd2, rs1, rf_0.rf[rs1], rs2, rf_0.rf[rs2], 
                rd, wd, rd, rf_0.rf[rd]);
   //WRITE
      //write disable
          we = 1'b0;
      //write enable
      #15 we = 1'b1;  //@15
      //initialized ram
      for(int k = 0; k < 32; k++) begin
         rf_0.rf[k] = 32'h0000_0000;
      end
      #5; //@20
      //random register write
      for (int i = 0; i < 10; i++) begin : write
         #10 rd = $urandom_range(0, 5'b1_1111);
             wd = $urandom_range(0, 32'h1111_1111);
      end : write
      //write disable
      #10 we = 1'b0; //@130
      
   //READ
      //random register read
      for (int j = 0; j < 10; j++) begin : read        
         #5 rs1 = $urandom_range(0, 5'b1_1111);
            rs2 = $urandom_range(0, 5'b1_1111);
      end : read
      
      $display("Count: %d, Pass: %d", count, pass);
      #10 $finish; //@190
   end : stimulus_rf


endmodule
