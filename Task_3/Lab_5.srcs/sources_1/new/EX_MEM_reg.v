`timescale 1ns / 1ps
module EX_MEM_reg(
    input clk,
    input reset,
    // Control signals
    input Branch_in,
    input MemRead_in,
    input MemtoReg_in,
    input MemWrite_in,
    input RegWrite_in,
    // Data signals
    input [63:0] Adder_2_in,        // Branch target address
    input zero_in,                  // Zero flag from ALU
    input BLT_in,                   // BLT flag from ALU
    input [63:0] ALU_Result_in,
    input [63:0] ReadData2_in,      // Data to be written to memory
    input [4:0] rd_in,
    input [3:0] Funct_in,
    // Control signals output
    output reg Branch_out,
    output reg MemRead_out,
    output reg MemtoReg_out,
    output reg MemWrite_out,
    output reg RegWrite_out,
    // Data signals output
    output reg [63:0] Adder_2_out,
    output reg zero_out,
    output reg BLT_out,
    output reg [63:0] ALU_Result_out,
    output reg [63:0] ReadData2_out,
    output reg [4:0] rd_out,
    output reg [3:0] Funct_out
);
 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset control signals
            Branch_out <= 0;
            MemRead_out <= 0;
            MemtoReg_out <= 0;
            MemWrite_out <= 0;
            RegWrite_out <= 0;
            // Reset data signals
            Adder_2_out <= 64'b0;
            zero_out <= 0;
            BLT_out <= 0;
            ALU_Result_out <= 64'b0;
            ReadData2_out <= 64'b0;
            rd_out <= 5'b0;
            Funct_out <= 4'b0;
        end
        else begin
            // Propagate control signals
            Branch_out <= Branch_in;
            MemRead_out <= MemRead_in;
            MemtoReg_out <= MemtoReg_in;
            MemWrite_out <= MemWrite_in;
            RegWrite_out <= RegWrite_in;
            // Propagate data signals
            Adder_2_out <= Adder_2_in;
            zero_out <= zero_in;
            BLT_out <= BLT_in;
            ALU_Result_out <= ALU_Result_in;
            ReadData2_out <= ReadData2_in;
            rd_out <= rd_in;
            Funct_out <= Funct_in;
        end
    end
endmodule
