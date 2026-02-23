`include "mod4.v"
module mod4_tb();
reg clk,reset;
wire [1:0]q,qb;

mod4 M1 (.clk(clk),.reset(reset),.q(q),.qb(qb));

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
    $monitor($time,"clk=%b reset=%b q=%b qb=%b",clk,reset,q,qb);
 end
 endmodule
