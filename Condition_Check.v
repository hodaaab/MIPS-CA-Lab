module Condition_Check
	(
		input [1:0] Br_type,
		input [31:0] Val1,
		input [31:0] Src2_Val,
		output reg Branch_Taken
	);

	always @(*) begin
		Branch_Taken <= 0;
		if (Br_type == 2'b01) begin //BEZ
			if(Val1 == 32'b0)
				Branch_Taken <= 1;
		end
		else if (Br_type == 2'b10) begin //BNE
			if(Val1 == Src2_Val)
				Branch_Taken <= 1;
		end
		else if (Br_type == 2'b11) begin
			Branch_Taken <= 1;
		end
		else if (Br_type == 2'b00) begin
			Branch_Taken <= 0;
		end
	end
endmodule