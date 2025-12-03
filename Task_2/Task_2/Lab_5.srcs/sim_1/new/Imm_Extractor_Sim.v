`timescale 1ns / 1ps

module Imm_Extractor_Sim(
    );
    reg [31:0] instruction;
    wire [63:0] imm_data;
    Imm_Extractor IM(instruction, imm_data);
    initial begin
    instruction = 32'b11111111110000110000001010010011;
    #100
    instruction = 32'b00000000101000010010010000100011;
    #100
    instruction = 32'b00000000001000001000100001100011;
    #100 $finish;
    end
endmodule



