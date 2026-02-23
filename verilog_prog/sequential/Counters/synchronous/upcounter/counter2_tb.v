`include "counter2.v"
module counter2_tb();
reg clk,reset;
wire [1:0]q,qb;

counter2 counter_inst(.clk(clk),.reset(reset),.q(q),.qb(qb));

initial begin
   forever #5 clk=~clk;
end

initial begin
   reset=0;clk=0;
   #5 reset=1;
   #5 reset=0;
end

initial begin
   #100 $finish;
end

initial begin
   $monitor ($time ,"clk=%b reset=%b q=%b qb=%b",clk,reset,q,qb);
end
endmodule

