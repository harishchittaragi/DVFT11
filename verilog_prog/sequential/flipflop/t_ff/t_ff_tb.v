`include "t_ff.v"
module t_ff_tb();
reg t;
reg clk,reset;
wire q,qb;
integer i;


t_ff t_ff_ibst(t,clk,reset,q,qb);

initial begin 
   forever #5 clk=~clk;
end

initial begin
   reset=0;
   #10 reset=1;
end

initial begin
   clk=0;
   for (i=0;i<16;i=i+1)begin
      t=$random();
   #4;
end
end
initial begin
   #100 $finish;
end

initial begin
   $monitor ($time, "clk=%b reset=%b t=%b q=%b qb=%b",clk,reset,t,q,qb);
end
endmodule
