`timescale 1ns / 1ps

module Lab7_top_sim();
    reg [31:0] instruction;
    reg clk;
    reg reset;
    reg Regwrite;
    reg [63:0] WriteData;
    wire [63:0] ReadData1;
    wire [63:0] ReadData2;
    Lab7_Top top(instruction, clk, reset, Regwrite, WriteData, ReadData1, ReadData2);
    initial begin
    clk = 0;   
    Regwrite = 0;   
    reset = 1;
    instruction = 32'b00000000010101010000001010110011;
    WriteData = 64'd35;
    #10 reset = 0;           
    #10 Regwrite = 1;
    #10 reset = 1;
    #100 $finish;
    end 
  always
    #5 clk=~clk;
endmodule


