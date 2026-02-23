`include "mux81.v"
module mux81_tb();
 reg [7:0]d;
 reg[2:0]s;
 wire y;
mux81 m81 (.d(d),.s(s),.y(y));
initial 
 begin 
       d=8'b01010101;
       s=3'b000;
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
 $monitor($time,"The Value of s=%b d=%b y=%b",s,d,y);
 end
endmodule
