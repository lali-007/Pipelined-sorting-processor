`timescale 1ns / 1ps

module testbench_DataMemory();
    reg [63:0] Mem_Addr;
    reg [63:0] Write_Data;
    reg clk;
    reg MemWrite;
    reg MemRead;
    wire [63:0] Read_Data;
    Data_Memory testmodule(Mem_Addr,Write_Data,clk,MemWrite, MemRead ,Read_Data);
    initial begin
      clk = 0;   
      MemWrite = 0;
      Mem_Addr = 64'd24;
      MemRead = 0;
      Write_Data = 64'd192; 
      #10   
      MemRead = 1;
      #10  
      Mem_Addr = 64'd40;   
      #10
      MemRead = 0; 
      #10
      Mem_Addr = 64'd57;
      MemWrite = 1; 
      #10 
      Mem_Addr = 64'd57;
      MemRead = 1;
    #10 $finish;
    end 
  
  always
    #5 clk=~clk;
endmodule


