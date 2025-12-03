`timescale 1ns / 1ps

module ALU_64(
    input [63:0] a,
    input [63:0] b,
    input [3:0] ALUOp,       // Comes from ALU_Control
    output reg [63:0] Result,
    output reg Zero,
    output reg BLT           // Branch Less Than
    );
 
    always @ (*) begin
        // 1. Set a default value to prevent Latches
        Result = 64'd0;
 
        case(ALUOp)
            4'b0000: Result = (a & b);      // AND
            4'b0001: Result = (a | b);      // OR
            4'b0010: Result = (a + b);      // ADD
            4'b0110: Result = (a - b);      // SUB
            4'b1100: Result = ~(a | b);     // NOR
            4'b1000: Result = a << b;       // SLLI
            
            // Default handled by initialization at top
        endcase
 
        // 2. Calculate Flags AFTER the Result is finalized
        Zero = (Result == 64'd0) ? 1'b1 : 1'b0;
        
        // 3. Signed Comparison for BLT (Critical for sorting negative numbers)
        BLT  = ($signed(a) < $signed(b)) ? 1'b1 : 1'b0; 
    end

endmodule