`include "shift4.v"
module shift4_tb();
reg d;
reg clk,reset;
wire q,qb;

shift4(.d(d),.clk(clk),.reset(reset),.q(q),.qb(qb));

always #5 clk=~clk;
initial begin 
   clk=0;reset=0;
   #3 reset=1;
   #3 reset=0;
end
initial begin 
   d=0;
   #10 d=1;
   #10 d=0;
   #10 d=1;
   #10 d=1;
   #10 d=0;
end
 initial begin 
    #200 $finish;
 end
  initial begin
     $monitor ($time,"clk=%b reset=%b q=%b qb=%b",clk,reset,q,qb);
  end
  endmodule
