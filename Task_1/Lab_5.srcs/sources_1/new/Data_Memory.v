`timescale 1ns / 1ps

module Data_Memory(
    input clk,
    input MemWrite,
    input MemRead,
    input [63:0] Mem_Addr, 
    input [63:0] Write_Data,
    output reg [63:0] Read_Data,
    output [63:0] val1, val2, val3, val4, val5, val6, val7);
    reg [7:0] data_mem [511:0]; 
    integer i;
    assign val1 = {32'b0, data_mem[259], data_mem[258], data_mem[257], data_mem[256]};
    assign val2 = {32'b0, data_mem[263], data_mem[262], data_mem[261], data_mem[260]};
    assign val3 = {32'b0, data_mem[267], data_mem[266], data_mem[265], data_mem[264]};
    assign val4 = {32'b0, data_mem[271], data_mem[270], data_mem[269], data_mem[268]};
    assign val5 = {32'b0, data_mem[275], data_mem[274], data_mem[273], data_mem[272]};
    assign val6 = {32'b0, data_mem[279], data_mem[278], data_mem[277], data_mem[276]};
    assign val7 = {32'b0, data_mem[283], data_mem[282], data_mem[281], data_mem[280]};
    initial begin
        for (i = 0; i < 512; i = i + 1) begin
            data_mem[i] = 8'h00; 
        end
        data_mem[256] = 8'd90; 
        data_mem[260] = 8'd72; 
        data_mem[264] = 8'd65; 
        data_mem[268] = 8'd55; 
        data_mem[272] = 8'd44; 
        data_mem[276] = 8'd33; 
        data_mem[280] = 8'd22;
    end
    always @(posedge clk) begin
        if (MemWrite) begin
            data_mem[Mem_Addr+0] <= Write_Data[7:0];
            data_mem[Mem_Addr+1] <= Write_Data[15:8];
            data_mem[Mem_Addr+2] <= Write_Data[23:16];
            data_mem[Mem_Addr+3] <= Write_Data[31:24];
        end 
    end
    always @(*) begin
        if (MemRead) begin
            Read_Data[7:0]   = data_mem[Mem_Addr + 0];
            Read_Data[15:8]  = data_mem[Mem_Addr + 1];
            Read_Data[23:16] = data_mem[Mem_Addr + 2];
            Read_Data[31:24] = data_mem[Mem_Addr + 3];
            Read_Data[63:32] = 32'h00000000; 
        end
        else begin
            Read_Data = 64'd0;
        end
    end
endmodule