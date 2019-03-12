module Decode_tb();
reg clk, rst;
wire WB_Write_Enable, Br_Taken, MEM_R_EN, MEM_W_EN, WB_EN;
wire [31:0] PC, PCd0, PCd, PCf0, PCf, PCe0, PCe, PCm0, PCm, PCw0, PCw, instruction, instruction_out, WB_Data, Val1, Val2, Reg2;
wire [6:0] dispfetch, dispdec, dispex, dispmem, dispwb;
wire [4:0] WB_Dest, Dest;
wire [1:0] Branch_Type;
wire [3:0] EXE_CMD;

IF_Stage ifs(clk, rst, PC,  instruction);
IF_Stage_reg ifsr(clk, rst, PC, instruction,	PCf, instruction_out);
ID_Stage decode_stage(clk, rst, PCf, WB_Data,WB_Dest,WB_Write_Enable,PCd0,Val1, Val2, Reg2, Dest, Branch_Type, Br_Taken, EXE_CMD, MEM_R_EN, MEM_W_EN, WB_EN);
ID_Stage_reg idsr(clk, rst, PCd0,  PCd);
EXE_Stage exes(clk, rst,   PCd,  PCe0);
EXE_Stage_reg exesr(clk, rst,   PCe0,  PCe);
MEM_Stage mems(clk, rst,   PCe,  PCm0);
MEM_Stage_reg memsr(clk, rst, PCm0, PCm);
WB_Stage wbs(clk, rst, PCm, PCw0);
WB_Stage_reg wbsr(clk, rst, PCw0, PCw);
initial begin
  clk=0;
  repeat(1000)#20
    clk=~clk;
  end
initial begin
rst=1;
#3000;
rst=0;


  end
endmodule
