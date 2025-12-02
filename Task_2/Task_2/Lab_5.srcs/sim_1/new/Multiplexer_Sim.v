`timescale 1ns / 1ps

module Multiplexer_Sim();
    reg [63:0] a;
    reg [63:0] b;
    reg s;
    wire [63:0] data;
    Multiplexer M(a,b,s,data);
    initial begin
    a = 64'd79;
    b = 64'd157;
    s = 1'b0;
    #100
    s = 1'b1;
    #100 $finish;
    end
endmodule


