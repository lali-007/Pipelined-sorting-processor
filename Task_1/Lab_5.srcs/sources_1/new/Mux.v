`timescale 1ns / 1ps

module Mux(
    input in1,
    input in2,
    input in_invert,
    output mux_out
    );
    assign mux_out = in_invert? in2:in1;    
endmodule
