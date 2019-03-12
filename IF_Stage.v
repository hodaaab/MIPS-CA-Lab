module IF_Stage
	(
		input clk, 
		input rst, 
		output reg[31:0] PC, 
		output [31:0] Instruction
	);
	
	//Missing a MUX here for branch taken
	always @(posedge clk, posedge rst)
	begin
		if(rst)
			PC <= 32'b0;
		else
			PC <= PC + 32'd4;
	end
	Instruction_Memory inst_mem(.Address(PC),.Instruction(Instruction));
endmodule