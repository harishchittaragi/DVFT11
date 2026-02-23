`include "mod10.v"
module mod10_tb();
reg clk,reset;
wire [3:0]q,qb;

mod10 M1 (.clk(clk),.reset(reset),.q(q),.qb(qb));

always #5 clk=~clk;
initial begin 
   reset=0;clk=0;
   #3 reset=1;
   #3 reset=0;
end
 initial begin
    #200 $finish;
 end

 initial begin 
    $monitor($time,"clk=%b reset=%b q=%b qb=%b",clk,reset,q,qb);
 end
 endmodule
