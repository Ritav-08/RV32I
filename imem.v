`timescale 1ns / 1ps

module imem(
   input wire [31:0] addr, 
   output wire [31:0] inst
);
   
   reg [31:0] rom [0: 255];
   
//Pre-load instructions from a hex file during simulation startup
   initial begin
   //   $readmemh("program.hex", rom);
   end   
   
//Combinational read: extract word index by shifting/dropping bottom 2 bits [31:2]
   assign inst = rom[ addr[9:2] ];
   
endmodule
