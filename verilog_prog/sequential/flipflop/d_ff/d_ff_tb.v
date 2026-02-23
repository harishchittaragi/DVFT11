`include "d_ff.v"
module d_ff_tb();
reg d;
reg clk,reset;
wire q,qb;
integer i;

d_ff d_ff_inst (d,clk,reset,q,qb);

initial begin
   forever #5 clk=~clk;
end

initial begin
   reset =0;
   #10 reset =1;
end

initial begin
   clk=0;
   for(i=0;i<16;i=i+1) begin
      d=$random();
   #10;
   end
 end
 initial begin
    #100 $finish;
 end

 initial begin
    $monitor ($time  ,"clk=%b reset=%b D=%b q=%b qb=%b",clk,reset,d,q,qb);
 end
 endmodule
