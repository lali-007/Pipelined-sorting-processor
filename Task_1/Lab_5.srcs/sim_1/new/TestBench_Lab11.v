`timescale 1ns / 1ps

module TestBench_Lab11();
    reg reset;
    reg clk;
    Lab_11 SCP(clk, reset);
    initial begin
    clk = 0;
    reset = 1;
    #10
    reset = 0;
//    #5000 $finish;
    end
    always
    #5 clk=~clk;
endmodule
//#20;

//    // Test case 1: Verify basic instruction fetch
//    $display("PC_Out: %h, Instruction: %h", PC_Out, Instruction);
//    #10;

//    // Test case 2: Check if register file works correctly
//    $display("ReadData1: %h, ReadData2: %h", ReadData1, ReadData2);
//    #10;

//    // Test case 3: Check ALU operation
//    $display("ALU_Result: %h, zero: %b, BLT: %b", ALU_Result, zero, BLT);
//    #10;

//end

//endmodule