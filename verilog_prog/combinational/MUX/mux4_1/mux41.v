module mux41(
   input wire [3:0]a,
   input wire [1:0]s,
   output reg out);
// assign out=s1?(s0?a[3]:a[2]):(s0?a[1]:a[0])
always @(*)
  begin 
   case({s[1],s[0]})
   2'b00:out=a[0];
   2'b01:out=a[1];
   2'b10:out=a[2];
   2'b11:out=a[3];
   endcase
  end
endmodule
