module mealy_1101(input in,
                  input reset,
                  input clk,
                  output reg out);
parameter s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11;
reg [1:0]current_state,next_state;
event e;
always @(posedge clk) begin
   if (reset) begin
      out<=1'b0;
      next_state<=s0;
   end
   else begin
       current_state=next_state;
       ->e;
       $display($time,"updated");
     end
  end
  always @(e)begin 
         $display($time,"starting in=%b cs=%b ns=%b ",in,current_state,next_state);
   case(current_state)
      2'b00:
        if(in) begin
         next_state<=s1;
         out<=1'b0;
         $display($time,"00 yes in=%b cs=%b ns=%b ",in,current_state,next_state);
         end
         else begin
         next_state<=s0;
         $display($time,"00 no in=%b cs=%b ns=%b ",in,current_state,next_state);
      end
      2'b01:
        if(in) begin
         next_state<=s2;
         out<=1'b0;
         $display($time,"01 yes in=%b ",in);
         end
         else begin
         next_state<=s0;
         $display($time,"01 no in=%b ",in);
      end
      2'b10:
        if(in) begin
         next_state<=s2;
         out<=1'b0;
         $display($time,"10 yes in=%b ",in);
         end
         else begin
         next_state<=s3;
         $display($time,"10 no in=%b ",in);
      end
      2'b11:
        if(in) begin
         next_state<=s0;
         out<=1'b1;
         $display($time,"11 yes in=%b ",in);
         end
         else begin
         next_state<=s0;
         $display("11 no");
      end
   endcase
end

endmodule
