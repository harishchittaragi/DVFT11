module demux14 (input d,
                input [1:0]s,
                output reg [3:0]y);
always @(*) begin
   case (s)
      2'b00:y[0]=d;
      2'b01:y[1]=d;
      2'b10:y[2]=d;
      2'b11:y[3]=d;
      default:y=1'b0;
   endcase
end
endmodule

