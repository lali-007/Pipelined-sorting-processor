`timescale 1ns / 1ps
module ID_EX_reg(

    input clk,

    input reset,

    // Control signals

    input Branch_in,

    input MemRead_in,

    input MemtoReg_in,

    input [1:0] ALUOp_in,

    input MemWrite_in,

    input ALUSrc_in,

    input RegWrite_in,

    // Data signals

    input [63:0] PC_Out_in,

    input [63:0] ReadData1_in,

    input [63:0] ReadData2_in,

    input [63:0] imm_data_in,

    input [3:0] Funct_in,

    input [4:0] rd_in,

    input [4:0] rs1_in,

    input [4:0] rs2_in,

    // Control signals output

    output reg Branch_out,

    output reg MemRead_out,

    output reg MemtoReg_out,

    output reg [1:0] ALUOp_out,

    output reg MemWrite_out,

    output reg ALUSrc_out,

    output reg RegWrite_out,

    // Data signals output

    output reg [63:0] PC_Out_out,

    output reg [63:0] ReadData1_out,

    output reg [63:0] ReadData2_out,

    output reg [63:0] imm_data_out,

    output reg [3:0] Funct_out,

    output reg [4:0] rd_out,

    output reg [4:0] rs1_out,

    output reg [4:0] rs2_out

);
 
    always @(posedge clk or posedge reset) begin

        if (reset) begin

            // Reset control signals

            Branch_out <= 0;

            MemRead_out <= 0;

            MemtoReg_out <= 0;

            ALUOp_out <= 2'b0;

            MemWrite_out <= 0;

            ALUSrc_out <= 0;

            RegWrite_out <= 0;

            // Reset data signals

            PC_Out_out <= 64'b0;

            ReadData1_out <= 64'b0;

            ReadData2_out <= 64'b0;

            imm_data_out <= 64'b0;

            Funct_out <= 4'b0;

            rd_out <= 5'b0;

            rs1_out <= 5'b0;

            rs2_out <= 5'b0;

        end

        else begin

            // Propagate control signals

            Branch_out <= Branch_in;

            MemRead_out <= MemRead_in;

            MemtoReg_out <= MemtoReg_in;

            ALUOp_out <= ALUOp_in;

            MemWrite_out <= MemWrite_in;

            ALUSrc_out <= ALUSrc_in;

            RegWrite_out <= RegWrite_in;

            // Propagate data signals

            PC_Out_out <= PC_Out_in;

            ReadData1_out <= ReadData1_in;

            ReadData2_out <= ReadData2_in;

            imm_data_out <= imm_data_in;

            Funct_out <= Funct_in;

            rd_out <= rd_in;

            rs1_out <= rs1_in;

            rs2_out <= rs2_in;

        end

    end

endmodule
 