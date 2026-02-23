`include "mealy_1101.v"
module mealy_1101_tb();
reg in;
reg clk,reset;
wire out;

mealy_1101 DUT (.in(in),.reset(reset),.clk(clk),.out(out));

always #5 clk=~clk;
initial begin
   clk=0;reset=0;
   #3 reset=1;
   #3 reset=0;
end

initial begin
 #6  in=0;
  #10 in=1;
  #10 in=1;
  #10 in=0;
  #10 in=1;
  #10 in=0;
  #10 in=1;
  #10 in=1;
  #50 $finish;
end
initial 
   $monitor($time,"out=%b s0=%b s1=%b s2=%b s3=%b",out,DUT.s0,DUT.s1,DUT.s2,DUT.s3);
endmodule

