`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: Hazard_Detection_Unit
//////////////////////////////////////////////////////////////////////////////////

module Hazard_Detection_Unit(
    input [4:0] RS1,
    input [4:0] RS2,
    input [4:0] ID_EX_RD,
    input       ID_EX_MEMREAD,
    output reg  IF_ID_WRITE,
    output reg  PC_WRITE,
    output reg  MUX_SELECTOR_BIT
);

    always @(*) begin

        if (ID_EX_MEMREAD && (ID_EX_RD != 5'b0) && ((ID_EX_RD == RS1) || (ID_EX_RD == RS2))) begin
            MUX_SELECTOR_BIT = 1; 
            IF_ID_WRITE      = 0;  
            PC_WRITE         = 0;  
            $display("There is an stall added in the code");
        end
        else begin
            MUX_SELECTOR_BIT = 0;
            IF_ID_WRITE      = 1;
            PC_WRITE         = 1;
        end 
    end
endmodule