module MIPS_tb();
  
reg clk, rst;
reg isFrw ;

wire [31:0] PC, BrAddress, instruction, PCf, instruction_out, Result_WB_Value, val1_ID, val2_ID, Reg2_ID, Reg2, val1, val2, PC_ID_OUT;
wire [31:0] ALU_res_MEM, ALU_result_toReg, BrAddress_EXE, ST_Val, Data, ALU_Result_WBin, memreadval;
 
wire MEM_W_EN_EXE, MEM_R_EN_EXE, WB_EN_EXE, WB_EN_MEM, MEM_R_EN_MEM, MEM_W_EN_MEM, MEM_R_EN_WB;
wire Br_taken_IF, WB_EN, WB_en_output, WB_EN_input, Br_taken, MEM_R_EN_ID, MEM_W_EN_ID, WB_EN_ID;
wire [4:0] Dest_WB, Dest_ID, Dest_MEM, Dest_out, WBdestAddress;
wire [1:0] Br_type_ID, Br_type;
wire [3:0 ] EXE_CMD_Sig, EXECMD;
wire freeze;

wire [1:0] frwA , frwB , stSelect ;
wire [4:0] src1 , src2 ;
wire [31:0] st_val_out ,st_val_in ;

IF_Stage if_stage (
	.clk 				(clk),
	.rst 				(rst),
	.PC 				(PC),
	.freeze				(freeze),
	.Br_taken 			(Br_taken_IF),
	.Br_Addr 			(BrAddress_EXE),
	.Instruction 		(instruction)
);
IF_Stage_reg if_stage_reg (
	.clk 				(clk),
	.rst 				(rst),
	.PC_in 				(PC),
	.freeze				(freeze),
	.Instruction_in 	(instruction),
	.flush 				(Br_taken_IF),
	.PC 				(PCf),
	.Instruction 		(instruction_out)
);
wire [4:0] source1 , source2 ;

ID_Stage id_stage (
	
	.is_forward 		(isFrw),
	.clk 				(clk),
	.rst 				(rst),
	.Instruction 		(instruction_out),
	.WB_Data 			(Result_WB_Value),
	.WB_Dest 			(Dest_WB),
	.WB_Write_Enable 	(WB_en_output),
  	.MEM_R_EN_regout (MEM_R_EN_EXE),

	.EXE_Dest			(Dest_MEM),
	.Exe_WB_EN			(WB_EN_EXE),
	.MEM_Dest			(Dest_out),
	.MEM_WB_EN			(WB_EN_MEM),
	.Val1 				(val1_ID), 
	.Val2 				(val2_ID),
	.Reg2 				(Reg2_ID), 
	.Dest 				(Dest_ID), 
	.Branch_Type 		(Br_type_ID), //why
	.Br_Taken 			(Br_taken), 
	.EXE_CMD 			(EXE_CMD_Sig),
	.MEM_R_EN 			(MEM_R_EN_ID),
	.MEM_W_EN 			(MEM_W_EN_ID),
	.WB_EN 				(WB_EN_ID),
	.Hazard_Detected_Signal(freeze),
	.haz_MEM_RD_EN		(MEM_R_EN_MEM),
	.src1 				(source1),
	.src2 				(source2)
);
ID_Stage_reg id_stage_reg	(
	.clk 				(clk),
	.rst 				(rst),
	.flush 				(Br_taken_IF),
	.src1_in  (source1) ,
	.src2_in  (source2),
	.Dest_in 			(Dest_ID),
	.Reg2_in 			(Reg2_ID),
	.Val2_in 			(val2_ID),
	.Val1_in			(val1_ID),
	.PC_in 				(PCf),
	.Br_type_in			(Br_type_ID),
	.EXE_CMD_in 		(EXE_CMD_Sig),
	.MEM_R_EN_in 		(MEM_R_EN_ID),
	.MEM_W_EN_in 		(MEM_W_EN_ID),
    .WB_EN_in 			(WB_EN_ID),
    .Dest 				(Dest_MEM),
	.Reg2 				(Reg2),
	.Val2 				(val2),
	.Val1 				(val1),
	.PC_out 			(PC_ID_OUT),
	.Br_type 			(Br_type),
	.EXE_CMD 			(EXECMD),
	.MEM_R_EN 			(MEM_R_EN_EXE),
	.MEM_W_EN 			(MEM_W_EN_EXE),
	.WB_EN 				(WB_EN_EXE),
	.src1_out  (src1),
	.src2_out  (src2)
);

 Forwarding_Unit forwardingUnit(

    .ID_reg_out_dest (Dest_MEM),
    .ID_reg_out_src1 (src1),
    .ID_reg_out_src2 (src2),
    
    .EXE_reg_out_WBEN (WB_EN_MEM),
    .EXE_reg_out_DEST (Dest_out),
    .MEM_reg_out_DEST (WBdestAddress),
    .MEM_reg_out_WBEN  (WB_EN_input),
    //.ID_reg_out_MEM_W  (MEM_W_EN_EXE),
  	.ID_reg_out_MEM_W  (MEM_W_EN_EXE),
     
    .forward_a_select (frwA),
    .forward_b_select  (frwB),
    .st_val_select (stSelect)
    );

