`timescale 1ns / 1ps
 
module registerFile(

    input [63:0] WriteData,

    input [4:0] RS1,

    input [4:0] RS2,

    input [4:0] RD,

    input RegWrite,

    input clk,

    input reset,

    output reg [63:0] ReadData1,

    output reg [63:0] ReadData2

    );
 
    reg [63:0] Registers [31:0];

    integer i;
 
    // FIX 1: Initialize all registers to 0 (Standard practice)

    initial begin

        for (i = 0; i < 32; i = i + 1) begin

            Registers[i] = 64'd0;

        end

    end
 
    // FIX 2: Prevent writing to Register 0

    always @(posedge clk) begin

        // Only write if RegWrite is HIGH AND the destination is NOT x0 (RD != 0)

        if (RegWrite && RD != 5'd0) begin

            Registers[RD] = WriteData;

        end

    end
 
    // Read Logic (Asynchronous)

    // Note: I also fixed your reset logic. 

    // In your broken code, "if (!reset)" meant "If Reset is LOW, read data". 

    // Usually reset is active HIGH. I matched the working version below.

    always @(*) begin

        if (reset) begin   

            ReadData1 = 64'b0;

            ReadData2 = 64'b0;

        end else begin

            // Double protection: Always read 0 from Register 0

            ReadData1 = (RS1 == 5'd0) ? 64'd0 : Registers[RS1];

            ReadData2 = (RS2 == 5'd0) ? 64'd0 : Registers[RS2];

        end

    end
 
endmodule
 