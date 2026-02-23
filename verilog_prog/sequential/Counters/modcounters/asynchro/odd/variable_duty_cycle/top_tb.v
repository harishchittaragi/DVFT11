`include "top.v"
module top_tb();
reg clk,reset;
wire out;
top top_inst(clk,reset,out);
always #5 clk=~clk;
initial begin
   clk=0;reset=0;
   #3 reset=1;
   #3 reset=0;
end

initial begin
   #200 $finish;
end
 initial begin
    $monitor($time,"clk=%b reset=%b out=%b",clk,reset,out);
 end
 endmodule
