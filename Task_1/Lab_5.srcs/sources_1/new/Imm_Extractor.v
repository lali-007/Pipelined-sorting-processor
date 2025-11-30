`timescale 1ns / 1ps
 
module Imm_Extractor(

    input wire [31:0] instruction,

    output reg [63:0] imm_data

    );
 
    reg [11:0] imm;
 
    // Use (*) to automatically detect all inputs

    always @(*) 

    begin

        // 1. Extract the 12-bit immediate

        // Note: Using blocking assignment (=) so 'imm' updates INSTANTLY

        if (instruction[6] == 1'b1)

            imm = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]}; // SB format

        else begin

            if (instruction[5] == 1'b1)

                imm = {instruction[31:25], instruction[11:7]}; // S format

            else

                imm = instruction[31:20]; // I format

        end
 
        // 2. Sign Extend to 64-bit

        // Now 'imm' definitely holds the current value

        if (imm[11] == 0)

            imm_data = {52'd0, imm};

        else

            imm_data = {52'hFFFFFFFFFFFFF, imm};

    end
 
endmodule
 

