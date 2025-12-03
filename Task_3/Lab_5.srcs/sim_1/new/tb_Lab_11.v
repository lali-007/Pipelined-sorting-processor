`timescale 1ns / 1ps

module tb_Lab_11;

    // Inputs to the Processor
    reg clk;
    reg reset;
    integer cycle_count = 0;

    //Values which are sorted (initialized)
    wire signed [63:0] Array_0;
    wire signed [63:0] Array_1;
    wire signed [63:0] Array_2;
    wire signed [63:0] Array_3;
    wire signed [63:0] Array_4;
    wire signed [63:0] Array_5;
    wire signed [63:0] Array_6;

    //Pipelined Register to be displayer on the simulation
    
    // --- STAGE 1: INSTRUCTION FETCH (IF) ---
    wire [63:0] PIPE_IF_PC    = uut.PC_Out;          // PC currently being fetched
    wire [31:0] PIPE_IF_Inst  = uut.Instruction_IF;  // Instruction currently being fetched

    // --- STAGE 2: INSTRUCTION DECODE (ID) ---
    wire [63:0] PIPE_ID_PC    = uut.PC_ID;           // PC currently in Decode
    wire [31:0] PIPE_ID_Inst  = uut.Instruction_ID;  // Instruction currently in Decode

    // --- STAGE 3: EXECUTE (EX) ---
    wire [63:0] PIPE_EX_PC    = uut.PC_EX;           // PC currently in Execute
    wire [63:0] PIPE_EX_ALU   = uut.ALU_Result_EX;   // ALU Result calculation
    wire [4:0]  PIPE_EX_rd    = uut.rd_EX;           // Destination Register target

    // --- STAGE 4: MEMORY (MEM) ---
    // (PC is not passed to MEM in this CPU design, so we track the Result/DestReg)
    wire [63:0] PIPE_MEM_ALU  = uut.ALU_Result_MEM;  // Address/Result in Memory Stage
    wire [4:0]  PIPE_MEM_rd   = uut.rd_MEM;          // Destination Register in MEM
    wire        PIPE_MEM_Wr   = uut.MemWrite_MEM;    // Is it writing to memory?

    // --- STAGE 5: WRITE BACK (WB) ---
    wire [63:0] PIPE_WB_Data  = uut.WriteData_WB;    // Data being written back to RegFile
    wire [4:0]  PIPE_WB_rd    = uut.rd_WB;           // Register Index being written to
    wire        PIPE_WB_En    = uut.RegWrite_WB;     // Is the write enable active?

    // Instantiate the Unit Under Test (UUT)
    Task3 uut (
        .clk(clk),
        .reset(reset)
    );

    // Continuous assignment to link Testbench wires to internal Data Memory
    assign Array_0 = uut.Data_Mem.val1;
    assign Array_1 = uut.Data_Mem.val2;
    assign Array_2 = uut.Data_Mem.val3;
    assign Array_3 = uut.Data_Mem.val4;
    assign Array_4 = uut.Data_Mem.val5;
    assign Array_5 = uut.Data_Mem.val6;
    assign Array_6 = uut.Data_Mem.val7;

    // Clock Generation: 10ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        // 1. Initialize Inputs
        clk = 0;
        reset = 1;

        $display("Simulation Started."); 
        $display("TIP: Add 'PIPE_IF...', 'PIPE_ID...' etc. to your waveform to visualize the pipeline flow.");

        // 2. Hold Reset for 100 ns to flush pipeline registers
        #100;
        reset = 0;

        // 3. Run Simulation
        // Bubble sort takes time. 5000ns is enough for this array size.
        #5000;
        
        // 4. Final Check
        $display("Simulation Finished.");
        $display("Final Array State:");
        $display("Arr[0] = %0d", Array_0);
        $display("Arr[1] = %0d", Array_1);
        $display("Arr[2] = %0d", Array_2);
        $display("Arr[3] = %0d", Array_3);
        $display("Arr[4] = %0d", Array_4);
        $display("Arr[5] = %0d", Array_5);
        $display("Arr[6] = %0d", Array_6);
        
        $finish;
    end
    
        always @(posedge clk) begin
        if (!reset) begin
            // Increment Cycle Count
            cycle_count = cycle_count + 1;
            
            // Debug: Print every 50 cycles to confirm simulation is running
            if (cycle_count % 50 == 0) begin
                 $display("Simulation running... Time: %0t ns, Cycles: %0d", $time, cycle_count);
            end
        end
    end

endmodule