`timescale 1ns / 1ps

module Task_1(
    input clk, 
    input reset);
    wire [63:0] PC_out;
    wire [31:0] Instruction; 
    wire [4:0] RS1; 
    wire [4:0] RS2; 
    wire [4:0] RD;
    wire [63:0] WriteData; 
    wire [63:0] ReadData1; 
    wire [63:0] ReadData2; 
    wire [63:0] imm_data; 
    wire [63:0] dataout; 
    wire [63:0] Result; 
    wire Zero;
    wire [63:0] Read_Data; 
    wire [63:0] Addr;
    wire [63:0] out;
    wire [63:0] out2;
    wire [6:0] opcode;
    wire selector = Branch && Zero;
    wire [63:0] Mem_Addr;
    wire MemtoReg;
    wire ALUSrc;
    wire [63:0] Reg_result;
    wire [1:0] ALUOp;
    wire [3:0] funct;
    wire [63:0] b;
    wire [3:0] Operation;
    wire [63:0] IMMSLLI;
    wire Mux_Selector;
    // Wire declarations missing in original
    wire [2:0] function3; 
    wire [6:0] function7;
    // Explicitly decode the specific branch type
    wire is_BEQ  = (funct[2:0] == 3'b000);
    wire is_BNE  = (funct[2:0] == 3'b001);
    wire is_BLT  = (funct[2:0] == 3'b100);
    wire is_BGE  = (funct[2:0] == 3'b101);
    // Calculate if the branch condition is met
    // Note: We ignore funct[3] because it's part of the immediate, not the opcode!
    assign Mux_Selector = Branch && (
                          (is_BEQ && Zero)  ||  // BEQ: Take branch if Zero=1
                          (is_BNE && !Zero) ||  // BNE: Take branch if Zero=0
                          (is_BLT && BLT)   ||  // BLT: Take branch if BLT=1
                          (is_BGE && !BLT)      // BGE: Take branch if BLT=0
                          );
    Program_Counter PC(clk, reset, Addr, PC_out);
    Adder Add_Inst(PC_out, 64'd4, out);
    assign IMMSLLI = imm_data<<1;
    Adder Add(PC_out, IMMSLLI, out2);
    // This is the correct PC Mux
    Multiplexer m1(out, out2, Mux_Selector, Addr);
    Instruction_Memory Instruction_Mem(PC_out, Instruction);
    // Parsing Instruction
    Parser IP(Instruction, opcode, RD, function3, RS1, RS2, function7);
    Control_Unit CU(opcode, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
    // Note: ensure Mem_Addr is the ALU Result output in your ALU module definition
    ALU_64 ALU(ReadData1, Reg_result, Operation, Mem_Addr, Zero, BLT);
    Multiplexer Mux_Reg(ReadData2, imm_data, ALUSrc, Reg_result);
    registerFile RF(WriteData, RS1, RS2, RD, RegWrite, clk, reset, ReadData1, ReadData2);
    Imm_Extractor Imm_Gen(Instruction, imm_data);
    assign funct[3] = Instruction[30];
    assign funct[2:0] = Instruction[14:12]; 
    Data_Memory Data_Mem(
        .clk(clk),
        .MemWrite(MemWrite), 
        .MemRead(MemRead),
        .Mem_Addr(Mem_Addr),       // Connect Top 'Mem_Addr' to Module 'Mem_Adr'
        .Write_Data(ReadData2),   // Connect Top 'ReadData2' to Module 'Write_Data'
        .Read_Data(Read_Data),
        // Connect the debug values so you can see them in waveform
        .val1(val1),
        .val2(val2),
        .val3(val3),
        .val4(val4),
        .val5(val5),
        .val6(val6),
        .val7(val7)
    );
    Multiplexer Mux_Mem(Mem_Addr, Read_Data, MemtoReg, WriteData);
    ALU_Control Control(ALUOp, funct, Operation);
endmodule
 