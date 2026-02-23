`include "mux8121.v"
module mux8121_tb();
 reg [7:0]a;
 reg [2:0]s;
 wire y;

mux8121 mux_inst (.a(a),.s(s),.y(y));
initial 
 begin
     a=8'b10101010;
  #10 s=3'b000;
  #10 s=3'b001;
  #10 s=3'b010;
  #10 s=3'b011;
  #10 s=3'b100;
  #10 s=3'b101;
  #10 s=3'b110;
  #10 s=3'b111;
  #10 $finish;
 end
initial 
 begin
    $monitor($time,"The value of s=%b a=%b y=%b",s,a,y);
 end
endmodule
