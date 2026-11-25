`timescale 1ns/ 1ps

//==================================================
//alu_if.sv
//Interface for alu of rv32i project
//==================================================

interface alu_if;
   logic        zero; 
   logic [3:0]  alu_ctrl; 
   logic [31:0] a;
   logic [31:0] b; 
   logic [31:0] alu_result; 
   
//--------------------------------------------------
//modports
//--------------------------------------------------
   modport DRV (input a, b, alu_ctrl, output zero, alu_result);
   modport MON (input zero, alu_ctrl, a, b, alu_result); 
   
endinterface 
