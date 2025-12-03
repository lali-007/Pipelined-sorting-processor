`timescale 1ns / 1ps

module Top_TB();
    reg[6:0] Opcode;
    reg [3:0] Funct;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire [3:0] Operation;
    Top_Control TC(Opcode, Funct, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Operation);
    initial begin
        Opcode = 7'b0110011;
        Funct = 4'b0000;
        #10
        Funct = 4'b1000;
        #10
        Funct = 4'b0111;
        #10
        Funct = 4'b0110;
        #10
        Opcode = 7'b0000011;
        #10
        Opcode = 7'b0100011;
        #10
        Opcode = 7'b1100011;
        #10
        Opcode = 7'b0010011;
        #10 $finish;
    end
endmodule

