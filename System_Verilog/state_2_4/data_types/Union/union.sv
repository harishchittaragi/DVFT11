module union_ex();
union { int a;
       byte b;
       logic l;
       reg c;} u_type;
initial begin
   $display($time,"a=%b",u_type.a);
   $display($time,"b=%b",u_type.b);
   $display($time,"l=%b",u_type.l);
   $display($time,"c=%b",u_type.c);

   #10;
  u_type.a=1'b0;
  u_type.b=1'b0;
  u_type.l=1'b0;
  u_type.c=1'b1;// here reg and logic are of 4 state so finally reg value is updated for both reg and logic types and is applied for 2 state also.
   $display($time,"a=%b",u_type.a);
   $display($time,"b=%b",u_type.b);
   $display($time,"l=%b",u_type.l);
   $display($time,"c=%b",u_type.c);
end
endmodule
  

