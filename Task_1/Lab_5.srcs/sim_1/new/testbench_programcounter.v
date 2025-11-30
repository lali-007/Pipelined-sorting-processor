`timescale 1ns / 1ps

module testbench_programcounter();
    reg clock;
    reg reset;
    reg [63:0]PC_in;
    wire [63:0]PC_out;
    Program_Counter PC(clock, reset, PC_in, PC_out);
initial begin
    clock = 0;
    reset = 0;
    PC_in = 64'd287;
    #50
    reset = 1;
    PC_in = 64'd932;
    #50
    reset = 0;
    PC_in = 64'd287;
    #100 $finish;
end
always
#50
clock = ~clock;
endmodule



