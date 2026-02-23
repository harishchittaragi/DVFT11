`include "demux18.v"
module demux18_tb();
reg d;
reg [2:0]s;
wire [7:0]y;
demux18 demux_dut(.d(d),.s(s),.y(y));
initial begin
   d=1;s=0;
   #10 s=1;
   #10 s=2;
   #10 s=3;
   #10 s=4;
   #10 s=5;
   #10 s=6;
   #10 s=7;
   #10 $finish;
end 
initial begin
   $monitor($time,"the value of s=%b d=%b y=%b",s,d,y);
end
endmodule
   
