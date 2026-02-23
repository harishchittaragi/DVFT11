`include "shiftreg.v"
module shiftreg_tb();
reg in,clk,reset;
wire [3:0]out;

shiftreg dut (.in(in),.clk(clk),.reset(reset),.out(out));

always #5 clk=~clk;
initial begin 
   reset=0;clk=0;
   #3 reset=1;
   #3 reset=0;
end
 initial begin 
    in=0;
    #10 in=1;
    #10 in=0;
    #10 in=1;
    #10 in=1;
    #100 $finish;
 end
 initial begin
    $monitor ($time,"in=%b clk=%b reset=%b out=%b",in,clk,reset,out);
 end
 endmodule

