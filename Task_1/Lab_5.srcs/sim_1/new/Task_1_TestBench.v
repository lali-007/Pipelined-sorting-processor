`timescale 1ns / 1ps

module Task_1_TestBench();
    reg reset;
    reg clk;
    Task_1 Sorting_Processor(clk, reset);
    initial begin
    clk = 0;
    reset = 1;
    #10
    reset = 0;
    end
    always
    #5 clk=~clk;
endmodule