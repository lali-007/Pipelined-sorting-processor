`timescale 1ns / 1ps
 
 module IF_ID_reg(

    input clk,

    input reset,

    input [63:0] PC_Out_in,         // PC value from Fetch stage

    input [31:0] Instruction_in,    // Instruction from Instruction Memory

    output reg [63:0] PC_Out_out,   // PC value passed to Decode stage

    output reg [31:0] Instruction_out // Instruction passed to Decode stage

);
 
    always @(posedge clk or posedge reset) begin

        if (reset) begin

            PC_Out_out <= 64'b0;

            Instruction_out <= 32'b0;

        end

        else begin

            PC_Out_out <= PC_Out_in;

            Instruction_out <= Instruction_in;

        end

    end

endmodule

 