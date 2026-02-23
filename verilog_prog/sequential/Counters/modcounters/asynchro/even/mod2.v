`include "t_ff.v"
module mod2( input clk,reset,output [1:0]q,qb);

wire q0,qb0;
t_ff T1(.t(1'b1),.clk(clk),.reset(reset),.q(q0),.qb(qb0));
assign q=q0;
assign qb=qb0;
endmodule
