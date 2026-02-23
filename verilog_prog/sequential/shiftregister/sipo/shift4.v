`include "d_ff.v"
module shift4(input d,
              input clk,reset,
              output [3:0]q,qb);
wire q0,q1,q2,q3;
wire qb0,qb1,qb2,qb3;

d_ff D1 (.d(d),.clk(clk),.reset(reset),.q(q0),.qb(qb0));
d_ff D2 (.d(q0),.clk(clk),.reset(reset),.q(q1),.qb(qb1));
d_ff D3 (.d(q1),.clk(clk),.reset(reset),.q(q2),.qb(qb2));
d_ff D4 (.d(q2),.clk(clk),.reset(reset),.q(q3),.qb(qb3));

assign q={q0,q1,q2,q3};

endmodule

