`include "mux41.v"
module mux41_tb();
 reg [3:0]a;
 reg [1:0]s;
 wire out;
mux41 mux41_inst (.a(a),.s(s),.out(out));
initial 
 begin
       a=4'b0001;s=2'b00;
   #10 a=4'b0011;s=2'b01;
   #10 a=4'b0110;s=2'b10;
   #10 a=4'b1111;s=2'b11;
   #10 $finish;
 end 
initial 
 begin
 $monitor ($time,"The value of a=%b s=%b out=%b",a,s,out);
 end
endmodule
