module MEM_Stage_reg(input clk, rst, input [31:0] PC_in, output reg [31:0]PC);
	always@(posedge clk, posedge rst)
	begin
		if(rst)
		begin
			PC <= 32'b0;
		end
			PC <= PC_in;
	end
endmodule