EXE_Stage exe_stage (
    .clk 				(clk),
    .sel_A   (frwA),
    .sel_B   (frwB),
    .sel_ST (stSelect),
    .reg_2  (Reg2),
	.EXE_CMD 			(EXECMD),
	.val1 				(val1),
	.val2 				(val2),
//	.val_src2 			(Reg2),
	.PC 				(PC_ID_OUT),
	.Br_type 			(Br_type),
	.ALU_result_memStage (ALU_res_MEM),
	.fromWBstage 		(Result_WB_Value),
	.ALU_result 		(ALU_result_toReg),
	.Br_Addr 			(BrAddress_EXE),
	.Br_taken 			(Br_taken_IF),
	.out_mux_st 		(st_val_in)
	
);

 EXE_Stage_reg exe_stage_reg (
	.clk 				(clk),
	.rst 				(rst),
	.WB_en_in 			(WB_EN_EXE),
	.MEM_R_EN_in 		(MEM_R_EN_EXE),
	.MEM_W_EN_in 		(MEM_W_EN_EXE),
	.ALU_result_in 		(ALU_result_toReg),
	.ST_val_in 			(st_val_in),
	.Dest_in 			(Dest_MEM),
	.WB_en 				(WB_EN_MEM),
	.MEM_R_EN 			(MEM_R_EN_MEM),
	.MEM_W_EN 			(MEM_W_EN_MEM),
	.ALU_result 		(ALU_res_MEM),
	.ST_Val 			(st_val_out),
	.Dest 				(Dest_out)
);

	
MEM_Stage mem_stage (
	.clk 				(clk),
	.MEM_R_EN_in 		(MEM_R_EN_MEM),
	.MEM_W_EN_in 		(MEM_W_EN_MEM),
	.ALU_result_in 		(ALU_res_MEM),
	.ST_val 			(st_val_out),
	.MEM_read_value 	(Data)
);
MEM_Stage_reg mem_stage_reg (
	.clk 				(clk),
	.rst 				(rst),
	.WB_en_in 			(WB_EN_MEM),
	.MEM_R_EN_in 		(MEM_R_EN_MEM),
	.ALU_result_in 		(ALU_res_MEM),
	.Mem_read_value_in 	(Data),
	.Dest_in 			(Dest_out),
	.WB_en 				(WB_EN_input),
	.MEM_R_EN 			(MEM_R_EN_WB),
	.ALU_result 		(ALU_Result_WBin),
	.Mem_read_value 	(memreadval),
	.Dest 				(WBdestAddress)
);
WB_Stage wb_stage (
	.clk 				(clk),
	.WB_en_in 			(WB_EN_input),
	.MEM_R_EN 			(MEM_R_EN_WB),
	.ALU_result 		(ALU_Result_WBin),
	.Mem_read_value 	(memreadval),
	.Dest_in 			(WBdestAddress),
	.WB_en 				(WB_en_output),
    .Write_value		(Result_WB_Value),
    .Dest 				(Dest_WB)
);


initial begin
  clk = 0;
  repeat(1000) #20
    clk = ~clk;
  end
initial begin
isFrw = 1'b1 ;
rst = 1;
#30;
rst = 0;
end

endmodule
