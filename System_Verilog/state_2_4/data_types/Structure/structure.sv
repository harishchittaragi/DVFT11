module structure();
struct {int a;
        byte b;
        logic l;
        string s;} s_type;
initial begin
   $display($time,"a=%b",s_type.a);
   $display($time,"a=%b",s_type.b);
   $display($time,"a=%d",s_type.l);
   $display($time,"a=%s",s_type.s);
#10;
   s_type.a=1;
   s_type.b=3'h4;
   s_type.l=1;
   s_type.s="Harish";
   $display($time,"a=%b",s_type.a);
   $display($time,"a=%b",s_type.b);
   $display($time,"a=%d",s_type.l);
   $display($time,"a=%s",s_type.s);
end
endmodule

