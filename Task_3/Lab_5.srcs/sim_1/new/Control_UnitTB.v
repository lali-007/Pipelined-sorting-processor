`timescale 1ns / 1ps

module Control_UnitTB();
    reg [6:0] Opcode;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [1:0] ALUOp;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    Control_Unit CU(Opcode, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
    initial begin
        Opcode = 7'b0110011;
        #10
        Opcode = 7'b0000011;
        #10
        Opcode = 7'b0100011;
        #10
        Opcode = 7'b1100011;
        #10
        Opcode = 7'b0010011;
        #10 $finish;
    end
endmodule
