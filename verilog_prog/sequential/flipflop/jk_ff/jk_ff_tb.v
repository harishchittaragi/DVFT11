`include "jk_ff.v"
module jk_ff_tb();
reg j,k;
reg clk,reset;
wire q,qb;
integer i;

jk_ff jk_ff_inst(.j(j),.k(k),.clk(clk),.reset(reset),.q(q),.qb(qb));

 initial begin
   forever #5 clk=~clk;
 end

 initial begin
    reset=0;
    #10 reset=1;
    #10 reset=0;
    #10 reset=1;
 end

 initial begin
    clk=0;
    for(i=0;i<8;i=i+1) begin
       j=$random();
       k=$random();
       #10;
    end
 end
 initial begin
 #100 $finish;
 end
 initial begin
       $monitor($time  ,"clk=%b reset=%b J=%b K=%b q=%b qb=%b",clk,reset,j,k,q,qb);
    end
endmodule
