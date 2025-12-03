`timescale 1ns / 1ps

module ALU_64_test();
    reg [63:0] a;
    reg [63:0] b;
    reg CarryIn;
    reg [3:0] ALUOp;
    wire [63:0] Result;
    wire Zero;
    ALU_64 ALU64(a, b, CarryIn, ALUOp, Result, Zero);
    initial begin
    a = 64'd5000000000000000123;
    b = 64'd3000000000000000456;
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
    a = 64'd0;
    b = 64'd0;
    CarryIn = 0;
    ALUOp = 4'b0000;
    #100 $finish;
    end
endmodule

