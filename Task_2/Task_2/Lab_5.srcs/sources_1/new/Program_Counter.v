`timescale 1ns / 1ps

module Program_Counter(
    input clock,
    input reset,
    input [63:0]PC_in,
    output reg [63:0]PC_out
    );
    always @(posedge clock)
    begin
    if (reset) 
    begin
        PC_out = 64'd0;
    end 
    else begin
        PC_out = PC_in[63:0];
    end
    end
endmodule


