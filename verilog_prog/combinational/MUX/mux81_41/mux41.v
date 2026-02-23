module mux41(
   input wire [3:0]a,
   input wire [1:0]s,
   output reg out);
always @(*)
  begin 
   case (s)
   2'b00:out=a[0];
   2'b01:out=a[1];
   2'b10:out=a[2];
   2'b11:out=a[3];
   default:out=1'b0;
   endcase
  end
endmodule
