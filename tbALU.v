
module TB();
//  wire [15:0]Out;
  reg clk,rst;
  all d1(clk,rst);
  
  initial begin
    clk=0;
    repeat(500)#200
    clk=~clk;
  end
  
  initial begin
    rst=1;
    #200
    rst=0;
  end
endmodule



