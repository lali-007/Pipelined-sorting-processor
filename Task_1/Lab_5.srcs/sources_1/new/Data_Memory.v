`timescale 1ns / 1ps

module Data_Memory(
    input clk,
    input MemWrite,
    input MemRead,
    input [63:0] Mem_Addr, 
    input [63:0] Write_Data,
    output reg [63:0] Read_Data,
    
    // Debug Outputs (Connect these to your Waveform Viewer)
    output [63:0] val1, val2, val3, val4, val5, val6, val7
);

    // Memory size of 512 bytes 
    reg [7:0] data_mem [511:0]; 
    integer i;

    // -------------------------------------------------------------------------
    // Debug / Visualization Logic
    // -------------------------------------------------------------------------
    // Maps 4 bytes (Little Endian) to a 32-bit value for easy viewing.
    // Address 256 (0x100) corresponds to the base address used in your Assembly.
    assign val1 = {32'b0, data_mem[259], data_mem[258], data_mem[257], data_mem[256]};
    assign val2 = {32'b0, data_mem[263], data_mem[262], data_mem[261], data_mem[260]};
    assign val3 = {32'b0, data_mem[267], data_mem[266], data_mem[265], data_mem[264]};
    assign val4 = {32'b0, data_mem[271], data_mem[270], data_mem[269], data_mem[268]};
    assign val5 = {32'b0, data_mem[275], data_mem[274], data_mem[273], data_mem[272]};
    assign val6 = {32'b0, data_mem[279], data_mem[278], data_mem[277], data_mem[276]};
    assign val7 = {32'b0, data_mem[283], data_mem[282], data_mem[281], data_mem[280]};

    // -------------------------------------------------------------------------
    // Initialization
    // -------------------------------------------------------------------------
    initial begin
        // 1. Initialize entire memory to zero first
        for (i = 0; i < 512; i = i + 1) begin
            data_mem[i] = 8'h00; 
        end
        
        // 2. Pre-load the values to be sorted (32-bit / 4-byte alignment)
        // Base Address: 256 (0x100)
        
        // Value: 1
        data_mem[256] = 8'd90; 

        // Value: 4 (Address 256 + 4)
        data_mem[260] = 8'd72; 

        // Value: 2 (Address 260 + 4)
        data_mem[264] = 8'd65; 

        // Value: 7 (Address 264 + 4)
        data_mem[268] = 8'd55; 

        // Value: 5 (Address 268 + 4)
        data_mem[272] = 8'd44; 

        // Value: 9 (Address 272 + 4)
        data_mem[276] = 8'd33; 

        // Value: 3 (Address 276 + 4)
        data_mem[280] = 8'd22;
    end

    // -------------------------------------------------------------------------
    // Synchronous Write & Console Display
    // -------------------------------------------------------------------------
    always @(posedge clk) begin
        if (MemWrite) begin
            // Perform the Store (Little Endian)
            data_mem[Mem_Addr+0] <= Write_Data[7:0];
            data_mem[Mem_Addr+1] <= Write_Data[15:8];
            data_mem[Mem_Addr+2] <= Write_Data[23:16];
            data_mem[Mem_Addr+3] <= Write_Data[31:24];

            // CONSOLE DISPLAY:
            // Check if we are writing to the sorting array range (256 - 280)
            // This prints the array state to the Tcl Console whenever it changes.
            if (Mem_Addr >= 256 && Mem_Addr <= 280) begin
                $display("[%0t ns] Array Update at Addr %0d | Val: %0d", $time, Mem_Addr, Write_Data);
                // Note: We use non-blocking assignment above (<=), so the values printed 
                // below will be the state *before* this specific write completes, 
                // or you can rely on the simulation waveform updates.
            end
        end 
    end
    
    // -------------------------------------------------------------------------
    // Asynchronous Read
    // -------------------------------------------------------------------------
    always @(*) begin
        if (MemRead) begin
            // Little Endian Load (32-bit LW)
            Read_Data[7:0]   = data_mem[Mem_Addr + 0];
            Read_Data[15:8]  = data_mem[Mem_Addr + 1];
            Read_Data[23:16] = data_mem[Mem_Addr + 2];
            Read_Data[31:24] = data_mem[Mem_Addr + 3];
            Read_Data[63:32] = 32'h00000000; // Zero-extend
        end
        else begin
            Read_Data = 64'd0;
        end
    end

endmodule