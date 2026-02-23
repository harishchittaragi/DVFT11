`include "counter.v"
module counter_tb();
reg t;
reg clk,reset;
wire [2:0]out;

counter dut(.t(t),.clk(clk),.reset(reset),.out(out));

initial begin
   forever #10 clk=~clk;
end 

initial begin
   clk=0;reset=0;
   #5 reset=1;
   #5 reset=0;
end

initial begin 
   t=0;
   #300 t=1;
   #700 $finish;
end
always @ (posedge clk) begin
   $display($time,"clk =%b reset=%b t=%b out=%b",clk,reset,t,out);
//initial begin
// $monitor($time,"clk=%b reset=%b t=%b out=%b",clk,reset,t,out);
 end
 endmodule
