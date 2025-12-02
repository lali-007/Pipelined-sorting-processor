//`timescale 1ns / 1ps

//module registerFile(
//    input [63:0] WriteData,
//    input [4:0] RS1,
//    input [4:0] RS2,
//    input [4:0] RD,
//    input RegWrite,
//    input clk,
//    input reset,
//    output reg [63:0] ReadData1,
//    output reg [63:0] ReadData2
//    );
//    reg [63:0] Registers [31:0];
    
//    initial begin
//    Registers[0] = 64'd1;
//    Registers[1] = 64'd2;
//    Registers[2] = 64'd3;
//    Registers[3] = 64'd4;
//    Registers[4] = 64'd5;
//    Registers[5] = 64'd6;
//    Registers[6] = 64'd7;
//    Registers[7] = 64'd8;
//    Registers[8] = 64'd9;
//    Registers[9] = 64'd10;
//    Registers[10] = 64'd11;
//    Registers[11] = 64'd12;
//    Registers[12] = 64'd13;
//    Registers[13] = 64'd14;
//    Registers[14] = 64'd15;
//    Registers[15] = 64'd16;
//    Registers[16] = 64'd17;
//    Registers[17] = 64'd18;
//    Registers[18] = 64'd19;
//    Registers[19] = 64'd20;
//    Registers[20] = 64'd21;
//    Registers[21] = 64'd22;
//    Registers[22] = 64'd23;
//    Registers[23] = 64'd24;
//    Registers[24] = 64'd25;
//    Registers[25] = 64'd26;
//    Registers[26] = 64'd27;
//    Registers[27] = 64'd28;
//    Registers[28] = 64'd29;
//    Registers[29] = 64'd30;
//    Registers[30] = 64'd31;
//    Registers[31] = 64'd32;
//    end
  
//    always @(posedge clk) begin
//        if (RegWrite) begin
//            Registers[RD] = WriteData;
//        end
//    end
    
//    always @(Registers, RS1, RS2, reset) begin
//        if (!reset) begin   
//            ReadData1 = Registers[RS1] ;
//            ReadData2 = Registers[RS2];
//        end else begin
//            ReadData1 = 64'b0;
//            ReadData2 = 64'b0;
//        end
//    end
//endmodule


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
 