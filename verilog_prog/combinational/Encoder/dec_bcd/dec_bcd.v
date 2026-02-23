module dec_bcd(input [3:0]dec,
               output reg [3:0] bcd);
always@(*) begin
   case(dec)
      4'd0:bcd=4'b0000;
      4'd1:bcd=4'b0001;
      4'd2:bcd=4'b0010;
      4'd3:bcd=4'b0011;
      4'd4:bcd=4'b0100;
      4'd5:bcd=4'b0101;
      4'd6:bcd=4'b0110;
      4'd7:bcd=4'b0111;
      4'd8:bcd=4'b1000;
      4'd9:bcd=4'b1001;
      default:bcd=1'bx;
   endcase
end
endmodule
