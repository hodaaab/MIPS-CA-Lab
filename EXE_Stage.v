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
		output [31:0] Br_Addr,
		output Br_taken
	);
  ALU alu1(val1, val2, EXE_CMD, aluout );

endmodule