module Instruction_Memory
	(
		input [31:0] Address, 
		output reg [31:0] Instruction
	);
	//logic [31:0] instruction [6:0];
	always@(Address) 
	begin
		case(Address)
			32'd0 : Instruction <= 32'b100000_00000_00001_00000_11000001010;
			32'd4 : Instruction <= 32'b000001_00000_00001_00010_00000000000;
			32'd8 : Instruction <= 32'b000011_00101_00001_00011_00000000000;
			/*
			32'd12 : Instruction <= 32'b000000_00111_01000_00010_00000000000;
			32'd16 : Instruction <= 32'b000000_01001_01010_00011_00000000000;
			32'd20 : Instruction <= 32'b000000_01011_01100_00000_00000000000;
			32'd24 : Instruction <= 32'b000000_01101_01110_00000_00000000000; */
		endcase
	end
endmodule