`include "demux14.v"
module demux14_tb ();
reg d;
reg [1:0]s;
wire [3:0]y;
demux14 demux_dut(.d(d),.s(s),.y(y));
initial begin
   s=2'b00;d=1;
   #10 s=2'b01;d=10;
   #10 s=2'b10;d=100;
   #10 s=2'b11;d=1000;
   #10 $finish;
end
initial begin
   $monitor($time,"the value of s=%b d=%b y=%b",s,d,y);
end 
endmodule
   

