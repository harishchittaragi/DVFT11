module demux18 (input d,
                input s0,s1,s2,
                output reg [7:0]y);
always @(*) begin
   y=8'b00000000;
   case({s2,s1,s0})
      3'b000:y[0]=d;
      3'b001:y[1]=d;
      3'b010:y[2]=d;
      3'b011:y[3]=d;
      3'b100:y[4]=d;
      3'b101:y[5]=d;
      3'b110:y[6]=d;
      3'b111:y[7]=d;
      default:y=8'b00000000;
   endcase
end
endmodule
      
