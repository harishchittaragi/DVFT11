module demux18 (input d,
                input [2:0]s,
                output reg [7:0]y);
always @(*) begin
   case(s)
      3'b000:y[0]=d;
      3'b001:y[1]=d;
      3'b010:y[2]=d;
      3'b011:y[3]=d;
      3'b100:y[4]=d;
      3'b101:y[5]=d;
      3'b110:y[6]=d;
      3'b111:y[7]=d;
      default:y=1'b0;
   endcase
end
endmodule
      
