`timescale 1ns / 1ps

module Multiplexer(
    input [63:0] a,
    input [63:0] b,
    input selector,
    output [63:0] data_out
    );
    assign data_out = selector? b:a;    
endmodule
