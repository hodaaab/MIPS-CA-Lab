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
	
	wire [31:0] Address;
	Address_Mapping addres_mapping( .ALU_result(ALU_result_in),
		.Data_memory_address(Address));
	Data_Memory data_memory(.clk (clk), .Address (Address), 
		.Write_data (ST_val), .MEM_R_EN (MEM_R_EN_in), .MEM_W_EN (MEM_W_EN_in),
		.Data (MEM_read_value));

endmodule