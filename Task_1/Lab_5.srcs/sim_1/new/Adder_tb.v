`timescale 1ns / 1ps

module Adder_tb();
    reg [63:0]a;
    reg [63:0]b;
    wire [63:0]out;
    Adder Added(a, b, out);
    initial begin
        a = 64'd64;
        b = 64'd36;
        #50
        b = 64'd33;
        #50
        a = 64'd77;
        #50 $finish;
        end
endmodule


