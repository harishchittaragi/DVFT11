module decode24(input [1:0]d,
                output reg [3:0]y);
always@(*) begin
   case(d)
      2'b00:y=4'b0001;
      2'b01:y=4'b0010;
      2'b10:y=4'b0100;
      2'b11:y=4'b1000;
      default:y=1'b0;
   endcase
end
// assign y[0]=~d[0]&~d[1];
// assign y[1]=~d[0]&d[1];
// assign y[2]=d[0]&~d[1];
// assign y[3]=d[0]&d[1];

endmodule
