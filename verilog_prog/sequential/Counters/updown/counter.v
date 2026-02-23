module counter(input t,
               input clk,reset,
               output reg [2:0]out);

always @(posedge clk or posedge reset) begin
   if (reset) begin
      out<=3'b0;
   end
      else begin
         if (t)
            out<=out+1;
         else
            out<=out-1;
      end
   end
   endmodule
