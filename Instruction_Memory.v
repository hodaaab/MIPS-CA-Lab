module Instruction_Memory
	(
		input [31:0] Address, 
		output reg [31:0] Instruction
	);
	reg [31:0] instructions [73:0];
	initial $readmemb("Benchmark.txt", instructions);
	always@(Address) 
		begin
			Instruction <= instructions[Address>>2];
		end
	// always@(Address) 
	// begin
	// 	case(Address)
	// 		32'd0 : Instruction <= 32'b100000_00000_00001_00000_11000001010;
	// 		32'd4 : Instruction <= 32'b000000_00000_00000_00000_00000000000;
	// 		32'd8 : Instruction <= 32'b000000_00000_00000_00000_00000000000;
	// 		32'd12 : Instruction <= 32'b000001_00000_00001_00010_00000000000;
	// 		32'd16 : Instruction <= 32'b000011_00000_00001_00011_00000000000;
	// 		32'd20 : Instruction <= 32'b000000_00000_00000_00000_00000000000;
	// 		32'd24 : Instruction <= 32'b000000_00000_00000_00000_00000000000;
	// 		32'd28 : Instruction <= 32'b000101_00010_00011_00100_00000000000;
	// 		32'd32 : Instruction <= 32'b100001_00011_00101_00011_01000110100;

			
	// 	endcase
	//end
endmodule