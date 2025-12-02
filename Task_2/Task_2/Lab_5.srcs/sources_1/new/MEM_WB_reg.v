`timescale 1ns / 1ps

module MEM_WB_reg(

    input clk,

    input reset,

    // Control signals

    input MemtoReg_in,

    input RegWrite_in,

    // Data signals

    input [63:0] Read_Data_in,      // Data read from memory

    input [63:0] ALU_Result_in,     // ALU result

    input [4:0] rd_in,              // Destination register

    // Control signals output

    output reg MemtoReg_out,

    output reg RegWrite_out,

    // Data signals output

    output reg [63:0] Read_Data_out,

    output reg [63:0] ALU_Result_out,

    output reg [4:0] rd_out

);
 
    always @(posedge clk or posedge reset) begin

        if (reset) begin

            // Reset control signals

            MemtoReg_out <= 0;

            RegWrite_out <= 0;

            // Reset data signals

            Read_Data_out <= 64'b0;

            ALU_Result_out <= 64'b0;

            rd_out <= 5'b0;

        end

        else begin

            // Propagate control signals

            MemtoReg_out <= MemtoReg_in;

            RegWrite_out <= RegWrite_in;

            // Propagate data signals

            Read_Data_out <= Read_Data_in;

            ALU_Result_out <= ALU_Result_in;

            rd_out <= rd_in;

        end

    end

endmodule
 