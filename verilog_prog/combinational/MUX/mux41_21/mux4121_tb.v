`include "mux4121.v"
module mux4121_tb ();
reg a0,a1,a2,a3,s0,s1;
wire out;
mux4121 mux4 (.a0(a0),.a1(a1),.a2(a2),.a3(a3),.s0(s0),.s1(s1),.out(out));
initial begin
   a0=0;a1=1;a2=0;a3=1;
   s0=0;s1=0;
   #10 s0=1;s1=0;
   #10 s0=0;s1=1;
   #10 s0=1;s1=1;
   #10 $finish;
end
initial begin 
   $monitor ($time,"The value of s0=%b s1=%b a0=%b a1=%b a2=%b a3=%b out=%b",s0,s1,a0,a1,a2,a3,out);
end
endmodule
