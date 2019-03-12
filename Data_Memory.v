module Data_Memory
	(
		input clk,
		input [31:0] Address,
		input [31:0] Write_data,
		input MEM_R_EN,
		input MEM_W_EN,
		output [31:0] Data
	);

	logic [7:0] memory [256:0]; 
	initial
	begin
  		memory[8'd100]=8'd255;
  		memory[8'd101]=8'd0;
  		memory[8'd102]=8'd1;
  		memory[8'd103]=8'd0;
	end
	always @(posedge clk)
	begin
  		if(MEM_W_EN)
  			memory[Address] <= Write_data;
	end
	assign Data = (MEM_R_EN)? memory[Address] : 8'b0;

endmodule