`include "counter2.v"
module counter2_tb();

reg clk,reset;
wire [1:0]q,qb;

counter2 dut(clk,reset,q);

initial begin 
   forever #5 clk=~clk;
end

initial begin
   reset =0;clk=0;
   #10 reset=1;
   #10 reset=0;
end

 initial begin
 #100 $finish;
 end

 initial begin 
    $monitor ($time ,"clk=%b reset=%b q=%b", clk,reset,q);
 end
 endmodule

