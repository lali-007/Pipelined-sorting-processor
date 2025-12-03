`timescale 1ns / 1ps

module IF_ID_reg(
    input clk,
    input reset,
    input IF_ID_WRITE,              // From Hazard Unit (1=Update, 0=Stall)
    input IF_FLUSH,                 // From Branch Logic (1=Flush/Reset to NOP)
    input [63:0] PC_Out_in,         
    input [31:0] Instruction_in,    
    output reg [63:0] PC_Out_out,   
    output reg [31:0] Instruction_out 
);
 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC_Out_out      <= 64'b0;
            Instruction_out <= 32'h00000013; // Reset to NOP (addi x0, x0, 0)
        end
        else begin
            // PRIORITY 1: FLUSH
            // If we branched, we must discard the current fetch immediately,
            // regardless of whether we were stalling or not.
            if (IF_FLUSH) begin
                Instruction_out <= 32'h00000013; // RISC-V NOP (addi x0, x0, 0)
                PC_Out_out      <= 64'b0; 
            end
            // PRIORITY 2: WRITE ENABLE (STALL)
            // Only update if Hazard Unit allows it
            else if (IF_ID_WRITE) begin
                PC_Out_out      <= PC_Out_in;
                Instruction_out <= Instruction_in;
            end
        end
    end

endmodule