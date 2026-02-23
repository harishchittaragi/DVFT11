module mux41(
   input a0,a1,a2,a3,
   input s0,s1,
   output out);
assign out =(s1==0&&s0==0)?a0:
            (s1==0&&s0==1)?a1:
            (s1==1&&s0==0)?a2:a3;
//assign out=s1?(s0?a[3]:a[2]):(s0?a[1]:a[0])
//always @(*)
//  begin 
//   case(s)
//   2'b00:out=a[0];
//   2'b01:out=a[1];
//   2'b10:out=a[2];
//   2'b11:out=a[3];
//   endcase
//  end
endmodule
