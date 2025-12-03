`timescale 1ns / 1ps

module Parser_Sim();
    reg [31:0] instruction;
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] function3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] function7;
    Parser P(instruction,opcode,rd,function3,rs1,rs2,function7);
    initial begin
    instruction = 32'b00000000010101010000001010110011;
    end
endmodule


