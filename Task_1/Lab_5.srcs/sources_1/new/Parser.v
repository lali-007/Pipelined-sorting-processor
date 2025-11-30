`timescale 1ns / 1ps

module Parser(
    input [31:0] instruction,
    output [6:0] opcode,
    output reg [4:0] rd,
    output reg [2:0] function3,
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [6:0] function7
    );
    assign opcode = instruction[6:0];
    always @(*) begin
        if (opcode == 7'b0110011) begin 
            // R-Type (add, sub, slt, etc.)
            rd        = instruction[11:7];
            function3 = instruction[14:12];
            rs1       = instruction[19:15];
            rs2       = instruction[24:20];
            function7 = instruction[31:25];
        end
        else if (opcode == 7'b0010011 || opcode == 7'b0000011 || opcode == 7'b1100111) begin 
            // I-Type (addi, ld, jalr)
            rd        = instruction[11:7];
            function3 = instruction[14:12];
            rs1       = instruction[19:15];
            rs2       = 5'b00000;          // I-types don't use rs2
            function7 = 7'b0000000;        // I-types don't use funct7 (usually)
        end
        else if (opcode == 7'b0100011) begin 
            // S-Type (sd)
            rd        = 5'b00000;          // S-types don't write to register
            function3 = instruction[14:12];
            rs1       = instruction[19:15];
            rs2       = instruction[24:20];
            function7 = 7'b0000000;
        end
        else if (opcode == 7'b1100011) begin 
            // SB-Type (beq, blt) - CRITICAL FOR SORTING
            rd        = 5'b00000;
            function3 = instruction[14:12];
            rs1       = instruction[19:15];
            rs2       = instruction[24:20];
            function7 = 7'b0000000;
        end
        else begin
            // Default / UJ-Type / Unknown
            rd        = instruction[11:7];
            function3 = instruction[14:12];
            rs1       = instruction[19:15];
            rs2       = instruction[24:20];
            function7 = instruction[31:25];
        end
    end
endmodule