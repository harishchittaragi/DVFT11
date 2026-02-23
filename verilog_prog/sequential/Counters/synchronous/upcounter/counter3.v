`include "t_ff.v"
module counter3(input clk,reset, output [2:0]q,qb);

wire q0,q1,q2,t0,t1,t2,qb0,qb1,qb2;

assign t0=1'b1;
assign t1=q0;
assign t2=q0&q1;

t_ff T1 (.t(1'b1),.clk(clk),.reset(reset),.q(q0),.qb(qb0));
t_ff T2 (.t(t1),.clk(clk),.reset(reset),.q(q1),.qb(qb1));
t_ff T3 (.t(t2),.clk(clk),.reset(reset),.q(q2),.qb(qb2));

assign q={q2,q1,q0};
assign qb={qb2,qb1,qb0};

endmodule
