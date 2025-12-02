`timescale 1ns / 1ps

module ALU_Control(
    input [1:0] ALUOp,
    input [3:0] Funct,
    output reg [3:0] Operation
    );

//    always @(*) begin
//        Operation = 4'bxxxx; 

//        if (ALUOp == 2'b00) begin
//            if (Funct == 4'b0001) begin
//                Operation = 4'b1000; 
//            end else begin
//                Operation = 4'b0010; 
//            end
//        end 
//        else if (ALUOp == 2'b01) begin
//            Operation = 4'b0110; 
//        end 
//        else if (ALUOp == 2'b10) begin
//            if (Funct == 4'b0000) begin
//                Operation = 4'b0010; 
//            end 
//            else if (Funct == 4'b1000) begin
//                Operation = 4'b0110; 
//            end 
//            else if (Funct == 4'b0111) begin
//                Operation = 4'b0000; 
//            end 
//            else if (Funct == 4'b0110) begin
//                Operation = 4'b0001; 
//            end
//        end 
//    end
//endmodule

always @(ALUOp or Funct)
    begin
    case(ALUOp)
    2'b00: // l/s
        begin
        if (Funct==4'b0001) Operation<=4'b1000; //SLLI
        else Operation<=4'b0010; // default to add
        end
    2'b01: //branch
        Operation<=4'b0110; //sub 
    2'b10: //R
        begin
        if (Funct==4'b0000) Operation<=4'b0010; //ADD
        else if(Funct==4'b1000) Operation<=4'b0110; //SUB
        else if(Funct==4'b0111) Operation<=4'b0000; //AND
        else if(Funct==4'b0110) Operation<=4'b0001; //OR
        end
        default: Operation<=4'bxxxx;
     endcase
     end
endmodule