`timescale 1ns / 1ps
module ALU_1_bit_test();
    reg a;
    reg b;
    reg CarryIn;
    reg [3:0] ALUOp;
    wire Result;
    wire CarryOut;
    ALU_1_bit ALU(a, b, CarryIn, ALUOp, Result, CarryOut);
    initial begin
    a = 1;
    b = 1;
    CarryIn = 0;
    ALUOp = 4'b0000;
    #100
    ALUOp = 4'b0001;
    #100
    ALUOp = 4'b0010;
    #100
    ALUOp = 4'b0110;
    CarryIn = 1;
    #100
    ALUOp = 4'b1100;
    CarryIn = 0;
    #100 $finish;
    end
endmodule

