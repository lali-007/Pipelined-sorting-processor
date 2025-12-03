`timescale 1ns / 1ps

module Instruction_Fetch(
    input clk,
    input reset,
    output [31:0] Instruction
    );
    wire [63:0]out;
    wire [63:0]PC_out;
    reg [63:0]b = 64'd4;
    Adder Add(PC_out, b, out);
    Program_Counter PC(clk, reset, out, PC_out);
    Instruction_Memory IM(PC_out, Instruction);
endmodule

