`include "counter2.v"
module counter2_tb();
reg clk,reset;
wire [1:0]q,qb;

counter2 count_inst(.clk(clk),.reset(reset),.qb(qb));

initial begin
   clk=0;
   forever #5 clk=~clk;
end

initial begin
   reset=0;
  #5 reset =1;
  #5 reset=0;
end

initial begin
 #100 $finish;
 end
 initial begin 
    $monitor ($time," reset =%b q=%b, qb=%b",reset,q,qb);
 end

 endmodule
