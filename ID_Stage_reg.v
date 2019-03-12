module ID_Stage_reg
	(
		input clk,
		input rst,
		//from EXE Stage
		input Flush,
		//to stage registers
		input [4:0] Dest_in,
		input [31:0] Reg2_in,
		input [31:0] Val2_in,
		input [31:0] Val1_in,
		input [31:0] PC_in,
		input Br_taken_in,
		input [3:0] EXE_CMD_in,
		input MEM_R_EN_in,
		input MEM_W_EN_in,
		input WB_EN_in,
		//to stage registers
		output reg [4:0] Dest,
		output reg [31:0] Reg2,
		output reg [31:0] Val2,
		output reg [31:0] Val1,
		output reg [31:0] PC_out,
		output reg Br_taken,
		output reg [3:0] EXE_CMD,
		output reg MEM_R_EN,
		output reg MEM_W_EN,
		output reg WB_EN
	);

	always@(posedge clk, posedge rst)
	begin
		if(rst)
		begin
			PC <= 32'b0;
		end
		EXE_CMD <= EXE_CMD_in;
		MEM_R_EN <= MEM_R_EN_in;
		MEM_W_EN <= MEM_W_EN_in;
		WB_EN <= WB_EN_in; 
		PC_out <= PC_in;
		Br_taken <= Br_taken_in;
		Dest <= Dest_in;
		Val1 <= Val1_in;
		Val2 <= Val2_in;
	end
endmodule