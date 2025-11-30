`timescale 1ns / 1ps

module testbench_InstructionMemory();
    reg [63:0] Instr_Addr;
    wire [31:0] Instruction;
    Instruction_Memory testmodule(Instr_Addr, Instruction);
    initial begin
    Instr_Addr = 64'd0;
    #100
    Instr_Addr = 64'd4;
    #100
    Instr_Addr = 64'd8;
    #100
    Instr_Addr = 64'd12;
    #100 $finish;
    end
endmodule



