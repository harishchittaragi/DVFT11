`include "counter3.v"
module counter3_tb();
reg clk,reset;
wire [2:0] q,qb;

counter3 count_inst(.clk(clk),.reset(reset),.q(q),.qb(qb));

initial begin 
   forever #5 clk=~clk;
end
 initial begin 
    clk=0;reset=0;
    #3 reset=1;
    #3 reset=0;
 end
  initial begin
     #100 $finish;
  end

  initial begin 
    $monitor ($time,"clk=%b reset=%b q=%b qb=%b",clk, reset, q, qb);
  end
  endmodule

