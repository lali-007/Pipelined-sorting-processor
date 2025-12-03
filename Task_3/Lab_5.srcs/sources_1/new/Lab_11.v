`timescale 1ns / 1ps

module Lab_11(
    input clk,
    input reset
);

    // ==============================================================================
    // WIRE DECLARATIONS (PIPELINED)
    // ==============================================================================
    
    // --- IF Stage Signals ---
    wire [63:0] PC_In;
    wire [63:0] PC_Out_IF;
    wire [31:0] Instruction_IF;
    wire [63:0] Adder_1_IF;

    // --- ID Stage Signals ---
    wire [63:0] PC_Out_ID;
    wire [31:0] Instruction_ID;
    wire [6:0]  opcode_ID;
    wire [4:0]  rd_ID, rs1_ID, rs2_ID;
    wire [2:0]  funct3_ID;
    wire [6:0]  funct7_ID;
    wire [3:0]  Funct_ID; // Your custom 4-bit funct
    wire [63:0] ReadData1_ID, ReadData2_ID;
    wire [63:0] imm_data_ID;
    
    // ID Control Signals
    wire Branch_ID, MemRead_ID, MemtoReg_ID, MemWrite_ID, ALUSrc_ID, RegWrite_ID;
    wire [1:0] ALUOp_ID;

    // --- EX Stage Signals ---
    wire [63:0] PC_Out_EX;
    wire [63:0] ReadData1_EX, ReadData2_EX, imm_data_EX;
    wire [3:0]  Funct_EX;
    wire [4:0]  rd_EX, rs1_EX, rs2_EX; // rs1/rs2 needed for Hazard Unit later (if you add it)
    wire [63:0] ALU_Result_EX;
    wire        zero_EX, BLT_EX;
    wire [3:0]  operation_EX;
    wire [63:0] Adder_2_EX;   // Branch Target
    wire [63:0] Alu_seco_EX;  // Mux output
    
    // EX Control Signals
    wire Branch_EX, MemRead_EX, MemtoReg_EX, MemWrite_EX, ALUSrc_EX, RegWrite_EX;
    wire [1:0] ALUOp_EX;

    // --- MEM Stage Signals ---
    wire [63:0] Adder_2_MEM; // Branch Target carried through
    wire        zero_MEM, BLT_MEM;
    wire [63:0] ALU_Result_MEM, ReadData2_MEM;
    wire [4:0]  rd_MEM;
    wire [3:0]  Funct_MEM;
    wire [63:0] Read_Data_MEM;
    wire        Mux_Selector_MEM; // The final Branch Decision
    
    // MEM Control Signals
    wire Branch_MEM, MemRead_MEM, MemtoReg_MEM, MemWrite_MEM, RegWrite_MEM;

    // --- WB Stage Signals ---
    wire [63:0] Read_Data_WB, ALU_Result_WB;
    wire [4:0]  rd_WB;
    wire [63:0] WriteData_WB;
    
    // WB Control Signals
    wire MemtoReg_WB, RegWrite_WB;

    // ==============================================================================
    // STAGE 1: INSTRUCTION FETCH (IF)
    // ==============================================================================

    // 1. PC Mux (Decides: Next Line OR Branch Target from MEM stage)
    Multiplexer m1(
        .a(Adder_1_IF),      // PC + 4
        .b(Adder_2_MEM),     // Branch Target (From MEM stage!)
        .selector(Mux_Selector_MEM), // Decision (From MEM stage!)
        .data_out(PC_In)
    );

    // 2. Program Counter
    Program_Counter PC(
        .clock(clk), 
        .reset(reset), 
        .PC_in(PC_In), 
        .PC_out(PC_Out_IF)
    );

    // 3. Instruction Memory
    Instruction_Memory Instruction_Mem(
        .Instr_Addr(PC_Out_IF), 
        .Instruction(Instruction_IF)
    );

    // 4. PC Adder (PC + 4)
    Adder Add_Inst(
        .a(PC_Out_IF), 
        .b(64'd4), 
        .out(Adder_1_IF)
    );

    // --- IF/ID PIPELINE REGISTER ---
    IF_ID_reg if_id(
        .clk(clk),
        .reset(reset),
        .PC_Out_in(PC_Out_IF),
        .Instruction_in(Instruction_IF),
        // Outputs
        .PC_Out_out(PC_Out_ID),
        .Instruction_out(Instruction_ID)
    );

    // ==============================================================================
    // STAGE 2: INSTRUCTION DECODE (ID)
    // ==============================================================================

    // 1. Parser
    // Note: Parsing wire names to match your module
    wire [2:0] unused_f3; // internal wire
    wire [6:0] unused_f7; // internal wire
    
    Parser IP(
        .instruction(Instruction_ID), 
        .opcode(opcode_ID), 
        .rd(rd_ID), 
        .function3(funct3_ID), // These are raw bits from parser
        .rs1(rs1_ID), 
        .rs2(rs2_ID), 
        .function7(funct7_ID)
    );

    // 2. Create your Custom Funct (Instruction[30] + funct3)
    // IMPORTANT: We do this here so we can pass 'Funct_ID' down the pipeline
    assign Funct_ID = {Instruction_ID[30], Instruction_ID[14:12]};

    // 3. Control Unit
    Control_Unit CU(
        .Opcode(opcode_ID), 
        .Branch(Branch_ID), 
        .MemRead(MemRead_ID), 
        .MemtoReg(MemtoReg_ID), 
        .ALUOp(ALUOp_ID), 
        .MemWrite(MemWrite_ID), 
        .ALUSrc(ALUSrc_ID), 
        .RegWrite(RegWrite_ID)
    );

    // 4. Register File
    // CRITICAL: Write inputs come from WB stage (Loopback)
    registerFile RF(
        .clk(clk), 
        .reset(reset), 
        .RS1(rs1_ID), 
        .RS2(rs2_ID), 
        .RD(rd_WB),              // <--- From WB Stage
        .WriteData(WriteData_WB),// <--- From WB Stage
        .RegWrite(RegWrite_WB),  // <--- From WB Stage
        .ReadData1(ReadData1_ID), 
        .ReadData2(ReadData2_ID)
    );

    // 5. Immediate Generation
    Imm_Extractor Imm_Gen(
        .instruction(Instruction_ID), 
        .imm_data(imm_data_ID)
    );

    // --- ID/EX PIPELINE REGISTER ---
    ID_EX_reg id_ex(
        .clk(clk),
        .reset(reset),
        // Control Inputs
        .Branch_in(Branch_ID), .MemRead_in(MemRead_ID), .MemtoReg_in(MemtoReg_ID),
        .ALUOp_in(ALUOp_ID), .MemWrite_in(MemWrite_ID), .ALUSrc_in(ALUSrc_ID), .RegWrite_in(RegWrite_ID),
        // Data Inputs
        .PC_Out_in(PC_Out_ID), .ReadData1_in(ReadData1_ID), .ReadData2_in(ReadData2_ID),
        .imm_data_in(imm_data_ID), .Funct_in(Funct_ID), .rd_in(rd_ID), .rs1_in(rs1_ID), .rs2_in(rs2_ID),
        
        // Control Outputs
        .Branch_out(Branch_EX), .MemRead_out(MemRead_EX), .MemtoReg_out(MemtoReg_EX),
        .ALUOp_out(ALUOp_EX), .MemWrite_out(MemWrite_EX), .ALUSrc_out(ALUSrc_EX), .RegWrite_out(RegWrite_EX),
        // Data Outputs
        .PC_Out_out(PC_Out_EX), .ReadData1_out(ReadData1_EX), .ReadData2_out(ReadData2_EX),
        .imm_data_out(imm_data_EX), .Funct_out(Funct_EX), .rd_out(rd_EX), .rs1_out(rs1_EX), .rs2_out(rs2_EX)
    );

    // ==============================================================================
    // STAGE 3: EXECUTE (EX)
    // ==============================================================================

    // 1. Branch Address Adder (Calculates PC + Imm*2)
    // Note: We do the shift (<< 1) here directly
    Adder adder2(
        .a(PC_Out_EX),
        .b(imm_data_EX << 1), 
        .out(Adder_2_EX)
    );

    // 2. ALU Mux (ReadData2 vs Immediate)
    Multiplexer Mux_Reg(
        .a(ReadData2_EX), 
        .b(imm_data_EX), 
        .selector(ALUSrc_EX), 
        .data_out(Alu_seco_EX)
    );

    // 3. ALU Control
    // Uses Funct_EX coming from the pipeline
    ALU_Control Control(
        .ALUOp(ALUOp_EX), 
        .Funct(Funct_EX), 
        .Operation(operation_EX)
    );

    // 4. ALU
    ALU_64 ALU(
        .a(ReadData1_EX), 
        .b(Alu_seco_EX), 
        .ALUOp(operation_EX), 
        .Result(ALU_Result_EX), 
        .Zero(zero_EX), 
        .BLT(BLT_EX)
    );

    // --- EX/MEM PIPELINE REGISTER ---
    EX_MEM_reg ex_mem(
        .clk(clk),
        .reset(reset),
        // Control Inputs
        .Branch_in(Branch_EX), .MemRead_in(MemRead_EX), .MemtoReg_in(MemtoReg_EX),
        .MemWrite_in(MemWrite_EX), .RegWrite_in(RegWrite_EX),
        // Data Inputs
        .Adder_2_in(Adder_2_EX), .zero_in(zero_EX), .BLT_in(BLT_EX),
        .ALU_Result_in(ALU_Result_EX), .ReadData2_in(ReadData2_EX), .rd_in(rd_EX), .Funct_in(Funct_EX),
        
        // Control Outputs
        .Branch_out(Branch_MEM), .MemRead_out(MemRead_MEM), .MemtoReg_out(MemtoReg_MEM),
        .MemWrite_out(MemWrite_MEM), .RegWrite_out(RegWrite_MEM),
        // Data Outputs
        .Adder_2_out(Adder_2_MEM), .zero_out(zero_MEM), .BLT_out(BLT_MEM),
        .ALU_Result_out(ALU_Result_MEM), .ReadData2_out(ReadData2_MEM), .rd_out(rd_MEM), .Funct_out(Funct_MEM)
    );

    // ==============================================================================
    // STAGE 4: MEMORY (MEM)
    // ==============================================================================

    // 1. Branch Decision Logic
    // This happens here because we need the ALU Flags (Zero/BLT) which are only valid now.
    wire is_BEQ  = (Funct_MEM[2:0] == 3'b000);
    wire is_BNE  = (Funct_MEM[2:0] == 3'b001);
    wire is_BLT  = (Funct_MEM[2:0] == 3'b100);
    wire is_BGE  = (Funct_MEM[2:0] == 3'b101);

    assign Mux_Selector_MEM = Branch_MEM && (
                          (is_BEQ && zero_MEM)  ||  
                          (is_BNE && !zero_MEM) ||  
                          (is_BLT && BLT_MEM)   ||  
                          (is_BGE && !BLT_MEM)      
                          );

    // 2. Data Memory
    // Note: We use named instantiation for safety
    // Using output wires val1..val7 for debugging
    wire [63:0] val1, val2, val3, val4, val5, val6, val7; // Declarations for debug outputs
    
    Data_Memory Data_Mem(
        .clk(clk),
        .MemWrite(MemWrite_MEM), 
        .MemRead(MemRead_MEM),
        .Mem_Adr(ALU_Result_MEM),       
        .Write_Data(ReadData2_MEM),   
        .Read_Data(Read_Data_MEM),
        .val1(val1), .val2(val2), .val3(val3), .val4(val4), .val5(val5), .val6(val6), .val7(val7)
    );

    // --- MEM/WB PIPELINE REGISTER ---
    MEM_WB_reg mem_wb(
        .clk(clk),
        .reset(reset),
        // Control Inputs
        .MemtoReg_in(MemtoReg_MEM), .RegWrite_in(RegWrite_MEM),
        // Data Inputs
        .Read_Data_in(Read_Data_MEM), .ALU_Result_in(ALU_Result_MEM), .rd_in(rd_MEM),
        
        // Control Outputs
        .MemtoReg_out(MemtoReg_WB), .RegWrite_out(RegWrite_WB),
        // Data Outputs
        .Read_Data_out(Read_Data_WB), .ALU_Result_out(ALU_Result_WB), .rd_out(rd_WB)
    );

    // ==============================================================================
    // STAGE 5: WRITE BACK (WB)
    // ==============================================================================

    // 1. Write Back Mux (Selects Memory Data vs ALU Result)
    Multiplexer Mux_Mem(
        .a(ALU_Result_WB), 
        .b(Read_Data_WB), 
        .selector(MemtoReg_WB), 
        .data_out(WriteData_WB)
    );

    // Note: WriteData_WB loops back to Stage 2 (RegisterFile) at the top of the file!

endmodule
