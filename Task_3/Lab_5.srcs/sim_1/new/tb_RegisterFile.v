`timescale 1ns / 1ps

module tb_RegisterFile (); 
 	reg [63:0]WriteData;  
 	reg [4:0]RS1;  
  	reg [4:0]RS2;  
  	reg [4:0]RD;  
  	reg RegWrite, clk, reset;  
  	wire  [63:0]ReadData1;  
  	wire  [63:0]ReadData2;    
  
  registerFile regFile  (WriteData, RS1, RS2, RD, RegWrite, clk, reset, ReadData1, ReadData2);    
  initial  
    begin 
      clk = 0;   
      RegWrite = 0;   
      reset = 1;   
      // add x20,x10,x20
      RS1 = 10; //ReadData1 reads value of register number 10 and the value is 11   
      RS2 = 20; //ReadData2 reads value in register number 20 and the value loaded is  21   
      WriteData = 64'd35;    //This value 32 is given by user for now, the add instruction given above is just to show how does the proces works
      RD = 20;  //The value of register number 20 was '21' . This 21 is the value or 'data' 
  #10 reset = 0;    
            
  #10 RegWrite = 1;//allow write in register 20  
 
    #100 $finish;
    end 
  
  always
    #5 clk=~clk;

endmodule