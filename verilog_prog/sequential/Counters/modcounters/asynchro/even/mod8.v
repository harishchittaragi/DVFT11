`include "t_ff.v"
module mod8(input clk,reset,
            output [2:0]q,qb);
wire q0,qb0;
wire q1,qb1;
wire q2,qb2;

t_ff T1(.t(1'b1),.clk(clk),.reset(reset),.q(q0),.qb(qb0));

t_ff T2(.t(1'b1),.clk(q0),.reset(reset),.q(q1),.qb(qb1));
t_ff T3(.t(1'b1),.clk(q1),.reset(reset),.q(q2),.qb(qb2));

assign q={q2,q1,q0};
assign qb={qb2,qb1,qb0};
endmodule
