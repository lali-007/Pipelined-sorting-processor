`timescale 1ns / 1ps

module Top_Control(
    input [6:0] Opcode,
    input [3:0] Funct,
    output Branch,
    output MemRead,
    output MemtoReg,
    output MemWrite,
    output ALUSrc,
    output RegWrite,
    output [3:0] Operation
    );
    wire [1:0] ALUOp;
    Control_Unit CU(Opcode, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
    ALU_Control ALUC(ALUOp, Funct, Operation);
endmodule
