
`timescale 1ns / 1ps

module imem #( parameter MEM_WORDS = 256 ) 
(
   input wire [31:0] addr, 
   output wire [31:0] inst
);
   
   reg [31:0] rom [0: MEM_WORDS - 1];
   
   //loop variable
   integer i;
   
// ----- Pre-load instructions from a hex file during simulation startup -----
   initial begin
   
   // --- READ FROM A FILE ---
//   $readmemh("program.hex", rom);

   // --- RANDOM MEMORY VALUES ---
   for(i = 0; i < MEM_WORDS; i = i + 1) begin
         rom[i] = 32'h00000013;
   end 
   
   end   
   
//Combinational read: extract word index by shifting/dropping bottom 2 bits [31:2]
   assign inst = rom[ addr[9:2] ];
   
endmodule
