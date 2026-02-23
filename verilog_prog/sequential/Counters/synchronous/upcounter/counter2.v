`include "t_ff.v"
module counter2(input clk,reset,
                output [1:0]q,qb);
wire qo,q1,qb0,qb1;

t_ff T1 (.t(1'b1),.clk(clk),.reset(reset),.q(q0),.qb(qb0));
t_ff T2 (.t(q0),.clk(clk),.reset(reset),.q(q1),.qb(qb1));

assign q={q1,q0};
assign qb={qb0,qb1};

endmodule
