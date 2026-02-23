`include "sr_ff.v"
module sr_ff_tb();
reg s,r;
reg clk;
reg reset;
wire q,qb;
//integer i
sr_ff sr_inst(s,r,clk,reset,q,qb);

always #5 clk=~clk;

initial begin
    clk=0;reset=0;
    //for (i=0;i<4;i=i+1) begin
//     s=$random();
//     r=$random();
//     #10;
//  end
   #10 s=0;r=0;reset=1;
   #10 s=0;r=1;
   #10 s=1;r=0;
   #10 s=1;r=1;
   #10 $finish;
end
initial begin 
   $monitor ($time , "clk=%b reset=%b s=%b r=%b q=%b qb=%b",clk,reset,s,r,q,qb);
end
endmodule
