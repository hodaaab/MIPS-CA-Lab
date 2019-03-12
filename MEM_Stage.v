module MEM_Stage
	(
		input clk,
		//MEM Signals
		input MEM_R_EN_in,
		input MEM_W_EN_in,

		input [31:0] ALU_result_in,
		input [31:0] ST_val,

		//MEM Signals
		output [31:0] MEM_read_value
	);
	
endmodule