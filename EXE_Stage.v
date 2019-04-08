module EXE_Stage
	(
		input clk,
		input [3:0] EXE_CMD,
		input [31:0] val1,
		input [31:0] val2,
		input [31:0] val_src2,
		input [31:0] PC,
		input [1:0] Br_type,

		output [31:0] ALU_result,
		output reg [31:0] Br_Addr,
		output Br_taken
	);
	always @(PC or val2) begin
		Br_Addr <= PC + 32'd4 + val2[15:0]; //PC + offset + 4
	end
	Condition_Check condition_check (
		.Br_type 			(Br_type), 
		.Val1 				(val1), 
		.Src2_Val 			(val_src2), 
		.Branch_Taken 		(Br_taken)
	);
	ALU alu (
		.in1 				(val1), 
		.in2 				(val2), 
		.cmd 				(EXE_CMD), 
		.result 			(ALU_result)
	);

endmodule