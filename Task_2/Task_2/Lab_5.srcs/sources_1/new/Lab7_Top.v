`timescale 1ns / 1ps

module Lab7_Top(
    input [31:0] instruction,
    input clk,
    input reset,
    input RegWrite,
    input [63:0] WriteData,
    output [63:0] ReadData1,
    output [63:0] ReadData2    
    );
    
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [6:0] function7;
    wire [2:0] function3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    Parser I(instruction, opcode, rd, function3, rs1, rs2, function7);
    registerFile RF(WriteData, rs1, rs2, rd, RegWrite, clk, reset, ReadData1, ReadData2);
endmodule

