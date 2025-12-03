`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2025 02:23:15 PM
// Design Name: 
// Module Name: Fowarding_Unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Fowarding_Unit(
    input [4:0] ID_EX_RS1, 
    input [4:0] ID_EX_RS2, 
    input [4:0] ID_EX_RD,       // Unused in standard forwarding, but kept for interface match
    input [4:0] EX_MEM_RD, 
    input [4:0] MEM_WB_RD,      
    input EX_MEM_REGWRITE, 
    input MEM_WB_REGWRITE,      
    output reg [1:0] FA, 
    output reg [1:0] FB
);
    
    always @(*) begin
        // ---------------------------------------------------------
        // FORWARDING FOR A (Source 1)
        // ---------------------------------------------------------
        // FIX: Changed (EX_MEM_RD == 1) to (EX_MEM_RD != 0)
        if (EX_MEM_REGWRITE && (EX_MEM_RD != 0) && (EX_MEM_RD == ID_EX_RS1))
            FA = 2'b10; // Forward from EX Stage
        
        // MEM Hazard (Double Data Hazard Check)
        // FIX: Added (MEM_WB_RD != 0) and matched the condition logic from FB
        else if (MEM_WB_REGWRITE && (MEM_WB_RD != 0) && (MEM_WB_RD == ID_EX_RS1) && 
                !(EX_MEM_REGWRITE && (EX_MEM_RD != 0) && (EX_MEM_RD == ID_EX_RS1)))
            FA = 2'b01; // Forward from MEM Stage
        else
            FA = 2'b00;
            
        // ---------------------------------------------------------
        // FORWARDING FOR B (Source 2)
        // ---------------------------------------------------------
        // Note: Your original logic for FB was actually correct! 
        if (EX_MEM_REGWRITE && (EX_MEM_RD != 0) && (EX_MEM_RD == ID_EX_RS2))
            FB = 2'b10;
        else if (MEM_WB_REGWRITE && (MEM_WB_RD != 0) && (MEM_WB_RD == ID_EX_RS2) && 
                !(EX_MEM_REGWRITE && (EX_MEM_RD != 0) && (EX_MEM_RD == ID_EX_RS2)))
            FB = 2'b01;
        else
            FB = 2'b00;
     end 
endmodule
