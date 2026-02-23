module encoder42(input [3:0]d,
   output reg [1:0]y);

always @(*) begin
   case(d)
      4'b0001:y=2'b00;
      4'b0010:y=2'b01;
      4'b0100:y=2'b10;
      4'b1000:y=2'b11;
      default:y=1'b0;
   endcase
end
endmodule

