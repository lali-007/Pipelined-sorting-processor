`timescale 1ns / 1ps

module Program_Counter(
    input clk,
    input reset,
    input PC_Write,         // 1 = Update PC, 0 = Stall (Keep current PC)
    input [63:0] PC_In,
    output reg [63:0] PC_Out
    );

    always @(posedge clk)
    begin
        if (reset) 
        begin
            PC_Out <= 64'd0;
        end 
        else begin
            // Only update the PC if the Hazard Unit allows it (PC_Write == 1)
            // If PC_Write == 0, the PC retains its current value (Stall)
            if (PC_Write)
                PC_Out <= PC_In[63:0];
            else
                PC_Out <= PC_Out; // Explicitly stating the stall
        end
    end
endmodule


