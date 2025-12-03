`timescale 1ns / 1ps

module Imm_Extractor(
    input wire [31:0] instruction,
    output reg [63:0] imm_data
    );

    always @(*) begin
        // ---------------------------------------------------------------------
        // SB-Type (Branch) - Opcode 1100011
        // Differentiating Check: instruction[6] is 1
        // ---------------------------------------------------------------------
        if (instruction[6] == 1'b1) begin
            // FIX: Re-ordered bits and ADDED '1'b0' at the end for alignment
            // Structure: Sign(31) | Bit(7) | Bits(30:25) | Bits(11:8) | 0
            imm_data = {{51{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; 
        end
        
        // ---------------------------------------------------------------------
        // S-Type (Store) - Opcode 0100011
        // Differentiating Check: instruction[5] is 1
        // ---------------------------------------------------------------------
        else if (instruction[5] == 1'b1) begin
             // Structure: Sign(31) | Bits(31:25) | Bits(11:7)
            imm_data = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]};
        end
        
        // ---------------------------------------------------------------------
        // I-Type (Load/ADDI) - Opcodes 0000011, 0010011
        // Default Case
        // ---------------------------------------------------------------------
        else begin
             // Structure: Sign(31) | Bits(31:20)
            imm_data = {{52{instruction[31]}}, instruction[31:20]};
        end
    end

endmodule