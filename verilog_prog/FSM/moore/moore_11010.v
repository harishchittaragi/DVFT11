//this moore machine is to implement 11010 sequence detector with overlapping
module moore_11010(input in,
                  input reset,
                  input clk,
                  output reg out);
parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100,s5=3'b101;
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
      3'b000:begin out=1'b0;
        if(in) begin
         next_state<=s1;
         end
         else begin
         next_state<=s0;
      end
      end

      3'b001:begin out=1'b0;
        if(in) begin
         next_state<=s2;
         end
         else begin
         next_state<=s0;
      end
      end

      3'b010:begin out=1'b0;
        if(in) begin
         next_state<=s2;
         end
         else begin
         next_state<=s3;
      end
      end

      3'b011:begin out=1'b0;
        if(in) begin
         next_state<=s4;
         end
         else begin
         next_state<=s0;
      end
      end

      3'b100:begin out=1'b0;
        if(in) begin
         next_state<=s2;
         end
         else begin
         next_state<=s5;
      end
      end

      3'b101:begin out=1'b1;
        if(in) begin
         next_state<=s1;
         end
         else begin
         next_state<=s0;
      end
      end
   endcase
end
endmodule
