`timescale 1ns / 1ps

module ALU_8_Bit(
    input [7:0] a,
    input [7:0] b,
    input CarryIn,
    input [3:0] ALUOp,
    output [7:0] Result,
    output CarryOut
    );
    ALU_1_bit bit0(a[0], b[0], CarryIn, ALUOp, Result[0], Carry0);
    ALU_1_bit bit1(a[1], b[1], Carry0, ALUOp, Result[1], Carry1);
    ALU_1_bit bit2(a[2], b[2], Carry1, ALUOp, Result[2], Carry2);
    ALU_1_bit bit3(a[3], b[3], Carry2, ALUOp, Result[3], Carry3);
    ALU_1_bit bit4(a[4], b[4], Carry3, ALUOp, Result[4], Carry4);
    ALU_1_bit bit5(a[5], b[5], Carry4, ALUOp, Result[5], Carry5);
    ALU_1_bit bit6(a[6], b[6], Carry5, ALUOp, Result[6], Carry6);
    ALU_1_bit bit7(a[7], b[7], Carry6, ALUOp, Result[7], CarryOut);
endmodule

