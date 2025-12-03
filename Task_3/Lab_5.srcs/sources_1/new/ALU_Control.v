`timescale 1ns / 1ps

module ALU_Control(
    input [1:0] ALUOp,
    input [3:0] Funct,      // {Instruction[30], Instruction[14:12]}
    output reg [3:0] ALU_Control // Renamed from 'Operation' to match Top Level instantiation usually
    );

    // Use (*) to automatically detect sensitivity list
    always @(*) begin
        case(ALUOp)
            // ------------------------------------------------
            // ALUOp 00: Load/Store (and I-types like ADDI/SLLI)
            // ------------------------------------------------
            2'b00: begin
                // Check for SLLI (Shift Left Logical Imm) - Funct3 = 001
                if (Funct == 4'b0001) 
                    ALU_Control = 4'b1000; // SLL
                else 
                    ALU_Control = 4'b0010; // Default: ADD (for lw/sw/addi)
            end
            
            // ------------------------------------------------
            // ALUOp 01: Branch (BEQ/BLT)
            // ------------------------------------------------
            2'b01: begin
                ALU_Control = 4'b0110; // SUB (Comparison)
            end
            
            // ------------------------------------------------
            // ALUOp 10: R-Type (ADD, SUB, AND, OR)
            // ------------------------------------------------
            2'b10: begin
                if (Funct == 4'b0000)      ALU_Control = 4'b0010; // ADD
                else if (Funct == 4'b1000) ALU_Control = 4'b0110; // SUB
                else if (Funct == 4'b0111) ALU_Control = 4'b0000; // AND
                else if (Funct == 4'b0110) ALU_Control = 4'b0001; // OR
                else                       ALU_Control = 4'b0000; // Default
            end
            
            default: ALU_Control = 4'b0000;
        endcase
    end
endmodule