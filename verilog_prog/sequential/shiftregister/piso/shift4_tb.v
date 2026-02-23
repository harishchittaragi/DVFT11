`include "shift4.v"
module shift4_tb();
reg clk,reset;
wire q,qb;

shift4 dut(.clk(clk),.reset(reset),.q(q),.qb(qb));

always #5 clk=~clk;

initial begin
   reset=0;clk=0;
   #3 reset=1;
   #3 reset=0;
end
initial begin
     #100 $finish;
  end
  initial begin
     $monitor ($time,"clk=%b reset=%b q=%b",clk,reset,q);
  end
  endmodule
