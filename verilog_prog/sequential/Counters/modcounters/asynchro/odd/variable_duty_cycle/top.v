`include "d_ff.v"
`include "mod5.v"
module top(input clk,reset,
           output out);
wire w1,w2; 
mod5 dut (.clk(clk),.reset(reset),.q(q),.qb());

assign w1=dut.q1;

d_ff dut1 (.d(w1),.clk(clk),.reset(reset),.q(w2),.qb());
 or O1(out,w1,w2);
 endmodule

