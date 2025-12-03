`timescale 1ns / 1ps

module ALU_1_bit(
    input a,
    input b,
    input CarryIn,
    input [3:0] ALUOp,
    output reg Result,
    output reg CarryOut);
    wire abar;
    wire bbar;
    wire mux1out;
    wire mux2out;
    assign abar = ~a;
    assign bbar = ~b;
    Mux m1(a, abar, ALUOp[3], mux1out);
    Mux m2(b, bbar, ALUOp[2], mux2out);
    always @ (*) begin
    case(ALUOp[1:0])
         2'b00: begin
                Result = (mux1out & mux2out);
                CarryOut = 0;
                end
         2'b01: begin
                Result = (mux1out | mux2out);
                CarryOut = 0;
                end
         2'b10: begin
                Result = (mux1out^mux2out^CarryIn);
                CarryOut = (mux2out & CarryIn) | (mux1out & CarryIn) | (mux1out & mux2out) | (mux1out & mux2out & CarryIn);
                end
        default: begin
                Result   = 0;
                CarryOut = 0;
            end
    endcase
    end
endmodule
