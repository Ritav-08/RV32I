
`timescale 1ns / 1ps

module imem(
   input wire [31:0] addr, 
   output wire [31:0] inst
);
   
   reg [31:0] rom [0: 255];
   
//Pre-load instructions from a hex file during simulation startup
   initial begin
   //read from a file
   // $readmemh("program.hex", rom);
   
   //hardcoded
      rom[0]  = 32'h1234_5678;
      rom[1]  = 32'hAABB_CCDD;
      rom[2]  = 32'h0000_0013;
      rom[3]  = 32'h0000_0093;
      rom[4]  = 32'h0000_0113;
      rom[5]  = 32'h1804_2009;
      rom[6]  = 32'h0000_2009;
      rom[7]  = 32'h0000_1804;
      rom[8]  = 32'h1804_0000;
      rom[9]  = 32'h2009_1804;
      rom[10] = 32'h0000_0000;
      rom[11] = 32'hFFFF_FFFF;
      rom[12] = 32'hABCD_EF09;
      
   //random
   
   // for(int i = 0; i < 256; i++);
   //    begin
   //       rom[i] = urandom_range(32'h0000_0000, 32'hFFFF_FFFF);
   //    end 
   
   end   
   
//Combinational read: extract word index by shifting/dropping bottom 2 bits [31:2]
   assign inst = rom[ addr[9:2] ];
   
endmodule
