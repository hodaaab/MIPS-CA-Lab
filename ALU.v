module ALU (input [31:0]A,input [31:0]B,input [3:0]CMD, output [31:0]out);
  reg [31:0]Y, var, x, g;
  
always@(A,B,CMD)begin
  case(CMD)
    4'b0000:Y=A+B;
    4'b0010:Y=A-B;
    4'b0110:Y=~(A|B);
    4'b0100:Y=A & B;
    4'b0101:Y=A | B;
    4'b0110:Y=~(A | B);
    4'b0111: Y=A^B;
    4'b1000:Y=A<<B;
    4'b1010:Y=A>>B;
  endcase 
   
  if (CMD == 4'b1001) begin 
    var = {32{A[31]}};    
    x = A >> B   ;   
    g = var << 31 - B;
    Y = { g , x };      
  end       
end

endmodule






