//this mealy machine is to implement 11010 sequence detector with overlapping
module mealy_11010(input in,
                  input reset,
                  input clk,
                  output reg out);
parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;
reg [2:0]current_state,next_state;

always @(posedge clk) begin
   if (reset) begin
      out<=1'b0;
      next_state<=s0;
   end
   else begin
       current_state=next_state;
     end
  end
  always @(posedge clk)begin 
   case(current_state)
      3'b000:
        if(in) begin
         next_state<=s1;
         out<=1'b0;
         end
         else begin
         next_state<=s0;
      end
      3'b001:
        if(in) begin
         next_state<=s2;
         out<=1'b0;
         end
         else begin
         next_state<=s0;
      end
      3'b010:
        if(in) begin
         next_state<=s2;
         out<=1'b0;
         end
         else begin
         next_state<=s3;
      end
      3'b011:
        if(in) begin
         next_state<=s4;
         out<=1'b1;
         end
         else begin
         next_state<=s0;
      end
      3'b100:
        if(in) begin
         next_state<=s2;
         end
         else begin
         next_state<=s0;
         out<=1'b1;
      end
   endcase
end
endmodule
