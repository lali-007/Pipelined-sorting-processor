`timescale 1ns / 1ps

module testbenchInstFetch();
    reg clk;
    reg reset;
    wire[31:0]Instruction;
    Instruction_Fetch testmodule(clk, reset, Instruction);
    initial begin
    clk = 0;
    reset = 1;
    #25
    reset = 0;
    #25 $finish;
    end
    always
        #5
        clk = ~clk;
    endmodule

