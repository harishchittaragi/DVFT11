module pa_enco83(input [7:0]d,
                 output reg [2:0]y);
always@(*) begin
   case(d)
      8'bxxxxxxx1:y=3'b000;
      8'bxxxxxx10:y=3'b001;
      8'bxxxxx100:y=3'b010;
      8'bxxxx1000:y=3'b011;
      8'bxxx10000:y=3'b100;
      8'bxx100000:y=3'b101;
      8'bx1000000:y=3'b110;
      8'b10000000:y=3'b111;
      default:y=1'b0;
   endcase
end
endmodule
