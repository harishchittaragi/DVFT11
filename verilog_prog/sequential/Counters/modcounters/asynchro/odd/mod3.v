`include "t_ff.v"
module mod3(input clk,reset,
            output [1:0]q,qb);
wire q0,qb0;
wire q1,qb1;
wire res;

t_ff T1(.t(1'b1),.clk(clk),.reset(res),.q(q0),.qb(qb0));
t_ff T2(.t(1'b1),.clk(q0),.reset(res),.q(q1),.qb(qb1));

assign q={q1,q0};
assign qb={qb1,qb0};
assign res =reset|(q1&q0);
endmodule
