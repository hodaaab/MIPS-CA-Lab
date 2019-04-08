module ID_Stage
	(
		input clk, 
		input rst,
		//From IF
		input [31:0] Instruction,
		//From WB Stage
		input [31:0] WB_Data,
		input [4:0] WB_Dest,
		input WB_Write_Enable,
		//to IF stage registers
		//output IF_Flush,
		//to stage registers
		output [31:0]Val1, Val2, Reg2, 
		output [4:0] Dest, 
		output [1:0] Branch_Type, //why
		output Br_Taken, 
		output  [3:0] EXE_CMD,
		//MEM Signals
		output  MEM_R_EN,
		output  MEM_W_EN,
		//Write Back Enable
		output  WB_EN 
	);
	
	wire [31:0] signed_out;
	wire is_Imm;
	Registers_File registers_file (
		.clk 			(clk),
		.rst 			(rst),
		.src1			(Instruction[20:16]),
		.src2 			(Instruction[15:11]),
		.dest 			(WB_Dest), 
		.Write_Val 		(WB_Data), 
		.Write_EN 		(WB_Write_Enable), 
		.reg1 			(Val1), 
		.reg2 			(Val2)
	);
	Sign_Extend sign_extend (
		.in 			(Instruction[15:0]), 
		.out 			(signed_out)
	);
	MUX2TO1 mux_reg2 (
		.a 				(signed_out), 
		.b 				(Val2), 
		.sel 			(is_Imm), 
		.res 			(Val2)
	);
	MUX5 mux_dest (
		.a 				(Instruction[20:16]), 
		.b 				(Instruction[15:11]), 
		.sel 			(is_Imm), 
		.res 			(Dest)
	);
	Control_Unit controller (
		.opcode 		(Instruction[31:26]), 
		.alu_command 	(EXE_CMD), 
		.mem_read 		(MEM_R_EN), 
		.mem_write 		(MEM_W_EN), 
		.wb_enable 		(WB_EN), 
		.is_immediate 	(is_Imm), 
		.branch 		(Branch_Type)
	);
	assign Br_Taken = (Instruction[31:29] == 3'b101)? 1'b1 : 1'b0;
endmodule
