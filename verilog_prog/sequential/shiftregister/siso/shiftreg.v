module shiftreg(input in,
                input clk,reset,
                output  [3:0]out);
reg w1,w2,w3,w4;
always @ (posedge clk or posedge reset) begin
   if (reset)begin
      w1<=1'b0;
      w2<=1'b0;
      w3<=1'b0;
      w4<=1'b0;
   end
   else begin
      w4<=w3;
      w3<=w2;
      w2<=w1;
      w1<=in;
   end
end
assign out =w4;
   endmodule

