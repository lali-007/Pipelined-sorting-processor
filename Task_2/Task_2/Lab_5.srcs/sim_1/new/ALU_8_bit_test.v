`timescale 1ns / 1ps

module ALU_8_bit_test();
    reg [7:0] a;
    reg [7:0] b;
    reg CarryIn;
    reg [3:0] ALUOp;
    wire [7:0] Result;
    wire CarryOut;
    ALU_8_Bit ALU(a, b, CarryIn, ALUOp, Result, CarryOut);
    initial begin
    a = 8'b10101010;
    b = 8'b11001100;
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
