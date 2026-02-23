module d_ff(input d,input clk,reset, output reg q,qb);
always @(posedge clk or posedge reset) begin
   if (reset) begin
      q<=0;
      qb<=1;
   end
   else begin
      if (d) begin
         q<=1'b1;
         qb<=1'b0;
        end
      else begin
         q<=1'b0;
         qb<=1'b1;
      end
end
end
endmodule
