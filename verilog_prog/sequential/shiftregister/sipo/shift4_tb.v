`include "shift4.v"
module shift4_tb();
reg d;
reg clk,reset;
wire [3:0]q,qb;

shift4 dut(.d(d),.clk(clk),.reset(reset),.q(q),.qb(qb));

always #5 clk=~clk;

initial begin
   reset=0;clk=0;
   #3 reset=1;
   #3 reset=0;
end
 initial begin
    d=0;
    #10 d=1;
    #10 d=0;
    #10 d=1;
 end
  initial begin
     #100 $finish;
  end
  initial begin
     $monitor ($time,"clk=%b reset=%b q=%b",clk,reset,q);
  end
  endmodule
