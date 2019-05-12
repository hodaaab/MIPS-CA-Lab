module EXE_Stage
	(
	   
		input clk,
		input [1:0] sel_A, sel_B, sel_ST,
		input [31:0] reg_2,
		input [3:0] EXE_CMD,
		input [31:0] val1,
		input [31:0] val2,
//		input [31:0] val_src2,
		input [31:0] PC,
		input [1:0] Br_type,
		input [31:0] ALU_result_memStage , 
		input [31:0] fromWBstage ,

		output [31:0] ALU_result,
		output reg [31:0] Br_Addr,
		output Br_taken,
		output [31:0] out_mux_st
	);
		wire [31:0] in_A , in_B ;
	always @(PC or val2) begin
		Br_Addr <= PC + {val2[29:0], 2'd0};
	end
	Condition_Check condition_check (
		.Br_type 			(Br_type), 
		.Val1 				(in_A), 
		.Src2_Val 			(out_mux_st), 
		.Branch_Taken 		(Br_taken)
	);
	MUX3TO1 MUXA (
		.a 					(val1),
		.b 					(ALU_result_memStage),
		.c 					(fromWBstage), 
		.sel 				(sel_A),
    	.res 				(in_A)
	);
	MUX3TO1 MUXB (
    	.a 					(val2),
    	.b 					(ALU_result_memStage),
    	.c 					(fromWBstage), 
		.sel 				(sel_B),
		.res 				(in_B)
	);
	MUX3TO1 MUXST (
		.a 					(reg_2),
		.b 					(ALU_result_memStage),
		.c 					(fromWBstage), 
		.sel 				(sel_ST),
		.res 				(out_mux_st)
	);
	ALU alu (
		.in1 				(in_A), 
		.in2 				(in_B), 
		.cmd 				(EXE_CMD), 
		.result 			(ALU_result)
	);

endmodule