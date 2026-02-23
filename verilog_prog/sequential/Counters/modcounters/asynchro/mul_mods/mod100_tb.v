`include "mod100.v"
module mod100_tb();
reg clk,reset;
wire [7:0]q,qb;

mod100 mod100_inst(.clk(clk),.reset(reset),.q(q),.qb(qb));

always #5 clk=~clk;
initial begin 
   clk=0;reset=0;
   #3 reset=1;
   #3 reset=0;
end 

initial begin 
   #1000 $finish;
end

initial begin 
   $monitor ($time,"clk=%b reset=%b q=%d qb=%b",clk,reset,q,qb);
end
endmodule
