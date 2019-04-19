module Hazard_Detection_Unit (
	input single_source,
	input [4:0] src1,
	input [4:0] src2,
	input [4:0] Exe_Dest,
	input Exe_WB_EN,
	input [4:0] Mem_Dest,
	input Mem_WB_EN,
	output Hazard_Detected
);
	assign Hazard_Detected = (single_source && Exe_Dest == src1 && Exe_WB_EN)? 1 :
		 (single_source && src1 == Mem_Dest && Mem_WB_EN)? 1 :
		 (!single_source && (Exe_Dest == src1 || Exe_Dest == src2) && Exe_WB_EN)? 1 :
		 (!single_source && (src1 == Mem_Dest || src2 == Mem_Dest) && Mem_WB_EN)? 1 : 0;
endmodule