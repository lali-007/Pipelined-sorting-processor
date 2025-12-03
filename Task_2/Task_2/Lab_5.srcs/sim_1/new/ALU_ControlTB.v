`timescale 1ns / 1ps

module ALU_ControlTB();
    reg [1:0] ALUOp;
    reg [3:0] Funct;
    wire [3:0] Operation;
    ALU_Control ALUC(ALUOp, Funct, Operation);
    initial begin
        ALUOp = 2'b00;
        #10
        ALUOp = 2'b01;
        #10
        ALUOp = 2'b10;
        Funct = 4'b0000;
        #10
        Funct = 4'b1000;
        #10
        Funct = 4'b0111;
        #10
        Funct = 4'b0110;
        #10 $finish;
    end
endmodule

