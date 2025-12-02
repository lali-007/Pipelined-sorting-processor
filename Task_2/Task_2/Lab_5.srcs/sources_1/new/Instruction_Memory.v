`timescale 1ns / 1ps

module Instruction_Memory(
    input [63:0] Instr_Addr,
    output reg [31:0] Instruction
    );
    // Adjusted size to 88 bytes (Instructions 0 to 87)
    reg [7:0] Instruction_Memory [27:0];
    
    initial begin
//        // Formerly Index 56 -> Now Index 0
//        Instruction_Memory[0] = 8'h13;
//        Instruction_Memory[1] = 8'h05;
//        Instruction_Memory[2] = 8'h00;
//        Instruction_Memory[3] = 8'h10;
//        //*Done
        
//        Instruction_Memory[4] = 8'h93;
//        Instruction_Memory[5] = 8'h05;
//        Instruction_Memory[6] = 8'h70;
//        Instruction_Memory[7] = 8'h00;
//        //*Done
        
//        Instruction_Memory[8] = 8'h13;
//        Instruction_Memory[9] = 8'h09;
//        Instruction_Memory[10] = 8'h00;
//        Instruction_Memory[11] = 8'h00;
//        //*Done
        
//        Instruction_Memory[12] = 8'h63;
//        Instruction_Memory[13] = 8'h06;
//        Instruction_Memory[14] = 8'hb9;
//        Instruction_Memory[15] = 8'h04;
//        //*Done
        
//        Instruction_Memory[16] = 8'h93;
//        Instruction_Memory[17] = 8'h09;
//        Instruction_Memory[18] = 8'h00;
//        Instruction_Memory[19] = 8'h00;
//        //*Done
        
//        Instruction_Memory[20] = 8'h33;
//        Instruction_Memory[21] = 8'h8a;
//        Instruction_Memory[22] = 8'h05;
//        Instruction_Memory[23] = 8'h00;
//        //*Done
        
//        Instruction_Memory[24] = 8'h13;
//        Instruction_Memory[25] = 8'h0a;
//        Instruction_Memory[26] = 8'hfa;
//        Instruction_Memory[27] = 8'hff;
//        //*Done
        
//        Instruction_Memory[28] = 8'h33;
//        Instruction_Memory[29] = 8'h0a;
//        Instruction_Memory[30] = 8'h2a;
//        Instruction_Memory[31] = 8'h41;
//        //*Done

//        Instruction_Memory[32] = 8'h63;
//        Instruction_Memory[33] = 8'h88;
//        Instruction_Memory[34] = 8'h49;
//        Instruction_Memory[35] = 8'h03;
//        //*Done
        
//        Instruction_Memory[36] = 8'h93;
//        Instruction_Memory[37] = 8'h92;
//        Instruction_Memory[38] = 8'h29;
//        Instruction_Memory[39] = 8'h00;
//        //*Done
        
//        Instruction_Memory[40] = 8'h33;
//        Instruction_Memory[41] = 8'h83;
//        Instruction_Memory[42] = 8'ha2;
//        Instruction_Memory[43] = 8'h00;
//        //*Done
        
//        Instruction_Memory[44] = 8'h03;
//        Instruction_Memory[45] = 8'h2e;
//        Instruction_Memory[46] = 8'h03;
//        Instruction_Memory[47] = 8'h00;
//        //*Done
        
//        Instruction_Memory[48] = 8'h93;
//        Instruction_Memory[49] = 8'h89;
//        Instruction_Memory[50] = 8'h19;
//        Instruction_Memory[51] = 8'h00;
//        //*Done
        
//        Instruction_Memory[52] = 8'h93;
//        Instruction_Memory[53] = 8'h93;
//        Instruction_Memory[54] = 8'h29;
//        Instruction_Memory[55] = 8'h00;
//        //*Done
        
//        Instruction_Memory[56] = 8'h33;
//        Instruction_Memory[57] = 8'h84;
//        Instruction_Memory[58] = 8'ha3;
//        Instruction_Memory[59] = 8'h00;
//        //*Done
        
//        Instruction_Memory[60] = 8'h83;
//        Instruction_Memory[61] = 8'h2e;
//        Instruction_Memory[62] = 8'h04;
//        Instruction_Memory[63] = 8'h00;
//        //*Done
        
//        Instruction_Memory[64] = 8'h63;
//        Instruction_Memory[65] = 8'h46;
//        Instruction_Memory[66] = 8'hde;
//        Instruction_Memory[67] = 8'h01;
//        //*Done
        
//        Instruction_Memory[68] = 8'h23;
//        Instruction_Memory[69] = 8'h20;
//        Instruction_Memory[70] = 8'hd3;
//        Instruction_Memory[71] = 8'h01;
//        //*Done
        
//        Instruction_Memory[72] = 8'h23;
//        Instruction_Memory[73] = 8'h20;
//        Instruction_Memory[74] = 8'hc4;
//        Instruction_Memory[75] = 8'h01;
//        //*Done
        
//        Instruction_Memory[76] = 8'he3;
//        Instruction_Memory[77] = 8'h04;    
//        Instruction_Memory[78] = 8'h00;
//        Instruction_Memory[79] = 8'hfc;
//        //*Done
        
//        Instruction_Memory[80] = 8'h13;
//        Instruction_Memory[81] = 8'h09;
//        Instruction_Memory[82] = 8'h19;
//        Instruction_Memory[83] = 8'h00;
//        //Done
        
//        Instruction_Memory[84] = 8'he3;
//        Instruction_Memory[85] = 8'h0c;
//        Instruction_Memory[86] = 8'h00;
//        Instruction_Memory[87] = 8'hfa;        
//        //Done

// -------------------------------------------------------------
        // TEST CASE 1: SETUP
        // -------------------------------------------------------------
        // addi x1, x0, 10  (x1 = 10)
        Instruction_Memory[0] = 8'h93;
        Instruction_Memory[1] = 8'h00;
        Instruction_Memory[2] = 8'hA0;
        Instruction_Memory[3] = 8'h00;

        // addi x2, x0, 5   (x2 = 5)
        Instruction_Memory[4] = 8'h13;
        Instruction_Memory[5] = 8'h01;
        Instruction_Memory[6] = 8'h50;
        Instruction_Memory[7] = 8'h00;

        // -------------------------------------------------------------
        // TEST CASE 2: EX HAZARD (The "10" Forwarding Case)
        // -------------------------------------------------------------
        // add x3, x1, x2   (x3 = 10 + 5 = 15) -> Result is in EX stage
        Instruction_Memory[8] = 8'hB3;
        Instruction_Memory[9] = 8'h81;
        Instruction_Memory[10] = 8'h20;
        Instruction_Memory[11] = 8'h00;

        // sub x4, x3, x2   (x4 = 15 - 5 = 10) -> Needs x3 IMMEDIATELY
        // *** CHECK FORWARD_A = 10 HERE ***
        Instruction_Memory[12] = 8'h33;
        Instruction_Memory[13] = 8'h82;
        Instruction_Memory[14] = 8'h21;
        Instruction_Memory[15] = 8'h40;

        // -------------------------------------------------------------
        // TEST CASE 3: MEM HAZARD (The "01" Forwarding Case)
        // -------------------------------------------------------------
        // addi x5, x0, 1   (Gap instruction to push 'sub' to MEM stage)
        Instruction_Memory[16] = 8'h93;
        Instruction_Memory[17] = 8'h02;
        Instruction_Memory[18] = 8'h10;
        Instruction_Memory[19] = 8'h00;

        // add x6, x4, x5   (x6 = 10 + 1 = 11) -> Needs x4 from MEM stage
        // *** CHECK FORWARD_A = 01 HERE ***
        Instruction_Memory[20] = 8'h33;
        Instruction_Memory[21] = 8'h03;
        Instruction_Memory[22] = 8'h52;
        Instruction_Memory[23] = 8'h00;

        // -------------------------------------------------------------
        // END SIMULATION (Infinite Loop)
        // -------------------------------------------------------------
        // beq x0, x0, 0 (Stops PC from running into garbage memory)
        Instruction_Memory[24] = 8'h63;
        Instruction_Memory[25] = 8'h00;
        Instruction_Memory[26] = 8'h00;
        Instruction_Memory[27] = 8'h00;
    end

    always @(Instr_Addr) begin
        // Protect against out-of-bounds reads during simulation
        if (Instr_Addr <= 84) begin
            Instruction[7:0]   = Instruction_Memory[Instr_Addr];
            Instruction[15:8]  = Instruction_Memory[Instr_Addr + 1];
            Instruction[23:16] = Instruction_Memory[Instr_Addr + 2];
            Instruction[31:24] = Instruction_Memory[Instr_Addr + 3];
        end else begin
            Instruction = 32'h00000000;
        end
    end 
endmodule